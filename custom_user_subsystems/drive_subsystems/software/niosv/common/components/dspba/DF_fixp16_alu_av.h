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

#ifndef DF_FIXP16_ALU_AV_H_
#define DF_FIXP16_ALU_AV_H_

#include "mc/mc_params.h"

#define DSPBA_bytes_per_word 4

/**
 * @file DF_fixp16_alu_av.h
 *
 * @brief Header file for DSPBA fixed point block
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup DSPBA
 *
 * @{
 */

// See DFf_fixp16_alu_av_mmap.h for register definitions


void INIT_DSPBA_DF_fixp16_alu_av_regs(
    unsigned int base_address,
    int I_Sat_Limit_cfg_cfg,
    int Ki_cfg_cfg,
    int Kp_cfg_cfg,
    unsigned short pwm_max,
    int axis_in_channel
);

void test_DF_fixp16_interface(drive_params *dp);


/*!
 * @}
 */

/*!
 * @}
 */

#endif
