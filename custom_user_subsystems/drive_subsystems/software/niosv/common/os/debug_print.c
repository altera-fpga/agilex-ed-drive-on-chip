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
 * @file debug_print.c
 *
 * @brief Create uc/OSII specific debug print output message queue
 */


#include <stdarg.h>
#include <stdio.h>
#include "includes.h"
#include "main.h"
#include "mc/mc_debug.h"

unsigned int dbg_level = DBG_ALL;

static OS_EVENT *debug_mutex;           //!< Mutex to control access to console output queue
static OS_EVENT *debug_empty_cnt_sem;   //!< Counting semaphore for console output queue empty status
static OS_EVENT *debug_full_cnt_sem;    //!< Mutex to control access to console outut queue

/**
 * \addtogroup DEBUG_MSG
 *
 * @{
 */
static char debug_msg[MAX_DEBUG_QUEUE+1][MAX_DEBUG_MSG+1];     //!< Debug mesage queue
static unsigned int debug_time[MAX_DEBUG_QUEUE+1];                     //!< Timestamp queue
static unsigned int debug_head = 0;                            //!< Current head of message queue
static unsigned int debug_tail = 0;                            //!< Current tail of message queue

/*
 * @brief Initialise the debug buffers and debug output filter
 */
void init_debug_print(void)
{
    unsigned char  os_error;

    debug_head = 0;
    debug_tail = 0;

    debug_empty_cnt_sem = OSSemCreate(MAX_DEBUG_QUEUE);
    debug_full_cnt_sem = OSSemCreate(0);
    debug_mutex = OSMutexCreate(DEBUG_MUTEX_PRIORITY,  &os_error);

    dbg_level = DBG_DEFAULT;
}

/*
 * @brief Add a message to the queue, filtered by priority. If the queue was
 * full then the previous message is overwritten.
 *
 * @param priority
 * @param format
 *
 */
int debug_printf(unsigned int priority, char *format, ...)
{
    unsigned char  os_error;
    OS_SEM_DATA sem_data;
    int ret = -1;

    va_list args;

    if (priority <= dbg_level) {
        // Take an empty slot if available
        OSSemQuery(debug_empty_cnt_sem, &sem_data);
        if (sem_data.OSCnt != 0) {
            OSSemPend(debug_empty_cnt_sem, 1, &os_error);

            // Protect for buffer access from multiple threads
            OSMutexPend(debug_mutex, 0, &os_error);

            va_start(args, format);
            vsnprintf(debug_msg[debug_head], MAX_DEBUG_MSG, format, args);
            va_end(args);
            debug_msg[debug_head][MAX_DEBUG_MSG-1] = 0;
            debug_time[debug_head] = OSTimeGet();

            // Update index to point to next free entry
            debug_head = (debug_head + 1) % MAX_DEBUG_QUEUE;

            OSMutexPost(debug_mutex);

            // Count the full slot
            OSSemPost(debug_full_cnt_sem);

            ret = 0;
        }
    }
    return ret;
}

/**
 * @brief Task to manage buffer of debug output messages
 *
 * @param pdata not used
 */
task_t debug_task(void *pdata)
{
    unsigned char os_err;

    while (1) {
        // Wait for the semaphore to be non-zero to indicate there is something in the queue
        OSSemPend(debug_full_cnt_sem, 0, &os_err);

        // Print something
        printf("%9d: %s", debug_time[debug_tail], debug_msg[debug_tail]);

        // Update index. Only this task doing this, so no need for mutex
        debug_tail = (debug_tail + 1) % MAX_DEBUG_QUEUE;

        // Give back an empty slot
        OSSemPost(debug_empty_cnt_sem);

        // Short delay to cause this task to yield in case counting semaphore is already non-zero
        OSTimeDlyHMSM(0, 0, 0, 10);
    }
}

/*!
 * @}
 */
