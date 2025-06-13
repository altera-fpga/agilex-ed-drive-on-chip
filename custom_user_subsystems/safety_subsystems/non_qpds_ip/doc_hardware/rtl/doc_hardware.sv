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

module doc_hardware
# (
    parameter P_TEMP_WIDTH = 8
) (
    input wire hw_clk,
    input wire hw_reset,

    //Voltage Validation
    (* preserve *) output logic pwr_good_p,
    (* preserve *) output logic pwr_good_n,

    //Temp Validation
    (* preserve *) output logic temp_good_p,
    (* preserve *) output logic temp_good_n,

    // Explore CRAM + Mailbox Functionality...
    (* preserve *) output logic cram_good_p,
    (* preserve *) output logic cram_good_n
);

// +--------------------------------------------------
// | Initial Signals
// +--------------------------------------------------

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

//Grabbed/Output Variables
logic                                   voltage_good;
logic                                   temperature_good;
logic [P_NO_CHANNELS - 1 : 0][31:0]     voltage_collection;
logic [P_NO_TEMP_CHANNELS - 1 : 0][7:0] temperature_collection;

// +--------------------------------------------------
// | Output Control
// +--------------------------------------------------

always_ff @(posedge hw_clk) begin
    pwr_good_p <= voltage_good;
    pwr_good_n <= ~voltage_good;

    temp_good_p <= temperature_good;
    temp_good_n <= ~temperature_good;

    cram_good_p <= 1'b1;
    cram_good_n <= 1'b0;
end

// +--------------------------------------------------
// | Module Instances
// +--------------------------------------------------

// Main Control Inst
// CMD & RSP driven in block below
main_ctrl main(
    .clk                        (hw_clk),
    .reset                      (hw_reset),

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
    .temperature_collection     (temperature_collection)
);

 altera_config_stream_endpoint #(
    .READY_LATENCY          (0),
    .HAS_URGENT             (0),
    .HAS_STATUS             (0),
    .HAS_STREAM             (0),
    .MAX_SIZE               (256),
    .STREAM_WIDTH           (32),
    .CLOCK_RATE_CLK         (0)
) inst (
    .clk                    (hw_clk),
    .reset                  (hw_reset),
    .command_ready          (command_ready),
    .command_valid          (command_valid),
    .command_data           (command_data),
    .command_startofpacket  (command_startofpacket),
    .command_endofpacket    (command_endofpacket),
    .command_invalid        (),
    .response_ready         (response_ready),
    .response_valid         (response_valid),
    .response_data          (response_data),
    .response_startofpacket (response_startofpacket),
    .response_endofpacket   (response_endofpacket),
    .urgent_ready           (),
    .urgent_valid           (1'b0),
    .urgent_data            (32'd0),
    .stream_ready           (),
    .stream_valid           (1'b0),
    .stream_data            (32'd0),
    .stream_active          ()
);

endmodule

`default_nettype wire
