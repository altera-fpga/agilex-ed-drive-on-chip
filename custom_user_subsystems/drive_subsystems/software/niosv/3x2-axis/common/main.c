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
 * @file
 *
 * @brief Application main for Nios
 */

#include "main.h"

#include <string.h>

#include "includes.h"

#include "demo_cfg.h"
#include "system.h"
#include "system_shim.h"
#include "mc/mc_debug.h"
#include "platform/common/platform.h"

/*!
 * \addtogroup MAIN Main
 *
 * @brief Main entry points based on each supported RTOS
 *
 * @{
 */

/*!
 * \addtogroup UCOSIIMAIN uC/OS-II Application Main
 *
 * @brief Main entry point for uC/OS-II application
 *
 * Built as Nios HAL project and BSP.
 *
 * Initialises the OS, initialises and starts the tasks necessary to run the
 * motor control application. Control does not return to main().
 *
 * @{
 */

extern void motor_task(void *pdata);                    //!< Task that runs the motor control application
extern void debug_task(void *pdata);                    //!< Task to handle queueing of non-blocking console output
extern void monitor_task(void *pdata);                  //!< Task to handle performance monitoring
extern void init_debug_print(void);

OS_STK    motor_task_stk[TASK_STACKSIZE];
OS_STK    debug_task_stk[TASK_STACKSIZE];
OS_STK    monitor_task_stk[TASK_STACKSIZE];

OS_TMR       *motion_timer;
OS_FLAG_GRP  *drive_enable_flag; //!< Signal to other threads that drive is in enable state

void drive_enable_callback(void)
{
    unsigned char err;

    // resume monitor thread
    OSFlagPost(drive_enable_flag, DRIVE_ENABLE_FLAG, OS_FLAG_SET, &err);
}

void drive_reset_callback(void)
{
    unsigned char err;

    // suspend monitor thread
    OSFlagPost(drive_enable_flag, DRIVE_ENABLE_FLAG, OS_FLAG_CLR, &err);
}

/**
 * Entry point for uC/OS-II application startup code.
 *
 * @return
 */
int main(void)
{
    unsigned char  os_err;

    drive_state_callbacks_t drive_state_callbacks = { drive_enable_callback, drive_reset_callback };

    // Start debug task now so it can be used during remaining startup code
    OSTaskCreateExt(debug_task,
                    NULL,
                    (void *)&debug_task_stk[TASK_STACKSIZE-1],
                    DEBUG_PRIORITY,
                    DEBUG_PRIORITY,
                    debug_task_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);
#if (OS_TASK_NAME_EN > 0u)
    OSTaskNameSet(DEBUG_PRIORITY, (INT8U *)"Debug", &os_err);
#endif

    init_debug_output();
    init_debug_print();

    // Create application objects
    drive_enable_flag = OSFlagCreate(0, &os_err);

    OSTaskCreateExt(motor_task,
                    (void *)&drive_state_callbacks,
                    (void *)&motor_task_stk[TASK_STACKSIZE-1],
                    MOTOR_PRIORITY,
                    MOTOR_PRIORITY,
                    motor_task_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);
#if (OS_TASK_NAME_EN > 0u)
    OSTaskNameSet(MOTOR_PRIORITY, (INT8U *)"Motor", &os_err);
#endif

    OSTaskCreateExt(monitor_task,
                    NULL,
                    (void *)&monitor_task_stk[TASK_STACKSIZE-1],
                    MONITOR_PRIORITY,
                    MONITOR_PRIORITY,
                    monitor_task_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);
#if (OS_TASK_NAME_EN > 0u)
    OSTaskNameSet(MOTOR_PRIORITY, (INT8U *)"Monitor", &os_err);
#endif

    OSStart();              /* Start multitasking (i.e. give control to uC/OS-II).  */

    while (1) {             /* Should not get here                                  */
        ;
    }

    // Should never get here
    return 1;
}

/*!
 * @}
 */

/*!
 * @}
 */
