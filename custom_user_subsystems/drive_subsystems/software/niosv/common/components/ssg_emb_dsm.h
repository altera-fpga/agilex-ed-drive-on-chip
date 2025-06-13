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

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#if defined __SSG_EMB_DSM

#ifndef SSG_EMB_DSM_H_
#define SSG_EMB_DSM_H_

/**
 * @file ssg_emb_dsm.h
 *
 * @brief Header file for Drive State Machine interface
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup DSM
 *
 * @{
 */

//drive state machine
#define SM_CONTROL                      0x00     // rw
#define SM_STATUS                       0x04     // r
#define SM_RESET                        0x04     // w

#define DSM_STATE_IDLE                  0x0        // Power up state
#define DSM_STATE_INIT                  0x5        // PWM counter and triggers running, some errors monitored
#define DSM_STATE_PRECHARGE             0x1        // Lower gate drive enabled, some errors monitored
#define DSM_STATE_PRERUN                0x2        // lower gate drive enabled and check errors
#define DSM_STATE_RUN                   0x3        // Upper and lower gate drive enabled and check errors
#define DSM_STATE_ERROR                 0x4        // Error state PWM counter and triggers running, gate drive disabled
#define DSM_STATE_PREINIT               0x6        // Reset state PWM counter and triggers running, errors ignored

#define DSM_CONTROL_TO_INIT             0x5
#define DSM_CONTROL_TO_PRECHARGE        0x1
#define DSM_CONTROL_TO_PRERUN           0x2
#define DSM_CONTROL_TO_RUN              0x3
#define DSM_CONTROL_TO_PREINIT          0x6

#define DSM_STATUS_MASK                 (0xFFF)
#define DSM_STATUS_STATUSBITS_OFFSET    (0)
#define DSM_STATUS_STATUSBITS_MASK      (0x1F<<DSM_STATUS_STATUS_OFFSET)
#define DSM_STATUS_PWM_OFFSET           (6)
#define DSM_STATUS_PWM_MASK             (0x7<<DSM_STATUS_PWM_OFFSET)
#define DSM_STATUS_STATE_OFFSET         (9)
#define DSM_STATUS_STATE_MASK           (0x7<<DSM_STATUS_STATE_OFFSET)


#define DSM_STATUS_ERR_OC               0x01        // Overcurrent
#define DSM_STATUS_ERR_OV               0x02        // Overvoltage
#define DSM_STATUS_ERR_UV               0x04        // Undervoltage
#define DSM_STATUS_ERR_CLOCK            0x08        // Clock
#define DSM_STATUS_ERR_MOSFET           0x10        // MOSFET
#define DSM_STATUS_ERR_CHOPPER          0x20        // Chopper

void dsm_reset(int base_address);
void dsm_init(int base_address);

/*!
 * @}
 */

/*!
 * @}
 */

#endif /*SSG_EMB_DSM_H_*/

#endif    // defined __SSG_EMB_DSM
