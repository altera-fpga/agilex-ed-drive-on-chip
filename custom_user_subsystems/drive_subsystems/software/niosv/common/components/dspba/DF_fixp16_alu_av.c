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

#include "DF_fixp16_alu_av.h"

#include "io.h"
#include "system.h"
#include "system_shim.h"

#include "DF_fixp16_alu_av_mmap.h"
#include "mc/mc_debug.h"

/**
 * @file DF_fixp16_alu_av.c
 *
 * @brief DSPBA fixed point filter block
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



/**
 *
 * @param base_address
 * @param I_Sat_Limit_cfg_cfg
 * @param Ki_cfg_cfg
 * @param Kp_cfg_cfg
 * @param axis_in_channel
 */
void INIT_DSPBA_DF_fixp16_alu_av_regs(unsigned int base_address, int I_Sat_Limit_cfg_cfg, int Ki_cfg_cfg,
    int Kp_cfg_cfg, unsigned short pwm_max, int axis_in_channel)
{
    IOWR_16DIRECT(base_address, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_I_SAT_LIMIT_CFG_CFG * DSPBA_bytes_per_word,
                    I_Sat_Limit_cfg_cfg);
    IOWR_16DIRECT(base_address, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_KI_CFG_CFG * DSPBA_bytes_per_word, Ki_cfg_cfg);
    IOWR_16DIRECT(base_address, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_KP_CFG_CFG * DSPBA_bytes_per_word, Kp_cfg_cfg);
    IOWR_16DIRECT(base_address, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_MAXPWM_INPUT * DSPBA_bytes_per_word, pwm_max);
    IOWR_16DIRECT(base_address, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_AXIS_IN * DSPBA_bytes_per_word, axis_in_channel);
}

/**
 * @Brief Simple test code that checks the data interface and handshake is working for the DSPBA block
 *
 */
void test_DF_fixp16_interface(drive_params *dp)
{
    int j = 0;
    int status_out = 0;
    int dspba_foc_base =  dp->DOC_FOC_BASE_ADDR;
    //Set I_Sat_Limit_cfg_cfg =3000, Ki_cfg_cfg =400, Kp_cfg_cfg = 10000,
    // axis_in_channel = 0(first motor), these values are standard default values.
    // Values to run are defined in mc/foc/foc.c
    INIT_DSPBA_DF_fixp16_alu_av_regs(dspba_foc_base, 3000, 400, 10000, 18750, 0);

    //Reset internal registers for AVALON
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_RESET_INPUT * DSPBA_bytes_per_word, 1);

    //Load start bit
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_START * DSPBA_bytes_per_word, 0);
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_START * DSPBA_bytes_per_word, 1);
    //Read finished bit - wait until it changes to 1
    while ((status_out != 1) & (j < 100)) {
        status_out = IORD_16DIRECT(dspba_foc_base,
            DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_READY * DSPBA_bytes_per_word);
        j++;
    }
    //Release reset
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_RESET_INPUT * DSPBA_bytes_per_word, 0);

    //Load input data, these values are just random example data used for testing DSPBA block.
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IU_INPUT * DSPBA_bytes_per_word, 0xEFEF);
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IW_INPUT * DSPBA_bytes_per_word, 0xF0F0);
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_PHI_EL_INPUT * DSPBA_bytes_per_word, 0x5678);
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_TORQUE_INPUT * DSPBA_bytes_per_word, 0x4321);

    debug_printf(DBG_INFO, "DSPBA data in: %08X %08X %08X %08X %08X\n",
        IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IU_INPUT * DSPBA_bytes_per_word),
        IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_IW_INPUT * DSPBA_bytes_per_word),
        IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_PHI_EL_INPUT * DSPBA_bytes_per_word),
        IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_RESET_INPUT * DSPBA_bytes_per_word),
        IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_TORQUE_INPUT * DSPBA_bytes_per_word));

    //Load start bit
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_START * DSPBA_bytes_per_word, 0);
    IOWR_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_START * DSPBA_bytes_per_word, 1);
    //Read finished bit - wait until it changes to 1
    while ((status_out != 1) & (j < 100)) {
        status_out = IORD_16DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_DSPBA_READY * DSPBA_bytes_per_word);
        j++;
    }
    debug_printf(DBG_INFO, "status_out = %08X  J = %d\n", status_out, j);

    int Valpha = IORD_32DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VALPHA_OUTPUT * DSPBA_bytes_per_word);
    int Vbeta = IORD_32DIRECT(dspba_foc_base, DF_FIXP16_ALU_AV_FOC_AVALON_REGS_VBETA_OUTPUT * DSPBA_bytes_per_word);

    if ((Valpha == 0xFFFFD8B8) && (Vbeta == 0xFFFF5C59)) {
        debug_printf(DBG_INFO, "DSPBA result out: %08X %08X, DSPBA test PASSED.\n", Valpha, Vbeta);
    } else {
        debug_printf(DBG_INFO,
            "DSPBA result out: %08X %08X, it should be FFFFD8B8 and FFFF5C59, DSPBA test FAILED.\n",
            Valpha, Vbeta);
    }

}



/*!
 * @}
 */

/*!
 * @}
 */
