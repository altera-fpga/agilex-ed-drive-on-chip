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
// Module Command Control

import doc_hw_pkg_hw::*;

module cmd_ctrl #(
    parameter DATA_WIDTH=42,
    parameter ADDR_WIDTH=8
) (
    input wire          clk,
    input wire          reset,

    //@@ command interface
    input  wire         command_ready_i,
    output logic        command_valid_o,
    output logic [31:0] command_data_o,
    output logic        command_startofpacket_o,
    output logic        command_endofpacket_o,

    //@@ response interface
    input  wire         response_i,
    input  wire         is_good,
    output logic        is_volt,
    output logic        is_temp,

    output logic [P_NO_CHANNELS - 1 : 0]  current_voltage_channel,
    output logic [3 : 0]                  current_temperature_channel
);

// +--------------------------------------------------
// | Signals
// +--------------------------------------------------

    // ROM
    reg   [ADDR_WIDTH - 1 : 0]  rom_addr;
    logic [ADDR_WIDTH - 1 : 0]  rom_addr_next;
    logic [DATA_WIDTH- 1 : 0]   rom_q;

    logic [ADDR_WIDTH - 1 : 0]  rom_cmd_next_addr;
    logic                       rom_cmd_startofpacket;
    logic                       rom_cmd_endofpacket;
    logic [31:0]                rom_cmd_data;

    reg                         cmd_valid_reg;
    reg   [31:0]                cmd_data_reg;
    reg                         cmd_startofpacket_reg;
    reg                         cmd_endofpacket_reg;
    reg                         busy_reg;

    logic                       cmd_valid;
    logic [31:0]                cmd_data;
    logic                       cmd_startofpacket;
    logic                       cmd_endofpacket;
    logic                       busy;

    logic [7:0] command_type;    // Voltage/Temp

// State Machine. IDLE -> SEND -> WAITRSP
typedef enum bit [1:0]
{
    ST_IDLE        = 2'b00,
    ST_SEND        = 2'b01,
    ST_WAIT_RSP    = 2'b10
} t_state;
t_state state, next_state /* synthesis preserve dont_replicate dont_retime */;

// +--------------------------------------------------
// | Command Rom: storage unit
// +--------------------------------------------------

commands command_rom
(
    .addr_i(rom_addr),
    .q_o(rom_q)
);

// Update ROM based on given address
assign rom_cmd_next_addr     = rom_q[41:34];
assign rom_cmd_startofpacket = rom_q[33];
assign rom_cmd_endofpacket   = rom_q[32];
assign rom_cmd_data          = rom_q[31:0];

// Last 8 bits represent type of command
// 19h - Temp, 20h - Voltage
assign command_type           = command_data_o[7:0];

// +--------------------------------------------------
// | Command Type Control
// +--------------------------------------------------

// Decode Command Data for Command Type
// Passed to Response Side for further usage
always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0) begin
        is_volt <= 1'b0;
        is_temp <= 1'b0;
    end
    else if (command_startofpacket_o) begin
        //Voltage
        if (command_type == 8'h18) begin
            is_volt <= 1'b1;
            is_temp <= 1'b0;
        end
        //Temp
        else if (command_type == 8'h19) begin
            is_volt <= 1'b0;
            is_temp <= 1'b1;
        end
        else begin
            is_volt <= 1'b0;
            is_temp <= 1'b0;
        end
    end
end

// Obtain voltage channel bits
// Passed to Response Side for further usage
always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0) begin
        current_voltage_channel     <= 'b0;
        current_temperature_channel <= 'b0;
    end else if (is_volt && command_endofpacket_o) begin
        current_voltage_channel <= command_data_o[P_NO_CHANNELS - 1:0];
    end else if (is_temp && command_endofpacket_o) begin
        current_temperature_channel <= command_data_o[19:16];
    end
end

// +--------------------------------------------------
// | Command Rom: Address Decision
// +--------------------------------------------------

logic [ADDR_WIDTH - 1 : 0] currentAddr = 'h01;
logic [ADDR_WIDTH - 1 : 0] nextAddr    = 'h01;

// Update ROM_ADDR with ROM_ADDR_NEXT
always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0)
        rom_addr <= 'h00;
    else
        rom_addr <= rom_addr_next;
end

// Determine ROM_ADDR_NEXT based on:
// - State
// - Recently fetched ROM command data
// - Current Address, used to cycle through set of commands
always_comb begin
    rom_addr_next = rom_addr;
    case(state)
        ST_IDLE: begin
            if (is_good) begin
                // Input from Response, shows response completed
                if (currentAddr + 'h02 > 'h1B)
                    // When next Address is beyond range
                    // Past set of defined address -> Reset to first valid Address
                    rom_addr_next = 'h01;
                else
                    // Move onto Next Address
                    rom_addr_next = currentAddr + 'h2;
            end
            else
                rom_addr_next = 'h01; // Default: Command 2
        end
        ST_SEND: begin
            if (command_ready_i)
                rom_addr_next = rom_cmd_next_addr;
        end
        ST_WAIT_RSP: begin
            rom_addr_next = 'h00;
        end
    endcase
end

// Update Current Address based on Next
// Allows to Cycle through set of Commands
always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0)
        currentAddr <= 'h01;
    else if (state == ST_IDLE)
        currentAddr <= rom_addr_next;
end

// +--------------------------------------------------
// | Command Rom: State Machine Control
// +--------------------------------------------------

// Updating State Machine
always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0)
        state <= ST_IDLE;
    else
        state <= next_state;
end

// Next State Condition
always_comb begin
    next_state = ST_IDLE;
    // when reset go into idle, wait for command_ready input
    case (state)
        ST_IDLE: begin
            next_state = ST_IDLE;
            if (command_ready_i)
                next_state = ST_SEND;
        end
        ST_SEND: begin
            next_state = ST_SEND;
            if (rom_cmd_endofpacket)
                next_state = ST_WAIT_RSP;
        end
        // If response valid and end of packet, then go into idle state
        ST_WAIT_RSP: begin
            next_state = ST_WAIT_RSP;
            if (response_i)
                next_state = ST_IDLE;
        end
    endcase
end

// +--------------------------------------------------
// | State Machine Outputs
// +--------------------------------------------------

always_comb begin
    cmd_valid         = 1'b0;
    cmd_data          = 32'b0;
    cmd_startofpacket = 1'b0;
    cmd_endofpacket   = 1'b0;
    busy              = 1'b0;
    case (state)
        ST_IDLE: begin
            cmd_valid         = 1'b0;
            cmd_data          = 1'b0;
            cmd_startofpacket = 1'b0;
            cmd_endofpacket   = 1'b0;
            busy              = 1'b0;
        end
        ST_SEND: begin
            cmd_valid         = 1'b1;
            cmd_data          = rom_cmd_data;
            cmd_startofpacket = rom_cmd_startofpacket;
            cmd_endofpacket   = rom_cmd_endofpacket;
            busy              = 1'b1;
        end
        ST_WAIT_RSP : begin
            cmd_valid         = 1'b0;
            cmd_data          = 1'b0;
            cmd_startofpacket = 1'b0;
            cmd_endofpacket   = 1'b0;
            busy              = 1'b1;
        end
    endcase // case (state)
end

// +--------------------------------------------------
// | FInal Module Outputs
// +--------------------------------------------------

always_ff @(posedge clk or negedge reset) begin
    if (reset == 1'b0) begin
        cmd_valid_reg         <= 1'b0;
        cmd_data_reg          <= 32'b0;
        cmd_startofpacket_reg <= 1'b0;
        cmd_endofpacket_reg   <= 1'b0;
        busy_reg              <= 1'b0;
    end else begin
        cmd_valid_reg         <= cmd_valid;
        cmd_data_reg          <= cmd_data;
        cmd_startofpacket_reg <= cmd_startofpacket;
        cmd_endofpacket_reg   <= cmd_endofpacket;
        busy_reg              <= busy;
    end
end

assign command_valid_o          = cmd_valid_reg;
assign command_data_o           = cmd_data_reg;
assign command_startofpacket_o  = cmd_startofpacket_reg;
assign command_endofpacket_o    = cmd_endofpacket_reg;

endmodule

`default_nettype wire
