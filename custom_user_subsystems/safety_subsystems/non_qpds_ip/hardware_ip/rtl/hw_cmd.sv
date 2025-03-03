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
//****************************************************************************//
module hw_cmd #(
//****************************************************************************//
    parameter int DATA_WIDTH   = 42,
    parameter int ADDR_WIDTH   = 8,
    parameter int P_NO_CH_VOLT = 9,
    parameter int P_NO_CH_TEMP = 5,
    parameter int P_REQ_TEMPSENS [12 : 0] = {13, 13, 13, 13, 13, 13, 13, 13, 4, 3, 2, 1, 0}
) (
    input  wire         clk,
    input  wire         reset,

    //@@ command interface
    input  wire         command_ready_i,
    output logic        command_valid_o,
    output logic [31:0] command_data_o,
    output logic        command_startofpacket_o,
    output logic        command_endofpacket_o,

    //@@ response interface
    input  wire         response_i,                  // = valid & endofpacket
    input  wire         is_good,
    output logic        is_volt,
    output logic        is_temp,

    output logic [P_NO_CH_VOLT - 1 : 0]  current_voltage_channel,
    output logic [3 : 0]                 current_temperature_channel
);

timeunit 1ns;
timeprecision 1ps;

import pkg_hardware_ip::*;

//****************************************************************************//

t_cmd command_storage [((P_NO_CH_VOLT + P_NO_CH_TEMP)*2) : 0];
// +--------------------------------------------------
// | Signals
// +--------------------------------------------------

// ROM
reg   [ADDR_WIDTH - 1 : 0]  rom_addr;
logic [ADDR_WIDTH - 1 : 0]  rom_addr_next;
t_cmd  rom_q;

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

t_cmd_type cmd_type_reg;

// State Machine. IDLE -> SEND -> WAITRSP
typedef enum logic [1:0]
{
    ST_IDLE,
    ST_SEND,
    ST_WAIT_RSP
} t_state;
t_state state, next_state /* synthesis preserve dont_replicate dont_retime */;

// +--------------------------------------------------
// | Command Rom: storage unit
// +--------------------------------------------------

//command_gen command_rom
hw_command_gen #(
  .P_NO_CH_TEMP     (P_NO_CH_TEMP),
  .P_NO_CH_VOLT     (P_NO_CH_VOLT),
  .P_REQ_TEMPSENS   (P_REQ_TEMPSENS)
) command_rom(
  .addr_i           (rom_addr),
  .q_o              (rom_q),
  .command_storage  (command_storage)
);

// Update ROM based on given address

assign rom_cmd_next_addr     = rom_q.cmd_next_addr;
assign rom_cmd_startofpacket = rom_q.sop;
assign rom_cmd_endofpacket   = rom_q.eop;
assign rom_cmd_data          = {4'b0000, rom_q.id, rom_q.cmd};

// Last 8 bits represent type of command
assign command_type           = command_data_o[7:0];

// +--------------------------------------------------
// | Command Type Control
// +--------------------------------------------------

// Decode Command Data for Command Type
// Passed to Response Side for further usage
always_ff @(posedge clk) begin
  if (reset) begin
    is_volt <= 1'b0;
    is_temp <= 1'b0;
  end else if (command_startofpacket_o) begin
    if(cmd_type_reg == CMD_VOLTAGE) begin
      is_volt <= 1'b1;
      is_temp <= 1'b0;
    end else if(cmd_type_reg == CMD_TEMP) begin
      is_volt <= 1'b0;
      is_temp <= 1'b1;
    end else begin
      is_volt <= 1'b0;
      is_temp <= 1'b0;
    end
  end
end

// Obtain voltage channel bits
// Passed to Response Side for further usage
always_ff @(posedge clk) begin
    if (reset) begin
    current_voltage_channel     <= 'b0;
    current_temperature_channel <= 'b0;
  end else if(is_volt && command_endofpacket_o) begin
    current_voltage_channel <= command_data_o[P_NO_CH_VOLT - 1:0];
  end else if(is_temp && command_endofpacket_o) begin
    current_temperature_channel <= command_data_o[19:16];
  end //if
end //always

// +--------------------------------------------------
// | Command Rom: Address Decision
// +--------------------------------------------------
logic [ADDR_WIDTH - 1 : 0] currentAddr = 'h01;
logic [ADDR_WIDTH - 1 : 0] nextAddr    = 'h01;

// Update ROM_ADDR with ROM_ADDR_NEXT
always_ff @(posedge clk)
begin
  if (reset) begin
    rom_addr <= {ADDR_WIDTH{1'b0}};
  end else begin
    rom_addr <= rom_addr_next;
  end //if
end //always_ff

// Determine ROM_ADDR_NEXT based on:
// - State
// - Recently fetched ROM command data
// - Current Address, used to cycle through set of commands
always_comb begin
  rom_addr_next = rom_addr;
  case (state)
    ST_IDLE : begin
      if (is_good) begin
        // Input from Response, shows response completed
        if (currentAddr + 'h02 > (2*(P_NO_CH_TEMP + P_NO_CH_VOLT) - 1)) begin
          // When next Address is beyond range
          // Past set of defined address -> Reset to first valid Address
          rom_addr_next = {{(ADDR_WIDTH-1){1'b0}}, {1'b1}};
        end else begin
          // Move onto Next Address
          rom_addr_next = currentAddr + 2'h2;
        end //if
      end else begin
        rom_addr_next = {{(ADDR_WIDTH-1){1'b0}}, {1'b1}}; // Default: Command 2
      end //if
    end //ST_IDLE

    ST_SEND : begin
      if (command_ready_i) begin
        rom_addr_next = rom_cmd_next_addr;
      end //if
    end //ST_SEND

    ST_WAIT_RSP : begin
      rom_addr_next = {{(ADDR_WIDTH){1'b0}}};
    end //ST_WAIT_RSP
  endcase
end //always_ff

// Update Current Address based on Next
// Allows to Cycle through set of Commands
always_ff @(posedge clk) begin
  if (reset) begin
    currentAddr <= {{(ADDR_WIDTH-1){1'b0}}, {1'b1}};
  end else if(state == ST_IDLE) begin
    currentAddr <= rom_addr_next;
  end //if
end //always_ff

// +--------------------------------------------------
// | Command Rom: State Machine Control
// +--------------------------------------------------

// Updating State Machine
always_ff @(posedge clk) begin
  if (reset) begin
    state <= ST_IDLE;
  end else begin
    state <= next_state;
  end //if
end //always_ff

// Next State Condition
always_comb begin
  next_state = ST_IDLE;
  case (state)

    ST_IDLE : begin                              // when reset go into idle, wait for command_ready input
      next_state = ST_IDLE;
      if (command_ready_i) begin
        next_state = ST_SEND;
      end //if
    end //ST_IDLE

    ST_SEND : begin
      next_state = ST_SEND;
      if (rom_cmd_endofpacket) begin
        next_state = ST_WAIT_RSP;
      end //if
    end //ST_SEND

    ST_WAIT_RSP : begin                          // If response valid and end of packet, then go into idle state
      next_state = ST_WAIT_RSP;
      if (response_i) begin
        next_state = ST_IDLE;
      end //if
    end //ST_WAIT_RSP

  endcase
end //always_ff

// +--------------------------------------------------
// | State Machine Outputs
// +--------------------------------------------------

always_comb begin
  cmd_valid             = 1'b0;
  cmd_data              = 32'b0;
  cmd_startofpacket     = 1'b0;
  cmd_endofpacket       = 1'b0;
  busy                  = 1'b0;
  case (state)
    ST_IDLE : begin
      cmd_valid         = 1'b0;
      cmd_data          = 1'b0;
      cmd_startofpacket = 1'b0;
      cmd_endofpacket   = 1'b0;
      busy              = 1'b0;
    end //ST_IDLE

    ST_SEND : begin
      cmd_valid         = 1'b1;
      cmd_data          = rom_cmd_data;
      cmd_startofpacket = rom_cmd_startofpacket;
      cmd_endofpacket   = rom_cmd_endofpacket;
      busy              = 1'b1;
    end //ST_SEND

    ST_WAIT_RSP : begin
      cmd_valid         = 1'b0;
      cmd_data          = 1'b0;
      cmd_startofpacket = 1'b0;
      cmd_endofpacket   = 1'b0;
      busy              = 1'b1;
    end //ST_WAIT_RSP
  endcase // case (state)
end

// +--------------------------------------------------
// | FInal Module Outputs
// +--------------------------------------------------

always_ff @(posedge clk) begin
  if (reset) begin
    cmd_valid_reg         <= 1'b0;
    cmd_data_reg          <= 32'b0;
    cmd_startofpacket_reg <= 1'b0;
    cmd_endofpacket_reg   <= 1'b0;
    busy_reg              <= 1'b0;
  end else begin
    cmd_valid_reg         <= cmd_valid;
    cmd_data_reg          <= cmd_data;
    cmd_type_reg          <= rom_q.cmd_type;
    cmd_startofpacket_reg <= cmd_startofpacket;
    cmd_endofpacket_reg   <= cmd_endofpacket;
    busy_reg              <= busy;
  end
end

assign command_valid_o          = cmd_valid_reg;
assign command_data_o           = cmd_data_reg;
assign command_startofpacket_o  = cmd_startofpacket_reg;
assign command_endofpacket_o    = cmd_endofpacket_reg;

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
