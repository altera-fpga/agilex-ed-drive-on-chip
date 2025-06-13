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
import complimentary_bit::*;

//****************************************************************************//
module esl_comp_inputs # (
//****************************************************************************//
  parameter P_DATA_WIDTH = 7
) (
  input wire                            clk,
  input wire                            reset,
  input wire [P_DATA_WIDTH - 1 : 0]     inputs_p,
  input wire [P_DATA_WIDTH - 1 : 0]     inputs_n,
  output logic [P_DATA_WIDTH - 1 : 0]   values,
  output logic                          fault
);

timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//

//----------------------------------------------------------------------------//
// signal declarations
//----------------------------------------------------------------------------//

compli [P_DATA_WIDTH - 1 : 0] allCompli;
compli [P_DATA_WIDTH - 1 : 0] allCompli_meta;
compli [P_DATA_WIDTH - 1 : 0] allCompli_safe;

//----------------------------------------------------------------------------//

always_comb begin
  for (int i = 0; i < P_DATA_WIDTH; i++) begin
    allCompli [i].p = inputs_p [i];
    allCompli [i].n = inputs_n [i];
  end //for
end // always_comb

always_ff @(posedge clk) begin
  allCompli_meta <= allCompli;
  allCompli_safe <= allCompli_meta;
end //always_ff

always_ff @(posedge clk or negedge reset) begin
  if(~reset)
    fault <= 1'b0;
  else begin
    for (int i = 0; i < P_DATA_WIDTH; i++) begin
      values [i] = pn_check (allCompli_safe [i]);
    end //for
    fault <= ~&values;
  end
end

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
