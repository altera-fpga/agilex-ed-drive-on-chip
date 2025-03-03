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

`timescale 1 ps / 1 ps
module doc_hw_mailbox_self #(
        parameter ENABLE_STATUS = 0,
        parameter ENABLE_STREAM = 0,
        parameter STREAM_WIDTH  = 32,
        parameter ENABLE_URGENT = 0
    ) (
        input  wire        in_clk_clk,             //   in_clk.clk
        input  wire        in_reset_reset,         // in_reset.reset
        output wire        command_ready,          //  command.ready
        input  wire        command_valid,          //         .valid
        input  wire [31:0] command_data,           //         .data
        input  wire        command_startofpacket,  //         .startofpacket
        input  wire        command_endofpacket,    //         .endofpacket
        input  wire        response_ready,         // response.ready
        output wire        response_valid,         //         .valid
        output wire [31:0] response_data,          //         .data
        output wire        response_startofpacket, //         .startofpacket
        output wire        response_endofpacket    //         .endofpacket
    );

    generate
        // If any of the display statements (or deliberately broken
        // instantiations) within this "generate" block triggers, then this module
        // has been instantiated with a set of parameters different
        // from those it was generated for.  This will usually result in a
        // non-functioning system.
        if (ENABLE_STATUS != 0)
        begin
        // synthesis translate_off
            initial begin
                $display("Generated module instantiated with wrong parameters");
                $stop;
            end
        // synthesis translate_on
            instantiated_with_wrong_parameters_error_see_comment_above
                    enable_status_check ( .error(1'b1) );
        end
        if (ENABLE_STREAM != 0)
        begin
        // synthesis translate_off
            initial begin
                $display("Generated module instantiated with wrong parameters");
                $stop;
            end
        // synthesis translate_on
            instantiated_with_wrong_parameters_error_see_comment_above
                    enable_stream_check ( .error(1'b1) );
        end
        if (STREAM_WIDTH != 32)
        begin
        // synthesis translate_off
            initial begin
                $display("Generated module instantiated with wrong parameters");
                $stop;
            end
        // synthesis translate_on
            instantiated_with_wrong_parameters_error_see_comment_above
                    stream_width_check ( .error(1'b1) );
        end
        if (ENABLE_URGENT != 0)
        begin
        // synthesis translate_off
            initial begin
                $display("Generated module instantiated with wrong parameters");
                $stop;
            end
        // synthesis translate_on
            instantiated_with_wrong_parameters_error_see_comment_above
                    enable_urgent_check ( .error(1'b1) );
        end
    endgenerate

    altera_config_stream_endpoint_wrapper #(
        .READY_LATENCY  (0),
        .HAS_URGENT     (0),
        .HAS_STATUS     (0),
        .HAS_STREAM     (0),
        .MAX_SIZE       (256),
        .STREAM_WIDTH   (32),
        .DATA_WIDTH     (32),
        .CLOCK_RATE_CLK (0)
    ) config_stream_endpoint_0 (
        .clk                    (in_clk_clk),                           //   input,   width = 1,      clk.clk
        .reset                  (in_reset_reset),                       //   input,   width = 1,    reset.reset
        .command_ready          (command_ready),                        //  output,   width = 1,  command.ready
        .command_valid          (command_valid),                        //   input,   width = 1,         .valid
        .command_data           (command_data),                         //   input,  width = 32,         .data
        .command_startofpacket  (command_startofpacket),                //   input,   width = 1,         .startofpacket
        .command_endofpacket    (command_endofpacket),                  //   input,   width = 1,         .endofpacket
        .response_ready         (response_ready),                       //   input,   width = 1, response.ready
        .response_valid         (response_valid),                       //  output,   width = 1,         .valid
        .response_data          (response_data),                        //  output,  width = 32,         .data
        .response_startofpacket (response_startofpacket),               //  output,   width = 1,         .startofpacket
        .response_endofpacket   (response_endofpacket),                 //  output,   width = 1,         .endofpacket
        .command_invalid        (),                                     // (terminated),
        .urgent_ready           (),                                     // (terminated),
        .urgent_valid           (1'b0),                                 // (terminated),
        .urgent_data            (32'b00000000000000000000000000000000), // (terminated),
        .stream_ready           (),                                     // (terminated),
        .stream_valid           (1'b0),                                 // (terminated),
        .stream_data            (32'b00000000000000000000000000000000), // (terminated),
        .stream_active          ()                                      // (terminated),
    );

endmodule

`default_nettype wire
