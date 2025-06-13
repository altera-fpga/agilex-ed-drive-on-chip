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
// Reference clock counter module
// ##########################################################################

`default_nettype none

module esl_clk_check_ref_clk_count #
  (
   parameter REF_CLK_TC            = 25'b0
   )
  (
   input wire        ref_clk,                   // reference clock input
   input wire        ref_rst_n,                 // reset for ref clock domain
   input wire        reset_ref_clk_count,       // reset from FSM to restart count
   input wire        en_ref_clk_count,          // counter can be enabled/disabled from FSM
   output wire       ref_clk_tc_reached         // flag to show that terminal count is reached
   );

   localparam REF_CLK_COUNT_BITS = 25;

   reg [REF_CLK_COUNT_BITS-1:0] ref_clk_count;
   reg                          ref_clk_tc_reached_reg;

   always @ (posedge ref_clk or negedge ref_rst_n)
     begin
        if (ref_rst_n == 1'b0) begin
           ref_clk_count <= {REF_CLK_COUNT_BITS{1'b0}};
           ref_clk_tc_reached_reg <= 1'b0;
           end
        else begin
           if (reset_ref_clk_count == 1'b1) begin
              ref_clk_count <= {REF_CLK_COUNT_BITS{1'b0}};
              ref_clk_tc_reached_reg <= 1'b0;
           end
           else begin

              ref_clk_tc_reached_reg <= 1'b0;

              // If Terminal count is reached, counter just stops
              // will only restart when reset by state machine or global reset
              if (ref_clk_count == REF_CLK_TC) begin
                 ref_clk_tc_reached_reg <= 1'b1;
              end

              // Counter only enabled when FSM sets the enable flag
              else if (en_ref_clk_count) begin
                 ref_clk_count <= ref_clk_count + {{(REF_CLK_COUNT_BITS-1){1'b0}}, 1'b1};
              end
           end // else: !if(reset_ref_clk_count == 1'b1)
        end
     end

   assign ref_clk_tc_reached = ref_clk_tc_reached_reg;

endmodule

`default_nettype wire
