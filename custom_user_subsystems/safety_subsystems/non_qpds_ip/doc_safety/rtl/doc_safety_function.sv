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

//----------------------------------------------------------------------------//
//                         doc_safety_function
// This module contains the speed estimator, payload generator for cross comparison,
// AXI interface and heartbeat generators.
// Parameters and localparams are capitalized and prefixed with P_ and C_ (constant)
// respectively; _M and _S further denote master and slave interfaces respectively
//----------------------------------------------------------------------------//

`default_nettype none

import pkg_doc_safety::*;

//****************************************************************************//
module doc_safety_function
//****************************************************************************//
# (
    int     S_AXI_ADDR_WIDTH      = 5,  // AXI Slave (_S) address width
    int     S_AXI_DATA_WIDTH      = 32, // AXI Slave (_S) Data width
    int     P_QEP_COUNT_WIDTH     = 13,
    t_speed P_SPEED_CC_MARGIN_RPM = 130,
    int     P_CLK_FREQ_HZ         = 100_000_000
) (
    input wire clk,
    input wire reset_n,
    input wire reset_safety_n,
    input wire generate_payload,
    input wire timeout_pulse,

    input wire [31 : 0] qep_count,
    input wire          qep_error,

    //Error Reg
    output logic quad_error_p,
    output logic quad_error_n,

    //Speed Estimator
    output logic fpga_is_safe_p,
    output logic fpga_is_safe_n,
    output logic over_speed,
    output logic over_speed_led,
    output logic heartbeat_fusa,
    output logic heartbeat_timer,
    output t_safety_payload payload,
    output t_speed          speed_cc_margin,

    // AXI4 Lite
    input  wire                               s_axi_aresetn,
    input  wire  [2 : 0]                      s_axi_awprot,
    input  wire  [2 : 0]                      s_axi_arprot,
    input  wire  [S_AXI_ADDR_WIDTH - 1 : 0]   s_axi_awaddr,
    input  wire                               s_axi_awvalid,
    output logic                              s_axi_awready,
    input  wire  [3 : 0]                      s_axi_wstrb,
    input  wire  [S_AXI_DATA_WIDTH - 1 : 0]   s_axi_wdata,
    input  wire                               s_axi_wvalid,
    output logic                              s_axi_wready,
    output logic [1 : 0]                      s_axi_bresp,
    output logic                              s_axi_bvalid,
    input  wire                               s_axi_bready,
    input  wire  [S_AXI_ADDR_WIDTH - 1 : 0]   s_axi_araddr,
    input  wire                               s_axi_arvalid,
    output logic                              s_axi_arready,
    output logic [S_AXI_DATA_WIDTH - 1 : 0]   s_axi_rdata,
    output logic [1 : 0]                      s_axi_rresp,
    output logic                              s_axi_rvalid,
    input  wire                               s_axi_rready
);

//****************************************************************************//
//AXILtoADP

logic [S_AXI_ADDR_WIDTH - 1 : 0] paddr;
logic                            pwrite;
logic                            psel;
logic                            penable;
logic [S_AXI_DATA_WIDTH - 1 : 0] pwdata;
logic [S_AXI_DATA_WIDTH - 1 : 0] prdata;
logic                            pready;
t_speed motor_speed_est;

//----------------------------------------------------------------------------//
// Convert the AXI Lite interface into a simpler APB interface to read and write registers
//----------------------------------------------------------------------------//

intel_fpga_axil2apb
# (
    .P_S_AXI_ADDR_WIDTH  (S_AXI_ADDR_WIDTH),
    .P_S_AXI_DATA_WIDTH  (S_AXI_DATA_WIDTH),
    .P_WATCHDOG_EN       (1)
) axil2apb_s0 (
    .s_axi_aclk      (clk),
    .s_axi_aresetn   (s_axi_aresetn),
    .s_axi_awprot    (s_axi_awprot),
    .s_axi_arprot    (s_axi_arprot),
    .s_axi_awaddr    (s_axi_awaddr),
    .s_axi_awvalid   (s_axi_awvalid),
    .s_axi_awready   (s_axi_awready),
    .s_axi_wstrb     (s_axi_wstrb),
    .s_axi_wdata     (s_axi_wdata),
    .s_axi_wvalid    (s_axi_wvalid),
    .s_axi_wready    (s_axi_wready),
    .s_axi_bresp     (s_axi_bresp),
    .s_axi_bvalid    (s_axi_bvalid),
    .s_axi_bready    (s_axi_bready),
    .s_axi_araddr    (s_axi_araddr),
    .s_axi_arvalid   (s_axi_arvalid),
    .s_axi_arready   (s_axi_arready),
    .s_axi_rdata     (s_axi_rdata),
    .s_axi_rresp     (s_axi_rresp),
    .s_axi_rvalid    (s_axi_rvalid),
    .s_axi_rready    (s_axi_rready),

    .m_apb_paddr     (paddr),
    .m_apb_pwrite    (pwrite),
    .m_apb_psel      (psel),
    .m_apb_penable   (penable),
    .m_apb_pwdata    (pwdata),
    .m_apb_prdata    (prdata),
    .m_apb_pready    (pready)
);

//----------------------------------------------------------------------------//
// heartbeat generator for the cross comparison FSM
//----------------------------------------------------------------------------//

doc_safety_heartbeat fusa_heartbeat_inst (
    .clk          (clk),
    .generateBit  (generate_payload),
    .heartbeat    (heartbeat_fusa)
);

//----------------------------------------------------------------------------//
// heartbeat generator for the raw timer output
//----------------------------------------------------------------------------//

doc_safety_heartbeat timer_heartbeat_inst(
    .clk          (clk),
    .generateBit  (timeout_pulse),
    .heartbeat    (heartbeat_timer)
);

//----------------------------------------------------------------------------//
// speed estimator
//----------------------------------------------------------------------------//

doc_safety_speed_est # (
  .S_APB_ADDR_WIDTH       (S_AXI_ADDR_WIDTH),
  .S_APB_DATA_WIDTH       (S_AXI_DATA_WIDTH),
  .P_QEP_COUNT_WIDTH      (P_QEP_COUNT_WIDTH),
  .P_SPEED_CC_MARGIN_RPM  (P_SPEED_CC_MARGIN_RPM),
  .P_CLK_FREQ_HZ          (P_CLK_FREQ_HZ)
) speed_est(
  .clk                  (clk),
  .reset_n              (reset_n),
  .qep_count            (qep_count),
  .qep_error            (qep_error),
  .fpga_is_safe_p       (fpga_is_safe_p),
  .fpga_is_safe_n       (fpga_is_safe_n),
  .quad_error_p         (quad_error_p),
  .quad_error_n         (quad_error_n),
  .over_speed           (over_speed),
  .led_signal           (over_speed_led),
  .motor_speed_filtered (motor_speed_est),
  .speed_cc_margin      (speed_cc_margin),

  .s_apb_paddr          (paddr),
  .s_apb_pwrite         (pwrite),
  .s_apb_psel           (psel),
  .s_apb_penable        (penable),
  .s_apb_pwdata         (pwdata),
  .s_apb_prdata         (prdata),
  .s_apb_pready         (pready)
);

//----------------------------------------------------------------------------//
// payload generator - combine the speed, overspeed flag and add a sequence count
//----------------------------------------------------------------------------//

doc_safety_payload_generator payload_gen(
    .clk            (clk),
    .reset_n        (reset_n),
    .reset_safety_n (reset_safety_n),
    .speed_rpm      (motor_speed_est),
    .over_speed     (over_speed),
    .generate_pulse (generate_payload),
    .fpga_payload   (payload)
);

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
