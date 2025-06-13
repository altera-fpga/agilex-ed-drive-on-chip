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

#include "powerboard.h"

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#include "platform/common/platform.h"

/**
 * @file powerboard.c
 *
 * @brief Low voltage motor control power board
 */

/*!
 * \addtogroup PLATFORM
 *
 * @{
 */

/**
 * @brief Populate powerboard struct
 *
 * @return
 */
void powerboard_init(void)
{
    // Motor Model inherits the Tandem Motion 48V Power board Max PWM Freq
    platform.powerboard->pwm_max_freq = 100;

}

/*!
 * @}
 */
