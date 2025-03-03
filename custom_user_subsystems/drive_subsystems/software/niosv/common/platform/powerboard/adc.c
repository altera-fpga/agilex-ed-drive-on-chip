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

#include <assert.h>

#include "mc/mc_params.h"

/**
 * @file doc_adc.c
 *
 * @brief Drive on chip ADC interface
 */

/*!
 * @brief Weak function prototypes for alternative ADC types
 *
 * @{
 */
void __attribute__((weak)) adc_sd_setup(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_sd_overcurrent_enable(drive_params * dp, int enable) { assert(1); }
void __attribute__((weak)) adc_sd_read(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_sd_irq_acknowledge(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_sd_irq_enable(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_sd_debug_oc(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_max10_setup(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_max10_overcurrent_enable(drive_params * dp, int enable) { assert(1); }
void __attribute__((weak)) adc_max10_read(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_max10_irq_acknowledge(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_max10_irq_enable(drive_params * dp) { assert(1); }
void __attribute__((weak)) adc_max10_debug_oc(drive_params * dp) { assert(1); }
/*!
 * @}
 */
