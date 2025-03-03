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

#ifndef DOC_ADC_H_
#define DOC_ADC_H_

/**
 * @file doc_adc.h
 *
 * @brief Header file for Low Voltage Motor Control (LVMC) power board and MAX 10 ADCs
 */

#include "system.h"
#include "system_shim.h"

#include "mc/mc_params.h"

/**
 * \addtogroup PLATFORM
 *
 * @{
 */

/**
 * \addtogroup ADC
 *
 * @{
 */

//
// Low level read/write function for MAX10 ADC threshold detection sink
//
#define adc_max10_threshold_read(base_addr, reg) (IORD_32DIRECT(base_addr, reg*4))
#define adc_max10_threshold_write(base_addr, reg, data) (IOWR_32DIRECT(base_addr, reg*4, data))
#define adc_max10_threshold_enable(base_addr, reg, data)\
    (IOWR_32DIRECT(base_addr, reg*4, adc_max10_threshold_read(base_addr, reg) | data))
#define adc_max10_threshold_disable(base_addr, reg, data)\
    (IOWR_32DIRECT(base_addr, reg*4, adc_max10_threshold_read(base_addr, reg) & ~data))

// MAX10 ADC threshold detection sink registers
#define THR_CAPTURE_UNDER_ENABLE_REG (0x0)
#define THR_CAPTURE_OVER_ENABLE_REG  (0x1)
#define THR_OUTPUT_UNDER_ENABLE_REG  (0x2)
#define THR_OUTPUT_OVER_ENABLE_REG   (0x3)
#define THR_LATCH_UNDER_REG          (0x4)
#define THR_LATCH_OVER_REG           (0x5)
#define THR_OUTPUT_UNDER_REG         (0x6)
#define THR_OUTPUT_OVER_REG          (0x7)
#define THR_SET_UNDER_ERROR_REG      (0x8)
#define THR_SET_OVER_ERROR_REG       (0x9)
#define THR_CLEAR_UNDER_ERROR_REG    (0xa)
#define THR_CLEAR_OVER_ERROR_REG     (0xb)

// MAX10 ADC threshold detection sink bit masks
#define THR_INPUT_VOLTAGE_FB_BIT    0x0001    // ADC1 ch 0
#define THR_I_FBK_DRIVE0_V_BIT      0x0002    // ADC1 ch 1
#define THR_I_FBK_DRIVE0_W_BIT      0x0004    // ADC1 ch 2
#define THR_V_FBK_DRIVE0_W_BIT      0x0008    // ADC1 ch 3
#define THR_I_FBK_BOOST_DRIVE1_BIT  0x0010    // ADC1 ch 4
#define THR_V_FBK_DRIVE1_V_BIT      0x0020    // ADC1 ch 5
#define THR_I_FBK_DRIVE1_U_BIT      0x0040    // ADC1 ch 6
#define THR_V_FBK_DRIVE1_U_BIT      0x0080    // ADC1 ch 7

#define THR_I_FBK_BOOST_DRIVE0_BIT  0x0100    // ADC2 ch 0
#define THR_V_FBK_DRIVE0_V_BIT      0x0200    // ADC2 ch 1
#define THR_I_FBK_DRIVE0_U_BIT      0x0400    // ADC2 ch 2
#define THR_V_FBK_DRIVE0_U_BIT      0x0800    // ADC2 ch 3
#define THR_DCBUS_VOLTAGE_FB_BIT    0x1000    // ADC2 ch 4
#define THR_I_FBK_DRIVE1_V_BIT      0x2000    // ADC2 ch 5
#define THR_I_FBK_DRIVE1_W_BIT      0x4000    // ADC2 ch 6
#define THR_V_FBK_DRIVE1_W_BIT      0x8000    // ADC2 ch 7

#define THR_ALL_CHANNEL_MASK 0xFFFF

#define THR_VOLTAGE_ERROR (THR_INPUT_VOLTAGE_FB_BIT | THR_DCBUS_VOLTAGE_FB_BIT)

#define THR_BOOST_OC (THR_I_FBK_BOOST_DRIVE0_BIT | THR_I_FBK_BOOST_DRIVE1_BIT)
#define THR_DRIVE0_OC (THR_I_FBK_DRIVE0_U_BIT | THR_I_FBK_DRIVE0_V_BIT | THR_I_FBK_DRIVE0_W_BIT)
#define THR_DRIVE1_OC (THR_I_FBK_DRIVE1_U_BIT | THR_I_FBK_DRIVE1_V_BIT | THR_I_FBK_DRIVE1_W_BIT)

void adc_setup(drive_params *dp);
void adc_overcurrent_enable(drive_params *dp, int enable);
void adc_read(drive_params *dp, system_params *sp) IRQ_SECTION;
void adc_irq_acknowledge(drive_params *dp) IRQ_SECTION;
void adc_irq_enable(drive_params *dp) IRQ_SECTION;
void adc_debug_oc(drive_params *dp);
void adc_offset_accumulate(drive_params *dp);
int adc_offset_calculation(drive_params *dp);

void adc_threshold_init(void);


/*!
 * @}
 */

/*!
 * @}
 */

#endif /* DOC_ADC_H_ */
