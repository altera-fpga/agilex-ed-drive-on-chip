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
#include "demo_cfg.h"

#if defined __SSG_EMB_PWM

#ifndef SSG_EMB_PWM_H_
#define SSG_EMB_PWM_H_

#include "mc/mc_params.h"

/**
 * @file ssg_emb_pwm.h
 *
 * @brief Header file for PWM interface
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup PWM
 *
 * @{
 */

// status codes
#define PWM_OK                      0
#define PWM_SAMPLE_RATE_TOO_HIGH   -1

// PWM internal ADR OFFSET
#define PWM_CONTROL                 0x00   // rw
#define PWM_U                       0x04   // rw
#define PWM_V                       0x08   // rw
#define PWM_W                       0x0C   // rw
#define PWM_MAX                     0x10   // rw
#define PWM_BLOCK                   0x14   // rw
#define PWM_TRIGGER_UP              0x18   // rw
#define PWM_TRIGGER_DOWN            0x1C   // rw
#define PWM_DIRECT_INTERFACE        0x20   // rw
#define PWM_HALL_EN                 0x2C   // rw

int pwm_init(drive_params *dp);
int pwm_enable(drive_params *dp);
int pwm_disable(drive_params *dp);
int pwm_setup(drive_params *dp);

void pwm_update(int base_address, unsigned short Vu_PWM, unsigned short Vv_PWM,
                unsigned short Vw_PWM, int uvw_en, int pwm_direct) IRQ_SECTION;

/*!
 * @}
 */

/*!
 * @}
 */

#endif /*SSG_EMB_PWM_H_*/

#endif    // defined __SSG_EMB_PWM
