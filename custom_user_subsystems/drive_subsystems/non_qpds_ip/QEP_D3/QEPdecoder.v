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
 * Decoder: pulse equals to 1 if there is a rising or falling edge detected on
 * input A and B. Dir will be high if rising edge on A is detected but B is low
 * or falling edge on A is detected but B is high, same theory also apply to B.
 * ##########################################################################
 */

module QEPdecoder(
    input       clk,
    input       reset,
    input       A,
    input       B,
    output reg  pulse,
    output reg  dir,
    output reg  QEP_overpseed
);

    // Register(s)
    reg [1:0] Ar, Br;
    wire A_posedge = (Ar==2'b01); //detect A rising edge
    wire A_negedge = (Ar==2'b10); //detect A falling edge
    wire B_posedge = (Br==2'b01); //detect B rising edge
    wire B_negedge = (Br==2'b10); //detect B falling edge

    // QEP Decoder Routine
    always@(posedge clk or posedge reset)
    if (reset)
    begin
        Ar <= 2'b0;
        Br <= 2'b0;
        pulse <= 1'b0;
        dir <= 1'b0;
    end
    else
    begin
        Ar<={Ar[0],A};
        Br<={Br[0],B};

        if(A_posedge)
            begin
                pulse<=1;
                if(~Br[1])dir<=1;
                else dir<=0;
            end
        else if(A_negedge)
            begin
                pulse<=1;
                if(Br[1])dir<=1;
                else dir<=0;
            end
        else if(B_posedge)
            begin
                pulse<=1;
                if(Ar[1])dir<=1;
                else dir<=0;
            end
        else if(B_negedge)
            begin
                pulse<=1;
                if(~Ar[1])dir<=1;
                else dir<=0;
            end
        else begin
            pulse<=0;
        end

    end

    always@(posedge clk or posedge reset)
    if(reset)
        QEP_overpseed <= 1'b0;
    else
    begin
        // When A or B change within the same clock cycle
        if((A_posedge & B_posedge) | (A_posedge & B_negedge) | (A_negedge & B_posedge) | (A_negedge & B_negedge))
            QEP_overpseed <= 1'b1;
        else
            QEP_overpseed <= 1'b0;
    end

endmodule
