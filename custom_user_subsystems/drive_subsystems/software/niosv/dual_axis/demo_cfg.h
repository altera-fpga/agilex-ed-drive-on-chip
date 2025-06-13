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

#ifndef DEMO_CFG_H_
#define DEMO_CFG_H_

/**
 * @file demo_cfg.h
 *
 * @brief Header file to configure the drive on chip motor control demo
 */

/*!
 * \addtogroup DEMOCONFIG
 *
 * @brief Macros to configure the operation of the motor control reference design
 *
 * A number of macros are used to define the operation of the motor control demo.
 *
 * @{
 */

/** @name Axis Enable
 *
 * Set these defines to control how many axes are actually present (i.e. how
 * many motors are connected) on the multi-axis or tandem motion power board
 *
 * @{
 */
#define FIRST_MULTI_AXIS 0    //!< First active axis on multi-axis or tandem motion power platform
#define LAST_MULTI_AXIS  1    //1    //!< Last active axis on multi-axis or tandem motion power platform
/*!
 * @}
 */

/** @name Default ADC type
 *
 * @{
 */
#define DEFAULT_ADC_TYPE ADC_TYPE_SIGMA_DELTA
#define SD_ADC_FILTER ADC_D_10US

/*!
 * @}
 */

/** @name constant voltage scale factor
 *
 * @{
 */
 //Voltage is stored as short (16 bits signed value:sfix16), (1<<n), n means how many decimal bit in sfix16
 //more information about this see platform/motors/motor_types.c
 //this means voltage is stored as sfix16_en6
#define constScaleVoltage (1<<6)

/*!
 * @}
 */

/** @name Interactive startup
 *
 * Startup pauses at key stages to allow, e.g. use of gui trace window. Interactive startup may also
 * be selected by holding button 3 down during startup.
 *
 * @{
 */
#define INTERACTIVE_START 0

/*!
 * @}
 */

/** @name Open Loop
 *
 * Set this define non zero for open loop control mode on all axes.
 * Set this define PWM DEAD time to 2 us.
 *
 * @{
 */
#define OPEN_LOOP_INIT 0
//This value is used in open loop calculation and it was divided by 1000 to reduce the FP operation for NIOSV.
//#define PWM_DEAD_TIME_NSEC 2000
#define PWM_DEAD_TIME_NSEC 2


/*!
 * @}
 */

/** @name Debug output
 *
 * Define the debug output level. See mc_debug.h for available debug levels.
 *
 * @{
 */
#define DBG_DEFAULT DBG_DEBUG
/*!
 * @}
 */

/** @name Sensorless startup count
 *
 * Count in sample periods to run in open loop before switching to sensorless.
 * e.g. 6400 counts = 0.46300 s @ 16 kHz
 *
 * @{
 */
#define SENSORLESS_STARTUP_COUNT 6400UL
/*!
 * @}
 */

/** @name State of charge update rate
 *
 * Period in milliseconds for updating the battery state of charge. Must match the
 * period used in the system conole gui.
 *
 * @{
 */
#define SOC_UPDATE_RATE 100 //0.1s

/*!
 * @}
 */

/*
 * Do not edit remaining lines of this file
 */
#define ACDS_MAJOR_VERSION 6
#define ACDS_MINOR_VERSION 0

#if LAST_MULTI_AXIS < FIRST_MULTI_AXIS
#error "Invalid first/last axis selection in demo_cfg.h"
#endif

#if LAST_MULTI_AXIS > 1
#error "Invalid first/last axis selection in demo_cfg.h"
#endif


// Period (in OS ticks) for speed/demo timer
#define MOTION_TMR_PERIOD 1

/*!
 * @}
 */

#endif /* DEMO_CFG_H_ */
