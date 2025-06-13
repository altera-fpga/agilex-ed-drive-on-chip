/* ##################################################################################
 * Copyright (C) 2025 Altera Corporation
 *
 * This software and the related documents are Altera copyrighted materials, and
 * your use of them is governed by the express license under which they were
 * provided to you ("License"). Unless the License provides otherwise, you may
 * not use, modify, copy, publish, distribute, disclose or transmit this software
 * or the related documents without Altera's prior written permission.
 *
 * This software and the related documents are provided as is, with no express
 * or implied warranties, other than those that are expressly stated in the License.
 * ##################################################################################
 */

/**
 * @file perf_print_formatted_report.c
 *
 * @brief Support file for performance reporting
 */

/*!
 * \addtogroup PERF
 *
 * @{
 */

/****************************************************************

   Print a formatted report summarizing performance-counter activity.

   The report is printed to STDOUT.  At-present, there is no way
   to choose another stream or print to a string.

   You should do this after you call PERF_STOP_MEASURING--but you'll
   be glad to know this routine calls PERF_STOP_MEASURING inside,
   defensively

****************************************************************/


/*
 * The printf function we are using does not support
 * floating point format. This function print the time in usec instead of
 * second.
 */
 /*
int perf_print_formatted_report (void* perf_base,
                                 alt_u32 clock_freq_hertz,
                                 int num_sections, ...)
{
    va_list name_args;
    alt_u64 total_usec;
    alt_u64 total_clocks;
    alt_u64 section_clocks;
    char* section_name;
    int section_num = 1;

    const char* separator =
      "+---------------+-----+------------+---------------+------------+\n";

    const char* column_header =
      "| Section       |  %  | Time (usec)|  Time (clocks)|Occurrences |\n";

    PERF_STOP_MEASURING (perf_base);

    va_start (name_args, num_sections);

    total_clocks = perf_get_total_time (perf_base);
    total_usec = total_clocks * 1000000 / clock_freq_hertz;

    // Print the total at the top:
    debug_printf(DEBUG_PERF, "--Performance Counter Report--\n");
    debug_printf(DEBUG_PERF, "Total Time : %llu usec ", total_usec);
    debug_printf(DEBUG_PERF, "(%llu clock-cycles)\n", total_clocks);
    debug_printf(DEBUG_PERF, "%s", separator);
    debug_printf(DEBUG_PERF, "%s", column_header);
    debug_printf(DEBUG_PERF, "%s", separator);

    section_name = va_arg(name_args, char*);

    for (section_num = 1; section_num <= num_sections; section_num++)
    {
        section_clocks = perf_get_section_time (perf_base, section_num);
        // section name, small C library does not support left-justify,
        // uses right-justify instead.
        //
        debug_printf (DEBUG_PERF, "|%15s", section_name);

        // section usage
        if (total_clocks)
        {
            debug_printf (DEBUG_PERF, "|%4u ", (unsigned int)(section_clocks * 100 / total_clocks));
        }
        else
        {
            debug_printf (DEBUG_PERF, "|%4u ", 0);
        }

        // section usecs
        debug_printf (DEBUG_PERF, "|%11llu ", (alt_u64)(section_clocks * 1000000 / clock_freq_hertz));

        // section clocks
        debug_printf (DEBUG_PERF, "|%14u ", (unsigned int)section_clocks);

        // section occurrences
        debug_printf (DEBUG_PERF, "|%10u  |\n",
        (unsigned int) perf_get_num_starts (perf_base, section_num));

        debug_printf (DEBUG_PERF, "%s", separator);

        section_name = va_arg(name_args, char*);
    }

    va_end (name_args);

    return 0;
}
*/

/*!
 * @}
 */
