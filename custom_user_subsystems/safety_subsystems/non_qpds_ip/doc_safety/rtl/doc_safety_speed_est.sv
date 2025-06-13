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
//                         doc_safety_speed_est
// The speed estimator samples the encoder counts periodically to calculate the

// speed of the motor. The over-speed threshold can be set via the APB interface.
// APB also allows the quadrature error and over-speed status to be read.
// The cross comparison speed margin is also set from this APB interface.
//----------------------------------------------------------------------------//

`default_nettype none

import pkg_doc_safety::*;

//****************************************************************************//
module doc_safety_speed_est #(
//****************************************************************************//
  int     SPEED_THRESHOLD_RPM_DEFAULT = 1500,
  int     S_APB_ADDR_WIDTH            = 5,
  int     S_APB_DATA_WIDTH            = 32,
  int     P_QEP_COUNT_WIDTH           = 13,
  t_speed P_SPEED_CC_MARGIN_RPM       = 130,
  int     P_CLK_FREQ_HZ               = 100_000_000
) (
  input   wire                             clk,
  input   wire                             reset_n,
  input   wire  [31:0]                     qep_count,
  input   wire                             qep_error,
  output  logic                            over_speed,
  output  logic                            led_signal,
  output  t_speed                          motor_speed_filtered,
  output  t_speed                          speed_cc_margin,

  (* preserve *) output logic              quad_error_p,
  (* preserve *) output logic              quad_error_n,
  (* preserve *) output logic              fpga_is_safe_p,
  (* preserve *) output logic              fpga_is_safe_n,

  //APB
  input   wire   [S_APB_ADDR_WIDTH - 1 : 0] s_apb_paddr,
  input   wire                              s_apb_pwrite,
  input   wire                              s_apb_psel,
  input   wire                              s_apb_penable,
  input   wire   [S_APB_DATA_WIDTH - 1 : 0] s_apb_pwdata,
  output  logic  [S_APB_DATA_WIDTH - 1 : 0] s_apb_prdata,
  output  logic                             s_apb_pready
);

//****************************************************************************//
localparam [4 : 0]  C_SPEED_FRAC_BITS  = 4;   // Number of Fractional bits
localparam [11 : 0] C_PLATFORM_RATE    = 4;   // Platform sampling frequency = 4kHz
localparam [11 : 0] C_MULTIPLIER       = 117; // Multiplier for speed calculation
// C_MULTIPLIER is calculated by 60 (for RPM) * 2^C_SPEED_FRAC_BITS * 1000 
// (for sampling units of kHz) / 2^13 (13 bit encoder resolution)

localparam [S_APB_ADDR_WIDTH - 1 : 0] C_CONTROL_ADDR           = 'h00;
localparam [S_APB_ADDR_WIDTH - 1 : 0] C_BASE_FREQ_ADDR         = 'h04;
localparam [S_APB_ADDR_WIDTH - 1 : 0] C_SAMPLING_FREQ_ADDR     = 'h08;
localparam [S_APB_ADDR_WIDTH - 1 : 0] C_SPEED_THRESHOLD_ADDR   = 'h0C;
localparam [S_APB_ADDR_WIDTH - 1 : 0] C_STATUS_ADDR            = 'h10;
localparam [S_APB_ADDR_WIDTH - 1 : 0] C_SPEED_CC_MARGIN_ADDR   = 'h14;

localparam C_STATUS_OVERSPEED_BIT   = 0;
localparam C_STATUS_QEP_ERROR_BIT   = 1;
localparam C_SAMPLE_COUNTER_WIDTH   = 16;

localparam C_SAMP_FREQ_4_KHZ   = 4000;
localparam C_SAMP_FREQ_8_KHZ   = 8000;
localparam C_SAMP_FREQ_16_KHZ  = 16000;
localparam C_SAMP_FREQ_32_KHZ  = 32000;
localparam C_SAMP_FREQ_64_KHZ  = 64000;
localparam C_SAMP_FREQ_96_KHZ  = 96000;
localparam C_SAMP_FREQ_128_KHZ = 128000;

logic        sampling_freq_enable;                      // Enable signal to generate 4kHz clock

logic [P_QEP_COUNT_WIDTH - 1 : 0]      encoder_raw;     // 12-bit readings from QEP IP
logic [P_QEP_COUNT_WIDTH - 1 : 0]      encoder_prev;    // Previous QEP IP reading
logic [P_QEP_COUNT_WIDTH - 1 : 0]      delta_phi;       // Position difference
logic [P_QEP_COUNT_WIDTH - 1 : 0]      delta_phi_abs;
// Count value to generate XkHz clock
logic [C_SAMPLE_COUNTER_WIDTH - 1 : 0] count_limit = P_CLK_FREQ_HZ / C_SAMP_FREQ_4_KHZ - 1;
logic [C_SAMPLE_COUNTER_WIDTH - 1 : 0] counter;

// speed value without fractional bits scaling (i.e. this variable has integer plus fractional bits)
logic [31:0] speed_rpm_frac;
logic [31:0] speed_threshold;
logic [31:0] motor_speed_rpm;                           //shifted speed
logic [1:0]  comp_speed_en = 'd0;


//for filter
logic [31:0] filter_spd_current = 0;
logic [31:0] filter_spd_prev = 0;
// speed multiplied by two (i.e. shifted right by 1 bit with sign extension)
logic [31:0] filter_spd_prev_mult2;
logic [1 : 0] speed_est_status;

logic overspeed_status_reset;
logic qep_error_status_reset;

logic [7:0] sampling_freq_req_freq; //In kHz

//---------------------------------------------------------------
// APB Setup
//---------------------------------------------------------------

always_ff @(posedge clk or negedge reset_n) begin
  if (reset_n == 1'b0) begin
    overspeed_status_reset <= 1'b0;
    qep_error_status_reset <= 1'b0;
  end else begin
    if ((s_apb_pwrite == 1'b1) && (s_apb_penable == 1'b1) && (s_apb_psel == 1'b1)
                && (s_apb_paddr == C_CONTROL_ADDR)) begin
      overspeed_status_reset <= s_apb_pwdata [C_STATUS_OVERSPEED_BIT];
      qep_error_status_reset <= s_apb_pwdata [C_STATUS_QEP_ERROR_BIT];
    end else begin
      overspeed_status_reset <= 1'b0;
      qep_error_status_reset <= 1'b0;
    end
  end // if
end // always_ff

always_ff @(posedge clk or negedge reset_n) begin
  if (reset_n == 1'b0) begin
    fpga_is_safe_p <= 1'b1;
    fpga_is_safe_n <= 1'b0;
  end else begin
    if (over_speed == 1'b1) begin
      fpga_is_safe_p <= 1'b0;
      fpga_is_safe_n <= 1'b1;
    end else if (overspeed_status_reset == 1'b1) begin
      fpga_is_safe_p <= 1'b1;
      fpga_is_safe_n <= 1'b0;
    end //if
  end // if
end //always_ff

always_ff @(posedge clk or negedge reset_n) begin
  if (reset_n == 1'b0) begin
    quad_error_p <= 1'b0;
    quad_error_n <= 1'b1;
  end else begin
    if (qep_error == 1'b1) begin
      quad_error_p <= 1'b1;
      quad_error_n <= 1'b0;
    end else if (qep_error_status_reset == 1'b1) begin
      quad_error_p <= 1'b0;
      quad_error_n <= 1'b1;
    end //if
  end // if
end //always_ff

assign speed_est_status [C_STATUS_QEP_ERROR_BIT] = quad_error_p;
assign speed_est_status [C_STATUS_OVERSPEED_BIT] = fpga_is_safe_n;

//----------------------------------------------------------------------------//
// APB - Read registers
//----------------------------------------------------------------------------//
always_ff @(posedge clk or negedge reset_n) begin
  if(reset_n == 1'b0) begin
    s_apb_prdata <= 'd0;
  end else begin
    if (  (s_apb_pwrite == 1'b0) && (s_apb_psel == 1'b1) ) begin
      s_apb_prdata <= 'd0;
      case (s_apb_paddr)
        C_BASE_FREQ_ADDR        : s_apb_prdata <= $size(s_apb_prdata)'($unsigned(P_CLK_FREQ_HZ));
        C_SAMPLING_FREQ_ADDR    : s_apb_prdata [$left(sampling_freq_req_freq) : 0] <= sampling_freq_req_freq;
        C_SPEED_THRESHOLD_ADDR  : s_apb_prdata [$left(speed_threshold) : 0]        <= speed_threshold;
        C_STATUS_ADDR           : s_apb_prdata [$left(speed_est_status) : 0]       <= speed_est_status;
        C_SPEED_CC_MARGIN_ADDR  : s_apb_prdata [C_T_SPEED_WIDTH - 1 : 0]           <= speed_cc_margin;
        default                 : s_apb_prdata <= 'd0;
      endcase
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------------------//
// APB - Write registers
//----------------------------------------------------------------------------//
always_ff @(posedge clk or negedge reset_n) begin
  if(reset_n == 1'b0) begin
    sampling_freq_req_freq <= 'd4;
  end else begin
    if ((s_apb_pwrite == 1'b1) && (s_apb_penable == 1'b1) && (s_apb_psel == 1'b1)
                && (s_apb_paddr == C_SAMPLING_FREQ_ADDR)  ) begin
      sampling_freq_req_freq <= s_apb_pwdata[$left(sampling_freq_req_freq) : 0];
    end //if
  end //if
end //always_ff

always_ff @(posedge clk or negedge reset_n) begin
  if(reset_n == 1'b0) begin
    speed_threshold <= SPEED_THRESHOLD_RPM_DEFAULT <<< C_SPEED_FRAC_BITS;
  end else begin
    if ((s_apb_pwrite == 1'b1) && (s_apb_penable == 1'b1) && (s_apb_psel == 1'b1)
                && (s_apb_paddr == C_SPEED_THRESHOLD_ADDR)  ) begin
      speed_threshold <= s_apb_pwdata[$left(speed_threshold)        : 0];
    end //if
  end //if
end //always_ff

always_ff @(posedge clk or negedge reset_n) begin
  if(reset_n == 1'b0) begin
    speed_cc_margin <= P_SPEED_CC_MARGIN_RPM;
  end else begin
    if ((s_apb_pwrite == 1'b1) && (s_apb_penable == 1'b1) && (s_apb_psel == 1'b1)
                && (s_apb_paddr == C_SPEED_CC_MARGIN_ADDR)  ) begin
      speed_cc_margin <= s_apb_pwdata[C_T_SPEED_WIDTH - 1 : 0];
    end //if
  end //if
end //if

//----------------------------------------------------------------------------//
// drive the APB's pready to complete the transaction
assign s_apb_pready = s_apb_penable & s_apb_psel;
//----------------------------------------------------------------------------//

//---------------------------------------------------------------
// Generating Count Limit for Sample Rate. The number of clock cycles per
// sampling interval is calculated from the actual clock frequency in Hz
// (P_CLK_FREQ_HZ), which is updated by Platform Designer, and the required
// sampling frequency in kHZ.
//---------------------------------------------------------------
always_ff @(posedge clk or negedge reset_n) begin
  if (reset_n == 1'b0) begin
    count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_4_KHZ - 1;
  end else begin

    case (sampling_freq_req_freq) // Required Clk
      4:
        count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_4_KHZ - 1;
      16:
        count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_16_KHZ - 1;
      32:
        count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_32_KHZ - 1;
      64:
        count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_64_KHZ - 1;
      96:
        count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_96_KHZ - 1;
      128:
        count_limit <= P_CLK_FREQ_HZ / C_SAMP_FREQ_128_KHZ - 1;
    endcase
  end //if
end //always_ff

//---------------------------------------------------------------
// Generating clock enable at the sampling frequency
//---------------------------------------------------------------
always_ff @(posedge clk or negedge reset_n)
begin
  if(reset_n == 1'b0) begin
    sampling_freq_enable <= 1'b0;
    counter              <= 'd0;
  end else begin
    counter <= counter + 1'b1;
    if(counter >= count_limit) begin
      sampling_freq_enable <= 1'b1;
      counter              <= 'd0;
    end else begin
      sampling_freq_enable <= 1'b0;
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------
// Sampling the QEP IP driven by the sampling clock enable (default 4 kHz)
//----------------------------------------------------------------
always_ff @(posedge clk or negedge reset_n)
begin
  if(reset_n == 1'b0) begin
    encoder_raw      <= 'd0;
    encoder_prev     <= 'd0;
    filter_spd_prev  <= 'd0;
    comp_speed_en    <= 2'b0;
  end else begin
    if (sampling_freq_enable == 1'b1) begin
      // the upper bit of comp_speed_en is used to enable the speed estimation
      // calculation below. This is so that the speed calulation is not performed
      // until both the current / raw and previous encoder counts are valid
      // (i.e. the second sample after reset release)
      comp_speed_en    <= {comp_speed_en[0], 1'b1};
      encoder_raw      <= qep_count [P_QEP_COUNT_WIDTH - 1 : 0];
      encoder_prev     <= encoder_raw;
      filter_spd_prev  <= filter_spd_current;
    end //if
  end //if
end //always_ff

//----------------------------------------------------------------

assign filter_spd_prev_mult2 = filter_spd_prev <<< 1;
assign motor_speed_rpm       = speed_rpm_frac >>> C_SPEED_FRAC_BITS;

//----------------------------------------------------------------
//Speed Estimation Calculation
//----------------------------------------------------------------
always_ff @(posedge clk or negedge reset_n)
begin
  if(reset_n == 1'b0) begin
    speed_rpm_frac     <= 'd0;
    over_speed         <= 1'b0;
    delta_phi          <= 'd0;
    delta_phi_abs      <= 'd0;
    filter_spd_current <= 'd0;
    led_signal         <= 1'b1; //led off (1) at reset
  end else begin
    if (comp_speed_en[1] == 1'b1) begin
      delta_phi <= encoder_raw - encoder_prev;
      if (delta_phi[$left(delta_phi)] == 1'b1) begin
          delta_phi_abs = -delta_phi;
      end else begin
          delta_phi_abs = delta_phi;
      end //if
      speed_rpm_frac     <= delta_phi_abs * C_PLATFORM_RATE * C_MULTIPLIER;
      filter_spd_current <= (motor_speed_rpm + filter_spd_prev_mult2 + filter_spd_prev) >>> 2;
    end //if

    if((speed_rpm_frac < 0) || (speed_rpm_frac >= speed_threshold)) begin
      over_speed <= 1'b1;
    end else begin
      over_speed <= 1'b0;
    end // if
    led_signal <= ~over_speed; //LED active LOW (0 = ON, 1 = OFF). LED should light up when over_speed is high.
  end //if
end //always_ff

assign motor_speed_filtered = filter_spd_current [$size(motor_speed_filtered) - 1 : 0];

endmodule

`default_nettype wire
