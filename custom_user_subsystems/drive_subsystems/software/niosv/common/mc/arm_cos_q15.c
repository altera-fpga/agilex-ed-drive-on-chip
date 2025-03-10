/* ----------------------------------------------------------------------
 * Project:      CMSIS DSP Library
 * Title:        arm_cos_q15.c
 * Description:  Fast cosine calculation for Q15 values
 *
 * $Date:        18. March 2019
 * $Revision:    V1.6.0
 *
 * Target Processor: Cortex-M cores
 * -------------------------------------------------------------------- */
/*
 * Copyright (C) 2010-2019 ARM Limited or its affiliates. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * @file arm_cos_q15.c
 *
 * @brief Fixed point trig functions
 */

#include "sin_cos_q15.h"

#include "math.h"

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



/**
 * Fast approximation to the trigonometric cosine function for Q15 data.
 * The Q15 input value is in the range [0 +1) and is mapped to a radian value in the range [0 2*pi).
 *
 * @param   x	Scaled input value in radians.
 * @return	cos(x) output value in 1.15(q15) format
 * The Q15 input value is in the range [0 +0.9999] and is mapped to a radian value in the range [0 2*PI).
 */
//data type has been changed from the original one.
short cos_q15(short x)
{
  short cosVal;                                  /* Temporary input, output variables */
  int   index;                                   /* Index variable */
  short a, b;                                    /* Two nearest output values */
  short fract;                                   /* Temporary values for fractional values */

  /* add 0.25 (pi/2) to read sine table */
  x = (short)x + 0x2000;
  if (x < 0)
  { /* convert negative numbers to corresponding positive ones */
    x = (short)x + 0x8000;
  }

  /* Calculate the nearest index */
  index = (int)x >> FAST_MATH_Q15_SHIFT;

  /* Calculation of fractional value */
  fract = (x - (index << FAST_MATH_Q15_SHIFT)) << 9;

  /* Read two nearest values of input value from the sin table */
  a = sinTable_q15[index];
  b = sinTable_q15[index+1];

  /* Linear interpolation process */
  cosVal = (int) (0x8000 - fract) * a >> 16;
  cosVal = (short) ((((int) cosVal << 16) + ((int) fract * b)) >> 16);

  /* Return output value */
  return (cosVal << 1);
}

/*!
 * @}
 */

/*!
 * @}
 */
