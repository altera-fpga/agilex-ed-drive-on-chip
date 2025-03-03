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

// Description:
// Clock Frequency comparator module
// ##########################################################################

`default_nettype none

module esl_clk_check_freq_comp #
    (
    parameter LO_COUNT_THR          = 25'd32,
    parameter HI_COUNT_THR          = 25'd16,
    parameter BIT_WD                = 24
    )
    (
   // CUT clock frequency comparator
    input  wire             cut_clk,            // Clock under test
    input  wire [BIT_WD:0]  cut_count_end_val,  // Value of cut_count at end of test phase
    output logic            comp_too_high,      // Output of high level comparator
    output logic            comp_too_low,       // Output of low level comparator
    output wire             param_error         // Flag output for param error
    );

wire [BIT_WD:0] lo_thr_wire;
wire [BIT_WD:0] hi_thr_wire;

assign      lo_thr_wire = LO_COUNT_THR[BIT_WD:0];
assign      hi_thr_wire = HI_COUNT_THR[BIT_WD:0];

// if HI and LO count parameters are incorrectly set, the core indicates
// this as a param_error
assign param_error = (LO_COUNT_THR > HI_COUNT_THR);


reg    comp_too_high_reg /* synthesis preserve noprune keep */;     // Prevents register being optimized
reg    comp_too_low_reg /* synthesis preserve noprune keep */;      // Prevents register being optimized

always @ (*) begin
    comp_too_high_reg = (cut_count_end_val > hi_thr_wire);
end

always @ (*) begin
    comp_too_low_reg = (cut_count_end_val < lo_thr_wire);
end

// added cut_clk as input wire, just for this always block....
always @ (posedge cut_clk) begin
    comp_too_high = comp_too_high_reg;
    comp_too_low  = comp_too_low_reg;
end

endmodule

`default_nettype wire