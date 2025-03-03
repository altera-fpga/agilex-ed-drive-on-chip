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

#ifndef MAIN_H_
#define MAIN_H_

/**
 * @file
 *
 * @brief Header file for uC/OS-II application main() module
 */

#include "demo_cfg.h"

typedef void (*drive_callback_fn_t)(void);

typedef struct {
    drive_callback_fn_t drive_enable_cb;
    drive_callback_fn_t drive_reset_cb;
} drive_state_callbacks_t;

// Definition of Task Stacks
#define   TASK_STACKSIZE       2048

// Definition of Task Priorities
#define DEBUG_MUTEX_PRIORITY        5
#define MOTOR_PRIORITY              8
#define DEBUG_PRIORITY              10
#define MOTION_PRIORITY             11
#define MONITOR_PRIORITY            12

#define DRIVE_ENABLE_FLAG 1

/*!
 * @}
 */

#endif /* MAIN_H_ */
