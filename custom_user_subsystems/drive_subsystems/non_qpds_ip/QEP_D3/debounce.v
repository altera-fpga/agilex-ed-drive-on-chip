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
 * If QEPsignal = "0000" output 0, if QEPsignal = "1111" output 1
 * ##########################################################################
 */ 
`default_nettype none

//****************************************************************************//
module debounce(
//****************************************************************************//
    input  wire clk,
    input  wire reset,
    input  wire QEPsignal,
    output reg  QEPqualified
);
//****************************************************************************//

    // Register(s)
    reg [3:0] debounce4;
  reg QEP_meta;
  reg QEP_safe;

    // Parameter Declaration(s)
    parameter qual0 = 4'b0000, qual1 = 4'b1111;
//----------------------------------------------------------------------------//

    always @(posedge clk) begin
    QEP_meta <= QEPsignal;
    QEP_safe <= QEP_meta;
  end //always
    
    // Debounce Routine
    always@(posedge clk or posedge reset)
    if (reset)
    begin
        QEPqualified <= 1'b0;
        debounce4    <= 4'h0;
    end
    else
    begin
        debounce4<={debounce4[2:0],QEP_safe};
    
        case(debounce4)
            qual0: QEPqualified<=0;
            qual1: QEPqualified<=1;
            default: QEPqualified<=QEPqualified;
        endcase
    end

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
