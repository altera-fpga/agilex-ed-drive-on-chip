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


#ifndef FOC_H_
#define FOC_H_

#include "mc/mc_params.h"

/**
 * @file foc.h
 *
 * @brief Header file for FOC
 */

/*!
 * \addtogroup FOC
 *
 * @{
 */

void software_foc(drive_params * dp, system_params * sp) IRQ_SECTION;
void dspba_foc(drive_params *dp, system_params *sp) IRQ_SECTION;

/*!
 * @}
 */

#endif /* FOC_H_ */
