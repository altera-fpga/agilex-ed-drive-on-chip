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

// Sinc3 filter differentiator based on "Combining the ADS1202 with
// an FPGA Digital Filter for Current Measurement in Motor Control
// Applications" TI Application report SBAA094 June 2003
//
// For a 3 stage Sinc3 filter, each 2x increase in decimation rate
// requires 3 extra bits in the data path so for a decimation rate
// of 128 we need 21 bits (3x7) plus one sign bit

`timescale 1ns/1ns

module psg_ecfs_lvdcdc_sd_adc_diff (
    input   clk_adc,                // ADC clock
    input   reset_n,                // System reset
    input   data,                   // ADC data in clk_adc domain

    // All outputs in clk_adc domain
    output wire [21:0]  cn_out      // Third stage integrator output
);

reg [21:0] delta1, cn1, cn2;

always @(posedge clk_adc or negedge reset_n)
    if (~reset_n)
        delta1 <= 22'b0;
    else if (data)
        delta1 <= delta1 + 22'b1;

always @(posedge clk_adc or negedge reset_n)
    if (~reset_n)
    begin
        cn1 <= 22'b0;
        cn2 <= 22'b0;
    end
    else
    begin
        cn1 <= cn1 + delta1;
        cn2 <= cn2 + cn1;
    end

assign cn_out = cn2;

endmodule   // psg_ecfs_lvdcdc_sd_adc_diff