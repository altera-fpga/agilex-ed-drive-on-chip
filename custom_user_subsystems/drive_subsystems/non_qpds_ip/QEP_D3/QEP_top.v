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

/* ##########################################################################
 * Quadrature encoder interface monitors and decodes the A, B and I signals
 * from a quadrature encoder. The resulting output is a count value representing
 * the position of the motor shaft.
 * ##########################################################################
 */

`default_nettype none

//****************************************************************************//
module QEP_top
//****************************************************************************//
# (
  parameter P_ENABLE_AVMM          = 1,
  parameter P_ENABLE_INDEX_CAPTURE = 0,     // only valid if AVMM is not enabled
  parameter P_ENABLE_INDEX_RESET   = 0,     // only valid if AVMM is not enabled
  parameter P_REVERSE_DIRECTION    = 0,     // only valid if AVMM is not enabled
  parameter P_EN_ENCODER_ERR_IP    = 0,
  parameter P_MAX_COUNT            = 32768, // only valid if AVMM is not enabled
  parameter P_QEP_COUNT_WIDTH      = 0      // 0 => legacy behavior, width is 32 bits and max_count is used
) (
    input  wire        clk,
    input  wire        reset_n,
    input  wire        avs_write_n,
    input  wire        avs_read_n,
    input  wire [3:0]  avs_address,
    input  wire [31:0] avs_writedata,
    output reg  [31:0] avs_readdata,

    input  wire        strobe,
    input  wire        QEP_A,
    input  wire        QEP_B,
    input  wire        QEP_I,
    input  wire        QEP_E,

    output wire [31:0] QEP_count,
    output reg         QEP_error

);

//****************************************************************************//

wire         QEP_Aq;
wire         QEP_Bq;
wire         QEP_Iq;
wire         QEP_Eq;

wire         direction;
wire         index_reset_en;
wire         index_capture_en;
reg  [31:0]  max_count_reg;
wire [31:0]  count_reg;
wire [31:0]  index_capture_reg;
reg          count_load;
reg  [31:0]  avs_writedata_r;

wire         I_posedge;
wire         pulse;
wire         dir;
wire         dir_for_count;
wire         QEP_overpseed;

//----------------------------------------------------------------------------//
//                                AVMM Interface
//----------------------------------------------------------------------------//
generate

  // ----------------------------------------------------------------------//
  if (P_ENABLE_AVMM != 0) begin : GEN_AVMM
  // ----------------------------------------------------------------------//
    reg [31:0]  count_capture_reg;
    reg [2:0]   control_reg;
    reg [1:0]   status_reg;
    reg [1:0]   clear_errors;

    assign direction         = control_reg[0];
    assign index_reset_en    = control_reg[1];
    assign index_capture_en  = control_reg[2];

    always @(posedge clk or negedge reset_n) begin
      if (~reset_n) begin
        count_capture_reg <= 32'd0;
      end else if (strobe) begin
        count_capture_reg <= count_reg;
      end //if
    end //always`

    always @(*) begin
      case (avs_address)
        4'h0:      avs_readdata <= {14'b0, status_reg, 13'b0, control_reg};
        4'h1:      avs_readdata <= count_capture_reg;
        4'h2:      avs_readdata <= max_count_reg;
        4'h3:      avs_readdata <= count_reg;
        4'h4:      avs_readdata <= index_capture_reg;
        4'h5:      avs_readdata <= P_QEP_COUNT_WIDTH;
        default:   avs_readdata <= 32'h0;
      endcase
    end //always

    always @(posedge clk or negedge reset_n) begin
      if (~reset_n) begin
        control_reg     <= 3'b0;
        max_count_reg   <= 32'd16383;
        count_load      <= 1'b0;
        clear_errors    <= 2'b00;
        avs_writedata_r <= 32'd0;
      end else if (~avs_write_n) begin
        case (avs_address)
          4'h0:    begin
            control_reg  <= avs_writedata[2:0];
            clear_errors <= avs_writedata[17:16];
          end
          4'h2:    max_count_reg <= avs_writedata;
          4'h3:    begin
            count_load       <= 1'b1;
            avs_writedata_r  <= avs_writedata;
          end
        endcase
      end else begin
        clear_errors <= 2'b00;
        count_load   <= 1'b0;
        if (I_posedge) begin
          // Clear index capture enable
          control_reg[2] <= 1'b0;
        end //if
      end //if
    end //always

    always @(posedge clk or negedge reset_n) begin
      if (~reset_n) begin
        status_reg <= 2'b00;
      end else begin

        if (clear_errors [0] == 1'b1) begin
          status_reg [0] <= 1'b0;
        end else if (QEP_Eq == 1'b1) begin
          status_reg [0] <= 1'b1;
        end //if

        if (clear_errors [1] == 1'b1) begin
          status_reg [1] <= 1'b0;
        end else if (QEP_overpseed == 1'b1) begin
          status_reg [1] <= 1'b1;
        end //if

      end //if
    end //always

  // ----------------------------------------------------------------------//
  end else begin : GEN_NO_AVMM
  // ----------------------------------------------------------------------//
    assign direction         = P_REVERSE_DIRECTION;
    assign index_reset_en    = P_ENABLE_INDEX_RESET;
    assign index_capture_en  = P_ENABLE_INDEX_CAPTURE;

    always @(*) begin
      max_count_reg     = P_MAX_COUNT;
      count_load        = 1'b0;
      avs_writedata_r   = 32'd0;
    end // always


  end //if GEN_AVMM / GEN_NO_AVMM

endgenerate
//----------------------------------------------------------------------------//

debounce  QA_sig
(
    .clk          (clk),
    .reset        (~reset_n),
    .QEPsignal    (QEP_A),
    .QEPqualified (QEP_Aq)
);

debounce  QB_sig
(
    .clk          (clk),
    .reset        (~reset_n),
    .QEPsignal    (QEP_B),
    .QEPqualified (QEP_Bq)
);

debounce  QI_sig
(
    .clk          (clk),
    .reset        (~reset_n),
    .QEPsignal    (QEP_I),
    .QEPqualified (QEP_Iq)
);

generate

  // ----------------------------------------------------------------------//
  if (P_EN_ENCODER_ERR_IP == 0) begin : GEN_NO_ENC_ERR_IP
  // ----------------------------------------------------------------------//

    assign QEP_Eq = 1'b0;

  // ----------------------------------------------------------------------//
  end else begin : GEN_ENC_ERR_IP
  // ----------------------------------------------------------------------//

    debounce  QE_sig
    (
      .clk          (clk),
      .reset        (~reset_n),
      .QEPsignal    (QEP_E),
      .QEPqualified (QEP_Eq)
    );

  end //if
  // ----------------------------------------------------------------------//

endgenerate

QEPdecoder  inst_dec
(
    .clk          (clk),
    .reset        (~reset_n),
    .A            (QEP_Aq),
    .B            (QEP_Bq),
    .pulse        (pulse),
    .dir          (dir),
  .QEP_overpseed(QEP_overpseed)
);

assign dir_for_count = (direction == 1'b0 ? dir : ~dir);

QEPcounter #(
  .P_QEP_COUNT_WIDTH (P_QEP_COUNT_WIDTH)
) inst_cnt (
    .clk              (clk),
    .reset            (~reset_n),
    .pulse            (pulse),
    .dir              (dir_for_count),
    .index            (QEP_Iq),
    .count_load       (count_load),
    .load_value       (avs_writedata_r),
    .index_reset_en   (index_reset_en),
    .index_capture_en (index_capture_en),
    .max_count        (max_count_reg),
    .index_capture_reg(index_capture_reg),

    .count            (count_reg),
    .I_posedge        (I_posedge)
);

always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    QEP_error <= 1'b0;
  end else begin
    QEP_error <= QEP_Eq | QEP_overpseed;
  end //if
end //always`

assign QEP_count = count_reg;

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
