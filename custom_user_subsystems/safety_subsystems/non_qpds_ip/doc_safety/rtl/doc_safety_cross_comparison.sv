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
//                         doc_safety_cross_comparison
// Cross Comparison FSM to compare the FPGA and HPS payloads via shared memory.
// Synchronicity is maintained with the status bits in the shared memory.
// A watchdog detects if the HPS has not responded in its expected time window.
// Parameters and localparams are capitalized and prefixed with P_ and C_ (constant)
// respectively; _M and _S further denote master and slave interfaces respectively
//----------------------------------------------------------------------------//

`default_nettype none

import pkg_doc_safety::*;
import pkg_doc_safety_cc::*;

//****************************************************************************//
module doc_safety_cross_comparison
//****************************************************************************//
# (
  int     P_M_APB_ADDR_WIDTH    = 4,
  int     P_M_APB_DATA_WIDTH    = 32,
  t_speed P_SPEED_CC_MARGIN_RPM = 130,
  int     P_WATCHDOG_TIMEOUT    = 100_000
) (
  input  wire                                clk,
  input  wire                                reset_n,
  input  wire                                reset_safety_n,
  input  wire                                start,
  input  wire  t_safety_payload              fpga_payload,
  input  wire  t_speed                       speed_cc_margin,
  output logic                               generate_fpga,
  (* preserve *) output logic                compare_good_p,
  (* preserve *) output logic                compare_good_n,
  output logic                               compare_timeout,
  output logic [P_M_APB_ADDR_WIDTH - 1 : 0]  m_apb_paddr,
  output logic                               m_apb_pwrite,
  output logic                               m_apb_psel,
  output logic                               m_apb_penable,
  output logic [P_M_APB_DATA_WIDTH - 1 : 0]  m_apb_pwdata,
  input  wire  [P_M_APB_DATA_WIDTH - 1 : 0]  m_apb_prdata,
  input  wire                                m_apb_pready
);

timeunit 1ns;
timeprecision 1ps;

//****************************************************************************//
(* altera_attribute =  "-name SAFE_STATE_MACHINE ON -to *;  -name PRESERVE_FOR_DEBUG ON -to * " *) t_cross_comparison_fsm cross_comparison_fsm;

logic mem_control_read;
logic mem_control_write;
logic apb_done;

t_safety_payload hps_payload;

logic [19 : 0] watchdog_counter;
logic          watchdog_en;
logic          start_latch;

//----------------------------------------------------------------------------//
// APB signals derived from the FSM
//----------------------------------------------------------------------------//

assign m_apb_psel   = mem_control_read | mem_control_write;
assign m_apb_pwrite = mem_control_write;
assign apb_done     = m_apb_pready & m_apb_psel & m_apb_penable;

always_ff @ (posedge clk, negedge reset_n) begin
  if (reset_n == 1'b0) begin
    m_apb_penable <= 1'b0;
  end else begin
    if (apb_done == 1'b1) begin
      m_apb_penable <= 1'b0;
    end else if (m_apb_psel == 1'b1) begin
      m_apb_penable <= 1'b1;
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------------------//
// Latch the start pulse so that we don't miss it if the FSM is running late
//----------------------------------------------------------------------------//

always_ff @ (posedge clk, negedge reset_n) begin

  if (reset_n == 1'b0) begin
    start_latch <= 1'b0;
  end else begin
    if (start == 1'b1) begin
      start_latch <= 1'b1;
    end else if ((generate_fpga == 1'b1) || (reset_safety_n == 1'b0)) begin
      start_latch <= 1'b0;
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------------------//
// Cross comparison FSM
// See AN999 for a detailed description of the state machine
//----------------------------------------------------------------------------//

always_ff @(posedge clk, negedge reset_n) begin
  if (reset_n == 1'b0) begin
    mem_control_write      <= 1'b0;
    mem_control_read       <= 1'b0;
    hps_payload            <= '{default : '0};
    compare_good_p         <= 1'b1;
    compare_good_n         <= 1'b0;
    watchdog_en            <= 1'b0;
    generate_fpga          <= 1'b0;
    m_apb_paddr            <= 'd0;;
    m_apb_pwdata           <= 'd0;
    cross_comparison_fsm   <= S_INIT;

  end else begin
    case (cross_comparison_fsm)
      S_INIT : begin
        watchdog_en <= 1'b0;
        if (start_latch == 1'b1) begin
          cross_comparison_fsm <= S_PAYLOAD_GENERATING;
          generate_fpga        <= 1'b1;
        end //if
      end // S_INT

      S_PAYLOAD_GENERATING : begin
        // the payload takes one clock cycle to generate
        generate_fpga        <= 1'b0;
        cross_comparison_fsm <= S_WRITING_PAYLOAD;
        watchdog_en          <= 1'b1;
      end //S_PAYLOAD_GENERATING

      S_WRITING_PAYLOAD : begin
        // write the payload to the shared memory
        generate_fpga        <= 1'b0;
        mem_control_write    <= 1'b1;
        mem_control_read     <= 1'b0;
        m_apb_paddr          <= C_FPGA_PAYLOAD_ADDR;
        m_apb_pwdata         <= fcn_t_safety_payload_to_logic (fpga_payload);
        if (apb_done == 1'b1) begin
          mem_control_write      <= 1'b0;
          mem_control_read       <= 1'b0;
          cross_comparison_fsm   <= S_WRITING_STATUS_DATA;
        end //if
      end // S_WRITING_PAYLOAD

      S_WRITING_STATUS_DATA : begin
        // update the FPGA status in the shared memory so that the HPS knows that the
        // FPGA payload is there
        generate_fpga     <= 1'b0;
        mem_control_write <= 1'b1;
        mem_control_read  <= 1'b0;
        m_apb_paddr       <= C_FPGA_STATUS_ADDR;
        m_apb_pwdata      <= 'd0;
        m_apb_pwdata [C_STATUS_DATA_VALID_BIT] <= 1'b1;
        if (apb_done == 1'b1) begin
          mem_control_write    <= 1'b0;
          mem_control_read     <= 1'b0;
          cross_comparison_fsm <= S_WAITING_FOR_HPS_STATUS;
        end //if
      end // S_WRITING_STATUS_DATA

      S_WAITING_FOR_HPS_STATUS : begin
        // Wait until the HPS updates its status to indicate that the HPS payload is
        // in the shared memory
        generate_fpga     <= 1'b0;
        mem_control_write <= 1'b0;
        mem_control_read  <= 1'b1;
        m_apb_paddr       <= C_HPS_STATUS_ADDR;
        if (apb_done == 1'b1) begin
          mem_control_write   <= 1'b0;
          mem_control_read    <= 1'b0;
          if (m_apb_prdata [C_STATUS_DATA_VALID_BIT] == 1'b1) begin
            cross_comparison_fsm <= S_READING_HPS_PAYLOAD;
          end else if (compare_timeout == 1'b1) begin
            cross_comparison_fsm <= S_TIMEOUT;
          end //if
        end //if
      end // S_WAITING_FOR_HPS_STATUS

      S_READING_HPS_PAYLOAD : begin
        generate_fpga     <= 1'b0;
        mem_control_write <= 1'b0;
        mem_control_read  <= 1'b1;
        m_apb_paddr       <= C_HPS_PAYLOAD_ADDR;
        if (apb_done == 1'b1) begin
          mem_control_write      <= 1'b0;
          mem_control_read       <= 1'b0;
          hps_payload            <= fcn_logic_to_t_safety_payload (m_apb_prdata);
          cross_comparison_fsm   <= S_COMPARING;
        end //if
      end // S_READING_HPS_PAYLOAD

      S_COMPARING : begin
        generate_fpga         <= 1'b0;
        mem_control_write     <= 1'b0;
        mem_control_read      <= 1'b0;
        // The cross-comparison margin could be a parameter rather than a software controlled register.
        // compare_good_p        <= fcn_payload_compare  (fpga_payload, hps_payload, P_SPEED_CC_MARGIN_RPM);
        // compare_good_n        <= ~fcn_payload_compare (fpga_payload, hps_payload, P_SPEED_CC_MARGIN_RPM);
        // The cross-comparison margin comes from a software controlled register in this example
        compare_good_p        <= fcn_payload_compare (fpga_payload, hps_payload, speed_cc_margin);
        compare_good_n        <= ~fcn_payload_compare (fpga_payload, hps_payload, speed_cc_margin);
        cross_comparison_fsm  <= S_WRITING_STATUS_DONE;
      end // S_COMPARING

      S_WRITING_STATUS_DONE    : begin
        // Writing FPGA Status done so that the HPS knows the FPGA has completed the cross comparison
        generate_fpga          <= 1'b0;
        mem_control_write      <= 1'b1;
        mem_control_read       <= 1'b0;
        m_apb_paddr            <= C_FPGA_STATUS_ADDR;
        m_apb_pwdata           <= 'd0;

        m_apb_pwdata [C_STATUS_DATA_VALID_BIT]   <= 1'b1;
        m_apb_pwdata [C_STATUS_COMPARE_DONE_BIT] <= 1'b1;

        if (apb_done == 1'b1) begin
          mem_control_write      <= 1'b0;
          mem_control_read       <= 1'b0;
          cross_comparison_fsm   <= S_WAITING_FOR_HPS_DONE;
        end //if
      end // S_WRITING_STATUS_DONE

      S_WAITING_FOR_HPS_DONE : begin
        // Waiting until the HPS updates its status in the shared memory to indicate that the
        // HPS has performed its cross comparison
        generate_fpga     <= 1'b0;
        mem_control_write <= 1'b0;
        mem_control_read  <= 1'b1;
        m_apb_paddr       <= C_HPS_STATUS_ADDR;
        if (apb_done == 1'b1) begin
          mem_control_write      <= 1'b0;
          mem_control_read       <= 1'b0;
          if ( (m_apb_prdata [C_STATUS_DATA_VALID_BIT] == 1'b1) && (m_apb_prdata [C_STATUS_COMPARE_DONE_BIT] == 1'b1) ) begin
            cross_comparison_fsm <= S_CLEARING_HPS_STATUS;
          end else if (compare_timeout == 1'b1) begin
            cross_comparison_fsm <= S_TIMEOUT;
          end //if
        end //if
      end // S_WAITING_FOR_HPS_DONE

      S_CLEARING_HPS_STATUS : begin
        // FPGA clears the HPS status in shared memory and vice versa to maintain synchronicity
        generate_fpga          <= 1'b0;
        mem_control_write      <= 1'b1;
        mem_control_read       <= 1'b0;
        m_apb_paddr            <= C_HPS_STATUS_ADDR;
        m_apb_pwdata           <= 'd0;
        if (apb_done == 1'b1) begin
          mem_control_write      <= 1'b0;
          mem_control_read       <= 1'b0;
          cross_comparison_fsm   <= S_WAITING_FOR_FPGA_CLEAR;
        end //if
      end // S_CLEARING_HPS_STATUS

      S_WAITING_FOR_FPGA_CLEAR : begin
        // Wait until the HPS has cleared the FPGA status in shared memory to maintain synchronicity
        generate_fpga     <= 1'b0;
        mem_control_write <= 1'b0;
        mem_control_read  <= 1'b1;
        m_apb_paddr       <= C_FPGA_STATUS_ADDR;
        if (apb_done == 1'b1) begin
          mem_control_write      <= 1'b0;
          mem_control_read       <= 1'b0;
          if ( (m_apb_prdata [C_STATUS_DATA_VALID_BIT] == 1'b0) && (m_apb_prdata [C_STATUS_COMPARE_DONE_BIT] == 1'b0) ) begin
            cross_comparison_fsm <= S_INIT;
          end else if (compare_timeout == 1'b1) begin
            cross_comparison_fsm <= S_TIMEOUT;
          end //if
        end //if
      end // S_WAITING_FOR_FPGA_CLEAR

      S_TIMEOUT                 : begin
        // If the watchdog expires then the HPS has stopped responding in the expected time.
        // The timeout state is only left when the button is pressed.
        generate_fpga          <= 1'b0;
        mem_control_write      <= 1'b0;
        mem_control_read       <= 1'b0;
        hps_payload            <= '{default : '0};
        compare_good_p         <= 1'b0;
        compare_good_n         <= 1'b1;
        watchdog_en            <= 1'b0;
        if (reset_safety_n == 1'b0) begin
          cross_comparison_fsm <= S_CLEARING_TIMEOUT;
        end //if
      end //

      S_CLEARING_TIMEOUT        : begin
        // Only return to the S_INIT state when the button is released.
        generate_fpga          <= 1'b0;
        mem_control_write      <= 1'b0;
        mem_control_read       <= 1'b0;
        hps_payload            <= '{default : '0};
        compare_good_p         <= 1'b0;
        compare_good_n         <= 1'b1;
        watchdog_en            <= 1'b0;
        if (reset_safety_n == 1'b1) begin
          cross_comparison_fsm <= S_INIT;
        end //if
      end //

      default                  : begin
        generate_fpga          <= 1'b0;
        mem_control_write      <= 1'b0;
        mem_control_read       <= 1'b0;
        hps_payload            <= '{default : '0};
        compare_good_p         <= 1'b0;
        compare_good_n         <= 1'b1;
        watchdog_en            <= 1'b0;
        cross_comparison_fsm   <= S_INIT;
      end //

    endcase

  end //if

end //always_ff

//----------------------------------------------------------------------------//
// run a watchdog timer whenever enabled by the Cross Comparison State Machine
//----------------------------------------------------------------------------//

always_ff @ (posedge clk, negedge reset_n) begin
  if (reset_n == 1'b0) begin
    watchdog_counter <= $size(watchdog_counter)'(P_WATCHDOG_TIMEOUT);
  end else begin
    if (watchdog_en == 1'b0) begin
      watchdog_counter <= $size(watchdog_counter)'(P_WATCHDOG_TIMEOUT);
    end else begin
      watchdog_counter <= watchdog_counter - 1'b1;
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------------------//
// If the watchdog ever reaches zero then alert the FSM so that it can go to
// an error state.
//----------------------------------------------------------------------------//

always_ff @ (posedge clk, negedge reset_n) begin
  if (reset_n == 1'b0) begin
    compare_timeout <= 1'b0;
  end else begin
    if (reset_safety_n == 1'b0) begin
      compare_timeout <= 1'b0;
    end else if ( watchdog_counter == ($size(watchdog_counter)'(0))) begin
      compare_timeout <= 1'b1;
    end //if
  end //if
end //always_ff

//****************************************************************************//
endmodule : doc_safety_cross_comparison
//****************************************************************************//

`default_nettype wire