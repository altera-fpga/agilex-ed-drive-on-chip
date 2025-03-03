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
 * @file mc_nios_perf.c
 *
 * @brief Nios performance monitoring functions
 */

#include "mc_nios_perf.h"

#include <stdarg.h>

#include "io.h"

#include "mc/mc_debug.h"
#include "perf/altera_avalon_performance_counter.h"

/*!
 * \addtogroup PERF
 *
 * @{
 */

int small2_perf_print_formatted_report(void *perf_base,
                                 unsigned int clock_freq_hertz,
                                 int num_sections, ...)
{
    va_list name_args;
    unsigned long long int total_clocks;
    unsigned long long int section_clocks;
    char *section_name;
    int section_num = 1;

    const char *separator =
      "+---------------+-----+------------+---------------+------------+------------+\n";

    const char *column_header =
      "| Section       |  %  | Time (usec)|  Time (clocks)|Occurrences | Clocks/Occ |\n";

    PERF_STOP_MEASURING(perf_base);

    va_start(name_args, num_sections);

    total_clocks = perf_get_total_time(perf_base);

    // Print the total at the top:
    debug_printf(DBG_PERF, "--Performance Counter Report--\n");
    debug_printf(DBG_PERF, "%s", separator);
    debug_printf(DBG_PERF, "%s", column_header);
    debug_printf(DBG_PERF, "%s", separator);

    section_name = va_arg(name_args, char*);

    for (section_num = 1; section_num <= num_sections; section_num++) {
        section_clocks = perf_get_section_time(perf_base, section_num);
        /* section name, small C library does not support left-justify,
         * uses right-justify instead.
         */
        debug_printf(DBG_PERF, "|%15s", section_name);

        /* section usage */
        if (total_clocks) {
            debug_printf(DBG_PERF, "|%4u ", (unsigned int)(section_clocks * 100 / total_clocks));
        } else {
            debug_printf(DBG_PERF, "|%4u ", 0);
        }

        /* section usecs */
        debug_printf(DBG_PERF, "|%11llu ", (unsigned long long int)(section_clocks * 1000000 / clock_freq_hertz));

        /* section clocks */
        debug_printf(DBG_PERF, "|%14u ", (unsigned int)section_clocks);

        unsigned int occurences = perf_get_num_starts(perf_base, section_num);
        /* section occurrences */
        debug_printf(DBG_PERF, "|%10u  ",
        occurences);

        debug_printf(DBG_PERF, "|%10u  |\n",
                (unsigned int)section_clocks / occurences);

        if (section_num == num_sections) {
            debug_printf(DBG_PERF, "%s", separator);
        }

        section_name = va_arg(name_args, char*);
    }

    va_end(name_args);

    return 0;
}

/**
 * Returns the number of clocks per iteration of the specified section
 */
int small2_perf_get_latency(void *perf_base,  int section_num)
{
    unsigned long long int section_clocks;

    PERF_STOP_MEASURING(perf_base);

    section_clocks = perf_get_section_time(perf_base, section_num);

    unsigned int occurences = perf_get_num_starts(perf_base, section_num);

    if ((section_clocks == 0) || (occurences == 0)) {
        return 0;
    }

    return (int)(section_clocks / occurences);
}

/*!
 * @}
 */
