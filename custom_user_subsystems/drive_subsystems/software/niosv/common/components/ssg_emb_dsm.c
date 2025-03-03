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

#if defined __SSG_EMB_DSM

/**
 * @file ssg_emb_dsm.c
 *
 * @brief Drive State Machine interface
 */

#include "ssg_emb_dsm.h"

#include "io.h"

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup DSM Drive State Machine
 *
 * @brief Drive state machine
 *
 * The drive state machine monitors drive status (e.g. undervoltage, overvoltage, overcurrent) and
 * shuts down the drive in the case of an error
 *
 * @{
 */

void dsm_reset(int base_address)
{
    IOWR_16DIRECT(base_address, SM_RESET, 0xf000ffff);                // reset error latches and set state to preinit
    IOWR_16DIRECT(base_address, SM_CONTROL, DSM_CONTROL_TO_PREINIT);
}

void dsm_init(int base_address)
{
    IOWR_16DIRECT(base_address, SM_RESET, 0xf000ffff);                // reset error latches and set state to preinit
    IOWR_16DIRECT(base_address, SM_CONTROL, DSM_CONTROL_TO_INIT);
}

/*!
 * @}
 */

/*!
 * @}
 */

#endif    // defined __SSG_EMB_DSM
