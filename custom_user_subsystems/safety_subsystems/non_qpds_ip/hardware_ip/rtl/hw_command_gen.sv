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

//****************************************************************************//
module hw_command_gen
//****************************************************************************//

import pkg_hardware_ip::*;

#(
  parameter int P_DATA_WIDTH                = 42,
  parameter int P_ADDR_WIDTH                = 8,
  parameter int P_NO_CH_VOLT                = 9,
  parameter int P_NO_CH_TEMP                = 5,
  parameter int P_REQ_TEMPSENS [12 : 0]     = {13, 13, 13, 13, 13, 13, 13, 13, 4, 3, 2, 1, 0}
) (
  input  wire  [P_ADDR_WIDTH - 1 : 0] addr_i,
  output t_cmd q_o,
  output t_cmd command_storage [((P_NO_CH_VOLT + P_NO_CH_TEMP)*2) : 0]
);

timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//

localparam      vol_offset              = (P_NO_CH_VOLT * 2) + 1;
localparam      tot_temp_channels       = 13;

// -----
//  Initial Variables
// -----

// --- 1st Packet --- //

logic [7:0]     p1_next_addr           = 'b0;
logic [1:0]     p1_startend            = 2'b10;
logic [3:0]     p1_res_bits            = 4'b0000;
logic [3:0]     p1_command_num         = 4'b1000;

// -- Temp -- //
logic [23:0]    p1_temp_command        = 24'b000000000001000000011001;

// --- 2nd Packet --- //

logic [7:0]     p2_next_addr           = 8'b00000000;
logic [1:0]     p2_startend            = 2'b01;

// -- Temp -- //
logic [11:0]    p2_temp_res            = 12'b000000000000;
logic [3:0]     p2_temp_loc;
logic [15:0]    p2_temp_command        = 16'b0000000000000001;
logic [23 : 0]  p2_temp_loc_command    = {4'b0000, p2_temp_loc, p2_temp_command};

logic [41:0]    p1;
logic [41:0]    p2;

logic [7:0]     address_counter = 0;

// -----
//  Command Storage Calculation
// -----

initial begin

  command_storage[0]  = '{cmd_next_addr: 8'd0,  sop: 1'b1, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0000, cmd_type:CMD_VOLTAGE}; // DO NOTHING - not used currently...

  // --- External Analogue Differential Pins (not being used, might be 0) ---
  command_storage[1]  = '{cmd_next_addr: 8'd2,  sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h0, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 0  Header GET_VOLTAGE
  command_storage[2]  = '{cmd_next_addr: 8'd3,  sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0001, cmd_type:CMD_VOLTAGE}; //    Channel 0

  command_storage[3]  = '{cmd_next_addr: 8'd4,  sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h1, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 1  Header GET_VOLTAGE
  command_storage[4]  = '{cmd_next_addr: 8'd5,  sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0002, cmd_type:CMD_VOLTAGE}; //    Channel 1

  // --- Internal Voltage Channels ---
  command_storage[5]  = '{cmd_next_addr: 8'd6,  sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h2, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 2  Header GET_VOLTAGE
  command_storage[6]  = '{cmd_next_addr: 8'd7,  sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0004, cmd_type:CMD_VOLTAGE}; //    Channel 2 - Internal

  command_storage[7]  = '{cmd_next_addr: 8'd8,  sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h3, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 3  Header GET_VOLTAGE
  command_storage[8]  = '{cmd_next_addr: 8'd9,  sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0008, cmd_type:CMD_VOLTAGE}; //    Channel 3 - Internal

  command_storage[9]  = '{cmd_next_addr: 8'd10, sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h4, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 4  Header GET_VOLTAGE
  command_storage[10] = '{cmd_next_addr: 8'd11, sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0010, cmd_type:CMD_VOLTAGE}; //    Channel 4 - Internal

  command_storage[11] = '{cmd_next_addr: 8'd12, sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h5, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 5  Header GET_VOLTAGE
  command_storage[12] = '{cmd_next_addr: 8'd13, sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0020, cmd_type:CMD_VOLTAGE}; //    Channel 5 - Internal

  command_storage[13] = '{cmd_next_addr: 8'd14, sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h6, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 6  Header GET_VOLTAGE
  command_storage[14] = '{cmd_next_addr: 8'd15, sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0040, cmd_type:CMD_VOLTAGE}; //    Channel 6 - Internal

  command_storage[15] = '{cmd_next_addr: 8'd16, sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h7, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 7  Header GET_VOLTAGE
  command_storage[16] = '{cmd_next_addr: 8'd17, sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0080, cmd_type:CMD_VOLTAGE}; //    Channel 7 - Internal

  command_storage[17] = '{cmd_next_addr: 8'd18, sop: 1'b1, eop: 1'b0, temp_index: 'h0, id: 'h8, cmd:'h1018, cmd_type:CMD_VOLTAGE}; // 8  Header GET_VOLTAGE
  command_storage[18] = '{cmd_next_addr: 8'd19, sop: 1'b0, eop: 1'b1, temp_index: 'h0, id: 'h0, cmd:'h0100, cmd_type:CMD_VOLTAGE}; //    Channel 8 - Internal

end //initial

// Temp Command Generation v2
initial begin
  for(int t = 0; t < tot_temp_channels; t++) begin
    // --- If value != 13 ---
    if(P_REQ_TEMPSENS[t] != 13) begin
      // --- Packet 1 ---
      p1_next_addr = vol_offset + address_counter + 1;
      p1_command_num = p1_command_num + 1;

      p2_temp_loc = P_REQ_TEMPSENS[t];

      command_storage[vol_offset + address_counter] = '{cmd_next_addr: p1_next_addr, sop: 1'b1, eop: 1'b0,
                        temp_index: p2_temp_loc, id: p1_command_num, cmd:'h1019, cmd_type:CMD_TEMP};

      // --- Packet 2 ---
      p2_temp_loc_command = {4'b0000, p2_temp_loc, p2_temp_command}; // specify TSD location and sensor mask
      command_storage[vol_offset + address_counter + 1] = '{cmd_next_addr: (p1_next_addr + 1'b1), sop: 1'b0,
                        eop: 1'b1, temp_index: p2_temp_loc, id: 'h0, cmd:p2_temp_loc_command, cmd_type:CMD_TEMP};

      // --- Update Address Counter ---
      address_counter = address_counter + 2;
    end //if
  end //for

  command_storage[$left(command_storage)].cmd_next_addr = 'd1;

end //initial

assign q_o = command_storage[addr_i];

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
