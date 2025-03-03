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

//----------------------------------------------------------------------------//
//                              doc safety
// Top level of the Safe Drive-on-Chip safety function. "doc_safety_function"
// containing the speed estimator, payload generator for cross comparison, AXI
// interface, heartbeat generators and cross comparison function.
// Parameters and localparams are capitalized and prefixed with P_ and C_ (constant)
// respectively; _M and _S further denote master and slave interfaces respectively
//----------------------------------------------------------------------------//

`default_nettype none

import pkg_doc_safety::*;

//****************************************************************************//
module doc_safety
//****************************************************************************//
# (
  // Parameters prefixed with P_
  int P_S_AXI_ADDR_WIDTH    = 5,       // AXI Slave (_S) address width
  int P_S_AXI_DATA_WIDTH    = 32,      // AXI Slave (_S) Data width
  int P_M_APB_ADDR_WIDTH    = 4,       // APB Master (_M) address width
  int P_M_APB_DATA_WIDTH    = 32,      // APB Master (_M) address width
  int P_SPEED_CC_MARGIN_RPM = 130,
  int P_WATCHDOG_TIMEOUT    = 100_000, // number of clocks for the cross comparison timeout.
  int P_QEP_COUNT_WIDTH     = 13,
  int P_CLK_FREQ_HZ         = 100_000_000
) (
  input  wire                                clk,
  input  wire                                reset_n,
  input  wire                                reset_safety_n_i,
  output logic                               reset_safety_n_o,
  output logic                               reset_safety_mem_n_o,
  //From QEP
  input  wire [31:0]                         qep_count,
  input  wire                                qep_error,
  //From Timer
  input  wire                                timer_pulse,
  // ---- Outputs to ESL ----
  //Error Reg
  output logic                               quad_error_p,
  output logic                               quad_error_n,
  //Speed Estimator
  output logic                               fpga_is_safe_p,
  output logic                               fpga_is_safe_n,
  //Cross Comparison
  output logic                               fpga_compare_good_p,
  output logic                               fpga_compare_good_n,
  output logic                               compare_timeout,
  (* preserve *) output logic                motor_powerdown_p,
  (* preserve *) output logic                motor_powerdown_n,
  //Heartbeats
  output logic                               heartbeat_fusa,
  output logic                               heartbeat_timer,
  // ---- AXI4 Lite ----
  input  wire                                s_axi_aresetn,
  input  wire  [2 : 0]                       s_axi_awprot,
  input  wire  [2 : 0]                       s_axi_arprot,
  input  wire  [P_S_AXI_ADDR_WIDTH - 1 : 0]  s_axi_awaddr,
  input  wire                                s_axi_awvalid,
  output logic                               s_axi_awready,
  input  wire  [3 : 0]                       s_axi_wstrb,
  input  wire  [P_S_AXI_DATA_WIDTH - 1 : 0]  s_axi_wdata,
  input  wire                                s_axi_wvalid,
  output logic                               s_axi_wready,
  output logic [1 : 0]                       s_axi_bresp,
  output logic                               s_axi_bvalid,
  input  wire                                s_axi_bready,
  input  wire  [P_S_AXI_ADDR_WIDTH - 1 : 0]  s_axi_araddr,
  input  wire                                s_axi_arvalid,
  output logic                               s_axi_arready,
  output logic [P_S_AXI_DATA_WIDTH - 1 : 0]  s_axi_rdata,
  output logic [1 : 0]                       s_axi_rresp,
  output logic                               s_axi_rvalid,
  input  wire                                s_axi_rready,

  output logic [P_M_APB_ADDR_WIDTH - 1 : 0]  m_apb_paddr,
  output logic                               m_apb_pwrite,
  output logic                               m_apb_psel,
  output logic                               m_apb_penable,
  output logic [P_M_APB_DATA_WIDTH - 1 : 0]  m_apb_pwdata,
  input  wire  [P_M_APB_DATA_WIDTH - 1 : 0]  m_apb_prdata,
  input  wire                                m_apb_pready
);

timeunit 1ns;
timeprecision 1ps;

//****************************************************************************//
localparam t_speed C_SPEED_CC_MARGIN_RPM = C_T_SPEED_WIDTH'(P_SPEED_CC_MARGIN_RPM);

logic                         generate_fpga;
t_safety_payload              fpga_payload;
t_speed                       speed_cc_margin;

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// fault sources are brought together to power down the motor
//----------------------------------------------------------------------------//
always_ff @(posedge clk, negedge reset_safety_n_i) begin
  if (reset_safety_n_i == 1'b0) begin
    motor_powerdown_p <= 1'b0;
    motor_powerdown_n <= 1'b1;
  end else begin
    if (  (fpga_is_safe_p != 1'b1) || (fpga_is_safe_n != 1'b0) ||
          (fpga_compare_good_p !=1'b1) || (fpga_compare_good_n != 1'b0) ||
          (quad_error_p !=1'b1) || (quad_error_n != 1'b0) ) begin
      motor_powerdown_p <= 1'b0;
      motor_powerdown_n <= 1'b1;
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------------------//
// The main safety function - speed estimator, heartbeat generators, payload generator
//----------------------------------------------------------------------------//
doc_safety_function # (
  .S_AXI_ADDR_WIDTH      (P_S_AXI_ADDR_WIDTH),
  .S_AXI_DATA_WIDTH      (P_S_AXI_DATA_WIDTH),
  .P_QEP_COUNT_WIDTH     (P_QEP_COUNT_WIDTH),
  .P_SPEED_CC_MARGIN_RPM (C_SPEED_CC_MARGIN_RPM),
  .P_CLK_FREQ_HZ         (P_CLK_FREQ_HZ)
) doc_safety_function_inst (
    .clk              (clk),
    .reset_n          (reset_n),
    .reset_safety_n   (reset_safety_n_i),
    .generate_payload (generate_fpga),
    .timeout_pulse    (timer_pulse),
    .qep_count        (qep_count),
    .qep_error        (qep_error),
    .fpga_is_safe_p   (fpga_is_safe_p),
    .fpga_is_safe_n   (fpga_is_safe_n),
    .quad_error_p     (quad_error_p),
    .quad_error_n     (quad_error_n),
    .heartbeat_fusa   (heartbeat_fusa),
    .heartbeat_timer  (heartbeat_timer),
    .payload          (fpga_payload),
    .speed_cc_margin  (speed_cc_margin),

    .s_axi_aresetn    (s_axi_aresetn),
    .s_axi_awprot     (s_axi_awprot),
    .s_axi_arprot     (s_axi_arprot),
    .s_axi_awaddr     (s_axi_awaddr),
    .s_axi_awvalid    (s_axi_awvalid),
    .s_axi_awready    (s_axi_awready),
    .s_axi_wstrb      (s_axi_wstrb),
    .s_axi_wdata      (s_axi_wdata),
    .s_axi_wvalid     (s_axi_wvalid),
    .s_axi_wready     (s_axi_wready),
    .s_axi_bresp      (s_axi_bresp),
    .s_axi_bvalid     (s_axi_bvalid),
    .s_axi_bready     (s_axi_bready),
    .s_axi_araddr     (s_axi_araddr),
    .s_axi_arvalid    (s_axi_arvalid),
    .s_axi_arready    (s_axi_arready),
    .s_axi_rdata      (s_axi_rdata),
    .s_axi_rresp      (s_axi_rresp),
    .s_axi_rvalid     (s_axi_rvalid),
    .s_axi_rready     (s_axi_rready)
);

//----------------------------------------------------------------------------//
// Cross-comparison - contains the state machine to perform the cross comparison
// and a watchdog to trap the HPS cross comparison failing.
// PRESERVE_FOR_DEBUG_ENABLE preserves the signals for easy identification and
// capture in Signaltap
//----------------------------------------------------------------------------//
(* altera_attribute = "-name PRESERVE_FOR_DEBUG_ENABLE ON" *) doc_safety_cross_comparison # (
  .P_M_APB_ADDR_WIDTH    (P_M_APB_ADDR_WIDTH),
  .P_M_APB_DATA_WIDTH    (P_M_APB_DATA_WIDTH),
  .P_SPEED_CC_MARGIN_RPM (C_SPEED_CC_MARGIN_RPM),
  .P_WATCHDOG_TIMEOUT    (P_WATCHDOG_TIMEOUT)
) doc_safety_cc_inst (
  .clk              (clk),
  .reset_n          (reset_n),
  .reset_safety_n   (reset_safety_n_i),
  .generate_fpga    (generate_fpga),
  .fpga_payload     (fpga_payload),
  .start            (timer_pulse),
  .compare_good_p   (fpga_compare_good_p),
  .compare_good_n   (fpga_compare_good_n),
  .compare_timeout  (compare_timeout),
  .speed_cc_margin  (speed_cc_margin),

  .m_apb_paddr      (m_apb_paddr),
  .m_apb_pwrite     (m_apb_pwrite),
  .m_apb_psel       (m_apb_psel),
  .m_apb_penable    (m_apb_penable),
  .m_apb_pwdata     (m_apb_pwdata),
  .m_apb_prdata     (m_apb_prdata),
  .m_apb_pready     (m_apb_pready)
);

//----------------------------------------------------------------------------//
// duplicate outputs because Platform designer cannot associate one signal
// with more than one conduit.
assign reset_safety_n_o      = reset_safety_n_i;
assign reset_safety_mem_n_o  = reset_safety_n_i;

//****************************************************************************//
endmodule : doc_safety
//****************************************************************************//

`default_nettype wire