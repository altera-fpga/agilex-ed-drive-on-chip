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

// Description:
// Error flag generator module
// ##########################################################################

// Flag generation block
// Flag generation based on comparator output (too high state)
// Flag generation based on comparator output (too low state)
// reference clock active flag

`default_nettype none

module esl_clk_check_flag_gen
  (
   input     wire            ref_clk,           // Fixed reference clock input
   input     wire            ref_rst_n,         // Reset for ref_clk domain
   input     wire            comp_too_high,     // Comparator input from esl_clk_check_freq_comp.v
   input     wire            comp_too_low,      // Comparator input from esl_clk_check_freq_comp.v
   input     wire            en_flag_gen,       // Enable signal from FSM block
   input     wire            cut_clock_stopped, // Input from FSM to indicate the cut_clk stopped

   output    wire            error,             // Flag for error signal
   output    wire            error_n,           // Complementary error flag (inverse of error port)
   output    wire            freq_too_high,     // Indication that cut_clk is too high/low
   output    wire            flag_int_error     // Flag for internal error (both high & low active)
   );

   // Output registers
   reg       flag_int_error_reg ;
   reg       error_reg /* synthesis preserve */;          // Prevents error and error_n registers being merged
   reg       error_n_reg /* synthesis preserve */;        // Prevents error and error_n registers being merged
   reg       freq_too_high_reg;

   // Intermediate register definitions placed to ensure that the signals are not optimized going
   // into the flag_int_error logic.  Note, that the construct where they are used
   // has a combinatorial structure meaning the register declarations synthesize into wires.
   reg       comp_too_high_reg /* synthesis preserve noprune keep */;
   reg       comp_too_low_reg /* synthesis preserve noprune keep */;

   always @ (*)
     begin
        comp_too_high_reg = comp_too_high;
        comp_too_low_reg = comp_too_low;
     end

   always @ (posedge ref_clk or negedge ref_rst_n)
     begin
        if (ref_rst_n == 1'b0) begin
           error_reg            <= 1'b0;
           error_n_reg          <= 1'b1;
           freq_too_high_reg    <= 1'b0;
           flag_int_error_reg   <= 1'b0;
        end
        else begin

           if (en_flag_gen) begin
              error_reg         <= (comp_too_high | comp_too_low) | cut_clock_stopped;
              error_n_reg       <= !((comp_too_high | comp_too_low )
                                     | cut_clock_stopped);
              freq_too_high_reg <= (comp_too_high & !cut_clock_stopped);
              // CUT cannot be both too high and too low, show internal error
              flag_int_error_reg <= comp_too_high_reg & comp_too_low_reg;
           end
        end // else: !if(ref_rst_n == 1'b0)
     end // always @ (posedge ref_clk or negedge ref_rst_n)

   // Set top level ports to internal register levels
   assign error          = error_reg;
   assign error_n        = error_n_reg;
   assign freq_too_high  = freq_too_high_reg;
   assign flag_int_error = flag_int_error_reg;

endmodule

`default_nettype wire
