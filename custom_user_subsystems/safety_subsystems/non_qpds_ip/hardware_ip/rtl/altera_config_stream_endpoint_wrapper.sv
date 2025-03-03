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


`timescale 1 ns / 1 ns

package altera_config_stream_endpoint_wpackage;

function integer nonzero;
input integer value;
begin
    nonzero = (value > 0) ? value : 1;
end
endfunction

endpackage

module altera_config_stream_endpoint_wrapper
    import altera_config_stream_endpoint_wpackage::nonzero;
#(
    parameter READY_LATENCY          = 0,
    parameter HAS_URGENT             = 0,
    parameter HAS_STATUS             = 0,
    parameter HAS_STREAM             = 0,
    parameter MAX_SIZE               = 256,
    parameter STREAM_WIDTH           = 64,
    parameter DATA_WIDTH             = 32,
    parameter CLOCK_RATE_CLK         = 0
) (
    input                       clk,
    input                       reset,
    output                      command_ready,
    input                       command_valid,
    input  [DATA_WIDTH-1:0]     command_data,
    input                       command_startofpacket,
    input                       command_endofpacket,
    output                      command_invalid,
    input                       response_ready,
    output                      response_valid,
    output [DATA_WIDTH-1:0]     response_data,
    output                      response_startofpacket,
    output                      response_endofpacket,
    output                      urgent_ready,
    input                       urgent_valid,
    input  [DATA_WIDTH-1:0]     urgent_data,
    output                      stream_ready,
    input                       stream_valid,
    input  [STREAM_WIDTH-1:0]   stream_data,
    output                      stream_active
);

    altera_config_stream_endpoint #(
        .READY_LATENCY          (READY_LATENCY),
        .HAS_URGENT             (HAS_URGENT),
        .HAS_STATUS             (HAS_STATUS),
        .HAS_STREAM             (HAS_STREAM),
        .MAX_SIZE               (MAX_SIZE),
        .STREAM_WIDTH           (STREAM_WIDTH),
        .CLOCK_RATE_CLK         (CLOCK_RATE_CLK)
) inst (
        .clk                    (clk),
        .reset                  (reset),
        .command_ready          (command_ready),
        .command_valid          (command_valid),
        .command_data           (command_data),
        .command_startofpacket  (command_startofpacket),
        .command_endofpacket    (command_endofpacket),
        .command_invalid        (command_invalid),
        .response_ready         (response_ready),
        .response_valid         (response_valid),
        .response_data          (response_data),
        .response_startofpacket (response_startofpacket),
        .response_endofpacket   (response_endofpacket),
        .urgent_ready           (urgent_ready),
        .urgent_valid           (urgent_valid),
        .urgent_data            (urgent_data),
        .stream_ready           (stream_ready),
        .stream_valid           (stream_valid),
        .stream_data            (stream_data),
        .stream_active          (stream_active)

    );

endmodule

// synthesis translate_off
// Empty module definition to allow simulation compilation.
module altera_config_stream_endpoint
    import altera_config_stream_endpoint_wpackage::nonzero;
#(
    parameter READY_LATENCY          = 0,
    parameter HAS_URGENT             = 0,
    parameter HAS_STATUS             = 0,
    parameter HAS_STREAM             = 0,
    parameter MAX_SIZE               = 256,
    parameter STREAM_WIDTH           = 64,
    parameter CLOCK_RATE_CLK         = 0
) (
    input                       clk,
    input                       reset,
    output                      command_ready,
    input                       command_valid,
    input  [32-1:0]             command_data,
    input                       command_startofpacket,
    input                       command_endofpacket,
    output                      command_invalid,
    input                       response_ready,
    output                      response_valid,
    output [32-1:0]             response_data,
    output                      response_startofpacket,
    output                      response_endofpacket,
    output                      urgent_ready,
    input                       urgent_valid,
    input  [32-1:0]             urgent_data,
    output                      stream_ready,
    input                       stream_valid,
    input  [STREAM_WIDTH-1:0]   stream_data,
    output                      stream_active
);
endmodule
// synthesis translate_on

`default_nettype wire

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "QIVWpxzUfGDyjpF24xYkgJT0rwiaq5jLMpIIYYVR8BEH/FSLg7c9DffhYw4Pqa3cV+tovBwM6fMqFYUChMDdFPuTzRFicw/HNpW5Cb2ckvT+h8mfSB1jLutRLAleHSNQU9E56Yn2Un4voN3gYtEWXGBHxvUCbwvP2uFthPfgXIv94bueC43AJ3Q8chlCX/Bos1sSQD1D/8UJWXJi6Fx1UlH364UPnhubCMgninMfWbtje9yuL4SVVhZ7NmJtxfXY5spnwztnrqsrGqX4egrl4On7YZBpoXdzHMXy9Hm9To1Xj1bxRNqxV3aI3Fjke8Z8qaoriqyk3NsfjH7rF2eSLuVx1MHK4XEIr45tduUuz+j5baxHQDxLgkZxQf3Dq2bNg4cQZPLCC36xeGk+K6hmVaN+k7Ri3Gy0zvY2HrpulDAM08GWxSUXaOgHFrniVadIRuyN6E2r7DUV7/039rLi5X1I/hIco2CyX4XpawgQtcgMK0XQ/UFNDu/sKatH8nWfgWY4+7FCzswiX0Q8CiSgy4CNnxs40qOJPWMd13xa5eXxk6gn+37vfjYATC6fO5NWujt8iQ+zt0MCoofDRrWX8kJoNx9HSIcuDQBMVc54IdgAWj8LMH/8gn3g3p4EACUdkkfB10f9lBKcb5m1F0LDhv5iQcWWQ2LpJY1hOnGHXujNfzpk0uDJKLb97Qxc/Gxk7Si5vaYv0F73oo+EF8fhiyM7ZQ7z/1z33HCt37F15G+pss4HPuqnNms7RV4k2bw3Wer/13tMhfck6ALd3uCkrXjnhIp9uueA0Bd2zg09KB2lD/7RTEuDjFlFbKbNxtmhv094MmmXzKAMn52bCQ8dnHruYlJSLRGTr14gJ9kCAueVSC+01nNMrF4hfQxweTX07aW8gNJvbeH8JAoSXJO8e8i1pXmouBSQL2F/4UReAZUlmYokijVy4QScS5BhPCuXDyVMSVqOG68FCREOaPswQniX9xpIkzrHJz/k9FJTARnYXinDb4ORXdQv2nr73z94"
`endif