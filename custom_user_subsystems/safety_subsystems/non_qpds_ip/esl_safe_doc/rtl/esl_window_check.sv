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

`default_nettype none

module window_check #(
    parameter delay_count_lim       = 20008,
    parameter delay_count_low_lim   = 19992
) (
    input  wire clk,
    input  wire reset,
    input  wire pulse,
    output logic window_error
);

logic [16:0] delay_count;

logic window_error_reg = 1'b0;

bit upper_limit_error;
bit lower_limit_error;

// Resetting Delay Count if:
//  - Max Count Limit Reached
//  - Pulse Received
always_ff @(posedge clk or negedge reset) begin
    if(~reset) begin
        delay_count <= 0;
    end else begin
        delay_count <= delay_count + 1'b1;
        if((delay_count >= delay_count_lim) | (pulse == 1'b1)) begin
            delay_count <= 0;
        end
    end
end

always_ff @(posedge clk or negedge reset) begin
    if(~reset) begin
        lower_limit_error <= 1'b0;
    end else begin
        if (pulse == 1'b1) begin
            if(delay_count <= delay_count_low_lim && ~upper_limit_error)
            begin
                lower_limit_error <= 1'b1;
            end
        end
    end
end

always_ff @(posedge clk or negedge reset) begin
    if(~reset) begin
        upper_limit_error <= 1'b0;
    end else begin
        if(delay_count >= delay_count_lim && ~lower_limit_error) begin
            upper_limit_error <= 1'b1;
        end
    end
end

always_ff @(posedge clk or negedge reset) begin
  if (~reset) begin
    window_error_reg <= 1'b0;
  end else begin
    if ((lower_limit_error == 1'b1) || (upper_limit_error == 1'b1)) begin
      window_error_reg <= 1'b1;
    end //if
  end //if
end //always_ff

assign window_error = window_error_reg;

endmodule

`default_nettype wire