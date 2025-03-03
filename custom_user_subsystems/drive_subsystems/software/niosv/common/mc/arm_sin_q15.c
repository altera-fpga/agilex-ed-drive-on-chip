/* ----------------------------------------------------------------------
 * Project:      CMSIS DSP Library
 * Title:        arm_sin_q15.c
 * Description:  Fast sine calculation for Q15 values
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
 * @file arm_sin_q15.c
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

short sinTable_q15[FAST_MATH_TABLE_SIZE+1];

/**
 * create sine table.
 */
void init_sin_tables(void) {
	double value;
	int n;
	int table_size = FAST_MATH_TABLE_SIZE ;
	for(n = 0; n < (table_size + 1); n++) {
		value = sin(2*PI_D*n/table_size);
		value = value * pow(2, 15);
		value += value > 0 ? 0.5 : -0.5;
		value = value >=32767 ? 32767 : value;
		sinTable_q15[n] = value;
	}
}

/**
 * Fast approximation to the trigonometric sine function for Q15 data.
 * @param[in]     x  Scaled input value in radians
 * @return	      sin(x)output value in 1.15(q15) format
 * The Q15 input value is in the range [0 +0.9999) and is mapped to a radian value in the range [0 2*PI).
 *
 *

 */
//data type has been changed from the original one.
short sin_q15(short x)
{
  short sinVal;                                  /* Temporary input, output variables */
  int index;                                     /* Index variable */
  short a, b;                                    /* Two nearest output values */
  short fract;                                   /* Temporary values for fractional values */

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
  sinVal = (int) (0x8000 - fract) * a >> 16;
  sinVal = (short) ((((int) sinVal << 16) + ((int) fract * b)) >> 16);

  /* Return output value */
  return (sinVal << 1);
}


/*!
 * @}
 */

/*!
 * @}
 */
