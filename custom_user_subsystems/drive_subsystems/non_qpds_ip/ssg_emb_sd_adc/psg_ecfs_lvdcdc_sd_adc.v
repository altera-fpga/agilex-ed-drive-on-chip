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

// 1.0  New version embedded in autonomous DCDC converter

`timescale 1ns/1ns

module psg_ecfs_lvdcdc_sd_adc #(
    parameter signed [12:0]CURRENT_SCALE    = 143,
    parameter CURRENT_SHIFT                 = 10,
    parameter signed [12:0]VOLTAGE_SCALE    = 301,
    parameter VOLTAGE_SHIFT                 = 12
) (
    input           clk_adc,
    input           reset_n,

    // Offset values
    input [15:0]    offset_i_phase_a,
    input [15:0]    offset_i_phase_b,
    input [15:0]    offset_v,

    // ADC inputs in clk_adc domain
    input           sync_dat_i_phase_a,
    input           sync_dat_i_phase_b,
    input           sync_dat_v_out,

    // Output samples in clk_adc domain
    output wire [12:0]  sample_i_phase_a,
    output wire [12:0]  sample_i_phase_b,
    output wire [12:0]  sample_v_out,
    output wire [15:0]  sample_i_phase_a_16,
    output wire [15:0]  sample_i_phase_b_16,
    output wire [15:0]  sample_v_out_16,
    output wire         sample_valid,
    output reg          out_of_range
);

reg [12:0] i_phase_a_reg;
reg [12:0] i_phase_b_reg;
reg [12:0] v_out_reg;
reg cnr128_d1,  cnr128_d2,  cnr128_d3,  cnr128_d4;
reg [12:0] sample128_i_phase_b_r;
reg [12:0] sample128_i_phase_a_r;
reg [12:0] sample128_v_out_r;
reg [15:0] sample128_i_phase_b_16_r;
reg [15:0] sample128_i_phase_a_16_r;
reg [15:0] sample128_v_out_16_r;

// Generate sample strobes for decimator and output result latch
reg [8:0] counter;
always @(posedge clk_adc or negedge reset_n)
    if (~reset_n)
        counter <= 9'b0;
    else
        counter <= counter + 9'b1;

reg cnr128;
// Generate pulses to tell decimator when to take a sample
always @(posedge clk_adc or negedge reset_n)
    if (~reset_n)
        cnr128 <= 1'b0;
    else
        cnr128 <= (counter[6:0] == 7'b1111111);

// Sinc3 filter differentiators
wire [21:0] cn_out_i_phase_a;
wire cnr128_i_phase_a;
psg_ecfs_lvdcdc_sd_adc_diff diff_i_phase_a (
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .data               (sync_dat_i_phase_a),

    .cn_out             (cn_out_i_phase_a)
);

wire [21:0] cn_out_i_phase_b;
wire cnr128_i_phase_b;
psg_ecfs_lvdcdc_sd_adc_diff diff_i_phase_b (
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .data               (sync_dat_i_phase_b),

    .cn_out             (cn_out_i_phase_b)
);

wire [21:0] cn_out_v_out;
wire cnr128_v_out;
psg_ecfs_lvdcdc_sd_adc_diff diff_v_out (
    .clk_adc            (clk_adc),
    .reset_n            (reset_n),
    .data               (sync_dat_v_out),

    .cn_out             (cn_out_v_out)
);

// Sinc3 filter decimators for high resolution samples
wire signed [15:0] sample128_i_phase_a;
wire signed [15:0] sample128_i_phase_b;
wire signed [15:0] sample128_v_out;
psg_ecfs_lvdcdc_sd_adc_dec128 decimator128_i_phase_a (
    .clk                (clk_adc),
    .reset_n            (reset_n),
    .cnr128             (cnr128),
    .offset             (offset_i_phase_a),
    .cn_in              (cn_out_i_phase_a),

    .sample             (sample128_i_phase_a)
);

psg_ecfs_lvdcdc_sd_adc_dec128 decimator128_i_phase_b (
    .clk                (clk_adc),
    .reset_n            (reset_n),
    .cnr128             (cnr128),
    .offset             (offset_i_phase_b),
    .cn_in              (cn_out_i_phase_b),

    .sample             (sample128_i_phase_b)
);

psg_ecfs_lvdcdc_sd_adc_dec128 decimator128_v_out (
    .clk                (clk_adc),
    .reset_n            (reset_n),
    .cnr128             (cnr128),
    .offset             (offset_v),
    .cn_in              (cn_out_v_out),

    .sample             (sample128_v_out)
);

// Delay cnr128 to give time for samples to be valid
always @(posedge clk_adc or negedge reset_n)
    if (~reset_n)
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

// Multiply samples by scale factor
wire signed [25:0] i_phase_a_scale = sample128_i_phase_a * CURRENT_SCALE;
wire signed [25:0] i_phase_b_scale = sample128_i_phase_b * CURRENT_SCALE;
wire signed [25:0] v_out_scale = sample128_v_out * VOLTAGE_SCALE;
wire signed [25-CURRENT_SHIFT:0] i_phase_a_shift = i_phase_a_scale[25: CURRENT_SHIFT];
wire signed [25-CURRENT_SHIFT:0] i_phase_b_shift = i_phase_b_scale[25: CURRENT_SHIFT];
wire signed [25-VOLTAGE_SHIFT:0] v_out_shift = v_out_scale[25:VOLTAGE_SHIFT];

// Latch samples in adc clock domain
always @(posedge clk_adc or negedge reset_n)
    if (~reset_n)
    begin
        sample128_i_phase_a_r <= 13'b0;
        sample128_i_phase_b_r <= 13'b0;
        sample128_v_out_r <= 13'b0;
        out_of_range <= 1'b0;
        sample128_i_phase_b_16_r <= 16'b0;
        sample128_i_phase_a_16_r <= 16'b0;
        sample128_v_out_16_r <= 16'b0;
    end
    else
    begin
        if (cnr128_d3)
        begin
            out_of_range <= 1'b0;

            if (i_phase_a_shift[13:12] == 2'b01)
            begin
                sample128_i_phase_a_r <= 13'h0fff;      // limit to +ve full scale
                out_of_range <= 1'b1;
            end
            else if (i_phase_a_shift[13:12] == 2'b10)
            begin
                sample128_i_phase_a_r <= 13'h1000;      // limit to -ve full scale
                out_of_range <= 1'b1;
            end
            else
                sample128_i_phase_a_r <= i_phase_a_shift[12:0];

            if (i_phase_b_shift[13:12] == 2'b01)
            begin
                sample128_i_phase_b_r <= 13'h0fff;      // limit to +ve full scale
                out_of_range <= 1'b1;
            end
            else if (i_phase_b_shift[13:12] == 2'b10)
            begin
                sample128_i_phase_b_r <= 13'h1000;      // limit to -ve full scale
                out_of_range <= 1'b1;
            end
            else
                sample128_i_phase_b_r <= i_phase_b_shift[12:0];

            if (v_out_shift[13:12] == 2'b01)
            begin
                sample128_v_out_r <= 13'h0fff;      // limit to +ve full scale
                out_of_range <= 1'b1;
            end
            else if (v_out_shift[13:12] == 2'b10)
            begin
                sample128_v_out_r <= 13'h1000;      // limit to -ve full scale
                out_of_range <= 1'b1;
            end
            else
            begin
                sample128_v_out_r <= v_out_shift[12:0];
            end

            sample128_i_phase_b_16_r <= sample128_i_phase_b;
            sample128_i_phase_a_16_r <= sample128_i_phase_a;
            sample128_v_out_16_r <= sample128_v_out;

        end

    end

    // Outputs in clk_adc domain
    assign sample_i_phase_a = sample128_i_phase_a_r;
    assign sample_i_phase_b = sample128_i_phase_b_r;
    assign sample_v_out = sample128_v_out_r;
    assign sample_valid = cnr128_d4;

    assign sample_i_phase_a_16 = sample128_i_phase_a_16_r;
    assign sample_i_phase_b_16 = sample128_i_phase_b_16_r;
    assign sample_v_out_16     = sample128_v_out_16_r;

endmodule   // psg_ecfs_lvdcdc_sd_adc
