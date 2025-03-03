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

#include "io.h"
#include "includes.h"
#include "main.h"
#include "platform/platform_linker.h"
#include "perf/altera_avalon_performance_counter.h"
#include "mc/mc_nios_perf.h"
#include "mc/mc_debug.h"

extern OS_FLAG_GRP * drive_enable_flag; //!< Signal to other threads that drive is in enable state

/**
 * @file monitor_task.c
 *
 * @brief Monitor task, initializes and loops forever, capturing latency values for the gui.
 *
 * @param pdata
 */

task_t monitor_task(void *pdata)
{
    unsigned char err;

    while (1) {
        PERF_RESET(PERFORMANCE_COUNTER_0_BASE);

        // wait for drive enable
        OSFlagPend(drive_enable_flag, DRIVE_ENABLE_FLAG, OS_FLAG_WAIT_SET_ANY, 0, &err);

        // execute performance measurement every 200ms while drive enable is set
        while (OSFlagPend(drive_enable_flag, DRIVE_ENABLE_FLAG, OS_FLAG_WAIT_CLR_ANY, OS_TICKS_PER_SEC/5, &err) == 0) {
            // timeout
            PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);
            debug_set_latency(
                small2_perf_get_latency((void *)PERFORMANCE_COUNTER_0_BASE, 1), //The FOC portion of the IRQ for 1 axis
                small2_perf_get_latency((void *)PERFORMANCE_COUNTER_0_BASE, 2) //The complete ISR
            );

            PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
            PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
        }
    }
}

/*!
 * @}
 */
