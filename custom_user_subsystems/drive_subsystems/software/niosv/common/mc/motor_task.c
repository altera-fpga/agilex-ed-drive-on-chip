/* ##################################################################################
 * Copyright (C) 2025 Altera Corporation
 *
 * This software and the related documents are Altera copyrighted materials, and
 * your use of them is governed by the express license under which they were
 * provided to you ("License"). Unless the License provides otherwise, you may
 * not use, modify, copy, publish, distribute, disclose or transmit this software
 * or the related documents without Altera's prior written permission.
 *
 * This software and the related documents are provided as is, with no express
 * or implied warranties, other than those that are expressly stated in the License.
 * ##################################################################################
 */

#include "motor_task.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>        //to use SHRT_MAX and SHRT_MIN

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"
#include "io.h"

#include "sys/alt_irq.h"

#include "main.h"

#include "demo_cfg.h"
#include "components/dspba/DF_fixp16_alu_av_mmap.h"
#include "components/dspba/DF_fixp16_alu_av.h"
#include "components/ssg_emb_dsm.h"
#include "components/ssg_emb_pwm.h"
#include "mc/mc.h"
#include "mc/mc_debug.h"
#include "mc/mc_dsp.h"
#include "mc/mc_nios_perf.h"
#include "mc/foc/foc.h"
#include "perf/altera_avalon_performance_counter.h"
#include "platform/platform_linker.h"
#include "platform/common/platform.h"
#include "platform/motors/motor_types.h"
#include "platform/powerboard/doc_adc.h"

#include "motorsim/motor_functions.h"        //motor simulation inside deferred_irq_task()
#include "motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL.h"
#include "motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL_mmap.h"

#include "app_cfg.h"

/**
 * @file motor_task.c
 *
 * @brief Main motor control task and ISR
 */

/*!
 * \addtogroup MC
 *
 * @{
 */

#define ISNEGATIVE(a) (((a) < 0) ? -1:0)

//
// On Nios the ISR is linked in tightly coupled memory
//
void drive_irq(void *context) IRQ_SECTION;

static inline void deferred_irq_task(void) IRQ_SECTION;

#define SPEED_SHIFT_INT 0

//
// Enable encoder offset calibration
//

#ifdef TCM_D_SPAN
    static drive_params dp[LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1] __attribute__((section(".tcm_d")));
    system_params sp __attribute__((section(".tcm_d")));
#else
    static drive_params dp[LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1];
    system_params sp;
#endif

void *get_dp(void)
{
    return (void *)&dp[0];
}

void *get_sp(void)
{
    return (void *)&sp;
}

void adjust_speed(unsigned int drive_index, int delta)
{
    if (drive_index < (sizeof(dp)/sizeof(drive_params))) {
        dp[drive_index].speed_command = ABS_MAX(dp[drive_index].speed_request + delta,
                                                dp[drive_index].motor->speed_limit<<SPEED_FRAC_BITS);
    }
}

void set_speed_limit(unsigned int drive_index, int limit)
{
    if (drive_index < (sizeof(dp)/sizeof(drive_params))) {
        dp[drive_index].pos_speed_limit = limit;
    }
}

void adjust_pos_setpoint(unsigned int drive_index, int delta)
{
    if (drive_index < (sizeof(dp)/sizeof(drive_params))) {
        dp[drive_index].pos_setpoint = dp[drive_index].pos_request + delta;
    }
}

void set_pos_setpoint(unsigned int drive_index, int pos_setpoint)
{
    if (drive_index < (sizeof(dp)/sizeof(drive_params))) {
        dp[drive_index].pos_setpoint = pos_setpoint;
    }
}

/**
 * @brief Sample encoder inputs
 *
 * Helper function to read motor position and current for a single axis. Also accumulates
 * current readings for offset calibration. We still read position sensors, even in
 * sensorless modes for debug purposes.
 *
 * @param dp    Pointer to single axis drive_params struct
 * @param sp    Pointer to system_params struct
 */
static void sample_inputs(drive_params * dp, system_params *sp) IRQ_SECTION;
static void sample_inputs(drive_params *dp, system_params *sp)
{
    dp->motor->encoder_read_position_fn(dp, sp);
    adc_read(dp, sp);
}

/**
 * @brief Helper function for position control
 *
 * @param dp            Pointer to single axis drive_params struct
 * @param update_speed    non-zero to update speed_command
 */
static void  position_control(drive_params *dp, int update_speed) IRQ_SECTION;
static void  position_control(drive_params *dp, int update_speed)
{
    // Update multiturn position control variable
    dp->pos_turns += dp->encoder.turns_delta;
    // Use short representation of mechanical position plus multi turn count for PI
    dp->pos_16q16 = (unsigned int)dp->phi_mech + (dp->pos_turns << 16);
    //Limit both setpoint and feedback to 31 bits including sign bit.
    //So later in pi_control_q15(), error_input will not overflow.
    dp->position_pi.feedback = ABS_MAX(dp->pos_16q16, (1<<30)-1);     // (1<<30)-1)=3fff ffff
    dp->position_pi.setpoint = ABS_MAX(dp->pos_setpoint, (1<<30)-1);  // (1<<30)-1)=3fff ffff
    pi_control_q15(&dp->position_pi, (dp->enable_drive == 0) || (dp->reset_control == 1));  //Direct current control
    if (update_speed) {
        dp->speed_command = (short)dp->position_pi.output;
    }
}

/**
 * @brief Position or speed control in closed loop mode
 *
 * Helper function to perform position or speed control in closed loop mode
 *
 * @param dp    Pointer to single axis drive_params struct
 */
static void  closed_loop_control(drive_params *dp) IRQ_SECTION;
static void  closed_loop_control(drive_params *dp)
{

        switch (dp->pos_speed_demo_mode) {
        case 1:
        case 2:
            // Position control
            // In position control, the speed_command is output from position_control(),
            // so we want to update it
            position_control(dp, 1);
            break;

        default:
            // Speed control
            // In speed control mode, position control() result is not used but still calculates position values for
            // monitoring speed_command is input from the gui and we do not want to update it
            position_control(dp, 0);
            //Set setpoint to actual measured position (not used but makes system console plot look better)
            dp->pos_setpoint = dp->pos_16q16;
            break;
        }
        // Speed Control by controlling current request (more current = more torque)

        dp->speed_pi.feedback = dp->encoder.speed_encoder;

        dp->speed_pi.setpoint = dp->speed_command;
        //Direct current control
        pi_control_q15(&dp->speed_pi, (dp->enable_drive == 0) || (dp->reset_control == 1));
        // Quadrature current command for FOC (d-axis current is always zero in our implementation
        // as all d-axis flux is supplied by the rotor)
        dp->i_command_q = dp->speed_pi.output;

        if (dp->enable_drive == 0) {
            dp->i_command_q = 0;
        }
}

/**
 * @brief Position control in open loop mode
 *
 * Helper function to perform position control in closed loop mode.
 *
 * Applies volts/Hz control to the motor, based on minimum voltage for motor movement and a gain derived
 * from the rated motor speed and voltage.
 *
 * Position, Ialpha & Ibeta are not used and are calculated for monitoring only.
 *
 * @param dp    Pointer to single axis drive_params struct
 */
static void open_loop_control(drive_params *dp) IRQ_SECTION;
static void open_loop_control(drive_params *dp)
{

    // Calculate new electrical angle wrapping around in 16-bit unsigned short representing one revolution
    // idx[new] = idx[old] + pole_pairs*speed_command*
    //      time interval between each update*rpm_to_rps_converting_coeffecient*one_revolution
    // idx += pole_pairs*speed_command*(1/isr_sample_rate)*(1/speed_scale)*one_revolution
    // idx += (pole_pairs*speed_command*one_revolution)/(isr_sample_rate*speed_scale)
    // idx += (dp->motor->pole_pairs*dp->speed_command*65536)/(platform.isr_sample_rate*1000*SPEED_SCALE);
    // Want to keep numerator in range of integer arithmetic, so make an approximation
    dp->open_loop_idx_q16 += (dp->motor->pole_pairs*dp->speed_command*655)/(platform.isr_sample_rate*10*SPEED_SCALE);

    // Apply volts/Hz control
    // volt_rms = v_min + speed_command * VoltsPerHzGain
    // speed command is rpm shifted by SPEED_FRAC_BITS or Hz scaled by SPEED_SCALE
    // Scaling is removed in calculation of v_req_volts

    // This calculation is implemented to use a better v_per_hz_gain_f in order to reduce power
    // consumption in open loop.
    // We calculate a minimum voltage to compensate for the dead-time in the PWM waveform generation.
    // This simplifies to 'dc link voltage' * ('pwm dead time' / 'pwm sample time') * sqrt(3)/2
    // V_min_f is an additional offset(dp->motor->V_min_f) for extra torque to compensate friction and cogging.
    // 0.866 is sqrt(3)/2 for compensation of svm() gain
    long int v_min_f = sp.dc_dc_v_scaled*(PWM_DEAD_TIME_NSEC*28)*platform.adc_sample_rate + dp->motor->V_min_f;

    // speed_command * VoltsPerHzGain
    dp->v_req_volts_f = v_min_f + abs(dp->speed_command)/SPEED_SCALE*dp->motor->v_per_hz_gain_f;

    // Limited to actual available DC link voltage
    if (dp->v_req_volts_f > sp.dc_dc_v_scaled * 32768) {
        dp->v_req_volts_f = sp.dc_dc_v_scaled * 32768;
    }
    // Calculate fraction of maximum pwm to apply, based on DC link voltage
    //This modification was done to reduce FP operation for NIOSV temporarily.
    dp->pwm_request_q15 = dp->v_req_volts_f/sp.dc_dc_v_scaled;

    if ((sp.demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp.demo_mode == DEMO_OPEN_LOOP_SINE_32)) {
        inverse_park(0, dp->pwm_request_q15, &dp->v_alpha_ol_q15, &dp->v_beta_ol_q15,
                    SINE(dp->open_loop_idx_q16), COSINE(dp->open_loop_idx_q16));

        // For monitoring only (want to calculate multi-turn position)
        position_control(dp, 0);
        if (sp.lvmc_adc_type == ADC_TYPE_MAX10) {
            clarke_transform(dp->max10_drive_adc.iu, dp->max10_drive_adc.iw, dp->motor->Iphase_ADC_scale_A,
                            dp->motor->CurrentParameter, &dp->i_alpha, &dp->i_beta);
        } else {
            clarke_transform(dp->sd_drive_adc.iu, dp->sd_drive_adc.iw, dp->motor->Iphase_ADC_scale_A,
                            dp->motor->CurrentParameter, &dp->i_alpha, &dp->i_beta);
        }
    }
}

/**
 * @brief Commutation function
 *
 * Helper function to perform closed loop commutation in selected mode.
 *
 * @param dp    Pointer to single axis drive_params struct
 */
static void commutate(drive_params *dp, int dn) IRQ_SECTION;
static void commutate(drive_params *dp, int dn)
{
    if (platform.commutation == FOC_SENSOR) {
        // FOC code
        closed_loop_control(dp);

        // Apply FOC algorithm in software or hardware
        //        park and clark transforms on input readings
        //        PI control loop
        //        inverse transform on outputs
        PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);

        if (sp.dsp_mode == SOFT_FIXP) {
            software_foc(dp, &sp);
        } else {
            dspba_foc(dp, &sp);
        }

        PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);

    }
}

/**
 * @brief Interrupt Service Routine for motor control
 *
 * Wakes up the deferred IRQ task to run in non-IRQ context
 *
 * @param context    Additional IRQ context
 */
void drive_irq(void *context)
{

#ifdef USE_LED_PIO_FOR_SIGNALTAP
    PIO_ONEBIT_SET(IO_OUT_LED_BASE, 0); // Set bit-0 as start of ISR
#endif

    // To measure the ISR timeing in Signal tap, use the IO_OUT_LED with the 
    // command "IOWR_32DIRECT(IO_OUT_LED_BASE, 0, 0x1);""

    // Disable channel 0 ADC IRQ
    adc_irq_acknowledge(&dp[0]);

    // When running on an SoC RTOS platform, set semaphore to wake deferred IRQ task
    // and get remaining processing out of IRQ context
    // For Nios we simply call the deferred isr as a function to save the task switch overhead
    deferred_irq_task();

    // Once finished the ISR, release the IO_OUT_LED using 
    // "IOWR_32DIRECT(IO_OUT_LED_BASE, 0, 0x0);" to visualize in SignalTap

    // Re-enable channel 0 ADC interrupt
    adc_irq_enable(&dp[0]);
}


/**
 * @brief Deferred Interrupt Service Routine for motor control
 *
 * For SoC projects, this is the deferred IRQ task so that all ISR processing occurs in non-IRQ context
 * which simplifies use of the FPU.
 *
 * For Nios there is no restriction so this is a function called from the ISR, not a task, which
 * saves the task switch overhead.
 *
 * All of the critical processing occurs here. The IRQ occurs every PWM cycle, which is every
 * 62.5us in the standard implementation, as a result of the ADC conversion completion interrupt.
 *
 * It is assumed that the hardware design is such that the position encoder reading is also
 * available.
 *
 * Processing must complete in time for the new PWM value to be written to the hardware before
 * the next cycle starts.
 *
 * @param pdata    Additional IRQ context
 */
static inline void deferred_irq_task(void)
{

    int dn;
    int Inverter_Enable;
    short dc_dc_v_fb;

    PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 2);

    if ((platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) && ((sp.lvmc_adc_type == ADC_TYPE_MAX10))) {
        dc_dc_v_fb = sp.max10_platform_adc.dc_dc_v_fb;
    } else {
        dc_dc_v_fb = sp.sd_platform_adc.dc_dc_v_fb;
    }
    debug_update_sys_params(sp.app_state, sp.dsp_mode, dc_dc_v_fb);

    for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {

#if (defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE))
        dspba_motor_model_fixedp_direct_inf(&dp[dn], &sp);
#endif
        sample_inputs(&dp[dn], &sp);    //reads sigma delta ADCs

        //assign current inputs from motor model+position
        // we overwrite values read from ADC (i.e. the ones we get after offset calibration,
        // since the power board is not connected)
        if (sp.app_state == APP_ADC_CALIBRATION) {
            if (dp[dn].Offset_start_calc > 0) {
                // the design gets stuck here when the power board is not connected, modified adc_offset_calculation()
                // (doc_adc.c) called inside motor_task()
                adc_offset_accumulate(&dp[dn]);
            }
        }


        if (sp.app_state != APP_DRIVE_ENABLED) {     //APP_DRIVE_SIM
            // Call debug_update_drive_params to allow monitoring in gui during
            // startup and ensure dclink adc readings are
            // kept up to date during DCDC startup.
            // During normal operation debug_update_drive_params() will be called,
            // less frequently, from the main loop rather than from here,
            // so as not to increase ISR execution time
            debug_update_drive_params(dn,
                dp[dn].state_act,
                dp[dn].encoder.speed_encoder,
                dp[dn].pos_16q16);

            /*
             * dc_link_read()
             *
             * Used to reads the DC input and DC link voltages and currents.
             * These are now read in the ISR along with other samples. All we do here is
             * scale them for use in limit checks..
             *
             * The lvdcdc output voltage and inductor current feedback are read each ISR, not here.
             */
            sp.dc_dc_v_scaled = (short)(sp.sd_platform_adc.dc_dc_v_fb / (dp[dn].motor->V_DC_link_scale_V));
        } else {
            if (dp[dn].enable_drive) {
                if ((sp.demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp.demo_mode == DEMO_OPEN_LOOP_SINE_32)) {
                    // Open loop control
                    open_loop_control(&dp[dn]);
                } else {
                    // Closed loop commutation
                    commutate(&dp[dn], dn);
                };
            }

            // Apply Inverse Clarke (SVM) to calculate new PWM values
            if ((dp[dn].enable_drive == 1) || (platform.powerboard_present == 0)) {
                if ((sp.demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp.demo_mode == DEMO_OPEN_LOOP_SINE_32)
                        || (platform.commutation == FOC_SENSOR)) {
                    if ((sp.demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp.demo_mode == DEMO_OPEN_LOOP_SINE_32)) {
                        // Open loop sinusoidal or open loop sinusoidal startup phase for sensorless
                        if (dp[dn].switch_count < SENSORLESS_STARTUP_COUNT) {
                            // Count for open sensorless startup delay and open loop voltage ramp
                            dp[dn].switch_count++;
                        }
                        // Take inputs from open loop control
                        svm(dp[dn].v_alpha_ol_q15, dp[dn].v_beta_ol_q15, &dp[dn].vu_pwm,
                            &dp[dn].vv_pwm, &dp[dn].vw_pwm);
                    } else {
                        // Closed loop sinusoidal, sensored
                        if (sp.dsp_mode != DSPBA_FIXP)
                            svm(dp[dn].v_alpha_q15, dp[dn].v_beta_q15, &dp[dn].vu_pwm,
                                &dp[dn].vv_pwm, &dp[dn].vw_pwm);
                    }
                    Inverter_Enable = 0x7;
                } else {
                    //using again 0x7, but if sensorless or trapezoidale modes are added, this must be changed
                    Inverter_Enable = 0x7;
                }

                // Write new PWM values to hardware ready for next cycle
                if (sp.dsp_mode == DSPBA_FIXP) {
                    pwm_update(dp[dn].DOC_PWM_BASE_ADDR, dp[dn].vu_pwm, dp[dn].vv_pwm, dp[dn].vw_pwm,
                                Inverter_Enable, 0x1);
                } else {
                    pwm_update(dp[dn].DOC_PWM_BASE_ADDR, dp[dn].vu_pwm, dp[dn].vv_pwm, dp[dn].vw_pwm,
                                Inverter_Enable, 0x0);
                }
            } else {
                // Disabled axes set stationary by setting PWM to midpoint
                pwm_update(dp[dn].DOC_PWM_BASE_ADDR, (platform.pwm_count+1)/2-1, (platform.pwm_count+1)/2-1,
                            (platform.pwm_count+1)/2-1, 0x7, 0x0);
                dp[dn].switch_count = 0;
            }
        }
    }

    // Dump diagnostic data for system console GUI
    dump_data(dp, &sp);

    PERF_END(PERFORMANCE_COUNTER_0_BASE, 2);

#ifdef USE_LED_PIO_FOR_SIGNALTAP
    PIO_ONEBIT_CLR(IO_OUT_LED_BASE, 0);        // Clear bit-0 as end of ISR
#endif

}

/**
 * Helper function to print diagnostics based on error state. Called from main loop.
 *
 * @param dn
 */
void decode_error_state(int dn)
{
    int error = 0;

    if (dp[dn].state_act == 4) {
        debug_printf(DBG_INFO, "Axis %d: Decode error state. State %d  Status: 0x%04X\n", dn,
                    dp[dn].state_act, dp[dn].status_word);
        debug_printf(DBG_ERROR, "Axis %d: Error state is %d\n", dn, dp[dn].state_act);
        if (dp[dn].status_word & DSM_STATUS_ERR_OC) {
            debug_printf(DBG_ERROR, "Axis %d: --> ERROR: <Overcurrent>\n", dn);
            adc_debug_oc(&dp[dn]);
            error = 1;
        }
        if (dp[dn].status_word & DSM_STATUS_ERR_OV) {
            debug_printf(DBG_ERROR, "Axis %d: --> ERROR: <DC-Link-Overvoltage>\n", dn);
            /*
             * dc_link_read()
             *
             * Used to reads the DC input and DC link voltages and currents.
             * These are now read in the ISR along with other samples. All we do here is
             * scale them for use in limit checks..
             *
             * The lvdcdc output voltage and inductor current feedback are read each ISR, not here.
             */
            sp.dc_dc_v_scaled = (short)(sp.sd_platform_adc.dc_dc_v_fb / (dp[dn].motor->V_DC_link_scale_V));
            debug_printf(DBG_ERROR, "U_DC_LINK: %i Volt Limit: %i Volt\n", sp.dc_dc_v_scaled,
                        platform.powerboard->overvoltage);
            error = 1;
        }
        if (dp[dn].status_word & DSM_STATUS_ERR_UV) {
            debug_printf(DBG_ERROR, "Axis %d: --> ERROR: <DC-Link-Undervoltage>\n",
                    dn);
            /*
             * dc_link_read()
             *
             * Used to reads the DC input and DC link voltages and currents.
             * These are now read in the ISR along with other samples. All we do here is
             * scale them for use in limit checks..
             *
             * The lvdcdc output voltage and inductor current feedback are read each ISR, not here.
             */
            sp.dc_dc_v_scaled = (short)(sp.sd_platform_adc.dc_dc_v_fb / (dp[dn].motor->V_DC_link_scale_V));
            debug_printf(DBG_ERROR, "U_DC_LINK: %i Volt\n", sp.dc_dc_v_scaled);
            error = 1;
        }
        if (dp[dn].status_word & DSM_STATUS_ERR_CLOCK) {
            debug_printf(DBG_ERROR,
                    "Axis %d: --> ERROR: <SD-Clock or DC-Link-Clock-Error>\n",
                    dn);
            error = 1;
        }
        if (dp[dn].status_word & DSM_STATUS_ERR_MOSFET) {
            debug_printf(DBG_ERROR,
                    "Axis %d: --> ERROR: <MOSFET-Error (no voltage?)>\n", dn);
            error = 1;
        }
        if (dp[dn].status_word & DSM_STATUS_ERR_CHOPPER) {
            // Ignored for all but ALT12}
            if (platform.powerboard->sysid == SYSID_PB_ALT12_MULTIAXIS) {
                debug_printf(DBG_ERROR, "Axis %d: --> ERROR: <Chopper>\n", dn);
            }
            error = 1;
        }
        if (error == 0) {
            debug_printf(DBG_ERROR, "Axis %d: --> ERROR: <Unknown> 0x%04x\n", dn, dp[dn].status_word);
        }
    }
}


#if defined __ECFS_DOC_THRESHOLD_SINK
/**
 * Helper function to print MAX10 ADC threshold diagnostics based on error state. Called from main loop.
 * this is used only in MAX10 devices, kept for consistency of the code
 */
void decode_threshold_error_state(void)
{
    int latch_under = adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE, THR_LATCH_UNDER_REG);
    int latch_over = adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE, THR_LATCH_OVER_REG);
    int output_under = adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE, THR_OUTPUT_UNDER_REG);
    int output_over = adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE, THR_OUTPUT_OVER_REG);

    if (latch_under | latch_over | output_under | output_over) {
        debug_printf(DBG_INFO, "MAX10 threshold below minimum error latch: 0x%04x\n", latch_under);
        debug_printf(DBG_INFO, "MAX10 threshold above maximum error latch: 0x%04x\n", latch_over);
        debug_printf(DBG_INFO, "MAX10 threshold below minimum error output: 0x%04x\n", output_under);
        debug_printf(DBG_INFO, "MAX10 threshold above maximum error output: 0x%04x\n", output_over);
        if (output_over & THR_DRIVE0_OC) {
            debug_printf(DBG_ERROR, "Axis 0: --> ERROR: <MAX10 threshold Overcurrent>\n");
            if (output_over & THR_I_FBK_DRIVE0_U_BIT) {
                debug_printf(DBG_ERROR, "Axis 0: --> ERROR: <Phase U MAX10 threshold Overcurrent>\n");
            }
            if (output_over & THR_I_FBK_DRIVE0_V_BIT) {
                debug_printf(DBG_ERROR, "Axis 0: --> ERROR: <Phase V MAX10 threshold Overcurrent>\n");
            }
            if (output_over & THR_I_FBK_DRIVE0_W_BIT) {
                debug_printf(DBG_ERROR, "Axis 0: --> ERROR: <Phase W MAX10 threshold Overcurrent>\n");
            }
        }
        if (output_over & THR_DRIVE1_OC) {
            debug_printf(DBG_ERROR, "Axis 1: --> ERROR: <MAX10 threshold Overcurrent>\n");
            if (output_over & THR_I_FBK_DRIVE1_U_BIT) {
                debug_printf(DBG_ERROR, "Axis 1: --> ERROR: <Phase U MAX10 threshold Overcurrent>\n");
            }
            if (output_over & THR_I_FBK_DRIVE1_V_BIT) {
                debug_printf(DBG_ERROR, "Axis 1: --> ERROR: <Phase V MAX10 threshold Overcurrent>\n");
            }
            if (output_over & THR_I_FBK_DRIVE1_W_BIT) {
                debug_printf(DBG_ERROR, "Axis 1: --> ERROR: <Phase W MAX10 threshold Overcurrent>\n");
            }
        }
        if (output_over & THR_BOOST_OC) {
            debug_printf(DBG_ERROR, "DC DC boost: --> ERROR: <MAX10 threshold DC DC Inductor Overcurrent>\n");
        }
        if (output_over & THR_INPUT_VOLTAGE_FB_BIT) {
            debug_printf(DBG_ERROR, "DC DC boost: --> ERROR: <MAX10 threshold DC Input Overvoltage>\n");
        }
        if (output_under & THR_INPUT_VOLTAGE_FB_BIT) {
            debug_printf(DBG_ERROR, "DC DC boost: --> ERROR: <MAX10 threshold DC Input Undervoltage>\n");
        }
        if (output_over & THR_DCBUS_VOLTAGE_FB_BIT) {
            debug_printf(DBG_ERROR, "DC DC boost: --> ERROR: <MAX10 threshold DC Link Overvoltage>\n");
        }
        if (output_under & THR_DCBUS_VOLTAGE_FB_BIT) {
            debug_printf(DBG_ERROR, "DC DC boost: --> ERROR: <MAX10 threshold DC Link Undervoltage>\n");
        }
    } else {
        debug_printf(DBG_INFO, "MAX10 threshold: --> No Enabled Error\n");
    }
}
#endif


/**
 * Reset function with flag
 * This function disables drive, then set reset control loop.
 * If motor_type_reset_flag is false, this reset function will not reset system to default motor structures.
 * If motor_type_reset_flag is true, this reset function will reset system to use default motor structures.
 * Be aware that dp[dn].motor got two structures. For FOC senor modes, FOC sensor
 * less modes and Openloop mode, they all use default motor: motors[dn]
 */

void drive_reset_with_flag(bool motor_type_reset_flag)
{
    int dn;

    // Disable drives to prevent inconsistent setup being used in ISR
    for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        dp[dn].enable_drive = 0;
    }
    // Wait for shutdown
    OS_SLEEP_MS(1);
    //Reset the control loop and revert to default motor
    for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        dp[dn].reset_control = 1;
        if (motor_type_reset_flag) {
            dp[dn].motor = motors[dn];
        }
    }

}

/**
 * Reset function reset disables drive, then set reset control loop and set motor type to default motor.
 */
void drive_reset(void)
{
    drive_reset_with_flag(true);
}

/**
 * Helper function called form main loop to decode the actions in the Tcl GUI
 *
 * @return            returns 1 if all drives should be reset
 */
int update_from_gui(void)
{
    static calc_type_e mode_select;
    static demo_mode_e demo_select;

    int adc_select;

    int ret = 0;
    int dn;

    // Reset all axes
    if (debug_read_reset()) {
        debug_printf(DBG_INFO, "\n\nDrive reset request\n");
        ret = 1;
        // Do not reset Motor_types strusts, because if in Trapezoidal/Hall mode, motor type is not default motor type.
        drive_reset_with_flag(false);

        // Reset the DC-DC
        // using an initial value
        sp.dc_dc_cmd_v = 12;

        sp.axis_select = 0;
        return ret;
    }
    // This part is the software protection mechanism, if the motor is rotating too fast,
    // it will reset the system to FOC 16kHz sensor mode in order to protect motor kit.
    demo_select = debug_read_demo_mode();
    for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        if ((abs(dp[dn].encoder.speed_encoder>>SPEED_FRAC_BITS) > 2000)) {
            demo_select = DEMO_FOC_SENSOR_16_2;
        }
    }
    if (demo_select != sp.demo_mode) {
        // Handle demo mode change request, will reset drive if a there is a change
        debug_printf(DBG_INFO, "\n\nDemo mode change request %d\n", demo_select);
        // PWM maximum value, this is just an initialization value. See ssg_emb_pwm for automatic calculation.
        // PMWM_MAX = (PWM frequency Hz)/((Sample Rate) *1000) = (300 MhZ)/ ((16KHz)*1000)  --- see Aapplication Note
        IOWR_16DIRECT(dp[0].DOC_PWM_BASE_ADDR, PWM_MAX, 18750);
        ret = 1;
        // During changing sensor mode, reset default motor type, because later the
        // correct motor type will be set by switch statement based on demo_select.
        drive_reset();

        // Switch to new mode
        switch (demo_select) {
        case DEMO_OPEN_LOOP_SINE_16:
        // case DEMO_RESET is handled by reset all axes code, above
            // Open loop sinusoidal 16 kHz Volts/Hz
            debug_printf(DBG_INFO, "Open loop Sinusoidal 16 kHz Volts/Hz\n");
            platform.isr_sample_rate = 16;
            platform.adc_sample_rate = 16;
            platform.commutation = FOC_SENSOR;
            platform.last_drive = platform.powerboard->last_axis;
            break;

        case DEMO_OPEN_LOOP_SINE_32:
            // Open loop sinusoidal 32 kHz Volts/Hz
            debug_printf(DBG_INFO, "Open loop Sinusoidal 32 kHz Volts/Hz\n");
            platform.isr_sample_rate = 32;
            platform.adc_sample_rate = 32;
            platform.commutation = FOC_SENSOR;
            platform.last_drive = platform.powerboard->last_axis;
            break;

        case DEMO_FOC_SENSOR_16_2:
            // FOC sensor 16kHz dual axis (Tandem)
            debug_printf(DBG_INFO, "FOC sensor 16 kHz two axes\n");
            platform.isr_sample_rate = 16;
            platform.adc_sample_rate = 16;
            platform.commutation = FOC_SENSOR;
            platform.last_drive = platform.powerboard->last_axis;
            break;

        case DEMO_FOC_SENSOR_32_2:
            // FOC sensor 32kHz dual axis (Tandem)
            debug_printf(DBG_INFO, "FOC sensor 32 kHz two axes\n");
            platform.isr_sample_rate = 32;
            platform.adc_sample_rate = 32;
            platform.commutation = FOC_SENSOR;
            platform.last_drive = platform.powerboard->last_axis;
            break;

        case DEMO_FOC_SENSOR_DSP_FIXED_64_2:
            // FOC sensor 64kHz dual axis (Tandem)
            debug_printf(DBG_INFO, "FOC sensor 64 kHz single axes\n");
            sp.dsp_mode = DSPBA_FIXP;
            platform.isr_sample_rate = 32;
            platform.adc_sample_rate = 64;
            platform.commutation = FOC_SENSOR;
            platform.last_drive = platform.powerboard->last_axis;
            break;

        default:
            debug_printf(DBG_ERROR, "Unsupported demo mode selected\n");
            break;
        }

        sp.demo_mode = demo_select;
    }

    // Switch ADC modes
    adc_select = debug_read_adc_type();
    if (adc_select != sp.lvmc_adc_type) {
        // Handle demo mode change request, will reset drive if a there is a change
        debug_printf(DBG_INFO, "\n\nADC mode change request %d\n", demo_select);
        ret = 1;
        // Do not reset Motor_types structs, because if in Trapezoidal/Hall mode, motor type is not default motor type.
        drive_reset_with_flag(false);

        sp.lvmc_adc_type = adc_select;
    }

    //Switch DSP modes between software & DSP builder
    mode_select = debug_read_dsp_mode();
    if (mode_select != sp.dsp_mode) {
        debug_printf(DBG_INFO, "\n\nDSP mode change request: %d\n", mode_select);

        //Reset the control loop
        for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
            dp[dn].reset_control = 1;
        }
        if (sp.demo_mode == DEMO_FOC_SENSOR_DSP_FIXED_64_2) {
            // Force soft floating point mode for FOC sensorless
            debug_printf(DBG_INFO, "DSP mode restricted to DSPBA fixed point for high speed FOC\n");
            mode_select = DSPBA_FIXP;
        }
        sp.dsp_mode = mode_select;
    }

    return ret;
}

/**
 * main loop task, initializes and loops forever.
 *
 * @param pdata
 */
task_t motor_task(void *pdata)
{
    int dn; // drive number index
    int restart_on_error = 0;
    int restart_on_mode = 0;
    drive_callback_fn_t drive_enable_notify = ((drive_state_callbacks_t *)pdata)->drive_enable_cb;
    drive_callback_fn_t drive_reset_notify  = ((drive_state_callbacks_t *)pdata)->drive_reset_cb;
    short dc_dc_v_fb;

    memset(&dp[0], 0, sizeof(dp));
    memset(&sp, 0, sizeof(sp));
    memset((unsigned char *)SYS_CONSOLE_DEBUG_RAM_BASE, 0, SYS_CONSOLE_DEBUG_RAM_SIZE_VALUE);
    memset((unsigned char *)SVM_DUMP_MEM_BASE, 0, SVM_DUMP_MEM_SPAN);
    init_sin_tables();

    // Determine what hardware we are running on
    if (decode_sysid(SYSID_0_BASE) > 0) {
        debug_printf(DBG_FATAL, "[Motor task] Could not decode SYSID\n");
        while (1) {
            OS_SLEEP_MS(1000);
        }
    }

#if (defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE))
    debug_printf(DBG_INFO, "Motor model: DSPBA fixed point version\n");
#endif

    init_sp(&sp);
    for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        dp[dn].motor = motors[dn];
    }

    // Configure the DC link
    debug_printf(DBG_INFO, "[Motor task] Setup DC link\n");

    while (1) {
        // Loop here after error or demo mode change. Drive state machines
        // have been reset to preinit state ignoring errors.
        debug_printf(DBG_INFO, "[Motor task] Start 'while (1)' loop\n");

        // Initialise all drives
        init_dp(&dp[0], &sp);    //at the end of init_dp() init of motor model    //APP_DRIVE_SIM
        write_to_gui();

        // Disable platform specific IRQ handling for drive IRQ

        alt_ic_isr_register(0, DRIVE0_DOC_ADC_IRQ, NULL, NULL, NULL);

        adc_irq_acknowledge(&dp[0]);    // Clear any spurious IRQ from the ADC

        sp.app_state = APP_INIT;

        // Reset drive state machines to preinit state ignoring error until system is stable
        // Check and report state
        debug_printf(DBG_INFO, "[Motor task] Reset drive state machines\n");
        for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
            dsm_reset(dp[dn].DOC_SM_BASE_ADDR);
            dp[dn].status_word = (DSM_STATUS_MASK & IORD_16DIRECT(dp[dn].DOC_SM_BASE_ADDR, SM_STATUS));
            dp[dn].state_act    = dp[dn].status_word >> DSM_STATUS_STATE_OFFSET;
            decode_error_state(dn);
        }

        // Set up the ADCs and enable IRQs
        debug_printf(DBG_INFO, "[Motor task] Init ADCs\n");
        for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
            adc_setup(&dp[dn]);
        }
        debug_printf(DBG_INFO, "[Motor task] Enable platform IRQs\n");

        alt_ic_isr_register(0, DRIVE0_DOC_ADC_IRQ, drive_irq, NULL, NULL);


        debug_printf(DBG_ALWAYS, "[Motor task] Open loop startup: %d\n",
            ((sp.demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp.demo_mode == DEMO_OPEN_LOOP_SINE_32)) ? 1 : 0);
        debug_printf(DBG_ALWAYS, "[Motor task] Commutation: %d\n", platform.commutation);

        // Test if button is pressed to indicate interactive startup, unless it's already enabled
        debug_printf(DBG_ALWAYS, "[Motor task] Interactive startup: %d\n", sp.interactive_start);

        sp.app_state = APP_DRIVE_INIT;

        sp.app_state = APP_PWM_INIT;

        // PWM modules must be setup for all channels to ensure consistent synchronisation
        // pwm_init() will re-enable if PWM was disabled by sample rate change
        debug_printf(DBG_INFO, "[Motor task] PWM clock %d Hz\n", DRIVE0_DOC_PWM_FREQ);
        debug_printf(DBG_INFO, "[Motor task] Requested adc sample rate %d kHz\n", platform.adc_sample_rate);
        if (pwm_init(dp) != PWM_OK) {
            debug_printf(DBG_FATAL, "[Motor task] PWM setup failed\n");
            while (1) {
                OS_SLEEP_MS(1000);
            }
        }
        debug_printf(DBG_INFO, "[Motor task] PWM count %d\n", platform.pwm_count);
        debug_printf(DBG_INFO, "[Motor task] Actual sample rate %lld kHz\n",
                (long long int)DRIVE0_DOC_PWM_FREQ/platform.pwm_count/1000);

        // PWM counter is now running, generating ADCs triggers.
        // ADC will interrupt when conversion is complete.
        // ISR will close feedback loop for DC-DC boost converter, although it is not yet enabled.

        sp.app_state = APP_WAIT_POWER;

        // Check and wait for the DC input voltage measurement to be in range
        debug_printf(DBG_INFO, "[Motor task] Check DC Input\n");

        // Reset latched dc input errors
        debug_printf(DBG_INFO, "[Motor task] Reset DC-DC error status\n");
        adc_threshold_init();

        sp.app_state = APP_POWER_OK;
        // Enable error checking and report state
        debug_printf(DBG_INFO, "[Motor task] Move to init state and enable error checking\n");
        for (dn = 0; dn <= platform.last_drive; dn++) {
            dsm_init(dp[dn].DOC_SM_BASE_ADDR);
            dp[dn].status_word = (DSM_STATUS_MASK & IORD_16DIRECT(dp[dn].DOC_SM_BASE_ADDR, SM_STATUS));
            dp[dn].state_act = dp[dn].status_word >> DSM_STATUS_STATE_OFFSET;
            decode_error_state(dn);
        }

        debug_waitchar(DBG_INFO, "[Motor task] ***\nPress a key to calibrate ADCs\n", sp.interactive_start);

        if (platform.powerboard_present == 0) {
            sp.app_state = APP_LOOPBACK;


            while (1) {
                adc_offset_calculation(dp);
            }
        } else {
            sp.app_state = APP_ADC_CALIBRATION;
            while (adc_offset_calculation(dp) > 0) {
                sp.app_state = APP_ADC_FAIL;
                #if ((defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE)))
                    //[Motor task] ---> Simulation mode: skip ADC calibration.\n
                    debug_printf(DBG_ERROR, "[Motor task] ---> while(1) to force ADC calibration.\n");
                #else
                    debug_printf(DBG_ERROR, "[Motor task] ---> Failure detected in ADC calibration.\n");
                #endif
                OS_SLEEP_MS(2000);
                sp.app_state = APP_ADC_CALIBRATION;
            }
        }

        sp.app_state = APP_ADC_CALIBRATED;
        //APP_DRIVE_SIM (suggested member to add to app_state_e)

        debug_waitchar(DBG_INFO, "[Motor task] ***\nPress a key to start DC-DC***\n", sp.interactive_start);

        sp.app_state = APP_INIT_DCDC;

        // It should now be safe to bring up the DC-DC boost converter
        if (platform.powerboard_present == 1) {
            debug_printf(DBG_INFO, "[Motor task] Enable DC-DC boost converter in closed loop mode at %d V\n",
                        sp.dc_dc_v_scaled);
            debug_waitchar(DBG_INFO, "[Motor task] ***\nPress a key to disable DC-DC***\n",
                        sp.interactive_start);

            debug_waitchar(DBG_INFO, "[Motor task] ***\nPress a key to enable DC-DC***\n",
                        sp.interactive_start);

            OS_SLEEP_MS(100);

            // Now set the requested voltage and wait for the ramp to apply it.
            // lvdcdc_set_voltage(&sp) is used to write direct to the hardware rather than ramping.
            // During ramping the voltage, there is not need to call lvdcdc_set_voltage(&sp),
            // so that is why here it is not called.
            // In order to ramp the voltage, all we need to do is set the correct value of sp.dc_dc_cmd_v,
            // so that the other part of the code will handle this.
            // There is a fucntion called lvdcdc_update() will do the voltage ramp.
            // Function deferred_irq_task() will call lvdcdc_update() every PWM cycle.
            // So after we setting the correct value for sp.dc_dc_cmd_v,
            // at the same time deferred_irq_task() is running in parallel,  deferred_irq_task()
            // will call lvdcdc_update() to ramp to the right voltage,
            // make sure to wait long enough after this had been completed.
            sp.dc_dc_cmd_v = dp[dn].motor->DC_link;

            // Wait for DC-DC to ramp up, based on change in voltage
            OS_SLEEP_MS((sp.dc_dc_cmd_v - sp.dc_dc_v_scaled)*15);

            // Check and wait for the DC link voltage measurement to be in range
            debug_printf(DBG_INFO, "[Motor task] Check DC Link\n");
        } else {
            debug_printf(DBG_INFO, "[Motor task] DC-DC enable is skipped\n");
        }
        debug_update_dc_dc_setp(sp.dc_dc_cmd_v);

        sp.app_state = APP_DCDC_OK;

        debug_update_drive_status(0, 6); //passed voltage test

        // Initialise Encoders
        for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
            debug_printf(DBG_INFO, "[Motor task] %s init for channel %d\n", dp[dn].motor->encoder_name, dn);
            dp[dn].motor->encoder_init_fn(&dp[dn]);
        };

        debug_waitchar(DBG_INFO, "[Motor task]\n***Press a key to calibrate encoders\n", sp.interactive_start);

        // Open loop and sensorless modes do not need an encoder but we still calibrate so that we can use the
        // encoder output as a reference in the gui.
        // Calibrate encoders that do not store their own offset
        for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
            if (dp[dn].motor->calibration_method == ENCODER_CALIBRATION_ALWAYS) {
                // Calibrate encoders that do not store their own offset
                sp.app_state = APP_ENCODER_CALIBRATION;
                debug_printf(DBG_INFO, "[Motor task] %s calibration for channel %d\n", dp[dn].motor->encoder_name, dn);
                dp[dn].motor->encoder_service_fn(&dp[dn], &sp);
            } else {
                debug_printf(DBG_INFO, "[Motor task] Skipping %s calibration for channel %d\n",
                            dp[dn].motor->encoder_name, dn);
            }
        }

        sp.app_state = APP_ENCODER_CALIBRATED;

        debug_update_drive_status(0, 7); //passed EnDat test

        debug_waitchar(DBG_INFO, "[Motor task] ***\nPress a key to continue startup\n",
                    sp.interactive_start);

        sp.app_state = APP_DRIVE_ENABLED;
        if (drive_enable_notify) {
            (*drive_enable_notify)();
        }

        restart_on_error = 0;
        restart_on_mode = 0;
        debug_printf(DBG_INFO, "[Motor task] Start 'while restart_on_error == 0' loop\n");
        while ((restart_on_error == 0) && (restart_on_mode == 0)) {
            // DC_link is set in the motor model.
            // Iterate from 0 to always update axis 0 as it includes axis independent data
            for (dn = 0; dn <= platform.last_drive; dn++) {
                debug_update_drive_params(dn,
                    dp[dn].state_act,
                    dp[dn].encoder.speed_encoder,
                    dp[dn].pos_16q16);

                /*
                 * dc_link_read()
                 *
                 * Used to reads the DC input and DC link voltages and currents.
                 * These are now read in the ISR along with other samples. All we do here is
                 * scale them for use in limit checks..
                 *
                 * The lvdcdc output voltage and inductor current feedback are read each ISR, not here.
                 */
                //dc_link_read(&sp);
                sp.dc_dc_v_scaled = (short)(sp.sd_platform_adc.dc_dc_v_fb / (dp[dn].motor->V_DC_link_scale_V));
                update_axis(&dp[dn]);
            }

            if ((platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) && ((sp.lvmc_adc_type == ADC_TYPE_MAX10))) {
                dc_dc_v_fb = sp.max10_platform_adc.dc_dc_v_fb;
            } else {
                dc_dc_v_fb = sp.sd_platform_adc.dc_dc_v_fb;
            }
            debug_update_sys_params(sp.app_state, sp.dsp_mode, dc_dc_v_fb);

            read_from_gui();

            // Drive state machine
            for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
                if (dp[dn].state_act != 3) { //Disable Motor when not in Run State
                    dp[dn].enable_drive = 0;
                }

                dp[dn].state_act_old  = dp[dn].state_act;
                dp[dn].status_word = (DSM_STATUS_MASK & IORD_16DIRECT(dp[dn].DOC_SM_BASE_ADDR, SM_STATUS));
                dp[dn].state_act    = dp[dn].status_word >> DSM_STATUS_STATE_OFFSET;
                if (dp[dn].state_act != dp[dn].state_act_old) {
                    debug_printf(DBG_INFO, "Axis %d: State now %d  Status=%04X\n", dn,
                                dp[dn].state_act, dp[dn].status_word);
                }

                switch (dp[dn].state_act) {
                case DSM_STATE_PREINIT:
                    // Will be in preinit state if we loop here after restart_all_drives() due to drive error
                    dp[dn].state_next = DSM_CONTROL_TO_INIT;
                    break;

                case DSM_STATE_INIT:
                    // Reset current controller command values and SVM output voltage
                    dp[dn].enable_drive = 0;
                    debug_update_drive_status(dn, 0);
                    adc_overcurrent_enable(&dp[dn], 0); // overcurrent measurement disabled
                    // Go to pre-charge state
                    dp[dn].state_next = DSM_CONTROL_TO_PRECHARGE;

// not used in Agilex Devices, kept for consistency across platforms (MAX10).
#ifdef __ECFS_DOC_THRESHOLD_SINK
                    if ((platform.device_family->sysid == SYSID_MAX10M50)
                        || (platform.device_family->sysid == SYSID_CVSX_NIOS)) {
                        // Enable voltage threshold errors
                        if (dn == platform.first_drive) {
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_UNDER_ENABLE_REG, THR_VOLTAGE_ERROR);
                            debug_printf(DBG_DEBUG, "Under latch enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_UNDER_ENABLE_REG));
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_OVER_ENABLE_REG, THR_VOLTAGE_ERROR);
                            debug_printf(DBG_DEBUG, "Over latch enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_OVER_ENABLE_REG));
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_UNDER_ENABLE_REG, THR_VOLTAGE_ERROR);
                            debug_printf(DBG_DEBUG, "Under output enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_UNDER_ENABLE_REG));
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_OVER_ENABLE_REG, THR_VOLTAGE_ERROR);
                            debug_printf(DBG_DEBUG, "Over output enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_OVER_ENABLE_REG));
                        }
                    }
#endif
                    break;

                case DSM_STATE_PRECHARGE:
                    debug_update_drive_status(dn, 1);
                    // Go to pre-run state
                    dp[dn].state_next = DSM_CONTROL_TO_PRERUN;
#ifdef __ECFS_DOC_THRESHOLD_SINK
                    if ((platform.device_family->sysid == SYSID_MAX10M50)
                        || (platform.device_family->sysid == SYSID_CVSX_NIOS)) {
                        // Enable overcurrent errors
                        if (dn == 0) {
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_OVER_ENABLE_REG, THR_DRIVE0_OC);
                            debug_printf(DBG_DEBUG, "Over latch enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_OVER_ENABLE_REG));
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_OVER_ENABLE_REG, THR_DRIVE0_OC);
                            debug_printf(DBG_DEBUG, "Over output enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_OVER_ENABLE_REG));
                        } else if (dn == 1) {
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_OVER_ENABLE_REG, THR_DRIVE1_OC);
                            debug_printf(DBG_DEBUG, "Over latch enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_CAPTURE_OVER_ENABLE_REG));
                            adc_max10_threshold_enable(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_OVER_ENABLE_REG, THR_DRIVE1_OC);
                            debug_printf(DBG_DEBUG, "Over output enable: %04X\n",
                                adc_max10_threshold_read(ECFS_DOC_THRESHOLD_SINK_BASE,
                                THR_OUTPUT_OVER_ENABLE_REG));
                        }
                    }
#endif
                    break;

                case DSM_STATE_PRERUN:
                    debug_update_drive_status(dn, 2);
                    adc_overcurrent_enable(&dp[dn], 1);        // enable overcurrent measure
                    // Go to run state
                    dp[dn].state_next = DSM_CONTROL_TO_RUN;
                    break;

                case DSM_STATE_RUN:
                    // Will stay here until DSM status changes due to error
                    dp[dn].enable_drive = 1;
                    break;

                case DSM_STATE_ERROR:
                    // This will cause us to drop out of the while loop and reset the drive(s)
                    restart_on_error = 1;
                    debug_printf(DBG_DEBUG, "[Motor task] State now DSM_STATE_ERROR\n");
                    break;
                }
                OS_SLEEP_MS(100);
                // Move to next state
                IOWR_16DIRECT(dp[dn].DOC_SM_BASE_ADDR, SM_CONTROL, dp[dn].state_next);
            }

            // Check for restart due to change of demo mode
            restart_on_mode = update_from_gui();
        }    // while ((restart_on_error == 0) && (restart_on_mode == 0))
        debug_printf(DBG_INFO,
            "[Motor task] Exited 'while ((restart_on_error == 0) && (restart_on_mode == 0))' loop\n\n\n");

        if (drive_reset_notify) {
            (*drive_reset_notify)();
        }

        sp.app_state = APP_DRIVE_RESTART;

        if (restart_on_error) {
            // Restarting due to error (not mode change) so decode the errors and allow the user to interact
#ifdef __ECFS_DOC_THRESHOLD_SINK
            if ((platform.device_family->sysid == SYSID_MAX10M50)
                || (platform.device_family->sysid == SYSID_CVSX_NIOS)) {
                // Decode errors from MAX10 ADC threshold monitor
                decode_threshold_error_state();
                dp[dn].enable_drive = 0;
            }
#endif

            for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
                // decode errors from axes
                decode_error_state(dn);
            }

            sp.app_state = APP_INIT;

            debug_waitchar(DBG_ALWAYS, "[Motor task] ***\n\n\nPress a key to continue after error\n", 1);

            // User may have changed GUI demo mode setting before restarting
            update_from_gui();
        }
    }    // while (1)
}

/*!
 * @}
 */
