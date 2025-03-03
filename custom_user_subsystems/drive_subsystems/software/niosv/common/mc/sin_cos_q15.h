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

#ifndef SIN_COS_Q15_H_
#define SIN_COS_Q15_H_

#include "platform/platform_linker.h"

/**
 * @file sin_cos_q15.h
 *
 * @brief Header file for fixed point trig functions
 */

/*!
 * \addtogroup MC
 *
 * @{
 */

/*!
 * \addtogroup DSPFIXED
 *
 * @{
 */

// Don't want to force double opertaions by using M_PI from mat.h
#define PI_D                        3.1415926
#define FAST_MATH_TABLE_SIZE        512
#define TABLE_SPACING_Q15           0x80    // 1/TABLE_LENGTH
#define FAST_MATH_Q15_SHIFT        (16 - 10)
#define FAST_MATH_TABLE_SIZE        512
extern short sinTable_q15[FAST_MATH_TABLE_SIZE+1];


void init_sin_tables(void);
short cos_q15(short x) MATH_SECTION;
short sin_q15(short x) MATH_SECTION;

#endif /* SIN_COS_Q15_H_ */

/*!
 * @}
 */

/*!
 * @}
 */
