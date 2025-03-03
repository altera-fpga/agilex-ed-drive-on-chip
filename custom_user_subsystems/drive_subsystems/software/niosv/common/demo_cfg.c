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

#include "platform/motors/motor_types.h"

/**
 * @file demo_cfg.c
 *
 * @brief Source file to configure the drive on chip motor control demo
 */

/*!
 * \addtogroup DEMOCONFIG
 *
 * @{
 */

/** @name Motor types
 *
 * The motors[] array is initialised with pointers to a motor_t structure for
 * each axis. The available motor types are declared in motor_types.c
 *
 * @{
 */
// Example for Tandem Motion Power with 2x anaheim motors using quadrature encoder
//motor_t * motors[] = {&anaheim_qep[0], &anaheim_qep[1], NULL,    NULL};

// Example for Tandem Motion Power with 2x Tamagawa motors
motor_t *motors[] = {&tamagawa_resolver[0], &tamagawa_resolver[1], NULL, NULL};


/*!
 * @}
 */

/*!
 * @}
 */
