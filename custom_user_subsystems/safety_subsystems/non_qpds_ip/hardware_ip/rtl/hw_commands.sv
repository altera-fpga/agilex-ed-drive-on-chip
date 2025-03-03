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
module hw_commands #(
//****************************************************************************//
  parameter DATA_WIDTH = 42,
  parameter ADDR_WIDTH = 8
)(
    input  wire    [(ADDR_WIDTH-1):0] addr_i,
    output logic   [(DATA_WIDTH-1):0] q_o
);

timeunit 1ns;
timeprecision 1ps;

//****************************************************************************//

always_comb begin
    case(addr_i)

        // --- Core Temperatures ---
        'h00: q_o = 'b000000001100000001000000000000000000000000; // 1 DO NOTHING - not used currently...

        'h01: q_o = 'b000000101000000010000000000001000000011001; // 2 Header GET_TEMPERATURE_1
        'h02: q_o = 'b000000000100000000000000000000000000000001; //   ARG : CORE, sensor 0

        'h03: q_o = 'b000001001000000011000000000001000000011001; // 3 Header GET_TEMPERATURE_2
        'h04: q_o = 'b000000000100000000000000010000000000000001; //   ARG : CORE, sensor 1

        'h05: q_o = 'b000001101000000100000000000001000000011001; // 4 Header GET_TEMPERATURE_3
        'h06: q_o = 'b000000000100000000000000100000000000000001; //   ARG : CORE, sensor 2

        'h07: q_o = 'b000010001000000101000000000001000000011001; // 5 Header GET_TEMPERATURE_4
        'h08: q_o = 'b000000000100000000000000110000000000000001; //   ARG : CORE, sensor 3

        'h09: q_o = 'b000010101000000110000000000001000000011001; // 6 Header GET_TEMPERATURE_5
        'h0A: q_o = 'b000000000100000000000001000000000000000001; //   ARG : CORE, sensor 4

        // --- External Analogue Differential Pins (not being used, might be 0) ---
        'h0B: q_o = 'b000011001000000111000000000001000000011000; // 7  Header GET_VOLTAGE
        'h0C: q_o = 'b000000000100000000000000000000000000000001; //    Channel 0

        'h0D: q_o = 'b000011101000001000000000000001000000011000; // 8  Header GET_VOLTAGE
        'h0E: q_o = 'b000000000100000000000000000000000000000010; //    Channel 1

        // --- Internal Voltage Channels ---
        'h0F: q_o = 'b000100001000001001000000000001000000011000; // 9  Header GET_VOLTAGE
        'h10: q_o = 'b000000000100000000000000000000000000000100; //    Channel 2 - Internal

        'h11: q_o = 'b000100101000001010000000000001000000011000; // 10  Header GET_VOLTAGE
        'h12: q_o = 'b000000000100000000000000000000000000001000; //    Channel 3 - Internal

        'h13: q_o = 'b000101001000001011000000000001000000011000; // 11  Header GET_VOLTAGE
        'h14: q_o = 'b000000000100000000000000000000000000010000; //    Channel 4 - Internal

        'h15: q_o = 'b000101101000001100000000000001000000011000; // 12  Header GET_VOLTAGE
        'h16: q_o = 'b000000000100000000000000000000000000100000; //    Channel 5 - Internal

        'h17: q_o = 'b000110001000001101000000000001000000011000; // 13  Header GET_VOLTAGE
        'h18: q_o = 'b000000000100000000000000000000000001000000; //    Channel 6 - Internal

        'h19: q_o = 'b000110101000001110000000000001000000011000; // 14  Header GET_VOLTAGE
        'h1A: q_o = 'b000000000100000000000000000000000010000000; //    Channel 7 - Internal

        'h1B: q_o = 'b000111001000001111000000000001000000011000; // 15  Header GET_VOLTAGE
        'h1C: q_o = 'b000000000100000000000000000000000100000000; //    Channel 9 - Internal

        default : q_o = 'b000000001100000001000000000000000000000000;

    endcase
end

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
