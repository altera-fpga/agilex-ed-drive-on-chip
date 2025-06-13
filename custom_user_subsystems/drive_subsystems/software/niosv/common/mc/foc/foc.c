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

#include "foc.h"

#include "io.h"
#include "system.h"
#include "system_shim.h"

#include "demo_cfg.h"
#include "components/dspba/DF_fixp16_alu_av_mmap.h"
#include "components/dspba/DF_fixp16_alu_av.h"
#include "mc/mc_debug.h"
#include "mc/mc_params.h"
#include "mc/mc.h"
#include "platform/common/platform.h"

/**
 * @file foc.c
 *
 * @brief FOC (Field Oriented Control) software
 */

/*!
 * \addtogroup FOC
 *
 * @{
 */

/**
 * @brief process input data with software FOC
 *
 * Called from deferred ISR to process input data
 *
 * @param dp        Pointer to axis data structure
 * @param sp        Pointer to system data structure
 */
void software_foc(drive_params *dp, system_params *sp)
{
    if (sp->dsp_mode == SOFT_FIXP) {
        // Software fixed point
        // sin & cosine are used in both forward and reverse park so calculate once
        dp->sin_phi_q15 = SINE(dp->phi_elec);
        dp->cos_phi_q15 = COSINE(dp->phi_elec);

        if (sp->lvmc_adc_type == ADC_TYPE_MAX10) {
            clarke_transform(dp->max10_drive_adc.iu, dp->max10_drive_adc.iw, dp->motor->Iphase_ADC_scale_A,
                            dp->motor->CurrentParameter, &dp->i_alpha, &dp->i_beta);
        } else {
            clarke_transform(dp->sd_drive_adc.iu, dp->sd_drive_adc.iw, dp->motor->Iphase_ADC_scale_A,
                            dp->motor->CurrentParameter, &dp->i_alpha, &dp->i_beta);
        }
        park_transform(dp->i_alpha, dp->i_beta, &dp->id, &dp->iq, dp->sin_phi_q15, dp->cos_phi_q15);

        // PI control of Id current. Setpoint is always 0 in our implementation as
        // all d-axis flux is supplied by the rotor permanent magnets
        dp->id_pi.feedback = dp->id;
        //Direct current control
        pi_control_q15(&dp->id_pi, ((dp->enable_drive == 0) || (dp->reset_control == 1)));
        dp->vd_q15 = dp->id_pi.output;

        // PI control of Iq current
        dp->iq_pi.feedback = dp->iq;
        dp->iq_pi.setpoint = dp->i_command_q;    // From speed PI
        //Quadrature current control
        pi_control_q15(&dp->iq_pi, ((dp->enable_drive == 0) || (dp->reset_control == 1)));
        dp->vq_q15 = dp->iq_pi.output;

        inverse_park(dp->vd_q15, dp->vq_q15, &dp->v_alpha_q15, &dp->v_beta_q15, dp->sin_phi_q15, dp->cos_phi_q15);

    }
    dp->reset_control = 0;
}



/**
 * @brief process input data with DSPBA FOC Av
 *
 * Called from deferred ISR to process input data
 *
 * @param dp        Pointer to axis data structure
 * @param sp        Pointer to system data structure
 */
void dspba_foc(drive_params *dp, system_params *sp)
{
    int dspba_foc_base = 0;
    int j = 0;
    int status_out = 0;

    dspba_foc_base = dp->DOC_FOC_BASE_ADDR;

    if (sp->dsp_mode == DSPBA_FIXP) {
        // Fixed point hardware FOC

        // Load PI parameters, which will also setup axis reg
        // To improve FOC runtime, use the same parameters for both axes
        // and write them from the update_axis() Function, rather than
        // using unique parameters for each axis.

        INIT_DSPBA_DF_fixp16_alu_av_regs(dspba_foc_base, dp->i_sat_limit, (dp->motor->id_ki),
                    (dp->motor->id_kp), platform.pwm_count, dp->drive);


        //Load input data
        if (sp->lvmc_adc_type == ADC_TYPE_MAX10) {
            IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IU_INPUT * DSPBA_bytes_per_word,
                            dp->max10_drive_adc.iu);
            IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IW_INPUT * DSPBA_bytes_per_word,
                            dp->max10_drive_adc.iw);
        }
        IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_PHI_EL_INPUT * DSPBA_bytes_per_word,
                            dp->phi_elec);
        IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_RESET_INPUT * DSPBA_bytes_per_word,
                            ((dp->enable_drive == 0) || (dp->reset_control == 1)));
        IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_TORQUE_INPUT * DSPBA_bytes_per_word,
                            dp->i_command_q);

        //Load start bit
        IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_START * DSPBA_bytes_per_word, 0);
        IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_START * DSPBA_bytes_per_word, 1);
        j = 0;
        status_out = 0;
        //Read finished bit - wait until it changes to 1
        while ((status_out != 1) && (j < 100)) {
            status_out = IORD_16DIRECT(dspba_foc_base,
                        DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_READY * DSPBA_bytes_per_word);
            j++;
        }

    }

    //Read integer output data from each axis

    if (sp->dsp_mode == DSPBA_FIXP) {
        IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_AXIS_IN * DSPBA_bytes_per_word, dp->drive);

        dp->iq = IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IQ_OUTPUT * DSPBA_bytes_per_word);
        dp->id = IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_ID_OUTPUT * DSPBA_bytes_per_word);
        dp->v_alpha_q15 = IORD_32DIRECT(dspba_foc_base,
                        DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VALPHA_OUTPUT * DSPBA_bytes_per_word);
        dp->v_beta_q15 = IORD_32DIRECT(dspba_foc_base,
                        DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VBETA_OUTPUT * DSPBA_bytes_per_word);
        dp->vu_pwm = IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VU_OUTPUT * DSPBA_bytes_per_word);
        dp->vv_pwm = IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VV_OUTPUT * DSPBA_bytes_per_word);
        dp->vw_pwm = IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VW_OUTPUT * DSPBA_bytes_per_word);

    }
    dp->reset_control = 0;
}

/*!
 * @}
 */
