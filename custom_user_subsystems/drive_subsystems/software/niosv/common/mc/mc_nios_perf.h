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

#ifndef MC_NIOS_PERF_H_
#define MC_NIOS_PERF_H_

/**
 * @file mc_nios_perf.h
 *
 * @brief Header file for Nios performance monitoring functions
 */

/*!
 * \addtogroup PERF
 *
 * @{
 */

int small2_perf_print_formatted_report(void *perf_base,
                                 unsigned int clock_freq_hertz,
                                 int num_sections, ...);

int small2_perf_get_latency(void *perf_base,  int section_num);

#endif /* MC_NIOS_PERF_H_ */

/*!
 * @}
 */
