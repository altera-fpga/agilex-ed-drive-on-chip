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

#ifndef APP_CFG_H_
#define APP_CFG_H_

/**
 * @file
 *
 * @brief Header file for OS cfg switches
 */

#ifdef __ucosii__

#include "includes.h"
#define OS_SLEEP_MS(sleep_ms) OSTimeDlyHMSM(0, 0, ((int)sleep_ms/1000), ((int)sleep_ms%1000))
#define OS_TIME_SEC()         (OSTimeGet()/OS_TICKS_PER_SEC)

#else

#ifdef ZEPHYR_RTOS

#include <zephyr/kernel.h>
#define OS_SLEEP_MS(sleep_ms) k_msleep(sleep_ms)

#else
#error "Unsupported OS"
#endif

#endif

/*!
 * @}
 */

#endif /* APP_CFG_H_ */
