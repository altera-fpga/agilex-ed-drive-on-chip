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

#include "system.h"
#include "system_shim.h"

#ifndef QEP_H_
#define QEP_H_

#include "mc/mc_params.h"
#include "platform/common/platform.h"

/**
 * @file qep.h
 *
 * @brief Header file for Tamagawa resolver encoder interface
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup QEP
 *
 * @{
 */

//
// Low level read/write function for QEP interface
//
#define qep_Read(base_addr, reg) (IORD_32DIRECT(base_addr, reg*4))
#define qep_Write(base_addr, reg, data) {IOWR_32DIRECT(base_addr, reg*4, data); }

// QEP register definitions
#define QEP_CONTROL_REG                 (0)        // RW
#define QEP_COUNT_CAPTURE_REG           (1)        // R
#define QEP_MAX_COUNT_REG               (2)        // RW
#define QEP_COUNT_REG                   (3)        // RW
#define QEP_INDEX_CAPTURE_REG           (4)        // R

#define QEP_CONTROL_DIRECTION_OFST          (0)
#define QEP_CONTROL_DIRECTION_MSK           (1<<QEP_CONTROL_DIRECTION_OFST)
#define QEP_DIRECTION_A_B_CW                (0)
#define QEP_DIRECTION_B_A_CCW               (1)
#define QEP_CONTROL_INDEX_RESET_OFST        (1)
#define QEP_CONTROL_INDEX_RESET_MSK         (1<<QEP_CONTROL_INDEX_RESET_OFST)
#define QEP_INDEX_RESET_ENABLE              (1)
#define QEP_INDEX_RESET_DISABLE             (0)
#define QEP_CONTROL_INDEX_CAPTURE_OFST      (2)
#define QEP_CONTROL_INDEX_CAPTURE_MSK       (1<<QEP_CONTROL_INDEX_CAPTURE_OFST)
#define QEP_CONTROL_INDEX_CAPTURE_ENABLE    (1)
#define QEP_CONTROL_INDEX_CAPTURE_DISABLE   (0)

//
// Application specific QEP support functions
//
int qep_Init(drive_params *dp);
void qep_Read_Sensor(drive_params *dp);
void qep_Read_Position(drive_params *dp, system_params *sp) IRQ_SECTION;
void qep_Service(drive_params *dp, system_params *sp);

/*!
 * @}
 */

/*!
 * @}
 */

#endif /* QEP_H_ */
