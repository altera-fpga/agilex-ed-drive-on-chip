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
module hw_avmm_fsm
//****************************************************************************//
# (

) (
  input  wire           clk,
  input  wire           reset,

  input  wire           do_read,
  input  wire           do_write,
  input  wire  [3 : 0]  address,
  input  wire  [31 : 0] data_wr,
  output logic          ready,
  output logic [31 : 0] data_rd,

  output logic [3 : 0]  avmm_address,
  output logic          avmm_write,
  output logic [31 : 0] avmm_writedata,
  output logic          avmm_read,
  input  wire  [31 : 0] avmm_readdata,
  input  wire           avmm_readdatavalid,
  input  wire           avmm_waitrequest
);

timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//

typedef enum
{
    S_IDLE,
    S_IDLE_WAITING,
    S_STARTING_WRITE,
    S_STARTING_READ,
    S_WAITING_READ,
    S_FINISHING_READ,
    S_WAITING_WRITE
} t_avmm_fsm;

t_avmm_fsm avmm_fsm;

//----------------------------------------------------------------------------//
always_ff @(posedge clk) begin
  if (reset == 1'b1) begin
    avmm_fsm       <= S_IDLE_WAITING;
    avmm_address   <= 'd0;
    avmm_write     <= 1'b0;
    avmm_writedata <= 'd0;
    avmm_read      <= 1'b0;
    ready          <= 1'b0;

  end else begin
    case (avmm_fsm)
      S_IDLE : begin
        if (avmm_waitrequest == 1'b1) begin
          avmm_fsm <= S_IDLE_WAITING;
          ready    <= 1'b0;
        end else if (do_read == 1'b1) begin
          avmm_fsm <= S_STARTING_READ;
          avmm_address   <= address;
          avmm_write     <= 1'b0;
          avmm_writedata <= 'd0;
          avmm_read      <= 1'b1;
          ready          <= 1'b0;
        end else if (do_write == 1'b1) begin
          avmm_fsm <= S_STARTING_WRITE;
          avmm_address   <= address;
          avmm_write     <= 1'b1;
          avmm_writedata <= data_wr;
          avmm_read      <= 1'b0;
          ready          <= 1'b0;
        end //if
      end //S_IDLE

      S_IDLE_WAITING : begin
        ready <= 1'b0;
        if (avmm_waitrequest == 1'b0) begin
          avmm_fsm <= S_IDLE;
          ready    <= 1'b1;
        end //if
      end //S_IDLE_WAITING

      S_STARTING_WRITE : begin
        if (avmm_waitrequest == 1'b1) begin
          avmm_fsm <= S_WAITING_WRITE;
        end else begin
          avmm_fsm       <= S_IDLE;
          avmm_address   <= 'd0;
          avmm_write     <= 1'b0;
          avmm_writedata <= 'd0;
          avmm_read      <= 1'b0;
          ready          <= 1'b1;
        end //if
      end //S_STARTING_WRITE

      S_STARTING_READ : begin
        if (avmm_waitrequest == 1'b1) begin
          avmm_fsm <= S_WAITING_READ;
        end else begin
          avmm_fsm       <= S_FINISHING_READ;
          avmm_read      <= 1'b0;
        end //if
      end //S_STARTING_READ

      S_WAITING_READ : begin
        if (avmm_readdatavalid == 1'b1) begin
          data_rd <= avmm_readdata;
        end //if
        if (avmm_waitrequest == 1'b0) begin
          avmm_fsm       <= S_FINISHING_READ;
          avmm_read      <= 1'b0;
        end //if
      end //S_WAITING_READ

      S_FINISHING_READ : begin
        if (avmm_readdatavalid == 1'b1) begin
          data_rd <= avmm_readdata;
          avmm_fsm       <= S_IDLE;
          avmm_address   <= 'd0;
          avmm_write     <= 1'b0;
          avmm_writedata <= 'd0;
          avmm_read      <= 1'b0;
          ready          <= 1'b1;
        end //if
      end //S_FINISHING_READ

      S_WAITING_WRITE : begin
        if (avmm_waitrequest == 1'b0) begin
          avmm_fsm       <= S_IDLE;
          avmm_address   <= 'd0;
          avmm_write     <= 1'b0;
          avmm_writedata <= 'd0;
          avmm_read      <= 1'b0;
          ready          <= 1'b1;
        end //if
      end //S_WAITING_WRITE

      default : begin
      end //default

    endcase
  end //if

end //always_ff

//****************************************************************************//
endmodule : hw_avmm_fsm
//****************************************************************************//

`default_nettype wire
