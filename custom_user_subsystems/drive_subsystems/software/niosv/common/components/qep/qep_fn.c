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
 * @file qep_fn.c
 *
 * @brief Drive on chip Components
 */

/*!
 * @brief Weak function prototypes for QEP interface in case interface is not present
 *
 * @{
 */
int __attribute__((weak)) qep_Init(drive_params * dp) { assert(1);  return 0; }
void __attribute__((weak)) qep_Read_Sensor(drive_params * dp) { assert(1); }
void __attribute__((weak)) qep_Read_Position(drive_params * dp, system_params *sp) { assert(1); }
void __attribute__((weak)) qep_Service(drive_params * dp, system_params *sp) { assert(1); }
/*!
 * @}
 */

/*!
 * @}
 */
