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
 * @file mc_debug_fn.c
 *
 * @brief Weak function prototypes for debug
 */

/*!
 * \addtogroup DEBUG
 *
 * @{
 */

/**
 * @brief Wait for console input without blocking RTOS thread
 */
char __attribute__((weak)) debug_waitchar(int level, char *str, int en) { return '\0'; }

/*!
 * @}
 */
