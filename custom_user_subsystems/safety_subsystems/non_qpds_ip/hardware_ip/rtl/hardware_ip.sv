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

`default_nettype none

//****************************************************************************//
module hardware_ip
//****************************************************************************//
# (
  parameter string  P_SPEED_GRADE       = "6",
  parameter string  P_FAMILY            = "Agilex 5",
  parameter string  P_AG5_SERIES        = "E",
  parameter string  P_AG5_DENSITY       = "065",
  parameter int     P_NO_CH_VOLT        = 9,
  parameter int     P_NO_CH_TEMP        = 5,
  parameter int     P_INDEX_CONVERT_0   = 0,
  parameter int     P_INDEX_CONVERT_1   = 1,
  parameter int     P_INDEX_CONVERT_2   = 2,
  parameter int     P_INDEX_CONVERT_3   = 3,
  parameter int     P_INDEX_CONVERT_4   = 4,
  parameter int     P_INDEX_CONVERT_5   = 13,
  parameter int     P_INDEX_CONVERT_6   = 13,
  parameter int     P_INDEX_CONVERT_7   = 13,
  parameter int     P_INDEX_CONVERT_8   = 13,
  parameter int     P_INDEX_CONVERT_9   = 13,
  parameter int     P_INDEX_CONVERT_10  = 13,
  parameter int     P_INDEX_CONVERT_11  = 13,
  parameter int     P_INDEX_CONVERT_12  = 13,
  parameter int     P_REQ_TEMPSENS_0    = 0,
  parameter int     P_REQ_TEMPSENS_1    = 1,
  parameter int     P_REQ_TEMPSENS_2    = 2,
  parameter int     P_REQ_TEMPSENS_3    = 3,
  parameter int     P_REQ_TEMPSENS_4    = 4,
  parameter int     P_REQ_TEMPSENS_5    = 13,
  parameter int     P_REQ_TEMPSENS_6    = 13,
  parameter int     P_REQ_TEMPSENS_7    = 13,
  parameter int     P_REQ_TEMPSENS_8    = 13,
  parameter int     P_REQ_TEMPSENS_9    = 13,
  parameter int     P_REQ_TEMPSENS_10   = 13,
  parameter int     P_REQ_TEMPSENS_11   = 13,
  parameter int     P_REQ_TEMPSENS_12   = 13,
  parameter int     P_S_AXI_ADDR_WIDTH  = 8,
  parameter int     P_S_AXI_DATA_WIDTH  = 32
) (
  input  wire clk,
  input  wire reset,

  //Voltage Validation
  (* preserve *) output logic pwr_good_p,
  (* preserve *) output logic pwr_good_n,

  //Temp Validation
  (* preserve *) output logic temp_good_p,
  (* preserve *) output logic temp_good_n,

  // Explore CRAM + Mailbox Functionality...
  (* preserve *) output logic cram_good_p,
  (* preserve *) output logic cram_good_n,

  //Dupes
  (* preserve *) output logic dup_pwr_good_p,
  (* preserve *) output logic dup_pwr_good_n,
  (* preserve *) output logic dup_temp_good_p,
  (* preserve *) output logic dup_temp_good_n,
  (* preserve *) output logic dup_cram_good_p,
  (* preserve *) output logic dup_cram_good_n,


  //---AXI4 Lite---
  input  wire                                     s_axi_aclk,
  input  wire                                     s_axi_aresetn,
  input  wire  [2 : 0]                            s_axi_awprot,
  input  wire  [2 : 0]                            s_axi_arprot,
  input  wire  [P_S_AXI_ADDR_WIDTH - 1 : 0]       s_axi_awaddr,
  input  wire                                     s_axi_awvalid,
  output logic                                    s_axi_awready,
  input  wire  [3 : 0]                            s_axi_wstrb,
  input  wire  [P_S_AXI_DATA_WIDTH - 1 : 0]       s_axi_wdata,
  input  wire                                     s_axi_wvalid,
  output logic                                    s_axi_wready,
  output logic [1 : 0]                            s_axi_bresp,
  output logic                                    s_axi_bvalid,
  input  wire                                     s_axi_bready,
  input  wire  [P_S_AXI_ADDR_WIDTH - 1 : 0]       s_axi_araddr,
  input  wire                                     s_axi_arvalid,
  output logic                                    s_axi_arready,
  output logic [P_S_AXI_DATA_WIDTH - 1 : 0]       s_axi_rdata,
  output logic [1 : 0]                            s_axi_rresp,
  output logic                                    s_axi_rvalid,
  input  wire                                     s_axi_rready
);

timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//

// +--------------------------------------------------
// | Local Param Setup
// +--------------------------------------------------

localparam int P_INDEX_CONVERT_INTERNAL [12:0] = {
    P_INDEX_CONVERT_12,
    P_INDEX_CONVERT_11,
    P_INDEX_CONVERT_10,
    P_INDEX_CONVERT_9,
    P_INDEX_CONVERT_8,
    P_INDEX_CONVERT_7,
    P_INDEX_CONVERT_6,
    P_INDEX_CONVERT_5,
    P_INDEX_CONVERT_4,
    P_INDEX_CONVERT_3,
    P_INDEX_CONVERT_2,
    P_INDEX_CONVERT_1,
    P_INDEX_CONVERT_0
};

localparam int P_REQ_TEMPSENS_INTERNAL [12:0] = {
    P_REQ_TEMPSENS_12,
    P_REQ_TEMPSENS_11,
    P_REQ_TEMPSENS_10,
    P_REQ_TEMPSENS_9,
    P_REQ_TEMPSENS_8,
    P_REQ_TEMPSENS_7,
    P_REQ_TEMPSENS_6,
    P_REQ_TEMPSENS_5,
    P_REQ_TEMPSENS_4,
    P_REQ_TEMPSENS_3,
    P_REQ_TEMPSENS_2,
    P_REQ_TEMPSENS_1,
    P_REQ_TEMPSENS_0
};

// +--------------------------------------------------
// | Initial Signals
// +--------------------------------------------------

//Grabbed/Output Variables
logic                                 voltage_good;
logic                                 temperature_good;

logic [P_NO_CH_VOLT - 1 : 0][31:0]    voltage_info;
logic [P_NO_CH_TEMP - 1 : 0][31:0]    temperature_info;

//AXI4Lite/APB Variables
logic [P_S_AXI_DATA_WIDTH - 1 : 0] s_wdata;
logic [P_S_AXI_DATA_WIDTH - 1 : 0] s_rdata;
logic [P_S_AXI_ADDR_WIDTH - 1 : 0] s_addr;
logic                              s_we;
logic                              s_pwrite;
logic                              s_psel;
logic                              s_penable;
logic                              s_pready;
logic                              s_clk_en;

// +--------------------------------------------------
// | Output Control
// +--------------------------------------------------
always_ff @(posedge clk) begin

    pwr_good_p <= voltage_good;
    pwr_good_n <= ~voltage_good;

    temp_good_p <= temperature_good;
    temp_good_n <= ~temperature_good;

    // Explore CRAM + Mailbox Functionality...
    cram_good_p <= 1'b1;
    cram_good_n <= 1'b0;
end //always_ff

// +--------------------------------------------------
// | Module Instances
// +--------------------------------------------------
generate
  if (P_FAMILY == "Agilex 7") begin : GEN_AGILEX_7

    // Mailbox/MainCtrl Variables
    //  command interface
    logic            command_ready;
    logic            command_valid;
    logic [31:0]     command_data;
    logic            command_startofpacket;
    logic            command_endofpacket;

    //  response interface
    logic            response_ready;
    logic            response_valid;
    logic [31:0]     response_data;
    logic            response_startofpacket;
    logic            response_endofpacket;
    logic [P_NO_CH_VOLT - 1 : 0][31:0]    voltage_collection;
    logic [P_NO_CH_TEMP - 1 : 0][7:0]     temperature_collection;

    // Main Control Inst
    // CMD & RSP driven in block below
    hw_main_ctrl #(
      .P_SPEED_GRADE    (P_SPEED_GRADE),
      .P_FAMILY         (P_FAMILY),
      .P_AG5_SERIES     (P_AG5_SERIES),
      .P_AG5_DENSITY    (P_AG5_DENSITY),
      .P_NO_CH_VOLT     (P_NO_CH_VOLT),
      .P_NO_CH_TEMP     (P_NO_CH_TEMP),
      .P_INDEX_CONVERT  (P_INDEX_CONVERT_INTERNAL),
      .P_REQ_TEMPSENS   (P_REQ_TEMPSENS_INTERNAL)
    ) main(
      .clk                        (clk),
      .reset                      (reset),

      //  command interface
      .command_ready_i            (command_ready),
      .command_valid_o            (command_valid),
      .command_data_o             (command_data),
      .command_startofpacket_o    (command_startofpacket),
      .command_endofpacket_o      (command_endofpacket),

      //  response interface
      .response_ready_o           (response_ready),
      .response_valid_i           (response_valid),
      .response_data_i            (response_data),
      .response_startofpacket_i   (response_startofpacket),
      .response_endofpacket_i     (response_endofpacket),

      .voltage_good               (voltage_good),
      .temperature_good           (temperature_good),
      .voltage_collection         (voltage_collection),
      .temperature_collection     (temperature_collection),
      .voltage_info               (voltage_info),
      .temperature_info           (temperature_info)

    );

    doc_hw_mailbox mailbox (
      .in_clk_clk             (clk),
      .in_reset_reset         (reset),

      //@@ command interface
      .command_ready          (command_ready),
      .command_valid          (command_valid),
      .command_data           (command_data),
      .command_startofpacket  (command_startofpacket),
      .command_endofpacket    (command_endofpacket),

      //@@ response interface
      .response_ready         (response_ready),
      .response_valid         (response_valid),
      .response_data          (response_data),
      .response_startofpacket (response_startofpacket),
      .response_endofpacket   (response_endofpacket)
    );

  end else if (P_FAMILY == "Agilex 5") begin : GEN_AGILEX_5

    hw_agilex_5 # (
      .P_FAMILY         (P_FAMILY),
      .P_SPEED_GRADE    (P_SPEED_GRADE),
      .P_AG5_SERIES     (P_AG5_SERIES),
      .P_AG5_DENSITY    (P_AG5_DENSITY),
      .P_NO_CH_VOLT     (P_NO_CH_VOLT),
      .P_NO_CH_TEMP     (P_NO_CH_TEMP),
      .P_INDEX_CONVERT  (P_INDEX_CONVERT_INTERNAL),
      .P_REQ_TEMPSENS   (P_REQ_TEMPSENS_INTERNAL)
    ) hw_agilex_5_ctrl (
      .clk                     (clk),
      .reset                   (reset),
      .voltage_good            (voltage_good),
      .temperature_good        (temperature_good),
      .voltage_info            (voltage_info),
      .temperature_info        (temperature_info)
    );

  end //if Agilex 5
endgenerate

assign dup_pwr_good_p  = pwr_good_p;
assign dup_pwr_good_n  = pwr_good_n;
assign dup_temp_good_p = temp_good_p;
assign dup_temp_good_n = temp_good_n;
assign dup_cram_good_p = cram_good_p;
assign dup_cram_good_n = cram_good_n;

// +--------------------------------------------------
// | AXI - Output Control
// +--------------------------------------------------
// - Takes in Voltage/Temperature Collections
// - Writes them into RAM
// - Would it be more efficient to

intel_fpga_axil2apb # (
  .P_S_AXI_ADDR_WIDTH  (P_S_AXI_ADDR_WIDTH),
  .P_S_AXI_DATA_WIDTH  (P_S_AXI_DATA_WIDTH),
  .P_WATCHDOG_EN       (1)
) axil2apb_s (
  .s_axi_aclk      (s_axi_aclk),
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

  .m_apb_paddr     (s_addr),
  .m_apb_pwrite    (s_pwrite),
  .m_apb_psel      (s_psel),
  .m_apb_penable   (s_penable),
  .m_apb_pwdata    (s_wdata),
  .m_apb_prdata    (s_rdata),
  .m_apb_pready    (s_pready)
);

hw_memory # (
  .P_S_AXI_ADDR_WIDTH  (P_S_AXI_ADDR_WIDTH),
  .P_S_AXI_DATA_WIDTH  (P_S_AXI_DATA_WIDTH),
  .P_NO_CH_VOLT        (P_NO_CH_VOLT),
  .P_NO_CH_TEMP        (P_NO_CH_TEMP)
) memory (
  .clk                        (s_axi_aclk),
  .reset                      (s_axi_aresetn),

  .voltage_info               (voltage_info),
  .temperature_info           (temperature_info),

  .s_apb_paddr                (s_addr),
  .s_apb_pwrite               (s_pwrite),
  .s_apb_psel                 (s_psel),
  .s_apb_penable              (s_penable),
  .s_apb_pwdata               (s_wdata),
  .s_apb_prdata               (s_rdata),
  .s_apb_pready               (s_pready)
);

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
