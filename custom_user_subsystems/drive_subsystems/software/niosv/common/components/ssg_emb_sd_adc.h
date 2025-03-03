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

#ifndef SSG_EMB_SD_ADC_H_
#define SSG_EMB_SD_ADC_H_

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#if defined __SSG_EMB_SD_ADC

/**
 * @file ssg_emb_sd_adc.h
 *
 * @brief Header file for ADC interface
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup SDADC
 *
 * @{
 */

//ADC internal ADR OFFSET
#define ADC_OFFSET_U                 0x04  // w
#define ADC_OFFSET_W                 0x08  // w
#define ADC_I_PEAK                   0x0C  // w
#define ADC_D                        0x10  // w
#define ADC_IRQ_ACK                  0x14  // w

#define ADC_STATUS                   0x18  // r
#define ADC_I_U                      0x1C  // r
#define ADC_I_W                      0x20  // r
#define ADC_I_PEAK_RD                0x24  // r
#define ADC_I_V                      0x28  // r
#define ADC_OFFSET_V                 0x2C  // w
#define OC_CAPTURE_U                 0x30  // r
#define OC_CAPTURE_W                 0x34  // r
#define OC_CAPTURE_V                 0x38  // r
#define SET_IRQ_COUNTER              0x3C  // rw

// Control register bit macros
#define ADC_UVOLT_EN_MSK            (0x1)
#define ADC_UVOLT_EN_OFST           (0)
#define ADC_OVERCURRENT_EN_MSK      (0x2)
#define ADC_OVERCURRENT_EN_OFST     (1)
#define ADC_D_MASK                  (0x4)
#define ADC_D_OFST                  (2)
#define ADC_D_10US                  (0)
#define ADC_D_5US                   (1)
#define ADC_3PH_EN_MSK              (0x8)
#define ADC_3PH_EN_OFST             (3)

void ssg_emb_adc_setup(int base_address, int ofst_u, int ofst_v, int ofst_w, int peak, int d, int irq);
void ssg_emb_adc_overcurrent_enable(int base_address, int enable);
void ssg_emb_adc_read(int base_address, short *u, short *v, short *w);

/*!
 * @}
 */

/*!
 * @}
 */

#endif /*SSG_EMB_SD_ADC_H_*/

#endif    // defined __SSG_EMB_SD_ADC
