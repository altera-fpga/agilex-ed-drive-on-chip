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
//                         pkg_doc_safety
// Contains the types and functions used for the safe drive-on-chip safety function
//----------------------------------------------------------------------------//

`default_nettype none

//****************************************************************************//
package pkg_doc_safety;
//****************************************************************************//

localparam C_T_SPEED_WIDTH = 25;

typedef logic signed [C_T_SPEED_WIDTH - 1 : 0] t_speed;
typedef logic [5 : 0]  t_seq;

typedef struct {
  logic          overspeed;
  t_speed        speed_rpm;
  t_seq          seq;
} t_safety_payload;

//----------------------------------------------------------------------------//
//                            fcn_t_safety_payload_to_logic
// Convert t_safety_payload to logic arrary
//----------------------------------------------------------------------------//
function logic [31 : 0] fcn_t_safety_payload_to_logic (t_safety_payload payload);
  fcn_t_safety_payload_to_logic = {payload.seq, payload.speed_rpm, payload.overspeed};
endfunction

//----------------------------------------------------------------------------//
//                            fcn_logic_to_t_safety_payload
// Convert logic array to t_safety_payload
//----------------------------------------------------------------------------//
function t_safety_payload fcn_logic_to_t_safety_payload (logic [31 : 0] payload_array);
  t_safety_payload result;
  {result.seq, result.speed_rpm, result.overspeed} = payload_array;
  return result;
endfunction

//----------------------------------------------------------------------------//
//                            fcn_payload_compare
// Compare payloads allowing for speed tolerance
//----------------------------------------------------------------------------//
function logic fcn_payload_compare (t_safety_payload payload0, t_safety_payload payload1, t_speed margin);
  logic result;
  t_speed speed_error;
  result = 1'b1;

  if (payload0.seq != payload1.seq) begin
    result = 1'b0;
  end //if

  speed_error = (payload0.speed_rpm - payload1.speed_rpm);

  if (  (signed'(speed_error) > signed'(margin)) || (signed'(speed_error) < -signed'(margin)) ) begin
    result = 1'b0;
  end //if

  return result;
endfunction

//****************************************************************************//
endpackage : pkg_doc_safety
//****************************************************************************//

`default_nettype wire
