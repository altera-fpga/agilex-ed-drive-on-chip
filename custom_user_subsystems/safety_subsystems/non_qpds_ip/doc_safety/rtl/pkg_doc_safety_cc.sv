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
//                         pkg_doc_safety_cc
// Contains the FSM type and addressing constants for the shared memory which are
// required by the FSM
//----------------------------------------------------------------------------//

`default_nettype none

//****************************************************************************//
package pkg_doc_safety_cc;
//****************************************************************************//

typedef enum {
  S_INIT,
  S_PAYLOAD_GENERATING,
  S_WRITING_PAYLOAD,
  S_WRITING_STATUS_DATA,
  S_WAITING_FOR_HPS_STATUS,
  S_READING_HPS_PAYLOAD,
  S_COMPARING,
  S_WRITING_STATUS_DONE,
  S_WAITING_FOR_HPS_DONE,
  S_CLEARING_HPS_STATUS,
  S_WAITING_FOR_FPGA_CLEAR,
  S_CLEARING_TIMEOUT,
  S_TIMEOUT
} t_cross_comparison_fsm;

localparam C_FPGA_PAYLOAD_ADDR = 4'h0;
localparam C_FPGA_STATUS_ADDR  = 4'h4;
localparam C_HPS_PAYLOAD_ADDR  = 4'h8;
localparam C_HPS_STATUS_ADDR   = 4'hC;

localparam C_STATUS_DATA_VALID_BIT = 0;
localparam C_STATUS_COMPARE_DONE_BIT = 1;

//****************************************************************************//
endpackage : pkg_doc_safety_cc
//****************************************************************************//

`default_nettype wire
