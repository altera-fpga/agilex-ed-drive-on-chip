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

/**
 * @file altera_avalon_performance_counter.c
 *
 * @brief Performance counter peripheral interface
 */

#include "altera_avalon_performance_counter.h"
#include "io.h"

/*!
 * \addtogroup PERF
 *
 * @{
 */

unsigned long long int perf_get_section_time(void *hw_base_address, unsigned int which_section)
{
  unsigned int lo;
  unsigned int hi;
  unsigned long long int result = 0;

  PERF_STOP_MEASURING(hw_base_address);
  lo = IORD_32DIRECT(hw_base_address, (which_section*4*4));
  hi = IORD_32DIRECT(hw_base_address, ((which_section*4*4)+1*4));

  result = ((unsigned long long int)(((unsigned long long int) hi) << ((unsigned long long int)32))) |
           ((unsigned long long int)(((unsigned long long int) lo)));
  return result;
}

unsigned long long int perf_get_total_time(void *hw_base_address)
{
  return perf_get_section_time(hw_base_address, 0);
}

unsigned int perf_get_num_starts(void *hw_base_address, unsigned int which_section)
{
  return IORD_32DIRECT(hw_base_address, ((which_section*4*4)+2*4));
}

/*!
 * @}
 */
