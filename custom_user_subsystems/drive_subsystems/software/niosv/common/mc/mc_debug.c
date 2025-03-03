/* ##################################################################################
 * Copyright (C) 2025 Intel Corporation
 *
 * This software and the related documents are Intel copyrighted materials, and
 * your use of them is governed by the express license under which they were
 * provided to you ("License"). Unless the License provides otherwise, you may
 * not use, modify, copy, publish, distribute, disclose or transmit this software
 * or the related documents without Intel's prior written permission.
 *
 * This software and the related documents are provided as is, with no express
 * or implied warranties, other than those that are expressly stated in the License.
 * ##################################################################################
 */

/**
 * @file mc_debug.c
 *
 * @brief Interface functions for system console debug GUI
 */

#include "mc_debug.h"

#include <stdio.h>

#include "io.h"
#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#include "mc/mc_params.h"
#include "mc/mc.h"
#include "mc/motor_task.h"
#include "mc/mc_nios_perf.h"
#include "platform/common/platform.h"

#include "main.h"
#include "app_cfg.h"

/**
 * (Re-)initialize the gui at startup or after error or mode change.
 *
 */
void write_to_gui(void)
{
    drive_params *dp = get_dp();
    system_params *sp = get_sp();
    int dn;

    if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
        debug_write_status(0, DOC_DBG_ADC_TYPE, DEFAULT_ADC_TYPE);
    }

    debug_write_status(0, DOC_DBG_DEMO_MODE, sp->demo_mode);
    debug_write_status(0, DOC_DBG_ADC_TYPE, sp->lvmc_adc_type);
    debug_write_status(0, DOC_DBG_BUTTON_DSP_MODE, sp->dsp_mode);

    // Leave this as 0 to platform.last_drive for debug interface
    for (dn = 0; dn <= platform.last_drive; dn++) {
        debug_write_status(dn, DOC_DBG_I_PI_KP, dp[dn].motor->iq_kp);
        debug_write_status(dn, DOC_DBG_I_PI_KI, dp[dn].motor->iq_ki);
        debug_write_status(dn, DOC_DBG_SPEED_PI_KP, dp[dn].motor->speed_kp);
        debug_write_status(dn, DOC_DBG_SPEED_PI_KI, dp[dn].motor->speed_ki);

        debug_write_status(dn, DOC_DBG_SPEED_SETP0, dp[dn].speed_request>>SPEED_FRAC_BITS);
        debug_write_status(dn, DOC_DBG_AXIS_SELECT, 0);

        debug_write_status(dn, DOC_DBG_POS_SETP0, dp[dn].pos_request);
        debug_write_status(dn, DOC_DBG_WAVE_DEMO_MODE, dp[dn].pos_speed_demo_mode);
        debug_write_status(dn, DOC_DBG_POS_SPEED_LIMIT, dp[dn].pos_speed_limit>>SPEED_FRAC_BITS);
        debug_write_status(dn, DOC_DBG_POS_PI_KP, dp[dn].motor->pos_kp);
    }
}

/**
 * Update parameters from the gui.
 */
void read_from_gui(void)
{
    drive_params *dp = get_dp();
    system_params *sp = get_sp();
    int dn;

    sp->axis_select = debug_read_command(0, DOC_DBG_AXIS_SELECT);
    if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
        sp->dc_dc_cmd_v = debug_read_command(0, DOC_DBG_DCDC_V_SETP0);
    }

    for (dn = 0; dn <= platform.last_drive; dn++) {

        dp[dn].motor->id_kp = debug_read_command(dn, DOC_DBG_I_PI_KP);
        dp[dn].motor->id_ki = debug_read_command(dn, DOC_DBG_I_PI_KI);
        dp[dn].motor->iq_kp = debug_read_command(dn, DOC_DBG_I_PI_KP);
        dp[dn].motor->iq_ki = debug_read_command(dn, DOC_DBG_I_PI_KI);
        dp[dn].motor->speed_kp = debug_read_command(dn, DOC_DBG_SPEED_PI_KP);
        dp[dn].motor->speed_ki = debug_read_command(dn, DOC_DBG_SPEED_PI_KI);

        dp[dn].speed_request = debug_read_command(dn, DOC_DBG_SPEED_SETP0) << SPEED_FRAC_BITS;
        dp[dn].pos_request = debug_read_command(dn, DOC_DBG_POS_SETP0);

        int temp_pos_mode = debug_read_command(dn, DOC_DBG_WAVE_DEMO_MODE);

        if (temp_pos_mode != dp[dn].pos_speed_demo_mode) {
            //Reset the multi-turn position when switching to/from position mode
            dp[dn].pos_turns = 0;
        }
        dp[dn].pos_speed_demo_mode = temp_pos_mode;
        if (dp[dn].pos_speed_demo_mode != 2) {
            // don't update the speed limit in clock demo mode as it is controlled by the demo code
            dp[dn].pos_speed_limit = debug_read_command(dn, DOC_DBG_POS_SPEED_LIMIT) << SPEED_FRAC_BITS;
        }
        dp[dn].motor->pos_kp = debug_read_command(dn, DOC_DBG_POS_PI_KP);

    }

    void update_trace_params_from_gui(system_params *sp, drive_params *dp);
    update_trace_params_from_gui(sp, dp);
}

/************************************************************************************/
/**
 * Translate sample data into integer
 * Used to get trigger_in value, called from dump_data ISR routine
 */
int ushort_ptr_to_int(void *trigger_in_ptr) IRQ_SECTION;
int ushort_ptr_to_int(void *trigger_in_ptr)
{
  return (int) (*((unsigned short *)trigger_in_ptr));
}
int short_ptr_to_int(void *trigger_in_ptr) IRQ_SECTION;
int short_ptr_to_int(void *trigger_in_ptr)
{
  return (int) (*((short *)trigger_in_ptr));
}
int int_ptr_to_int(void *trigger_in_ptr) IRQ_SECTION;
int int_ptr_to_int(void *trigger_in_ptr)
{
  return (int) (*((int *)trigger_in_ptr));
}
int unsigned_ptr_to_int(void *trigger_in_ptr) IRQ_SECTION;
int unsigned_ptr_to_int(void *trigger_in_ptr)
{
  return (int) (*((unsigned int *)trigger_in_ptr));
}
int int_ptr_to_int_with_SPEED_FRAC_BITS_rshift(void *trigger_in_ptr) IRQ_SECTION;
int int_ptr_to_int_with_SPEED_FRAC_BITS_rshift(void *trigger_in_ptr)
{
  return (int) (*((int *)(trigger_in_ptr))) >> SPEED_FRAC_BITS;
}

/************************************************************************************/

/**
 * Update trace parameters from the gui.
 */
void update_trace_params_from_gui(system_params *sp, drive_params *dp)
{

    int axis_select = sp->axis_select;

    drive_adc_t *drive_adc_ptr = &dp[axis_select].sd_drive_adc;    // Default to sigma delta drive ADC
    platform_adc_t *platform_adc_ptr = &sp->sd_platform_adc;        // Some are available from platform ADC

#ifdef __ALTERA_MODULAR_DUAL_ADC
    if (sp->lvmc_adc_type == ADC_TYPE_MAX10) {
        // Switch to MAX10 ADCs
        drive_adc_ptr = &dp[axis_select].max10_drive_adc;
        platform_adc_ptr = &sp->max10_platform_adc;
    }
#endif

    int (*get_trigger_in)(void *) = NULL;

    int dump_trig_edge = debug_read_command(0, DOC_DBG_TRIG_EDGE);
    int trigger_data_select = debug_read_command(0, DOC_DBG_TRIG_SEL);
    int trigger_value = debug_read_command(0, DOC_DBG_TRIG_VALUE);
    int trace_depth = debug_read_command(0, DOC_DBG_TRACE_DEPTH);

    int *trigger_in_ptr = NULL;
    int sample_skip = debug_read_command(0, DOC_DBG_TRACE_SAMPLES);

    if (sample_skip > 32) {
        sample_skip = 1;
    }

    if (trace_depth < 256) {
        trace_depth = 256;
    } else if (trace_depth > 4096) {
        trace_depth = 4096;
    }

       /*  Select triger_in */
    switch (trigger_data_select) {
    default:
        trigger_in_ptr = NULL;    //Trigger always TRIGGER_ALWAYS
        get_trigger_in = NULL;
        break;
    case TRIGGER_VU_PWM:
        trigger_in_ptr = (void *) &dp[axis_select].vu_pwm;
        get_trigger_in = ushort_ptr_to_int;
        break;
    case TRIGGER_VV_PWM:
        trigger_in_ptr = (void *) &dp[axis_select].vv_pwm;
        get_trigger_in = ushort_ptr_to_int;
        break;
    case TRIGGER_VW_PWM:
        trigger_in_ptr = (void *) &dp[axis_select].vw_pwm;
        get_trigger_in = ushort_ptr_to_int;
        break;
    case TRIGGER_IU:
        trigger_in_ptr = (void *) &drive_adc_ptr->iu;
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_IU_MEASURE:
        trigger_in_ptr = (void *) &drive_adc_ptr->iu_measure;
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_IV:
        trigger_in_ptr = (void *) &(drive_adc_ptr->iv);
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_IW:
        trigger_in_ptr = (void *) &drive_adc_ptr->iw;
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_SPD_CMD:
        trigger_in_ptr = (void *) &dp[axis_select].speed_command;
        get_trigger_in = int_ptr_to_int_with_SPEED_FRAC_BITS_rshift;
        break;
    case TRIGGER_SPD:
        trigger_in_ptr = (void *) &dp[axis_select].encoder.speed_encoder;
        get_trigger_in = int_ptr_to_int_with_SPEED_FRAC_BITS_rshift;
        break;
    case TRIGGER_SPD_EST:
        break;
    case TRIGGER_ID:
        trigger_in_ptr = (void *) &dp[axis_select].id;
        get_trigger_in = int_ptr_to_int;
        break;
    case TRIGGER_IQ:
        trigger_in_ptr = (void *) &dp[axis_select].iq;
        get_trigger_in = int_ptr_to_int;
        break;
    case TRIGGER_IQ_CMD:
        trigger_in_ptr = (void *) &dp[axis_select].i_command_q;
        get_trigger_in = int_ptr_to_int;
        break;
    case TRIGGER_POS:
        trigger_in_ptr = (void *) &dp[axis_select].pos_16q16;
        get_trigger_in = int_ptr_to_int;
        break;
    case TRIGGER_POS_CMD:
        trigger_in_ptr = (void *) &dp[axis_select].pos_setpoint;
        get_trigger_in = int_ptr_to_int;
        break;
    case TRIGGER_ENABLE_DRIVE:
        trigger_in_ptr = (void *) &dp[axis_select].state_act;
        get_trigger_in = ushort_ptr_to_int;
        break;
    case TRIGGER_APP_STATE:
        trigger_in_ptr = (void *) &sp->app_state;
        get_trigger_in = int_ptr_to_int;
        break;
    case TRIGGER_VU:
        trigger_in_ptr = (void *) &drive_adc_ptr->vu;
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_VV:
        trigger_in_ptr = (void *) &drive_adc_ptr->vv;
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_VW:
        trigger_in_ptr = (void *) &drive_adc_ptr->vw;
        get_trigger_in = short_ptr_to_int;
        break;
    case TRIGGER_DCDC_V:
        trigger_in_ptr = (void *) &platform_adc_ptr->dc_dc_v_fb;
        get_trigger_in = short_ptr_to_int;
        break;
    }

    sp->trace_params.dump_trig_edge = dump_trig_edge;
    sp->trace_params.trace_depth = trace_depth;
    sp->trace_params.sample_skip = sample_skip;

    sp->trace_params.trigger_value = trigger_value;
    sp->trace_params.trigger_in_ptr = trigger_in_ptr;
    sp->trace_params.get_trigger_in = get_trigger_in;

}

/*
 * Dump selected data to system console Tcl GUI
 */
void dump_data(const drive_params *dp, const system_params *sp)
{
    int axis_select = sp->axis_select;
    const drive_adc_t *drive_adc_ptr = &dp[axis_select].sd_drive_adc; // Default to sigma delta drive ADC
    const platform_adc_t *platform_adc_ptr = &sp->sd_platform_adc;    // Some are available from platform ADC

#ifdef __ALTERA_MODULAR_DUAL_ADC
    if (sp->lvmc_adc_type == ADC_TYPE_MAX10) {
        // Switch to MAX10 ADCs
         drive_adc_ptr = &dp[axis_select].max10_drive_adc;
        platform_adc_ptr = &sp->max10_platform_adc;
    }
#endif

    static int dump_addr = 0;
    static int samples = 0;
    static int sample_skip_count = 0;
     static int trigger_in_prev = 0;
    static int trigger_out = 0;

    //Update dump debug variables

    int dump_mode;

    dump_mode = debug_read_command(0, DOC_DBG_DUMP_MODE);

    int trigger_in = 0;
    int dump_trig_edge = sp->trace_params.dump_trig_edge;
    int trigger_value = sp->trace_params.trigger_value;
    int sample_skip = sp->trace_params.sample_skip;
    int trace_depth = sp->trace_params.trace_depth;

/****************************************************************/

    /* Always update trigger_in */
    if (sp->trace_params.get_trigger_in != NULL) {
        trigger_in = sp->trace_params.get_trigger_in(sp->trace_params.trigger_in_ptr);
    } else {
        trigger_in = 0;
    }

    if (trigger_out == 0) {

        if (sp->trace_params.get_trigger_in == NULL) {
                trigger_out = 1;
        } else {
            switch (dump_trig_edge) {
            case TRIGGER_EQUAL:
                if (trigger_in == trigger_value) {
                    trigger_out = 1;
                }
                break;
            case TRIGGER_RISING_EDGE:
                if ((trigger_in > trigger_value) && (trigger_in_prev <= trigger_value)) {
                    trigger_out = 1;
                }
                break;
            case TRIGGER_FALLING_EDGE:
                if ((trigger_in < trigger_value) && (trigger_in_prev >= trigger_value)) {
                    trigger_out = 1;
                }
                break;
            case TRIGGER_ANY_EDGE:
                if (((trigger_in < trigger_value) && (trigger_in_prev >= trigger_value)) ||
                        ((trigger_in > trigger_value) && (trigger_in_prev <= trigger_value))) {
                    trigger_out = 1;
                }
                break;
            default:
                trigger_out = 0;
                break;
            }

        }

    }

    /* Always update trigger_in_prev */
    trigger_in_prev = trigger_in;

    // Now always allow trace, even when drive disabled, so trace will work during interactive startup
    // Memory spaces commented out related to DC-DC converter that was removed from current version.
    if ((dump_mode == 0) && (dump_addr < (SVM_DUMP_MEM_SPAN-2)) && (samples < trace_depth)) {
        if (trigger_out) {

            if (sample_skip_count == 0) {
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].vu_pwm);    // 0 SVM V_u
                dump_addr += 2;
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].vv_pwm);    // 1 SVM V_v
                dump_addr += 2;
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].vw_pwm);    // 2 SVM V_w
                dump_addr += 2;

                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->iu);          // 3 ADC I_u
                dump_addr += 2;
                if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->iv);     // 4 ADC I_v
                    dump_addr += 2;
                                                                                        // 4 ADC I_v (calculated)
                } else {
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, (0 - drive_adc_ptr->iw - drive_adc_ptr->iu));
                    dump_addr += 2;
                }
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->iw);         // 5 ADC I_w
                dump_addr += 2;

                                                                                        // 6 Commanded speed
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].speed_command>>SPEED_FRAC_BITS);
                dump_addr += 2;
                                                                                        // 7 Measured speed from encoder
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].encoder.speed_encoder>>SPEED_FRAC_BITS);
                dump_addr += 2;
                                                                                        // 8 Measured speed from encoder
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].encoder.speed_encoder>>SPEED_FRAC_BITS);
                dump_addr += 2;

                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].id);       // 9 Calculated Id
                dump_addr += 2;
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, 0);                        // 10 Commanded Id
                dump_addr += 2;
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].iq);       // 11 Calculated Iq
                dump_addr += 2;
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].i_command_q);// 12 Commanded Iq
                dump_addr += 2;

                // Padding to align to 32 bit word boundary before IOWR_32
                IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, 0);                         // 13 Padding
                dump_addr += 2;

                if ((sp->demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp->demo_mode == DEMO_OPEN_LOOP_SINE_32)) {
                    // Open loop position
                                                                                        // 14 Measured position
                    IOWR_32DIRECT(SVM_DUMP_MEM_BASE, dump_addr, (unsigned int)dp[axis_select].phi_mech);
                    dump_addr += 4;
                                                                                        // 15 Commanded position
                    IOWR_32DIRECT(SVM_DUMP_MEM_BASE, dump_addr, (unsigned int)dp[axis_select].open_loop_idx_q16);
                    dump_addr += 4;
                                                                                        // 14 Measured position
                } else {
                    IOWR_32DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].pos_16q16);
                    dump_addr += 4;
                                                                                        // 15 Commanded position
                    IOWR_32DIRECT(SVM_DUMP_MEM_BASE, dump_addr, dp[axis_select].pos_setpoint);
                    dump_addr += 4;
                }
                if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
                    short eff = 0;
                    // Additional sample data available on the Tandem Motion Power board
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->vu);     // 16 ADC Motor phase U voltage
                    dump_addr += 2;
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->vv);     // 17 ADC Motor phase V voltage
                    dump_addr += 2;
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->vw);     // 18 ADC Motor phase W voltage
                    dump_addr += 2;
                                                                                        // 19 ADC DC input voltage
                    //IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, platform_adc_ptr->dc_dc_v_in);
                    dump_addr += 2;
                                                                                        // 20 ADC DC input current only
                                                                                        // available from sigma-delta
                    //IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, sd_platform_adc_ptr->dc_dc_i_in);
                    dump_addr += 2;
                                                                                        // 21 ADC DC link voltage
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, platform_adc_ptr->dc_dc_v_fb);
                    dump_addr += 2;
                                                                                        // 22 ADC DC link current only
                                                                                        // available from sigma-delta
                    //IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, sd_platform_adc_ptr->dc_dc_i);
                    dump_addr += 2;
                                                                                        // 23 ADC DC-DC phase 0
                                                                                        // inductor current
                    //IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, platform_adc_ptr->dc_dc_boost0_fb);
                    dump_addr += 2;
                                                                                        // 24 ADC DC-DC phase 0
                                                                                        // inductor current
                    //IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, platform_adc_ptr->dc_dc_boost1_fb);
                    dump_addr += 2;
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, drive_adc_ptr->iu_measure);// 25 ADC I_u measured
                    dump_addr += 2;
                    // Padding (if required) to align to 32 bit word boundary
                    //IOWR_32DIRECT(SVM_DUMP_MEM_BASE, dump_addr, (unsigned int)powerin);  // 26 PowerIn
                    dump_addr += 4;
                    //IOWR_32DIRECT(SVM_DUMP_MEM_BASE, dump_addr, (unsigned int)powerlink); // 27 Power Out
                    dump_addr += 4;
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, (short)eff);           // 28 Efficiency
                    dump_addr += 2;
                    IOWR_16DIRECT(SVM_DUMP_MEM_BASE, dump_addr, 0);                    // 29 Padding
                    dump_addr += 2;
                    //dump_addr+=2;

                }
                samples++;
            }
            // Sample skip_count and sample_skip are used to extend the trace depth by capturing every Nth sample
            // Where N is set by the GUI in DOC_DBG_TRACE_SAMPLES and passed as a power of 2 in sample_skip
            sample_skip_count++;
            sample_skip_count = sample_skip_count % (1<<sample_skip);
        }
    } else {
        //stop dumping
        dump_mode = 1;
        debug_write_status(0, DOC_DBG_DUMP_MODE, dump_mode);
        dump_addr = 0;
        samples = 0;
        trigger_out = 0;    //reset trigger

    }
}

/*!
 * \addtogroup DEBUG_MSG Debug Message Handling
 *
 * Mechanism to handle debug output to console
 *
 * @{
 */
/*
 * Initialise the debug buffers and debug output filter
 */
void init_debug_output(void)
{
    int i;

    char *debug_ptr = (char *)SYS_CONSOLE_DEBUG_RAM_BASE;

    for (i = 0; i < SYS_CONSOLE_DEBUG_RAM_SIZE_VALUE; i++) {
        *debug_ptr = 0;
        debug_ptr++;
    }
}

/**
 * @brief Wait for console input without blocking RTOS thread
 *
 */
char debug_waitchar(int level, char *str, int en)
{
    if (en) {
        debug_printf(level, str);
        while (feof(stdin)) {
            OS_SLEEP_MS(100);
        }

        int result_debug_waitchar = getc(stdin);

        if (result_debug_waitchar == 0) {
            debug_printf(DBG_ALWAYS, "Interaction with user failed");
            return 0;
        } else {
            return result_debug_waitchar;
        }
    } else {
        return 0;
    }
}

int debug_waveform_demo_update_check(void)
{
    return (int)(debug_read_command(0, DOC_DBG_DEMO_UPDATE));
}

void debug_waveform_demo_update_clear(void)
{
    debug_write_status(0, DOC_DBG_DEMO_UPDATE, 0);
}

int debug_waveform_demo_parameters(int drive_index, waveform_input_params_t *waveform)
{
    int result = -1;

    if (drive_index >= FIRST_MULTI_AXIS && drive_index <= LAST_MULTI_AXIS) {
        waveform->period = debug_read_command(drive_index, DOC_DBG_WAVE_DEMO_PERIOD);
        waveform->offset = debug_read_command(drive_index, DOC_DBG_WAVE_DEMO_OFFSET);
        waveform->shape  = debug_read_command(drive_index, DOC_DBG_WAVE_DEMO_WAVEFORM);
        waveform->cmd_wave_amp = debug_read_command(drive_index, DOC_DBG_WAVE_DEMO_AMP_F);
        waveform->mode   = debug_read_command(drive_index, DOC_DBG_WAVE_DEMO_MODE);
        result = 0;
    }
    return result;
}

void debug_set_latency(int latency1, int latency2)
{
    debug_write_status(0, DOC_DBG_LATENCY1, latency1);
    debug_write_status(0, DOC_DBG_LATENCY2, latency2);
}

void debug_update_drive_params(int drive_index, unsigned short state, int speed, int pos)
{
    if (drive_index >= FIRST_MULTI_AXIS && drive_index <= LAST_MULTI_AXIS) {
        debug_write_status(drive_index, DOC_DBG_DRIVE_STATE, state);
        debug_write_status(drive_index, DOC_DBG_SPEED, speed >> SPEED_FRAC_BITS);
        debug_write_status(drive_index, DOC_DBG_POSITION, pos);
    }
}

void debug_update_sys_params(app_state_e app_state, calc_type_e dsp_mode, short dc_dc_v_fb)
{
    debug_write_status(0, DOC_DBG_APP_STATE, app_state);
    debug_write_status(0, DOC_DBG_RUNTIME, OS_TIME_SEC());
    debug_write_status(0, DOC_DBG_DSP_MODE, dsp_mode);
    debug_write_status(0, DOC_DBG_DC_DC_V_LINK, dc_dc_v_fb);
}

int debug_read_reset(void)
{
    int reset = debug_read_command(0, DOC_DBG_BUTTON_DRIVE_RESET);

    if (reset) {
        debug_write_status(0, DOC_DBG_BUTTON_DRIVE_RESET, 0);
    }
    return reset;
}

demo_mode_e debug_read_demo_mode(void)
{
    return (demo_mode_e)debug_read_command(0, DOC_DBG_DEMO_MODE);
}

int debug_read_adc_type(void)
{
    return (int)debug_read_command(0, DOC_DBG_ADC_TYPE);
}

calc_type_e debug_read_dsp_mode(void)
{
   return (calc_type_e)debug_read_command(0, DOC_DBG_BUTTON_DSP_MODE);
}

void debug_update_dc_dc_setp(short setp)
{
    debug_write_status(0, DOC_DBG_DCDC_V_SETP0, setp);
}

void debug_update_drive_status(int drive_index, int new_status)
{
    if (drive_index >= FIRST_MULTI_AXIS && drive_index <= LAST_MULTI_AXIS) {
        debug_write_status(drive_index, DOC_DBG_DRIVE_STATE, new_status);
    }
}

/*!
 * @}
 */

/*!
 * @}
 */
