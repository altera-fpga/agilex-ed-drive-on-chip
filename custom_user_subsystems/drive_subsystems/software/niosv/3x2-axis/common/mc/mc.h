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

#ifndef MC_H_
#define MC_H_

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#include "mc/mc_params.h"

/**
 * @file mc.h
 *
 * @brief Header file for motor control demo
 */

/*!
 * \addtogroup MC
 *
 * @{
 */

/**
 * Defines how many fractional bits are used for the internal representation of speed/rpm of the motor
 * Design has only been tested with 4 and 0. If this values is changed then the equivalent value in
 * the System Console doc_debug_gui.tcl script must be changed for the speed graphs to be scaled correctly.
 */
#define SPEED_FRAC_BITS                     4
// Scale factor for speed command which is in RPM
#define SPEED_SCALE                         (60<<SPEED_FRAC_BITS)

// Speed limits in RPM
#define INIT_SPEED_COMMAND_FOC_SENSOR          (100)
#define INIT_SPEED_COMMAND_OPENLOOP_SENSOR     (500)
#define INIT_SPEED_COMMAND_OTHER               (500)

/*!
 * @}
 */

void init_sp(system_params *sp);
void init_dp(drive_params *dp, system_params *sp);
void update_axis(drive_params *dp);
void drive_irq(void *context);

/*!
 * @}
 */

#endif /* MC_H_ */
