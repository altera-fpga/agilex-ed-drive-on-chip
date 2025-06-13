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

#include "DF_fixp16_alu_av_MOTORMODEL.h"

#include "io.h"
#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#include "DF_fixp16_alu_av_MOTORMODEL_mmap.h"
#include "mc/mc_debug.h"        //DBG_INFO

/**
 * @file DF_fixp16_alu_av_MOTORMODEL.c
 *
 * @brief DSPBA 16-bit fixed point motor model block
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

#if defined(DF_FIXP16_ALU_AV_MOTORMODEL_MOTORMODEL_0_BASE) || defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE)

/**
 *
 * @param base_address            module base address
 * @param SampleTime_s_cfg        Sample Time
 * @param Rphase_ohm_cfg          Phase resistance
 * @param inv_Lphase_1_H_cfg      Inverse of the phae inductance
 * @param PolePairs_int_cfg       Numbers of pole pairs
 * @param Ke_Vs_rad_cfg
 * @param Kt_Nm_A_cfg
 * @param inv_J_1_kgm2_cfg       Inverse of the mechanical inertia
 * @param Iabc_range             Current Range
 * @param Vabc_range             Voltage Range
 * @param V_dc_range             Input voltage range
 * @param V_dc        I          Input DC voltage
 */

 void INIT_DSPBA_DF_fixp16_alu_av_MOTORMDL_regs(unsigned int base_address, int SampleTime_s_cfg, int Rphase_ohm_cfg,
        int inv_Lphase_1_H_cfg, int PolePairs_int_cfg, int Ke_Vs_rad_cfg, int Kt_Nm_A_cfg, int inv_J_1_kgm2_cfg,
        int Iabc_range, int Vabc_range, int V_dc_range, int V_dc)
{

     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DC_LINK_V_INPUT * DSPBA_bytes_per_word, V_dc);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_SAMPLE_TIME_CFG * DSPBA_bytes_per_word, SampleTime_s_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RPHASE_CFG * DSPBA_bytes_per_word, Rphase_ohm_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_INV_LPHASE_CFG * DSPBA_bytes_per_word, inv_Lphase_1_H_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_POLEPAIRS_CFG * DSPBA_bytes_per_word, PolePairs_int_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_KE_CFG * DSPBA_bytes_per_word, Ke_Vs_rad_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_KT_CFG * DSPBA_bytes_per_word, Kt_Nm_A_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_INV_J_CFG * DSPBA_bytes_per_word, inv_J_1_kgm2_cfg);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_IABC_RANGE_CFG * DSPBA_bytes_per_word, Iabc_range);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VABC_RANGE_CFG * DSPBA_bytes_per_word, Vabc_range);
     IOWR_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DC_LINK_RANGE_CFG * DSPBA_bytes_per_word, V_dc_range);


     debug_printf(DBG_INFO, "[DSPBA motor model] INIT function. Config data: T = %d, R = %d,\
        inv_L = %d, PolePairs = %d, Ke = %d, Kt = %d, inv_J %d, , dc_dc_v %d\n",
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_SAMPLE_TIME_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RPHASE_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_INV_LPHASE_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_POLEPAIRS_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_KE_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_KT_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_INV_J_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DC_LINK_V_INPUT * DSPBA_bytes_per_word)
    );

 }

/**
 * @Brief Simple test code that checks the data interface and handshake is working for the DSPBA block
 *
 * @param base_address        module base address
 */

void test_DSPBA_DF_fixp16_alu_av_MOTORMDL_interface(unsigned int base_address)
{
    int j = 0;
    volatile int status_out = 0;

    //DSPBA module outputs
    volatile short ia = 0;
    volatile short ib = 0;
    volatile short ic = 0;
    volatile short dTheta_dt = 0;
    volatile short ThetaMech = 0;

    //send the reset separated from the inputs
    debug_printf(DBG_INFO, "[DSPBA motor model] test function. Reset latches.\n");

    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RESET_INPUT * DSPBA_bytes_per_word, 1);
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DSPBA_START * DSPBA_bytes_per_word, 0);
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DSPBA_START * DSPBA_bytes_per_word, 1);

    while ((status_out != 1) & (j < 100)) {
        status_out = IORD_32DIRECT(base_address,
            MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DSPBA_READY * DSPBA_bytes_per_word);
        j++;
    }

    //Load input data
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VA_INPUT * DSPBA_bytes_per_word,
        (short)(2.5f * ((float)(1.0f * constScaleVoltage))));
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VB_INPUT * DSPBA_bytes_per_word,
        (short)(2.5f * ((float)(1.0f * constScaleVoltage))));
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VC_INPUT * DSPBA_bytes_per_word,
        (short)(-5.0f * ((float)(1.0f * constScaleVoltage))));
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_LOADT_INPUT * DSPBA_bytes_per_word, 0);
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RESET_INPUT * DSPBA_bytes_per_word, 0);

    debug_printf(DBG_INFO, "[DSPBA motor model] test function. Inputs: Va = %d, Vb = %d,\
        Vc = %d, Load = %d, Reset = %08x, DC = %d\n",
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VA_INPUT * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VB_INPUT * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_VC_INPUT * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_LOADT_INPUT * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RESET_INPUT * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DC_LINK_V_INPUT * DSPBA_bytes_per_word));

    debug_printf(DBG_INFO, "[DSPBA motor model] test function. Config data set by INIT function: T = %d,\
        R = %d, inv_L = %d, PolePairs = %d, Ke = %d, Kt = %d, inv_J %d\n",
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_SAMPLE_TIME_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_RPHASE_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_INV_LPHASE_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_POLEPAIRS_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_KE_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_KT_CFG * DSPBA_bytes_per_word),
            IORD_32DIRECT(base_address,
                MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_INV_J_CFG * DSPBA_bytes_per_word));

    for (int k = 0; k < 2; k++) {

    //Load start bit
#ifndef MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DSPBA_START * DSPBA_bytes_per_word, 0);
#endif
    IOWR_32DIRECT(base_address, MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DSPBA_START * DSPBA_bytes_per_word, 1);
    status_out = 0;
    j = 0;
    //Read finished bit - wait until it changes to 1
    while ((status_out != 1) & (j < 100)) {
        status_out = IORD_32DIRECT(base_address,
            MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DSPBA_READY * DSPBA_bytes_per_word);
        j++;
    }
    debug_printf(DBG_INFO, "[DSPBA motor model] test function. Ready bit from IP = %08X,\
        while loop iterations = %d\n", status_out, j);

    ia = IORD_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_IA_OUTPUT * DSPBA_bytes_per_word);
    ib = IORD_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_IB_OUTPUT * DSPBA_bytes_per_word);
    ic = IORD_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_IC_OUTPUT * DSPBA_bytes_per_word);
    dTheta_dt = IORD_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DTHETA_DT_OUTPUT * DSPBA_bytes_per_word);
    ThetaMech = IORD_32DIRECT(base_address,
        MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_THETAMECH_OUTPUT * DSPBA_bytes_per_word);

    debug_printf(DBG_INFO, "[DSPBA motor model] test function. EXPECTED Outputs: ia = 159, ib = 159,\
        ic = -319, dTheta_dt = , ThetaMech = \n");
    debug_printf(DBG_INFO, "[DSPBA motor model] test function. Outputs: ia = %d, ib = %d, ic = %d,\
        dTheta_dt = %d, ThetaMech = %d\n", ia, ib, ic, dTheta_dt, ThetaMech);
    }

 }

 #endif /*defined(DF_FIXP16_ALU_AV_MOTORMODEL_MOTORMODEL_0_BASE) || defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE)*/


/*!
 * @}
 */

/*!
 * @}
 */
