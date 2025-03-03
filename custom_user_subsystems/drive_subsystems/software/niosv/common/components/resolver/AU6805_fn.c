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
 * @file AU6805_fn.c
 *
 * @brief Drive on chip Components
 */

/*!
 * @brief Weak function prototypes in case interface is not present
 *
 * @{
 */
void __attribute__((weak)) au6805_Write(unsigned int base_addr, unsigned int data) { assert(1); }
int __attribute__((weak)) au6805_Init(drive_params * dp) { assert(1); return 0; }
void __attribute__((weak)) au6805_Read_Errors(drive_params * dp) { assert(1); }
void __attribute__((weak)) au6805_Clear_Errors(drive_params * dp) { assert(1); }
void __attribute__((weak)) au6805_Read_Sensor(drive_params * dp) { assert(1); }
void __attribute__((weak)) au6805_Read_Absolute_Position(drive_params * dp) { assert(1); }
void __attribute__((weak)) au6805_Read_Position(drive_params * dp, system_params *sp) { assert(1); }
void __attribute__((weak)) au6805_Service(drive_params * dp, system_params *sp) { assert(1); }
/*!
 * @}
 */

/*!
 * @}
 */
