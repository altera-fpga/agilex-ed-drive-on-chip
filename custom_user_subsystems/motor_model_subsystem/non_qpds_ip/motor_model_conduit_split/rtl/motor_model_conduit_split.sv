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
// Conduit to connect the motor model signals to the higher level.
module motor_model_conduit_split
//****************************************************************************//
# (
  bit P_EN_POWERDOWN = 1'b0
) (

  // Combined conduit down to motor model
  input  wire           clk,
  output logic          o_u_h,
  output logic          o_v_h,
  output logic          o_w_h,
  output logic          o_u_l,
  output logic          o_v_l,
  output logic          o_w_l,
  output logic          o_powerdown_p,
  output logic          o_powerdown_n,
  input  wire           i_ia_sd,
  input  wire           i_ib_sd,
  input  wire           i_ic_sd,
  input  wire           i_Va_sd,
  input  wire           i_Vb_sd,
  input  wire           i_Vc_sd,
  input  wire           i_QEP_A,
  input  wire           i_QEP_B,
  input  wire  [15 : 0] i_Theta_one_turn_k,
  input  wire           i_V_DC_link_sd,

  // conduit from motor model to higher level
  input  wire           i_u_h,
  input  wire           i_v_h,
  input  wire           i_w_h,
  input  wire           i_u_l,
  input  wire           i_v_l,
  input  wire           i_w_l,
  output logic          o_ia_sd,
  output logic          o_ib_sd,
  output logic          o_ic_sd,
  output logic          o_Va_sd,
  output logic          o_Vb_sd,
  output logic          o_Vc_sd,
  output logic          o_QEP_A,
  output logic          o_QEP_B,
  output logic [15 : 0] o_Theta_one_turn_k,
  output logic          o_V_DC_link_sd,

  // conduit from motor model to higher level safety function
  input  wire           i_powerdown_esl_p,
  input  wire           i_powerdown_esl_n,
  input  wire           i_powerdown_fpga_p,
  input  wire           i_powerdown_fpga_n,
  input  wire           i_powerdown_hps_p,
  input  wire           i_powerdown_hps_n

);

timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//

//----------------------------------------------------------------------------//

generate
  if (P_EN_POWERDOWN == 0) begin : GEN_POWERDOWN_TIE_OFF

    assign o_powerdown_p = 1'b0;
    assign o_powerdown_n = 1'b1;

  end else begin

    logic [2 : 0] powerdown_p;
    logic [2 : 0] powerdown_p_meta;
    logic [2 : 0] powerdown_p_safe;
    logic [2 : 0] powerdown_n;
    logic [2 : 0] powerdown_n_meta;
    logic [2 : 0] powerdown_n_safe;

    assign powerdown_p [0] = i_powerdown_esl_p;
    assign powerdown_n [0] = i_powerdown_esl_n;

    assign powerdown_p [1] = i_powerdown_fpga_p;
    assign powerdown_n [1] = i_powerdown_fpga_n;

    assign powerdown_p [2] = i_powerdown_hps_p;
    assign powerdown_n [2] = i_powerdown_hps_n;

    always_ff @ (posedge clk) begin
      powerdown_p_meta <= powerdown_p;
      powerdown_p_safe <= powerdown_p_meta;

      powerdown_n_meta <= powerdown_n;
      powerdown_n_safe <= powerdown_n_meta;
    end //always_ff

    assign o_powerdown_p = &powerdown_p_safe;
    assign o_powerdown_n = |powerdown_n_safe;

  end

endgenerate

assign o_u_h                 = i_u_h;
assign o_v_h                 = i_v_h;
assign o_w_h                 = i_w_h;
assign o_u_l                 = i_u_l;
assign o_v_l                 = i_v_l;
assign o_w_l                 = i_w_l;
assign o_ia_sd               = i_ia_sd;
assign o_ib_sd               = i_ib_sd;
assign o_ic_sd               = i_ic_sd;
assign o_Va_sd               = i_Va_sd;
assign o_Vb_sd               = i_Vb_sd;
assign o_Vc_sd               = i_Vc_sd;
assign o_QEP_A               = i_QEP_A;
assign o_QEP_B               = i_QEP_B;
assign o_Theta_one_turn_k    = i_Theta_one_turn_k;
assign o_V_DC_link_sd        = i_V_DC_link_sd;


//****************************************************************************//
endmodule : motor_model_conduit_split
//****************************************************************************//

`default_nettype wire