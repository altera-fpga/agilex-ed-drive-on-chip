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

#ifndef PLATFORM_LINKER_H_
#define PLATFORM_LINKER_H_

#ifndef __arm__  // If compiler is not ARM Compiler
#include <unistd.h>
#endif

#include "system.h"
#include "system_shim.h"

/**
 * @file platform_linker.h
 *
 * @brief Include file for Nios HAL application to define linker regions and
 * OS abstractions
 */

// Nios solution uses on-chip memory for performance
#define MATH_SECTION __attribute__((section(".exceptions")))
#define IRQ_SECTION __attribute__((section(".exceptions")))



typedef void task_t;

#endif /* PLATFORM_LINKER_H_ */
