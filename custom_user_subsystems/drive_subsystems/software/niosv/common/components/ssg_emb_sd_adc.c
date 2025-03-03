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
 * @file ssg_emb_sd_adc.c
 *
 * @brief ADC interface
 */

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#if defined __SSG_EMB_SD_ADC

#include "ssg_emb_sd_adc.h"
#include "platform/common/platform.h"

#include "io.h"

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup SDADC Sigma-Delta ADC Interface
 *
 * @brief Interface to sigma-delta ADCs
 *
 * The ADCs are used to measure the motor currents
 *
 * @{
 */

void ssg_emb_adc_setup(int base_address, int ofst_u, int ofst_v, int ofst_w, int peak, int d, int irq)
{
    //Parameters of ADC
    IOWR_16DIRECT(base_address, ADC_OFFSET_U, ofst_u);
    IOWR_16DIRECT(base_address, ADC_OFFSET_V, ofst_v);
    IOWR_16DIRECT(base_address, ADC_OFFSET_W, ofst_w);
    IOWR_16DIRECT(base_address, ADC_I_PEAK, peak);
    IOWR_16DIRECT(base_address, ADC_D, d);
    IOWR_16DIRECT(base_address, ADC_IRQ_ACK, irq);
    if (platform.adc_sample_rate > 32)
        IOWR_16DIRECT(base_address, SET_IRQ_COUNTER, (platform.adc_sample_rate/32-1));
    else
        IOWR_16DIRECT(base_address, SET_IRQ_COUNTER, 0);
}

/*
 * Control bits are confusingly named. Bits[1:0] need to be 01 to enable
 */
void ssg_emb_adc_overcurrent_enable(int base_address, int enable)
{
    IOWR_16DIRECT(base_address, ADC_D, (enable&1) | IORD_16DIRECT(base_address, ADC_D)|SD_ADC_FILTER<<ADC_D_OFST);
}

void ssg_emb_adc_read(int base_address, short *u, short *v, short *w)
{
    *u = (short) IORD_16DIRECT(base_address, ADC_I_U);
    *v = (short) IORD_16DIRECT(base_address, ADC_I_V);
    *w = (short) IORD_16DIRECT(base_address, ADC_I_W);
}

/*!
 * @}
 */

/*!
 * @}
 */

#endif    // defined __SSG_EMB_SD_ADC
