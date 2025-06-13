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

module rsp(
    input wire                                      clk,
    input wire                                      reset,
    //@@ response interface
    output logic                                    response_ready_o,
    input  wire                                     response_valid_i,
    input  wire  [31:0]                             response_data_i,
    input  wire                                     response_startofpacket_i,
    input  wire                                     response_endofpacket_i,
    output logic                                    is_good,
    input  wire                                     is_temp,
    input  wire                                     is_volt,
    input  wire [P_NO_CHANNELS - 1 : 0]             current_voltage_channel,
    input  wire [3 : 0]                             current_temperature_channel,

    output logic                                    voltage_good,
    output logic                                    temperature_good,
    output logic [P_NO_TEMP_CHANNELS - 1 : 0][7:0]  temperature_collection,
    output logic [P_NO_CHANNELS - 1 : 0][31:0]      voltage_collection
);

// +--------------------------------------------------
// | Internal Variables + Limits
// +--------------------------------------------------

// Custom Type to store voltage parameters
typedef struct {
    logic [31:0] min;
    logic [31:0] max;
} t_vparam;

// Array to indicate whether each temp/voltage channel is within limits
logic [P_NO_CHANNELS - 1 : 0]         voltage_valid       = 'b0;
logic [P_NO_TEMP_CHANNELS - 1 : 0]    temperature_valid   = 'b0;

// Limits Initialization
t_vparam voltage_ranges[P_NO_CHANNELS - 1 : 0]            = '{default : 'h0};

initial begin
    // Add elements using key-value pairs
    voltage_ranges[2] = '{32'h0000A767, 32'h0000F4DB};  // Channel 2 - VCC
    voltage_ranges[3] = '{32'h0001A3C2, 32'h0001F3B6};  // Channel 3 - VCCIO_SDM
    voltage_ranges[4] = '{32'h0001A3C2, 32'h0001F3B6};  // Channel 4 - VCCPT
    voltage_ranges[5] = '{32'h000117D6, 32'h000149CF};  // Channel 5
    voltage_ranges[6] = '{32'h0000D6E0, 32'h0000F4DB};  // Channel 6
    voltage_ranges[7] = '{32'h0000BDE3, 32'h0000D95F};  // Channel 7
    voltage_ranges[8] = '{32'h0001A3C2, 32'h0001F3B6};  // Channel 8
end

// +--------------------------------------------------
// | Response Control - Info Grabbing
// +--------------------------------------------------

always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0) begin
        is_good <= 1'b0;
        voltage_collection <= 'h0;
        temperature_collection <= 'h0;
    end
    else begin
        if (response_endofpacket_i & response_valid_i) begin
            if (is_volt) begin
                // Grab Voltage
                for(int i = 0; i < P_NO_CHANNELS; i++) begin
                    if(current_voltage_channel[i] == 1'b1) begin
                        voltage_collection[i] <= response_data_i;
                    end
                    // [ADD ERROR TRAPPING]
                end
            end
            else if (is_temp) begin
                // Grab Temperature
                temperature_collection[current_temperature_channel] <= response_data_i[15:8];
            end
            // Update "is_good" when valid and eop - Last Response has completed
            is_good <= 1'b1;
        end
        else begin
            is_good <= 1'b0;
        end
    end
end

// +--------------------------------------------------
// | Voltage Parameter Checks + Validation
// +--------------------------------------------------

always_ff @(posedge clk) begin
    for(int x = 0; x < P_NO_CHANNELS; x++) begin
        if(x == 0 || x == 1)
            voltage_valid[x] <= 1'b1;
        else if(voltage_ranges[x].min < voltage_collection[x] && voltage_collection[x] < voltage_ranges[x].max)
            voltage_valid[x] <= 1'b1;
        else
            voltage_valid[x] <= 1'b0;
    end
end

always_ff @(posedge clk or negedge reset) begin
    if(reset == 1'b0)
        voltage_good <= 1'b0;
    else
        voltage_good <= &voltage_valid;
end

// +--------------------------------------------------
// | Temperature Parameter Checks + Validation
// +--------------------------------------------------

always_ff @(posedge clk) begin
    for(int t = 0; t < P_NO_TEMP_CHANNELS; t++) begin
        if(P_MIN_TEMP_HW <= temperature_collection[t] && temperature_collection[t] <= P_MAX_TEMP_HW)
            temperature_valid[t] <= 1'b1;
        else
            temperature_valid[t] <= 1'b0;
    end
end

always_ff @(posedge clk or negedge reset) begin
    if(reset == 1'b0)
        temperature_good <= 1'b0;
    else
        temperature_good <= &temperature_valid;
end

// +--------------------------------------------------
// | Response Side
// +--------------------------------------------------

always_comb begin
    response_ready_o = 1'b1;
end // always_comb

endmodule

`default_nettype wire
