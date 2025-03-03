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

#ifndef AU6805_H_
#define AU6805_H_
#if (defined DRIVE0_DOC_RSLVR_PIO_BASE) || (defined DRIVE1_DOC_RSLVR_PIO_BASE)
#include "altera_avalon_spi.h"
#endif
#include "mc/mc_params.h"
#include "platform/common/platform.h"

/**
 * @file AU6805.h
 *
 * @brief Header file for low level Tamagawa resolver encoder interface
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup RESOLVER Tamagawa resolver interface
 *
 * @{
 */

//
// Low level read/write function for Resolver QEP equivalent interface
//
#define rslvr_Qep_Read(base_addr, reg) (IORD_32DIRECT(base_addr, reg*4))
#define rslvr_Qep_Write(base_addr, reg, data) (IOWR_32DIRECT(base_addr, reg*4, data))

// AU6805 Setting Register bit macros
#define AU6805_SET_THRESHOLD_MSK            (0x800)
#define AU6805_SET_THRESHOLD_OFST           (11)
#define AU6805_THRESHOLD_1X                 (0)
#define AU6805_THRESHOLD_14X                (1)
#define AU6805_SET_LOOP_GAIN_GROUP_MSK      (0x400)
#define AU6805_SET_LOOP_GAIN_GROUP_OFST     (10)
#define AU6805_LOOP_GAIN_GROUP_A            (0)
#define AU6805_LOOP_GAIN_GROUP_B            (1)
#define AU6805_SET_BIST_MODE_MSK            (0x3c0)
#define AU6805_SET_BIST_MODE_OFST           (6)
#define AU6805_BIST_MODE_RESET              (13)
#define AU6805_BIST_MODE_SER_ABS            (14)
#define AU6805_SET_LOOP_GAIN_MSK            (0x030)
#define AU6805_SET_LOOP_GAIN_OFST           (4)
#define AU6805_LOOP_GAIN_A800_B1000         (0)
#define AU6805_LOOP_GAIN_A2000_B500         (1)
#define AU6805_LOOP_GAIN_A2500_B200         (2)
#define AU6805_LOOP_GAIN_A1500_BAUTO        (3)
#define AU6805_SET_SERIAL_OUTPUT_MODE_MSK   (0x00c)
#define AU6805_SET_SERIAL_OUTPUT_MODE_OFST  (2)
#define AU6805_SERIAL_OUTPUT_MODE_ANGLE     (0)
#define AU6805_SERIAL_OUTPUT_MODE_PULSE     (1)
#define AU6805_SERIAL_OUTPUT_MODE_CALLBACK  (2)
#define AU6805_SERIAL_OUTPUT_MODE_BIST      (3)
#define AU6805_SET_EXCITE_CLOCK_MSK         (0x002)
#define AU6805_SET_EXCITE_CLOCK_OFST        (1)
#define AU6805_EXCITE_CLOCK_INT             (0)
#define AU6805_EXCITE_CLOCK_EXT             (1)
#define AU6805_SET_OUTPUT_MODE_MSK          (0x001)
#define AU6805_SET_OUTPUT_MODE_OFST         (0)
#define AU6805_OUTPUT_MODE_ANGLE            (0)
#define AU6805_OUTPUT_MODE_PULSE            (1)

// AU6805 Serial Output bit macros for all modes
#define AU6805_OUTPUT_PRTY2_MSK         (0x8000)
#define AU6805_OUTPUT_PRTY2_OFST        (15)
#define AU6805_OUTPUT_PRTY_MSK          (0x1000)
#define AU6805_OUTPUT_PRTY_OFST         (12)

// AU6805 Serial Output bit macros for absolute value output mode
#define AU6805_OUTPUT_ANGLE_DATA_MSK    (0x0fff)
#define AU6805_OUTPUT_ANGLE_DATA_OFST   (0)

// AU6805 Serial Output bit macros for pulse output mode
#define AU6805_OUTPUT_PULSE_ABZ_MSK     (0x0007)
#define AU6805_OUTPUT_PULSE_ABZ_OFST    (0)
#define AU6805_OUTPUT_PULSE_UVW_MSK     (0x0038)
#define AU6805_OUTPUT_PULSE_UVW_OFST    (3)
#define AU6805_OUTPUT_PULSE_ERR_MSK     (0x1F80)
#define AU6805_OUTPUT_PULSE_ERR_OFST    (7)

// AU6805 Serial Output bit macros for callback mode
#define AU6805_OUTPUT_CALLBACK_MSK      (0x0fff)
#define AU6805_OUTPUT_CALLBACK_OFST     (0)

// Function prototypes
void au6805_Reset(drive_params *dp);
void au6805_Write(drive_params *dp, unsigned short data);
unsigned short au6805_Read(drive_params *dp);
int au6805_Init(drive_params *dp);
void au6805_Read_Errors(drive_params *dp);
void au6805_Clear_Errors(drive_params *dp);
void au6805_Read_Sensor(drive_params *dp);
void au6805_Read_Absolute_Position(drive_params *dp);
void au6805_Read_Position(drive_params *dp, system_params *sp);
void au6805_Service(drive_params *dp, system_params *sp);

/*!
 * @}
 */

/*!
 * @}
 */

#endif
