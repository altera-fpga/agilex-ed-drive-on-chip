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
// Top level of the esl clock checker block
// ##########################################################################

`default_nettype none

module esl_clk_check #
    (
    parameter LO_COUNT_THR          = 500000,
    parameter HI_COUNT_THR          = 500050,
    parameter REF_CLK_TC            = 20000000    // this is 20Mhz
    )
    (
    // System clock interface
    input  wire                   ref_clk,        // Fixed reference clock input
    input  wire                   ref_rst_n,      // Reset for ref_clk domain
    // Clock under test interface
    input  wire                   cut_clk,        // Clock under test input
    input  wire                   cut_rst_n,      // Reset for cut_clk domain
    // FLAG Interface
    output wire                   error,          // error flag, indicates error on cut_clk
    output wire                   error_n,        // Inverse of error, i.e. differential signal
    output wire                   freq_too_high,  // Flag to indicate if cut_clk too high/low
    output wire                   check_running,  // Flag to show that check is in progress
    output wire                   check_done,     // Flag to show that a check phase has finished
    output wire                   int_error       // Flag to indicate a core internal error
    );

localparam BIT_WD            = 28;
localparam CORE_STATUS_BITS  = 24;

// Avalon Slave interface instance
// The avalon slave interface below is a stripped down version of the altera standard
// Avalon slave template

wire [CORE_STATUS_BITS-1:0]  core_status;
wire [BIT_WD:0]              ref_clk_tc_reg;
wire [BIT_WD:0]              cut_count_end_val;
wire [2:0]                   control_fsm_state;
wire [BIT_WD:0]              cut_count_store;
wire                         cut_clock_stopped;
wire                         flag_int_error;
wire                         param_error;
wire                         en_flag_gen;
wire                         en_ref_clk_count;
wire                         en_cut_count;

// Wire status bits into core_status bus
assign    core_status [23:8] = 16'b0;
assign    core_status [7]    = param_error;
assign    core_status [6]    = flag_int_error;
assign    core_status [5:4]  = {error_n, error};
assign    core_status [3]    = freq_too_high;
assign    core_status [2:0]  = control_fsm_state;

assign    ref_clk_tc_reg     = REF_CLK_TC[BIT_WD:0];
assign    check_running      = en_cut_count;
assign    check_done         = en_flag_gen;


// Clock under test counter
// Internal connections to clock under test counter
wire         reset_cut_count;
wire         cut_count_available;
wire         reset_ack;

esl_clk_check_cut_count # (.BIT_WD(BIT_WD)) u_esl_clk_check_cut_count
    (
    .cut_clk                  (cut_clk),
    .cut_rst_n                (cut_rst_n),
    .ref_clk                  (ref_clk),
    .ref_rst_n                (ref_rst_n),
    .reset_cut_count          (reset_cut_count),
    .en_cut_count             (en_cut_count),
    .en_flag_gen              (en_flag_gen),

    .reset_ack                (reset_ack),
    .cut_count_available      (cut_count_available),
    .cut_count_end_val        (cut_count_end_val),
    .cut_count_store          (cut_count_store)
    );

 // Ref clk counter
wire         reset_ref_clk_count;
wire         ref_clk_tc_reached;

esl_clk_check_ref_clk_count #
    (
    .REF_CLK_TC (REF_CLK_TC)
    ) u_esl_clk_check_ref_clk_count (
    .ref_clk                  (ref_clk),
    .ref_rst_n                (ref_rst_n),
    .reset_ref_clk_count      (reset_ref_clk_count),
    .en_ref_clk_count         (en_ref_clk_count),
    .ref_clk_tc_reached       (ref_clk_tc_reached)
    );

// CUT clock frequency comparator
logic         comp_too_high;
logic         comp_too_low;
logic         comp_too_high_meta;
logic         comp_too_low_meta;
logic         comp_too_high_safe;
logic         comp_too_low_safe;

esl_clk_check_freq_comp #
    (
    .LO_COUNT_THR (LO_COUNT_THR),
    .HI_COUNT_THR (HI_COUNT_THR),
    .BIT_WD (BIT_WD)
    )

u_esl_clk_check_freq_comp
    (
    .cut_clk                  (cut_clk),
    .cut_count_end_val        (cut_count_end_val),
    .comp_too_high            (comp_too_high),
    .comp_too_low             (comp_too_low),
    .param_error              (param_error)
    );


always_ff @(posedge ref_clk) begin
    comp_too_high_meta <= comp_too_high;
    comp_too_low_meta  <= comp_too_low;

    comp_too_high_safe <= comp_too_high_meta;
    comp_too_low_safe  <= comp_too_low_meta;
end

// Flag generation block
esl_clk_check_flag_gen u_esl_clk_check_flag_gen
    (
    .ref_clk                  (ref_clk),
    .ref_rst_n                (ref_rst_n),
    .comp_too_high            (comp_too_high_safe),
    .comp_too_low             (comp_too_low_safe),
    .en_flag_gen              (en_flag_gen),
    .cut_clock_stopped        (cut_clock_stopped),
    .error                    (error),
    .error_n                  (error_n),
    .freq_too_high            (freq_too_high),
    .flag_int_error           (flag_int_error)
    );

assign int_error = flag_int_error;

// Control state machine
esl_clk_check_fsm u_esl_clk_check_fsm
    (
    .ref_clk                  (ref_clk),
    .ref_rst_n                (ref_rst_n),
    // FSM inputs
    .ref_clk_tc_reached       (ref_clk_tc_reached),
    .cut_count_available      (cut_count_available),
    .flag_int_error           (flag_int_error),
    .reset_ack                (reset_ack),
    // FSM outputs
    .reset_ref_clk_count      (reset_ref_clk_count),
    .reset_cut_count          (reset_cut_count),
    .en_cut_count             (en_cut_count),
    .en_ref_clk_count         (en_ref_clk_count),
    .en_flag_gen              (en_flag_gen),
    .control_fsm_state        (control_fsm_state),
    .cut_clock_stopped        (cut_clock_stopped)
    );

endmodule

`default_nettype wire