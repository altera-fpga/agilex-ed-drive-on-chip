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

#ifndef DF_FIXP16_ALU_AV_MOTORMODEL_H_
#define DF_FIXP16_ALU_AV_MOTORMODEL_H_

/**
 * @file DF_fixp16_alu_av_MOTORMODEL.h
 *
 * @brief Header file for DSPBA 16-bit fixed point motor model block
 */

/*!
 * \addtogroup MOTORSIM
 *
 * @{
 */

/*!
 * \addtogroup DSPBA_MOTORSIM
 *
 * @{
 */

#define DSPBA_bytes_per_word 4

// See DF_fixp16_alu_av_MOTORMODEL_mmap.h for register definitions

void INIT_DSPBA_DF_fixp16_alu_av_MOTORMDL_regs(
        unsigned int base_address,
        int SampleTime_s_cfg,
        int Rphase_ohm_cfg,
        int inv_Lphase_1_H_cfg,
        int PolePairs_int_cfg,
        int Ke_Vs_rad_cfg,
        int Kt_Nm_A_cfg,
        int inv_J_1_kgm2_cfg,
        int Iabc_range,
        int Vabc_range,
        int V_dc_range,
        int V_dc
);

void test_DSPBA_DF_fixp16_alu_av_MOTORMDL_interface(unsigned int base_address);


/*!
 * @}
 */

/*!
 * @}
 */

#endif /*DF_FIXP16_ALU_AV_MOTORMODEL_H_*/
