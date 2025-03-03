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

//----------------------------------------------------------------------------//
//                         doc_safety_heartbeat
// The generateBit input is a clock wide pulse which causes the heartbeat
// output to toggle. This is used to provide a toggling signal which can easily
// be passed across clock domains to a watchdog.
//----------------------------------------------------------------------------//

`default_nettype none

//****************************************************************************//
module doc_safety_heartbeat
//****************************************************************************//
(
    input  wire  clk,
    input  wire  generateBit,
    output logic heartbeat
);

//****************************************************************************//

logic heartbeat_int = 1'b0;

assign heartbeat = heartbeat_int;

always_ff @(posedge clk)
    if(generateBit)
        heartbeat_int <= ~heartbeat_int;

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
