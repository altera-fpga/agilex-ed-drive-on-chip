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


#include <math.h>
#include "motorsim/motor_functions.h"
#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"
#include "mc/mc.h"
#include "platform/common/platform.h"
#include <limits.h>

#include "motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL_mmap.h"
#include "motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL.h"

#include "mc/mc_debug.h"
#include "io.h"
#include "components/qep/qep.h"
#include "components/ssg_emb_sd_adc.h"

/**
 * @file motor.c
 *
 * @brief Functions to initialize the motor model
 */

/*!
 * \addtogroup motorsim
 *
 * @{
 */

/**
 * @brief Motor model initialization function
 *
 * initialise motor model structure in the initialisation section, at the end of init_dp()
 *
 * @param dp    Pointer to single axis drive_params struct
 */

void init_motor_mdl(drive_params *dp)
{
    short Iabc_range;
    short Vabc_range;
    short V_dc_range;
    short V_dc;

    //constant values
    dp->motor_mdl.load_T_Nm = dp->motor->load_T_Nm;
    dp->motor_mdl.Ts_s_20 = dp->motor->Ts_s_20;
    //Tamagawa TS4747N3200E600 motor
    //<! Stator Phase resistance [Ohm] from data sheet Ra = 3xRph, Rph = 0.68/3
    dp->motor_mdl.R_ohm = dp->motor->R_ohm;
    //<! Stator Phase Inductance [H] from data sheet La = 3xLph, Lph = 3.0/3mH
    dp->motor_mdl.L_H = dp->motor->L_H;
    //<! Inverse Stator Phase Inductance [1/H]
    dp->motor_mdl.inv_L_H = dp->motor->inv_L_H;
    //<! Back-emf constant kE [Vs/rad] set equal to Motor Torque constant's peak phase value 0.07/3*sqrt(2)
    dp->motor_mdl.Ke_Vs_rad = dp->motor->Ke_Vs_rad;
    //<! Motor torque constant kT's peak phase value 0.07/3*sqrt(2) [Nm/A]
    dp->motor_mdl.Kt_Nm_A = dp->motor->Kt_Nm_A;
    //<! Pole pairs (0.5*n poles) [integer]
    dp->motor_mdl.PolePairs_int = dp->motor->PolePairs_int;
    //<! Rotor Mechanical Inertia [kgm^2]
    dp->motor_mdl.J_kgm2 = dp->motor->J_kgm2;
    //<! Inverse Rotor Mechanical Inertia [1/(kgm^2)]
    dp->motor_mdl.invJ_kgm2 = dp->motor->invJ_kgm2;
    //<! DC link voltage
    dp->motor_mdl.DC_link = dp->motor->DC_link;
    //!< Phase current ADC scale factor: number per Amp
    dp->motor_mdl.Iphase_ADC_scale_A = dp->motor->Iphase_ADC_scale_A;
    //!< Phase voltage ADC scale factor: number per V
    dp->motor_mdl.Vphase_ADC_scale_V = dp->motor->Vphase_ADC_scale_V;
    //!< DC link voltage ADC scale factor: number per V
    dp->motor_mdl.V_DC_link_scale_V = dp->motor->V_DC_link_scale_V;
    dp->motor_mdl.T_Nm = dp->motor->T_Nm;

    V_dc = (short)(dp->motor->DC_link)*constScaleVoltage;
    Iabc_range = (short)((32768/(dp->motor_mdl.Iphase_ADC_scale_A)));
    Vabc_range = (short)((32768/(dp->motor_mdl.Vphase_ADC_scale_V)));
    V_dc_range = (short)((32768/(dp->motor_mdl.V_DC_link_scale_V)));

    debug_printf(DBG_INFO, "[DSPBA motor model] init_dp(): INIT 20MHz fixed point IP axis%d.\n", dp->drive);
    INIT_DSPBA_DF_fixp16_alu_av_MOTORMDL_regs(dp->DOC_MOTORMODEL_BASE_ADDR,
        (unsigned short)(dp->motor_mdl.Ts_s_20*((float)(1.0f * ((long long int)1<<39)))),
        (unsigned short)(dp->motor_mdl.R_ohm*((float)(1.0f * (1<<16)))),
        (unsigned short)(dp->motor_mdl.inv_L_H*((float)(1.0f * (1<<6)))),
        ((dp->motor_mdl.PolePairs_int) * (1<<14)),
        (unsigned short)(dp->motor_mdl.Ke_Vs_rad * ((float)(1.0f * (1<<16)))),
        (unsigned short)(dp->motor_mdl.Kt_Nm_A * ((float)(1.0f * (1<<16)))),
        (unsigned short)(dp->motor_mdl.invJ_kgm2),
        Iabc_range, Vabc_range, V_dc_range, V_dc);

}

/**
 * @brief Motor model inference
 *
 * Re-calculation of Va, Vb, Vc
 *
 * @param dp    Pointer to single axis drive_params struct
 * @param sp    Pointer to system_params struct
 */

void dspba_motor_model_fixedp_direct_inf(drive_params *dp, system_params *sp)
{

    //called where motor_model_f is called BUT we have only one Motor Model IP
    //LAST_MULTI_AXIS has been modified (demo_cfg.h) now the design is single axis

    /*
     * DSPBA scaling factors:
     * voltages: 2^-9
     * torque: 2^-14
     * currents: 2^-10
     * single turn angle: 2^-16 (unsigned short)
     * speed: 2^-6
     */
    int base_address = dp->DOC_MOTORMODEL_BASE_ADDR;

    //we use volatile attribute to avoid optimization and read the value of the variable using ni
    volatile short Va_V_sfix16_En9 = 0;
    volatile short Vb_V_sfix16_En9 = 0;
    volatile short Vc_V_sfix16_En9 = 0;
    volatile int reset = 0;


   /*float pwm_max;
    * pwm_max = (float)platform.pwm_count;


    *  vu_pwm, vv_pwm, vw_pwm generated by SVM are sent to PWM IP when the power
    * board is connected, so they are calculated based on the pwm_count
    * here we convert the int type to Volts to pass them directly to the motor model
    * sp->sd_platform_adc.dc_dc_v_scaled is the short variable for DC link voltage


    * dp->motor_mdl.Va_V = vu_pwm/pwm_max * sp->sd_platform_adc.dc_dc_v_scaled
    * shift left and then cast to convert float to fixed format

    * Vb_V_sfix16_En9 = (short)(dp->motor_mdl.Vb_V * ( (float)(1.0f *constScaleVoltage) ));
    * Vc_V_sfix16_En9 = (short)(dp->motor_mdl.Vc_V * ( (float)(1.0f *constScaleVoltage) ));
    */

    //merge above equation together
    //pwm_max = platform.pwm_count = DRIVE0_DOC_PWM_FREQ/(platform.adc_sample_rate *1000);
    //pwm_max = platform.pwm_count = 300000000/(platform.adc_sample_rate *1000);
    //pwm_max = platform.pwm_count = 300000/platform.adc_sample_rate

    //constScaleVoltage/ pwm_max = constScaleVoltage/300000 * platform.adc_sample_rate
    //constScaleVoltage/300000 * platform.adc_sample_rate =  platform.adc_sample_rate * constScaleVoltage /300000

    Va_V_sfix16_En9 = (short)((long long int)
        (constScaleVoltage * dp->vu_pwm * sp->dc_dc_v_scaled * platform.adc_sample_rate / ((300000))));
    Vb_V_sfix16_En9 = (short)
        ((long long int)(constScaleVoltage * dp->vv_pwm * sp->dc_dc_v_scaled * platform.adc_sample_rate / ((300000))));
    Vc_V_sfix16_En9 = (short)
        ((long long int)(constScaleVoltage * dp->vw_pwm * sp->dc_dc_v_scaled * platform.adc_sample_rate / ((300000))));

   /*
    * Va_V_sfix16_En9 = (short)(2.5f * ( (float)(1.0f *constScaleVoltage) ));
    * Vb_V_sfix16_En9 = (short)(2.5f * ( (float)(1.0f *constScaleVoltage) ));
    * Vc_V_sfix16_En9 = (short)(-5.0f * ( (float)(1.0f *constScaleVoltage) ));
    * LoadT_Nm_sfix16_En14 = (short)(dp->motor_mdl.load_T_Nm * ( (float)(1.0f *(1<<14)) ));
    */

    //reset = ((dp->enable_drive == 0) || (dp->reset_control == 1));
    reset = (dp->enable_drive == 0);

    //Load input data
    IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VA_INPUT * DSPBA_bytes_per_word, Va_V_sfix16_En9);
    IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VB_INPUT * DSPBA_bytes_per_word, Vb_V_sfix16_En9);
    IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VC_INPUT * DSPBA_bytes_per_word, Vc_V_sfix16_En9);
    IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RESET_INPUT * DSPBA_bytes_per_word, reset);

}

/*!
 * @}
 */
