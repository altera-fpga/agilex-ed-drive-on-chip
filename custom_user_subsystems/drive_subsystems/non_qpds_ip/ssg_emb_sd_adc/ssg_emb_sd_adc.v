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

/* ##########################################################################
 *  The Drive-On-Chip Reference Design sigma-delta ADC interface samples the 20-MHz
 * 1-bit ADC serial input for 3 inputs. A decimating sinc3 filter in the FPGA then low-pass
 * filters the serial input. The sinc3 filter does not require hardware multipliers.
 * ##########################################################################
 */

// 1.2  Move over current detection to adc clock domain to avoid clock crossing problems
//      Add capture registers for over current detection
// 1.3  Synchronize control reg bits
//      Tidy up some synthesis warnings
// 1.4 Use shorter counter value when decimation rate is set to lower value so that
//     conversion time is reduced
// 1.5  Add third motor phase and enable bit for over current detection to allow
//      for checking 2 or 3 phases
// 1.6 Reduce the conversion time from 20us(128 clock cycles per measurement) and
//     10us(64 clock cycles per measurement) to 10us(64 clock cycles per measurement)
//     and 5us(32 clock cycles per measurement), this is for high speed mode.


//                      Resolution      Clock cycles per measurement
//  Sinc3_filter_20us   Signed [15:0]   128
//  Sinc3_filter_10us   Signed [12:0]   64
//  Sinc3_filter_5us    Signed [9:0]    32
//  Sinc3_filter_2.5us  Signed [6:0]    16


`timescale 1ns/1ns

`default_nettype none

//****************************************************************************//
module ssg_emb_sd_adc
//****************************************************************************//
(
    input wire          clk,
    input wire          clk_adc,
    input wire          reset_n,
    input wire          reset_adc_n,    // System reset - clk_adc domain

    // Avalon-MM in system clk domain
    input wire          avs_write_n,
    input wire          avs_read_n,
    input wire [3:0]    avs_address,
    input wire [31:0]   avs_writedata,
    output reg [31:0]   avs_readdata,
    output wire         avs_irq,

    // ADC inputs in clk_adc domain
    input wire          sync_dat_u,
    input wire          sync_dat_v,
    input wire          sync_dat_w,

    // Start conversion pulse in system clk domain
    input wire          start,          // was cnr128_reset

    output reg[15:0]    Iu_reg,         //dec_rate = 0: conversion time 10us; dec_rate = 1: conversion time 5us
    output reg[15:0]    Iw_reg,         //dec_rate = 0: conversion time 10us; dec_rate = 1: conversion time 5us

    output reg[15:0]    Iu_reg_156,     //conversion time 20us;
    output reg[15:0]    Iw_reg_156,     //conversion time 20us;

    // status output in system clk domain
    output reg          overcurrent
);
//****************************************************************************//

reg [15:0]  offset_u_reg;
reg [15:0]  offset_u_reg_src;
reg [15:0]  offset_u_reg_adc;
reg [15:0]  offset_v_reg;
reg [15:0]  offset_v_reg_src;
reg [15:0]  offset_v_reg_adc;
reg [15:0]  offset_w_reg;
reg [15:0]  offset_w_reg_src;
reg [15:0]  offset_w_reg_adc;
reg [9:0]   i_peak_reg;
reg [9:0]   i_peak_reg_src;
reg [9:0]   i_peak_reg_adc;
reg [3:0]   control_reg;
reg [3:0]   control_reg_src;
reg [3:0]   control_reg_adc;
reg [2:0]   set_irq_counter_reg;
reg [2:0]   set_irq_counter_reg_src;
reg [2:0]   set_irq_counter_reg_adc;

wire chk_3_ph;          // Check all 3 current phases
wire dec_rate;          // Decimation rate
wire overcurrent_error;
wire overvolt_en;

wire irq_ack;

reg conv_done_u;
reg conv_done_v;
reg conv_done_w;
reg overcurrent_u;
reg overcurrent_v;
reg overcurrent_w;

// Sample64_x_r are sourced from clk_adc clock domain but we do not read them until the IRQ
// is being serviced, by which time they are stable.
reg [15:0] sample64_w_r;
reg [15:0] sample64_v_r;
reg [15:0] sample64_u_r;
reg [9:0] oc_capture_u;
reg [9:0] oc_capture_v;
reg [9:0] oc_capture_w;

wire latch_u;
wire latch_v;
wire latch_w;
reg  latch_u_sync;
reg  latch_v_sync;
reg  latch_w_sync;
reg  latch_u_sync2;
reg  latch_v_sync2;
reg  latch_w_sync2;

wire irq_u;
wire irq_v;
wire irq_w;
reg  irq_u_sync;
reg  irq_v_sync;
reg  irq_w_sync;
reg  irq_u_sync2;
reg  irq_v_sync2;
reg  irq_w_sync2;

reg  [8:0] counter;
reg cnr128;
wire [21:0] cn_out_u;
wire [21:0] cn_out_u_direct;
wire cnr16_u;
wire cnr64_u;

wire [21:0] cn_out_v;
wire cnr16_v;
wire cnr64_v;
wire [21:0] cn_out_w;
wire [21:0] cn_out_w_direct;
wire cnr16_w;
wire cnr64_w;
wire [15:0] sample64_w;
wire [15:0] sample64_v;
wire [15:0] sample64_u;
wire [15:0] sample128_u_direct;
wire [15:0] sample128_w_direct;

wire [9:0] sample16_u;
wire [9:0] sample16_v;
wire [9:0] sample16_w;
reg  cnr128_d1,  cnr128_d2,  cnr128_d3,  cnr128_d4;
reg  [15:0] sample128_u_direct_r;
reg  [15:0] sample128_w_direct_r;
wire sample_valid;
reg  sample_valid_syn1;
reg  sample_valid_syn2;
reg  [9:0] sample16_u_abs;
reg  [9:0] sample16_v_abs;
reg  [9:0] sample16_w_abs;
reg  overcurrent_u_r, overcurrent_v_r, overcurrent_w_r;
reg  overcurrent_x;
reg  overcurrent_xx;

reg req_toggle        = 1'b1;
reg ack_toggle_meta   = 1'b0;
reg ack_toggle_safe   = 1'b0;
reg ack_toggle_safe_d = 1'b0;
reg ack_pulse         = 1'b0;
wire in_data_en;

reg ack_toggle        = 1'b0;
reg req_toggle_meta   = 1'b1;
reg req_toggle_safe   = 1'b1;
reg req_toggle_safe_d = 1'b0;
wire out_data_en;

//----------------------------------------------------------------------------//
//
// Avalon register interface
//
// Registers are written in clk domain but used in clk_adc domain.
// Control bits are explicitly synchronized.
// Other registers are assumed to be setup by software in advance of the PWM/ADC being enabled
// and any conversions being made. Values will be stable and there is no need for any further
// synchronization. timing constraints will be used to flag these false paths.
//
//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        offset_u_reg        <= 16'b0;
        offset_v_reg        <= 16'b0;
        offset_w_reg        <= 16'b0;
        i_peak_reg          <= 10'b0;
        control_reg         <= 4'b0;
        set_irq_counter_reg <= 3'b0;
    end
    else if (~avs_write_n)
    begin
        case (avs_address)
            4'h1:   offset_u_reg        <= avs_writedata[15:0];
            4'h2:   offset_w_reg        <= avs_writedata[15:0];
            4'h3:   i_peak_reg          <= avs_writedata[9:0];
            4'h4:   control_reg         <= avs_writedata[3:0];
            4'hb:   offset_v_reg        <= avs_writedata[15:0];
            4'hf:   set_irq_counter_reg <= avs_writedata[2:0];
        endcase
    end
//----------------------------------------------------------------------------//
always @(*)
    case (avs_address)
        4'h1:   avs_readdata <= {16'b0, offset_u_reg};
        4'h2:   avs_readdata <= {16'b0, offset_w_reg};
        4'h3:   avs_readdata <= {12'b0, i_peak_reg};
        4'h4:   avs_readdata <= {28'b0, control_reg};
        4'h6:   avs_readdata <= {25'b0, overcurrent_v, conv_done_v, conv_done_u, conv_done_w,
                                        overcurrent_u, overcurrent_w, overcurrent};
        4'h7:   avs_readdata <= {16'b0, sample64_u_r};
        4'h8:   avs_readdata <= {16'b0, sample64_w_r};
        4'h9:   avs_readdata <= {12'b0, i_peak_reg};
        4'ha:   avs_readdata <= {16'b0, sample64_v_r};
        4'hb:   avs_readdata <= {16'b0, offset_v_reg};

        4'hc:   avs_readdata <= {12'b0, oc_capture_u};
        4'hd:   avs_readdata <= {12'b0, oc_capture_w};
        4'he:   avs_readdata <= {12'b0, oc_capture_v};
        4'hf:   avs_readdata <= {29'b0, set_irq_counter_reg};

        default:    avs_readdata <= 32'h0;
    endcase

//----------------------------------------------------------------------------//
// Synchronize latch signals to system clock domain
//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        latch_u_sync <= 1'b0;
        latch_v_sync <= 1'b0;
        latch_w_sync <= 1'b0;
        latch_u_sync2 <= 1'b0;
        latch_v_sync2 <= 1'b0;
        latch_w_sync2 <= 1'b0;
        Iu_reg        <= 16'b0;
        Iw_reg        <= 16'b0;

    end
    else
    begin
        latch_u_sync  <= latch_u;
        latch_v_sync  <= latch_v;
        latch_w_sync  <= latch_w;
        latch_u_sync2 <= latch_u_sync;
        latch_v_sync2 <= latch_v_sync;
        latch_w_sync2 <= latch_w_sync;
        if (latch_u_sync2) Iu_reg <= sample64_u_r ;
        if (latch_w_sync2) Iw_reg <= sample64_w_r;
    end

//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        irq_u_sync  <= 1'b0;
        irq_v_sync  <= 1'b0;
        irq_w_sync  <= 1'b0;
        irq_u_sync2 <= 1'b0;
        irq_v_sync2 <= 1'b0;
        irq_w_sync2 <= 1'b0;
    end
    else
    begin
        irq_u_sync  <= irq_u;
        irq_v_sync  <= irq_v;
        irq_w_sync  <= irq_w;
        irq_u_sync2 <= irq_u_sync;
        irq_v_sync2 <= irq_v_sync;
        irq_w_sync2 <= irq_w_sync;

    end

//----------------------------------------------------------------------------//
// Conversion complete interrupt
//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        conv_done_u <= 1'b0;
        conv_done_v <= 1'b0;
        conv_done_w <= 1'b0;
    end
    else if (irq_ack)
    begin
        conv_done_u <= 1'b0;
        conv_done_v <= 1'b0;
        conv_done_w <= 1'b0;
    end
    else
    begin
        if (irq_u_sync2) conv_done_u <= 1'b1;
        if (irq_v_sync2) conv_done_v <= 1'b1;
        if (irq_w_sync2) conv_done_w <= 1'b1;
    end

//----------------------------------------------------------------------------//
assign avs_irq = conv_done_u & conv_done_v & conv_done_w;
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Double sample to synch to clk domain
//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        overcurrent_xx <= 1'b0;
        overcurrent <= 1'b0;
    end
    else
    begin
        overcurrent_xx <= overcurrent_x;
        overcurrent <= overcurrent_xx;
    end

//----------------------------------------------------------------------------//
// Sinc3 filter differentiators
//
// *** NOTE
// Input bit stream is inverted to match FalconEye implementation
//----------------------------------------------------------------------------//
ssg_emb_sd_adc_diff diff_u (
    .clk                (clk),
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .reset_adc_n        (reset_adc_n),
    .data               (sync_dat_u),
    .start              (start),
    .dec_rate           (dec_rate),
    .set_irq_counter    (set_irq_counter_reg_adc),

    .cn_out             (cn_out_u),
    .cnr16              (cnr16_u),
    .cnr64              (cnr64_u),
    .latch_en           (latch_u),
    .irq                (irq_u)
);

psg_ecfs_lvdcdc_sd_adc_diff diff_u_direct (
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .data               (sync_dat_u),
    .cn_out             (cn_out_u_direct)
);

ssg_emb_sd_adc_diff diff_v (
    .clk                (clk),
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .reset_adc_n        (reset_adc_n),
    .data               (sync_dat_v),
    .start              (start),
    .dec_rate           (dec_rate),
    .set_irq_counter    (set_irq_counter_reg_adc),

    .cn_out             (cn_out_v),
    .cnr16              (cnr16_v),
    .cnr64              (cnr64_v),
    .latch_en           (latch_v),
    .irq                (irq_v)
);

ssg_emb_sd_adc_diff diff_w (
    .clk                (clk),
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .reset_adc_n        (reset_adc_n),
    .data               (sync_dat_w),
    .start              (start),
    .dec_rate           (dec_rate),
    .set_irq_counter    (set_irq_counter_reg_adc),

    .cn_out             (cn_out_w),
    .cnr16              (cnr16_w),
    .cnr64              (cnr64_w),
    .latch_en           (latch_w),
    .irq                (irq_w)
);

psg_ecfs_lvdcdc_sd_adc_diff diff_w_direct (
    .clk_adc            (clk_adc),
    .reset_n            (reset_adc_n),
    .data               (sync_dat_w),
    .cn_out             (cn_out_w_direct)
);

//----------------------------------------------------------------------------//
// Clock Domain Crossing
//----------------------------------------------------------------------------//
// clk domain

assign in_data_en = ((ack_toggle_safe == ack_toggle_safe_d) && (ack_toggle_safe == req_toggle));

always @ (posedge clk) begin
  // the "req_toggle_safe = req_toggle_safe_d" condition ensures that any glitches
  // do not perpetuate and the data is only latched when the toggle signals are stable
  if (in_data_en == 1'b1) begin
    control_reg_src           <= control_reg;
    set_irq_counter_reg_src   <= set_irq_counter_reg;
    offset_u_reg_src          <= offset_u_reg;
    offset_v_reg_src          <= offset_v_reg;
    offset_w_reg_src          <= offset_w_reg;
    i_peak_reg_src            <= i_peak_reg;
  end //if
end // always

always @ (posedge clk or negedge reset_n) begin
  // the "req_toggle_safe = req_toggle_safe_d" condition ensures that any glitches
  // do not perpetuate and the data is only latched when the toggle signals are stable
  if (reset_n == 1'b0) begin
    req_toggle <= 1'b1;
  end else if (in_data_en == 1'b1) begin
    req_toggle <= ~req_toggle;
  end //if
end // always

always @ (posedge clk or negedge reset_n) begin
  if (reset_n == 1'b0) begin
    ack_toggle_meta   <= 1'b0;
    ack_toggle_safe   <= 1'b0;
    ack_toggle_safe_d <= 1'b0;
  end else begin
    ack_toggle_meta   <= ack_toggle;
    ack_toggle_safe   <= ack_toggle_meta;
    ack_toggle_safe_d <= ack_toggle_safe;
  end //if
end //always

// clk_adc domain

always @ (posedge clk_adc or negedge reset_adc_n) begin
  if (reset_adc_n == 1'b0) begin
    req_toggle_meta   <= 1'b1;
    req_toggle_safe   <= 1'b1;
    req_toggle_safe_d <= 1'b0;
  end else begin
    req_toggle_meta   <= req_toggle;
    req_toggle_safe   <= req_toggle_meta;
    req_toggle_safe_d <= req_toggle_safe;
  end //if
end //always

// the "req_toggle_safe = req_toggle_safe_d" condition ensures that any glitches
// do not perpetuate and the data is only latched when the toggle signals are stable
assign out_data_en = ((req_toggle_safe == req_toggle_safe_d) && (req_toggle_safe != ack_toggle));

always @ (posedge clk_adc) begin
  if (out_data_en == 1'b1) begin
    control_reg_adc         <= control_reg_src;
    set_irq_counter_reg_adc <= set_irq_counter_reg_src;
    offset_u_reg_adc        <= offset_u_reg_src;
    offset_v_reg_adc        <= offset_v_reg_src;
    offset_w_reg_adc        <= offset_w_reg_src;
    i_peak_reg_adc          <= i_peak_reg_src;
  end //if
end //always

always @ (posedge clk_adc or negedge reset_adc_n) begin
  if (reset_adc_n == 1'b0) begin
    ack_toggle <= 1'b0;
  end else if (out_data_en == 1'b1) begin
    ack_toggle <= ~ack_toggle;
  end //if
end //always

//----------------------------------------------------------------------------//
//                             clk_adc DOMAIN
//----------------------------------------------------------------------------//

assign chk_3_ph = control_reg_adc[3];         // Check all 3 current phases
assign dec_rate = control_reg_adc[2];         // Decimation rate
assign overcurrent_error = control_reg_adc[1];
assign overvolt_en = control_reg_adc[0];

assign irq_ack = (avs_address == 4'h5) & ~avs_write_n & avs_writedata[0];

//----------------------------------------------------------------------------//
// Generate sample strobes for decimator and output result latch
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
        counter <= 9'b0;
    else
        counter <= counter + 9'b1;

//----------------------------------------------------------------------------//
// Generate pulses to tell decimator when to take a sample
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
        cnr128 <= 1'b0;
    else
        cnr128 <= (counter[6:0] == 7'b1111111);


//----------------------------------------------------------------------------//
// Sinc3 filter decimators for high resolution samples
//----------------------------------------------------------------------------//
ssg_emb_sd_adc_dec64 decimator64_u (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr64              (cnr64_u),
    .dec_rate           (dec_rate),
    .offset             (offset_u_reg_adc),
    .cn_in              (cn_out_u),

    .sample             (sample64_u)
);

psg_ecfs_lvdcdc_sd_adc_dec128 decimator128_u_direct (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr128             (cnr128),
    .offset             (offset_u_reg_adc),
    .cn_in              (cn_out_u_direct),

    .sample             (sample128_u_direct)
);

ssg_emb_sd_adc_dec64 decimator64_v (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr64              (cnr64_v),
    .dec_rate           (dec_rate),
    .offset             (offset_v_reg_adc),
    .cn_in              (cn_out_v),

    .sample             (sample64_v)
);

ssg_emb_sd_adc_dec64 decimator64_w (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr64              (cnr64_w),
    .dec_rate           (dec_rate),
    .offset             (offset_w_reg_adc),
    .cn_in              (cn_out_w),

    .sample             (sample64_w)
);

psg_ecfs_lvdcdc_sd_adc_dec128 decimator128_w_direct (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr128             (cnr128),
    .offset             (offset_w_reg_adc),
    .cn_in              (cn_out_w_direct),

    .sample             (sample128_w_direct)
);

//----------------------------------------------------------------------------//
// Register samples
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
    begin
        sample64_u_r <= 16'b0;
        sample64_v_r <= 16'b0;
        sample64_w_r <= 16'b0;
    end
    else
    begin
        if (latch_u) sample64_u_r <= sample64_u; //latch sample values
        if (latch_v) sample64_v_r <= sample64_v; //latch sample values
        if (latch_w) sample64_w_r <= sample64_w; //latch sample values
    end

//----------------------------------------------------------------------------//
// Sinc3 filter decimators for low resolution samples for current fail
//----------------------------------------------------------------------------//
ssg_emb_sd_adc_dec16 decimator16_u (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr16              (cnr16_u),
    .dec_rate           (dec_rate),
    .cn_in              (cn_out_u),

    .sample             (sample16_u)
);

ssg_emb_sd_adc_dec16 decimator16_v (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr16              (cnr16_v),
    .dec_rate           (dec_rate),
    .cn_in              (cn_out_v),

    .sample             (sample16_v)
);

ssg_emb_sd_adc_dec16 decimator16_w (
    .clk                (clk_adc),
    .reset_n            (reset_adc_n),
    .cnr16              (cnr16_w),
    .dec_rate           (dec_rate),
    .cn_in              (cn_out_w),

    .sample             (sample16_w)
);

//----------------------------------------------------------------------------//
// Delay cnr128 to give time for samples to be valid
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
    begin
        cnr128_d1 <= 1'b0;
        cnr128_d2 <= 1'b0;
        cnr128_d3 <= 1'b0;
        cnr128_d4 <= 1'b0;
    end
    else
    begin
        cnr128_d1 <= cnr128;
        cnr128_d2 <= cnr128_d1;
        cnr128_d3 <= cnr128_d2;
        cnr128_d4 <= cnr128_d3;
    end

//----------------------------------------------------------------------------//
// Latch samples in adc clock domain
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
    begin
        sample128_u_direct_r <= 16'b0;
        sample128_w_direct_r <= 16'b0;

    end
    else
    begin
        if (cnr128_d3)
        begin
            sample128_u_direct_r <= sample128_u_direct;
            sample128_w_direct_r <= sample128_w_direct;
        end

    end

//----------------------------------------------------------------------------//
assign sample_valid = cnr128_d4;
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        sample_valid_syn1 <= 1'b0;
        sample_valid_syn2 <= 1'b0;
    end
    else
    begin
        sample_valid_syn1 <= sample_valid;
        sample_valid_syn2 <= sample_valid_syn1;
    end

//----------------------------------------------------------------------------//
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        Iu_reg_156 <= 16'b0;
        Iw_reg_156 <= 16'b0;

    end
    else
    begin
        if ( sample_valid_syn2)
        begin
            Iu_reg_156 <= sample128_u_direct_r;
            Iw_reg_156 <= sample128_w_direct_r;
        end
    end

//----------------------------------------------------------------------------//
// Absolute value of current measurements
//----------------------------------------------------------------------------//
always @(*)
    if (sample16_u[9])
        sample16_u_abs <= (~sample16_u + 10'b1);
    else
        sample16_u_abs <= sample16_u;

always @(*)
    if (sample16_v[9])
        sample16_v_abs <= (~sample16_v + 10'b1);
    else
        sample16_v_abs <= sample16_v;

always @(*)
    if (sample16_w[9])
        sample16_w_abs <= (~sample16_w + 10'b1);
    else
        sample16_w_abs <= sample16_w;

//----------------------------------------------------------------------------//
// Current fail logic
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
    begin
        overcurrent_u <= 1'b0;
        overcurrent_v <= 1'b0;
        overcurrent_w <= 1'b0;
    end
    else if (overcurrent_error | ~overvolt_en)
    begin
        overcurrent_u <= 1'b0;
        overcurrent_v <= 1'b0;
        overcurrent_w <= 1'b0;
    end
    else
    begin
        // Change from FalconEye design to allow parallel detection in both channels
        if (sample16_u_abs >= i_peak_reg_adc)
            overcurrent_u <= 1'b1;
        else
            overcurrent_u <= 1'b0;
        if ((sample16_v_abs >= i_peak_reg_adc) & chk_3_ph)
            overcurrent_v <= 1'b1;
        else
            overcurrent_v <= 1'b0;
        if (sample16_w_abs >= i_peak_reg_adc)
            overcurrent_w <= 1'b1;
        else
            overcurrent_w <= 1'b0;
    end

//----------------------------------------------------------------------------//
// Capture absolute value on each rising edge of overcurrent flag
// By the time software reads them , they will be stable in clk domian
//----------------------------------------------------------------------------//
always @(posedge clk_adc or negedge reset_adc_n)
    if (~reset_adc_n)
    begin
        overcurrent_u_r <= 1'b0;
        overcurrent_v_r <= 1'b0;
        overcurrent_w_r <= 1'b0;
    end
    else
    begin
        overcurrent_u_r <= overcurrent_u;
        overcurrent_v_r <= overcurrent_v;
        overcurrent_w_r <= overcurrent_w;

        if (overcurrent_u & ~overcurrent_u_r)
        begin
            oc_capture_u <= sample16_u_abs;
        end
        if (overcurrent_v & ~overcurrent_v_r)
        begin
            oc_capture_v <= sample16_v_abs;
        end
        if (overcurrent_w & ~overcurrent_w_r)
        begin
            oc_capture_w <= sample16_w_abs;
        end
    end

//----------------------------------------------------------------------------//
always @(posedge clk_adc) begin
  overcurrent_x <= overcurrent_u | overcurrent_v | overcurrent_w;
end //always
//----------------------------------------------------------------------------//

//****************************************************************************//
endmodule   // ssg_emb_sd_adc
//****************************************************************************//

`default_nettype wire
