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
 * Counter: it can go up or go down, able to load value, also can record
 * and output counting value at special time based on input.
 * ##########################################################################
 */

module QEPcounter # (
  int P_QEP_COUNT_WIDTH = 0
) (
    input               clk,
    input               reset,
    input               pulse,
    input               dir,
    input               index,
    input               count_load,
    input [31:0]        load_value,
    input               index_reset_en,
    input               index_capture_en,
    input [31:0]        max_count,

    output reg [31:0]   count,
    output reg [31:0]   index_capture_reg,
    output wire         I_posedge
);

localparam LP_QEP_COUNT_WIDTH = (P_QEP_COUNT_WIDTH == 0 ? 32 : P_QEP_COUNT_WIDTH);


    // Register(s)
    reg [1:0] Pr;
    reg [1:0] Ir;
    wire P_posedge = (Pr==2'b01);       //detect rising pulse
    assign I_posedge = (Ir==2'b01);     //detect reset based on index pulse

  generate
    if (P_QEP_COUNT_WIDTH == 0) begin : GEN_USE_MAX_COUNT

      // QEP Counter Routine
      always@(posedge clk or posedge reset)
      if (reset)
      begin
        Pr <= 2'b00;
        Ir <= 2'b00;
        count <= 32'h0000_0000;
        index_capture_reg <= 32'h0000_0000;
      end
      else
      begin
        Pr <= {Pr[0],pulse};
        Ir <= {Ir[0],index & index_reset_en};

        if (count_load)
        begin
          count <= load_value;
        end
        else if(I_posedge)
        begin
          count <= 32'h0000_0000;
          if (index_capture_en)
          begin
            index_capture_reg <= count;
          end
        end
        else if(P_posedge)
        begin
          if(dir == 1'b1)
          begin
            if (count == max_count)
              count <= 0;
            else
              count <=count + 1'b1;
          end
          else
          begin
            if (count == 0)
              count <= max_count;
            else
              count <= count - 1'b1;
          end
        end
        else begin
        count <= count;
        end
      end

    end else begin : GEN_ROTARY_ROLLOVER

      reg [LP_QEP_COUNT_WIDTH - 1 : 0] qep_count;

      // QEP Counter Routine
      always@(posedge clk or posedge reset)
      if (reset)
      begin
        Pr <= 2'b00;
        Ir <= 2'b00;
        qep_count <= 'd0;
        index_capture_reg <= 32'h0000_0000;
      end
      else
      begin
        Pr <= {Pr[0],pulse};
        Ir <= {Ir[0],index & index_reset_en};

        if (count_load)
        begin
          qep_count <= load_value [LP_QEP_COUNT_WIDTH - 1 : 0];
        end
        else if(I_posedge)
        begin
          qep_count <= 'd0;
          if (index_capture_en)
          begin
            index_capture_reg <= 'd0;
            index_capture_reg [LP_QEP_COUNT_WIDTH - 1 : 0] <= qep_count;
          end
        end
        else if(P_posedge)
        begin
          if(dir == 1'b1)
          begin
            qep_count <=qep_count + 1'b1;
          end
          else
          begin
            qep_count <= qep_count - 1'b1;
          end
        end
      end

      always @(*) begin
        count <= 'd0;
        count [LP_QEP_COUNT_WIDTH - 1 : 0] <= qep_count;
      end //always

    end // generate if
  endgenerate
endmodule
