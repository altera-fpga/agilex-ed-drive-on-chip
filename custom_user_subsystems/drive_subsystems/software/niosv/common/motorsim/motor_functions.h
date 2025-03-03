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

#ifndef MOTOR_FUNCTIONS_H_
#define MOTOR_FUNCTIONS_H_

/*
 * Functions to simulate motor model
 */

#include "motor.h"
#include "mc/mc_params.h"

//void dspba_motor_model_fixedp_direct_inf(drive_params * dp, system_params * sp) IRQ_SECTION;
void dspba_motor_model_fixedp_direct_inf(drive_params * dp, system_params * sp);

//all in IRQ_SECTION?
void init_motor_mdl(drive_params *dp);


#endif /*MOTOR_FUNCTIONS_H_*/
