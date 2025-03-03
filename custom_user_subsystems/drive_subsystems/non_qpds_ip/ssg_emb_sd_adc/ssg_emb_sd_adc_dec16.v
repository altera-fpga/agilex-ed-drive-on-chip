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
 * This is the physical implementation of Sinc3 filter.
 * ##########################################################################
 */

// Sinc3 filter differentiator based on "Combining the ADS1202 with
// an FPGA Digital Filter for Current Measurement in Motor Control
// Applications" TI Application report SBAA094 June 2003
//
// For a 3 stage Sinc3 filter, each 2x increase in decimation rate
// requires 3 extra bits in the data path

`timescale 1ns/1ns

module ssg_emb_sd_adc_dec16 (
    input               clk,        // ADC clock
    input               reset_n,    // System reset
    input               cnr16,      // Decimator pulse
    input               dec_rate,   // Decimation rate control register bit 1: M=8, 0: M=16
    input [21:0]        cn_in,      // Input from integrator

    output reg [9:0]    sample      // Output sample
);

reg [9:0] dn0, dn1, dn3, dn5, sample_x;
wire [9:0] cn3, cn4, cn5;

always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        dn0 <= 10'b0;
        dn1 <= 10'b0;
        dn3 <= 10'b0;
        dn5 <= 10'b0;
        sample_x <= 10'b0;
    end
    else if (cnr16)
    begin
        dn0 <= dec_rate ? cn_in[9:0] : cn_in[12:3];
        dn1 <= dn0;
        dn3 <= cn3;
        dn5 <= cn4;
    end
    else
        sample_x <= cn5 - 10'b0011111111;

assign cn3 = dn0 - dn1;
assign cn4 = cn3 - dn3;
assign cn5 = cn4 - dn5;

always @(posedge clk or negedge reset_n)
    if (~reset_n)
        sample <= 10'b0;
    else
        sample <= sample_x;

endmodule   // ssg_emb_sd_adc_dec16
