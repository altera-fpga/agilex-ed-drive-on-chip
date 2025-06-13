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

//----------------------------------------------------------------------------//
//                         doc_safety_payload_generator
// The estimated speed and over-speed status are combined with a sequence counter
// into a payload packet to be cross compared with the equivalent data from the HPS
//----------------------------------------------------------------------------//

`default_nettype none

import pkg_doc_safety::*;

//****************************************************************************//
module doc_safety_payload_generator (
//****************************************************************************//
    input  wire             clk,
    input  wire             reset_n,
    input  wire             reset_safety_n,
    input  wire             t_speed speed_rpm,
    input  wire             over_speed,
    input  wire             generate_pulse,
    output t_safety_payload fpga_payload
);

//****************************************************************************//

//Variables

t_seq sequence_count = 'd0;

always @(posedge clk or negedge reset_n) begin
    if(reset_n == 1'b0)
        sequence_count <= 'd0;
    else
    begin
        if (reset_safety_n == 1'b0) begin
            sequence_count <= 'd0;
        end else
        if(generate_pulse)
        begin
            //Increment Sequence
            sequence_count <= sequence_count + 1'b1;
        end
    end
end

always @(posedge clk ) begin
    if(generate_pulse)
    begin
        //Increment Sequence
        fpga_payload.overspeed <= over_speed;
        fpga_payload.speed_rpm <= speed_rpm;
        fpga_payload.seq       <= sequence_count;
    end
end

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
