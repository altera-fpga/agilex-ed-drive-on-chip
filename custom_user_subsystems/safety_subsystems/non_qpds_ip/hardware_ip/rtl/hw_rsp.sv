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
module hw_rsp # (
//****************************************************************************//
  parameter string P_SPEED_GRADE             = "6",
  parameter string P_FAMILY                  = "Agilex 7",
  parameter string P_AG5_SERIES              = "E",
  parameter string P_AG5_DENSITY             = "065",
  parameter int    P_INDEX_CONVERT [12 : 0]  = {13, 13, 13, 13, 13, 13, 13, 13, 4, 3, 2, 1, 0},
  parameter int    P_NO_CH_VOLT              = 9,
  parameter int    P_NO_CH_TEMP              = 5,
  parameter int    P_REQ_TEMPSENS [12 : 0]   = {13, 13, 13, 13, 13, 13, 13, 13, 4, 3, 2, 1, 0}
) (
  input  wire                                 clk,
  input  wire                                 reset,
  //@@ response interface
  output logic                                response_ready_o,
  input  wire                                 response_valid_i,
  input  wire  [31:0]                         response_data_i,
  input  wire                                 response_startofpacket_i,
  input  wire                                 response_endofpacket_i,

  output logic                                is_good,
  input  wire                                 is_temp,
  input  wire                                 is_volt,
  input  wire  [P_NO_CH_VOLT - 1 : 0]         current_voltage_channel,
  input  wire  [3 : 0]                        current_temperature_channel,

  output logic                                voltage_good,
  output logic                                temperature_good,
  output logic [P_NO_CH_TEMP - 1 : 0][7:0]    temperature_collection,
  output logic [P_NO_CH_VOLT - 1 : 0][31:0]   voltage_collection,

  //Experimental
  output logic [P_NO_CH_VOLT - 1 : 0][31:0]   voltage_info,
  output logic [P_NO_CH_TEMP - 1 : 0][31:0]   temperature_info
);

timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//

// +--------------------------------------------------
// | Internal Variables + Limits
// +--------------------------------------------------
localparam int P_MAX_TEMP_HW = 80;
localparam int P_MIN_TEMP_HW = 10;

// Custom Type to store voltage parameters
typedef struct {
    logic [31:0] min;
    logic [31:0] max;
} t_vparam;

// Array to indicate whether each temp/voltage channel is within limits
logic [P_NO_CH_VOLT - 1 : 0]         voltage_valid   = 'b0;
logic [P_NO_CH_TEMP - 1 : 0]     temperature_valid   = 'b0;

// Limits Initialisation
t_vparam voltage_ranges[P_NO_CH_VOLT - 1 : 0]            = '{default : 'h0};

initial begin
    if (P_FAMILY == "Agilex 7") begin
        // Add elements using key-value pairs
        voltage_ranges[2] = '{32'h0000A767, 32'h0000F4DB};          // Channel 2 - VCC
        voltage_ranges[3] = '{32'h0001A3C2, 32'h0001F3B6};          // Channel 3 - VCCIO_SDM
        voltage_ranges[4] = '{32'h0001A3C2, 32'h0001F3B6};          // Channel 4 - VCCPT
        voltage_ranges[5] = '{32'h000117D6, 32'h000149CF};          // Channel 5 - VCCRRCORE
        voltage_ranges[6] = '{32'h0000D6E0, 32'h0000F4DB};          // Channel 6 - VCCH_SDM
        voltage_ranges[7] = '{32'h0000BDE3, 32'h0000D95F};          // Channel 7 - VCCL_SDM
        voltage_ranges[8] = '{32'h0001A3C2, 32'h0001F3B6};          // Channel 8 - VCCADC
    end else if (P_FAMILY == "Agilex 5") begin
    if (P_AG5_SERIES == "E") begin

        if (P_SPEED_GRADE == "6") begin
            // Add elements using key-value pairs
            voltage_ranges[2] = '{32'h0000B165, 32'h0000CA62};      // Channel 2 - VCC
            voltage_ranges[3] = '{32'h0001A3C2, 32'h0001F3B6};      // Channel 3 - VCCIO_SDM
            voltage_ranges[4] = '{32'h0001ADC0, 32'h0001E9B7};      // Channel 4 - VCCPT
            voltage_ranges[5] = '{32'h000117D6, 32'h000149CF};      // Channel 5 - VCCRRCORE
            if (  (P_AG5_DENSITY == "005") || (P_AG5_DENSITY == "007") )begin
                // 005 and 007 devices do not have transceivers and run at a different VCCH_SDM
                voltage_ranges[6] = '{32'h0000B165, 32'h0000CA62};    // Channel 6 - VCCH_SDM
            end else begin
                voltage_ranges[6] = '{32'h0000EADD, 32'h00010DD8};    // Channel 6 - VCCH_SDM
            end //if
            voltage_ranges[7] = '{32'h0000B165, 32'h0000CA62};      // Channel 7 - VCCL_SDM
            voltage_ranges[8] = '{32'h0001A3C2, 32'h0001F3B6};      // Channel 8 - VCCADC
        end //if

    end else begin
    // D series TDB

    end //if
  end // if
end

logic [3:0] tracker = 0;
logic [3:0] pos = 0;
logic [P_NO_CH_TEMP - 1 : 0][3:0]  only_req_temps;

initial begin
    while (tracker < P_NO_CH_TEMP) begin
        if(P_REQ_TEMPSENS[pos] != 13) begin
            only_req_temps[tracker]  = P_REQ_TEMPSENS[pos];
            tracker = tracker + 1;
        end
        pos = pos + 1;
    end
end

// +--------------------------------------------------
// | Response Control - Info Grabbing
// +--------------------------------------------------
always_ff @(posedge clk) begin
    if (reset) begin
        is_good                <= 1'b0;
        voltage_collection     <= '0;
        temperature_collection <= '0;
    end else begin
        if (response_endofpacket_i & response_valid_i) begin
            if (is_volt) begin
                // Grab Voltage
                for (int i = 0; i < P_NO_CH_VOLT; i++) begin
                    if (current_voltage_channel[i] == 1'b1) begin
                        voltage_collection[i] <= response_data_i;
                    end //if
                end //if
            end else if (is_temp) begin
            // Grab Temperature 8000000h
             temperature_collection[P_INDEX_CONVERT[current_temperature_channel]] <= response_data_i[15:8];
            end //if
            // Update is_good when valid and eop - Last Response has completed
            is_good <= 1'b1;
        end else begin
        is_good <= 1'b0;
        end //if
    end //if
end //always_ff

// +--------------------------------------------------
// | Voltage Paramater Checks + Validation
// +--------------------------------------------------
always_ff @(posedge clk) begin
  for (int x = 0; x < P_NO_CH_VOLT; x++) begin
    if (x == 0 || x == 1) begin
      voltage_valid[x] <= 1'b1;
    end else if(voltage_ranges[x].min <= voltage_collection[x] && voltage_collection[x] <= voltage_ranges[x].max) begin
      voltage_valid[x] <= 1'b1;
    end else begin
      voltage_valid[x] <= 1'b0;
    end //if
  end //for
end //always_ff

always_ff @(posedge clk) begin
    if (reset) begin
        voltage_good <= 1'b0;
    end else begin
        voltage_good <= &voltage_valid;
    end //if
end //always_ff

// +--------------------------------------------------
// | Temperature Paramater Checks + Validation
// +--------------------------------------------------
always_ff @(posedge clk) begin
    for (int t = 0; t < P_NO_CH_TEMP; t++) begin
        if (P_MIN_TEMP_HW <= temperature_collection[t] && temperature_collection[t] <= P_MAX_TEMP_HW) begin
            temperature_valid[t] <= 1'b1;
         end else begin
        temperature_valid[t] <= 1'b0;
        end //if
    end //for
end //always_ff

always_ff @(posedge clk) begin
    if (reset) begin
        temperature_good <= 1'b0;
    end else begin
        temperature_good <= &temperature_valid;
    end //if
end //always_ff

// +--------------------------------------------------
// | Response Side
// +--------------------------------------------------
always_comb begin
    response_ready_o = 1'b1;
end // always_comb

// +--------------------------------------------------
// | Informational Bits for NIOS Application
// +--------------------------------------------------

// Voltage Side
always_ff @(posedge clk) begin
    for (int x = 0; x < P_NO_CH_VOLT; x++) begin
        voltage_info[x]     <= voltage_collection[x];
        voltage_info[x][31] <= voltage_valid[x];
    end //for
end //always_ff

// Temperature Side
always_ff @(posedge clk) begin
    for (int x = 0; x < P_NO_CH_TEMP; x++) begin
        temperature_info[x]         <= temperature_collection[x];
        temperature_info[x][31]     <= temperature_valid[x];
        temperature_info[x][27:24]  <= only_req_temps[x];
    end //for
end //always_ff

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
