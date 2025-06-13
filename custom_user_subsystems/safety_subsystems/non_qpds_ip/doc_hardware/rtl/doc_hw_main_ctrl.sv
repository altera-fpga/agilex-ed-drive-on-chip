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

`default_nettype none

import doc_hw_pkg_hw::*;

module main_ctrl(
    input wire              clk,
    input wire              reset,

    //  command interface
    input  wire             command_ready_i,
    output logic            command_valid_o,
    output logic [31:0]     command_data_o,
    output logic            command_startofpacket_o,
    output logic            command_endofpacket_o,

    //  response interface
    output logic            response_ready_o,
    input  wire             response_valid_i,
    input  wire  [31:0]     response_data_i,
    input  wire             response_startofpacket_i,
    input  wire             response_endofpacket_i,

    output logic                                   voltage_good,
    output logic                                   temperature_good,
    output logic [P_NO_CHANNELS - 1 : 0][31:0]     voltage_collection,
    output logic [P_NO_TEMP_CHANNELS - 1 : 0][7:0] temperature_collection
);

// +--------------------------------------------------
// | Internal Signals
// +--------------------------------------------------

logic cmd_response;
logic is_good;
logic is_volt;
logic is_temp;

logic [P_NO_CHANNELS - 1 : 0]  current_voltage_channel;
logic [3:0]                    current_temperature_channel;

assign cmd_response = response_valid_i & response_endofpacket_i;

// +--------------------------------------------------
// | Command Control
// +--------------------------------------------------

cmd_ctrl cmd_ctrl
(
    .clk                         (clk),
    .reset                       (reset),

    //@@ command interface
    .command_ready_i             (command_ready_i),
    .command_valid_o             (command_valid_o),
    .command_data_o              (command_data_o),
    .command_startofpacket_o     (command_startofpacket_o),
    .command_endofpacket_o       (command_endofpacket_o),
    //@@ response interface
    .response_i                  (cmd_response),
    .is_good                     (is_good),
    .is_volt                     (is_volt),
    .is_temp                     (is_temp),
    .current_voltage_channel     (current_voltage_channel),
    .current_temperature_channel (current_temperature_channel)
);

// +--------------------------------------------------
// | Response Control
// +--------------------------------------------------

rsp rsp
(
    .clk                          (clk),
    .reset                        (reset),

    //@@ response interface
    .response_ready_o             (response_ready_o),
    .response_valid_i             (response_valid_i),
    .response_data_i              (response_data_i),
    .response_startofpacket_i     (response_startofpacket_i),
    .response_endofpacket_i       (response_endofpacket_i),

    .is_good                      (is_good),
    .is_volt                      (is_volt),
    .is_temp                      (is_temp),
    .current_voltage_channel      (current_voltage_channel),
    .current_temperature_channel  (current_temperature_channel),

    .voltage_good                 (voltage_good),
    .temperature_good             (temperature_good),
    .voltage_collection           (voltage_collection),
    .temperature_collection       (temperature_collection)
);

endmodule

`default_nettype wire
