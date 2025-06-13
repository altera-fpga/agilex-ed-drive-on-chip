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
 * This is the physical implementation of Sinc3 filter.
 * Output sample range from -ve to +ve full scale.
 * ##########################################################################
 */

// Sinc3 filter differentiator based on "Combining the ADS1202 with
// an FPGA Digital Filter for Current Measurement in Motor Control
// Applications" TI Application report SBAA094 June 2003
//
// For a 3 stage Sinc3 filter, each 2x increase in decimation rate
// requires 3 extra bits in the data path

`timescale 1ns/1ns

module ssg_emb_sd_adc_dec64 (
    input               clk,        // ADC clock
    input               reset_n,    // System reset
    input               cnr64,      // Decimator pulse
    input               dec_rate,   // Decimation rate control register bit 1: M=32, 0: M=64
    input [15:0]        offset,     // zero offset register
    input [21:0]        cn_in,      // Input from integrator

    output reg [15:0]   sample      // Output sample
);

reg [15:0] dn0, dn1, dn3, dn5, sample_x;
wire [15:0] cn3, cn4, cn5;

always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        dn0 <= 16'b0;
        dn1 <= 16'b0;
        dn3 <= 16'b0;
        dn5 <= 16'b0;
        sample_x <= 16'b0;
    end
    else if (cnr64)
    begin
        dn0 <= dec_rate ? cn_in[15:0] : cn_in[18:3];
        dn1 <= dn0;
        dn3 <= cn3;
        dn5 <= cn4;
    end
    else
        sample_x <= cn5 - {1'b0, offset[15:3], 2'b11};

assign cn3 = dn0 - dn1;
assign cn4 = cn3 - dn3;
assign cn5 = cn4 - dn5;

always @(posedge clk or negedge reset_n)
    if (~reset_n)
        sample <= 16'b0;
    else
        if ((sample_x[15:14] == 2'b00) || (sample_x[15:14] == 2'b11))
            sample <= {sample_x[14:2],3'b000};
        else if (sample_x[15] == 1'b0)      // Limit to +ve full scale
            sample <= 16'h7FFF;
        else if (sample_x[15] == 1'b1)      // Limit to -ve full scale
            sample <= 16'h8001;

endmodule   // ssg_emb_sd_adc_dec64
