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

/**
 * @file mc.c
 *
 * @brief Motor control demo functions
 */

#include "system.h"
#include "system_shim.h"

#include "mc.h"

#include "demo_cfg.h"
#include "components/dspba/DF_fixp16_alu_av_mmap.h"
#include "components/dspba/DF_fixp16_alu_av.h"

#include "platform/common/platform.h"
#include "platform/motors/motor_types.h"

#include <stdlib.h>
#include "motorsim/motor_functions.h"

/*!
 * \addtogroup MC
 *
 * @{
 */


/**
 * Initialize the system parameter data structure
 *
 * @param sp    Pointer to system parameters data structure
 */
void init_sp(system_params *sp)
{
    if (OPEN_LOOP_INIT == 1) {
        sp->demo_mode = DEMO_OPEN_LOOP_SINE_16;
        platform.commutation = FOC_SENSOR;
        platform.isr_sample_rate = 16;
        platform.adc_sample_rate = 16;
    } else {
        sp->demo_mode = DEMO_FOC_SENSOR_32_2;
        platform.commutation = FOC_SENSOR;
    }
    sp->dsp_mode = SOFT_FIXP;
    sp->lvmc_adc_type = ADC_TYPE_SIGMA_DELTA;
    sp->axis_select = 0;
    sp->interactive_start = INTERACTIVE_START;

    //this just give the initial value that will be changed to 32V
    sp->dc_dc_cmd_v = 12;

}

/**
 * Called for each axis, once from init_axis() and then on each pass of motor task loop to update
 * drive parameter structure members that may change, e.g., from changes in the system console gui.
 *
 * @param dp    pointer to a single drive parameter structure
 */
void update_axis(drive_params *dp)
{
    //position kp and ki are limited to 0 to 1023
    dp->position_pi.kp = ABS_MAX(abs(dp->motor->pos_kp), ((1<<dp->position_pi.kp_ki_bits)-1));
    dp->position_pi.ki = ABS_MAX(abs(dp->motor->pos_ki), ((1<<dp->position_pi.kp_ki_bits)-1));
    dp->position_pi.output_limit = ABS_MAX(dp->pos_speed_limit, (1<<15)-1);// (1<<15)-1 =32767

    // motor struct may be updated from gui. Copied to pi struct here.

    //speed kp and ki are limited to 0 to 524287
    dp->speed_pi.kp = ABS_MAX(abs(dp->motor->speed_kp), ((1<<dp->speed_pi.kp_ki_bits)-1));
    dp->speed_pi.ki = ABS_MAX(abs(dp->motor->speed_ki), ((1<<dp->speed_pi.kp_ki_bits)-1));

    //final speed_pi.error_limit is intended to be 2047
    dp->speed_pi.error_limit = MIN((1<<(30-dp->speed_pi.kp_ki_bits))-1, dp->speed_limit);
    dp->speed_pi.integrator_limit = dp->i_sat_limit<<dp->speed_pi.precision_bits;
    dp->speed_pi.output_limit = dp->i_sat_limit;

    //current id kp and ki are limited to 0 to 524287
    dp->id_pi.kp = ABS_MAX(abs(dp->motor->id_kp), ((1<<dp->id_pi.kp_ki_bits)-1));
    dp->id_pi.ki = ABS_MAX(abs(dp->motor->id_ki), ((1<<dp->id_pi.kp_ki_bits)-1));

    //current iq kp and ki are limited to 0 to 524287
    dp->iq_pi.kp = ABS_MAX(abs(dp->motor->iq_kp), ((1<<dp->iq_pi.kp_ki_bits)-1));
    dp->iq_pi.ki = ABS_MAX(abs(dp->motor->iq_ki), ((1<<dp->iq_pi.kp_ki_bits)-1));

#if defined(__ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_2)
    dp->i_d_pi_f.Kp = ((float)dp->motor->id_kp) * SHIFTR10FLOAT;
    dp->i_d_pi_f.Ki = ((float)dp->motor->id_ki) * SHIFTR10FLOAT;
    dp->i_d_pi_f.error_limit = ((float)dp->i_sat_limit) * SHIFTR10FLOAT;
    // Limits scaled by 32 as we are really dealing with q10 format
    dp->i_d_pi_f.integrator_limit = 0.95 * 32.0;
    dp->i_d_pi_f.output_limit = 0.95 * 32.0;
    dp->i_q_pi_f.Kp = ((float)dp->motor->id_kp) * SHIFTR10FLOAT;
    dp->i_q_pi_f.Ki = ((float)dp->motor->iq_ki) * SHIFTR10FLOAT;
    dp->i_q_pi_f.error_limit = ((float)dp->i_sat_limit) * SHIFTR10FLOAT;
    // Limits scaled by 32 as we are really dealing with q10 format
    dp->i_q_pi_f.integrator_limit = 0.95 * 32.0;
    dp->i_q_pi_f.output_limit = 0.95 * 32.0;
#endif

}

/**
 * Called for each axis from init_dp to initialize per axis drive data structure members.
 *
 * @param dp    pointer to a single axis drive parameter structure
 * @param sp    pointer to system parameters structure
 */
void init_axis(drive_params *dp, system_params *sp)
{
    // Approx 3A on Tandem Motion power 48V.
    // This is very close to the original value from FalconEye code, so keep it the same.
    dp->i_sat_limit = dp->motor->i_sat_limit;
    // Set V limit based on PWM_MAX value which depends on adc sample rate
    dp->v_sat_limit = DRIVE0_DOC_PWM_FREQ/(platform.adc_sample_rate * 10) * 95;

    // One time PI & filter init
    dp->position_pi.precision_bits = dp->motor->position_pi_precision_bits;
    dp->position_pi.kp_ki_bits = dp->motor->position_pi_kp_ki_bits;
    //final position_pi.error_limit = 0xf ffff
    dp->position_pi.error_limit = MIN((1<<(30-dp->position_pi.kp_ki_bits))-1, 0x40000000);
    dp->position_pi.integrator_limit = 0<<dp->position_pi.precision_bits;
    pi_reset_q15(&dp->position_pi);

    dp->speed_pi.precision_bits = dp->motor->speed_pi_precision_bits;
    dp->speed_pi.kp_ki_bits = dp->motor->speed_pi_kp_ki_bits;
    pi_reset_q15(&dp->speed_pi);

    // Always zero in our implementation as all d-axis flux is supplied by the rotor permanent magnets
    dp->id_pi.setpoint = dp->motor->id_pi_setpoint;
    dp->id_pi.precision_bits = dp->motor->id_pi_precision_bits;
    dp->id_pi.kp_ki_bits = dp->motor->id_pi_kp_ki_bits;
    //final id_pi.error_limit intended to be 2047
    dp->id_pi.error_limit = MIN((1<<(30-dp->id_pi.kp_ki_bits))-1, dp->i_sat_limit);
    // 0.95 Q15 shifted by precision_bits
    dp->id_pi.integrator_limit = (((((int)1<<15)-1)*95)/100)<<dp->id_pi.precision_bits;
    dp->id_pi.output_limit = dp->motor->id_pi_output_limit;        // 0.95 Q15
    pi_reset_q15(&dp->id_pi);

    dp->iq_pi.precision_bits = dp->motor->iq_pi_precision_bits;
    dp->iq_pi.kp_ki_bits = dp->motor->iq_pi_kp_ki_bits;
    //final iq_pi.error_limit intended to be 2047
    dp->iq_pi.error_limit = MIN((1<<(30-dp->iq_pi.kp_ki_bits))-1, dp->i_sat_limit);
    // 0.95 Q15 shifted by precision_bits
    dp->iq_pi.integrator_limit = (((((int)1<<15)-1)*95)/100)<<dp->iq_pi.precision_bits;
    dp->iq_pi.output_limit = dp->motor->iq_pi_output_limit;        // 0.95 Q15
    pi_reset_q15(&dp->iq_pi);

    #if defined(__ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_2)
        // Always zero in our implementation as all d-axis flux is supplied by the rotor permanent magnets
        dp->i_d_pi_f.setpoint = 0;
        PI_reset_f(&dp->i_d_pi_f);
    #endif

    // Complete PI & filter init
    update_axis(dp);
}


/**
 * Initialise the drive parameters data structure.
 *
 * @param dp    pointer to drive parameters structure
 * @param sp    pointer to system parameters structure
 */
void init_dp(drive_params *dp, system_params *sp)
{
    int dn;

    dp[0].DOC_ADC_BASE_ADDR               = DRIVE0_DOC_ADC_BASE;
    dp[0].DOC_ADC_POW_BASE_ADDR           = DRIVE0_DOC_ADC_POW_BASE;
#ifdef DRIVE0_DOC_QEP_BASE
    dp[0].DOC_QEP_BASE_ADDR               = DRIVE0_DOC_QEP_BASE;
#endif
#ifdef DRIVE0_DOC_RSLVR_PIO_BASE
    dp[0].DOC_RSLVR_PIO_BASE_ADDR       = DRIVE0_DOC_RSLVR_PIO_BASE;
#endif
#ifdef DRIVE0_DOC_RSLVR_SPI_CTRL_BASE
    dp[0].DOC_RSLVR_SPI_CTRL_BASE_ADDR  = DRIVE0_DOC_RSLVR_SPI_CTRL_BASE;
#endif
#ifdef DRIVE0_DOC_RSLVR_SPI_POSN_BASE
    dp[0].DOC_RSLVR_SPI_POSN_BASE_ADDR  = DRIVE0_DOC_RSLVR_SPI_POSN_BASE;
#endif
    dp[0].DOC_PWM_BASE_ADDR               = DRIVE0_DOC_PWM_BASE;
    dp[0].DOC_SM_BASE_ADDR                = DRIVE0_DOC_SM_BASE;
    dp[0].DOC_FOC_BASE_ADDR               = DRIVE0_FOC_FIXP_BASE;

#ifdef MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE
    dp[0].DOC_MOTORMODEL_BASE_ADDR         = MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE;
#endif

#if defined DRIVE1_DOC_ADC_BASE && LAST_MULTI_AXIS > 0
    dp[1].DOC_ADC_BASE_ADDR               = DRIVE1_DOC_ADC_BASE;
    dp[1].DOC_ADC_POW_BASE_ADDR           = DRIVE1_DOC_ADC_POW_BASE;

    dp[1].DOC_QEP_BASE_ADDR               = DRIVE1_DOC_QEP_BASE;
#ifdef DRIVE1_DOC_RSLVR_PIO_BASE
    dp[1].DOC_RSLVR_PIO_BASE_ADDR       = DRIVE1_DOC_RSLVR_PIO_BASE;
#endif
#ifdef DRIVE1_DOC_RSLVR_SPI_CTRL_BASE
    dp[1].DOC_RSLVR_SPI_CTRL_BASE_ADDR  = DRIVE1_DOC_RSLVR_SPI_CTRL_BASE;
#endif
#ifdef DRIVE1_DOC_RSLVR_SPI_POSN_BASE
    dp[1].DOC_RSLVR_SPI_POSN_BASE_ADDR  = DRIVE1_DOC_RSLVR_SPI_POSN_BASE;
#endif
    dp[1].DOC_PWM_BASE_ADDR               = DRIVE1_DOC_PWM_BASE;
    dp[1].DOC_SM_BASE_ADDR                = DRIVE1_DOC_SM_BASE;
    dp[1].DOC_FOC_BASE_ADDR               = DRIVE1_FOC_FIXP_BASE;
#ifdef MOTOR_KIT_SIM_20MHZ_MOTORMODEL_1_BASE
    dp[1].DOC_MOTORMODEL_BASE_ADDR        = MOTOR_KIT_SIM_20MHZ_MOTORMODEL_1_BASE;
#endif
#endif

    for (dn = 0; dn <= platform.last_drive; dn++) {
        dp[dn].drive = dn;

        dp[dn].i_sat_limit = 3125;
        dp[dn].v_sat_limit = 3000;

        dp[dn].v_alpha_q15 = 0;
        dp[dn].v_beta_q15 = 0;
        dp[dn].v_alpha_ol_q15 = 0;
        dp[dn].v_beta_ol_q15 = 0;

        dp[dn].vu_pwm = (platform.pwm_count+1)/2-1;
        dp[dn].vv_pwm = (platform.pwm_count+1)/2-1;
        dp[dn].vw_pwm = (platform.pwm_count+1)/2-1;

        dp[dn].i_command_q = 100;


        if (sp->lvmc_adc_type == ADC_TYPE_MAX10) {
            dp[dn].mdp.voltage_scalar = (float) (1/67.7);
        } else {
            dp[dn].mdp.voltage_scalar = (float) (1/(float)(dp[dn].motor->Vphase_ADC_scale_V));
        }

        dp[dn].switch_count = 0;

        dp[dn].i_alpha_f = 0.0;
        dp[dn].i_beta_f = 0.0;

        dp[dn].enable_drive = 0;

        dp[dn].speed_limit = motors[dn]->speed_limit<<SPEED_FRAC_BITS;        // Setpoint / Initial Speed
        if ((platform.commutation == FOC_SENSOR) && (sp->demo_mode != DEMO_OPEN_LOOP_SINE_16)
            && (sp->demo_mode != DEMO_OPEN_LOOP_SINE_32)) {
            dp[dn].speed_request = INIT_SPEED_COMMAND_FOC_SENSOR<<SPEED_FRAC_BITS;

        } else if ((sp->demo_mode == DEMO_OPEN_LOOP_SINE_16) || (sp->demo_mode == DEMO_OPEN_LOOP_SINE_32)) {
            dp[dn].speed_request = INIT_SPEED_COMMAND_OPENLOOP_SENSOR<<SPEED_FRAC_BITS;

        } else {
            dp[dn].speed_request = INIT_SPEED_COMMAND_OTHER<<SPEED_FRAC_BITS;
        }

        if (platform.isr_sample_rate == 32) {
            dp[dn].min_speed = 450<<SPEED_FRAC_BITS;
        } else {
            dp[dn].min_speed = 400<<SPEED_FRAC_BITS;
        }

        dp[dn].pos_request = 100000; // Position 23 Bit = 8388607 count = 360°
        dp[dn].pos_speed_limit = 50<<SPEED_FRAC_BITS;
        dp[dn].open_loop_idx_q16 = 0;

        dp[dn].reset_control = 1;

        init_axis(&dp[dn], sp);
        #if (defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE))
            init_motor_mdl(&dp[dn]);    //APP_DRIVE_SIM
        #endif
    }
}

/*!
 * @}
 */
