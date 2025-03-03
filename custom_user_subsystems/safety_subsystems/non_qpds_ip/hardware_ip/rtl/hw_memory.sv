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

//****************************************************************************//
module hw_memory #(
//****************************************************************************//
    parameter int P_NO_CH_VOLT       = 9,
    parameter int P_NO_CH_TEMP       = 5,
    parameter int P_S_AXI_ADDR_WIDTH = 8,
    parameter int P_S_AXI_DATA_WIDTH = 32
) (
    input  wire clk,
    input  wire reset,

    //--- Collections ---
    input  wire  [P_NO_CH_VOLT - 1 : 0][31:0]  voltage_info,
    input  wire  [P_NO_CH_TEMP - 1 : 0][31:0]  temperature_info,

    //APB Inputs --- After using AXIL to APB
    input  wire  [P_S_AXI_ADDR_WIDTH - 1 : 0]  s_apb_paddr,
    input  wire                                s_apb_pwrite,
    input  wire                                s_apb_psel,
    input  wire                                s_apb_penable,
    input  wire  [P_S_AXI_DATA_WIDTH - 1 : 0]  s_apb_pwdata,
    output logic [P_S_AXI_DATA_WIDTH - 1 : 0]  s_apb_prdata,
    output logic                               s_apb_pready

);
timeunit 1ns;
timeprecision 1ps;
//****************************************************************************//


localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH0           = 'h00;    //0
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH1           = 'h04;    //1
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH2           = 'h08;    //2
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH3           = 'h0C;    //3
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH4           = 'h10;    //4
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH5           = 'h14;    //5
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH6           = 'h18;    //6
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH7           = 'h1C;    //7
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_VOLT_CH9           = 'h20;    //8
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH0           = 'h24;    //9
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH1           = 'h28;    //10
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH2           = 'h2C;    //11
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH3           = 'h30;    //12
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH4           = 'h34;    //13
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH5           = 'h38;    //14
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH6           = 'h3C;    //15
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH7           = 'h40;    //16
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH8           = 'h44;    //17
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH9           = 'h48;    //18
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH10          = 'h4C;    //19
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH11          = 'h50;    //20
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] C_TEMP_CH12          = 'h54;    //21

localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] no_volts             = 'h58;    //22
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] no_temps             = 'h5C;    //23

localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] baseTempAddr         = 'h24;
localparam [P_S_AXI_ADDR_WIDTH - 1 : 0] baseInfoAddr         = 'h58;

logic [P_S_AXI_ADDR_WIDTH - 1 - 2 : 0] offset = 0;

//----------------------------------------------------------------------------//

//Offset Calculation
always_comb begin
  logic [P_S_AXI_ADDR_WIDTH - 1 : 0] offset_wide;

  offset_wide  = (s_apb_paddr - baseTempAddr);
  offset       = offset_wide [$left(offset) : 2];
end

// Read
always_ff @(posedge clk or negedge reset) begin
    if(~reset) begin
        s_apb_prdata <= {P_S_AXI_DATA_WIDTH{1'b0}};
    end else begin
        if ((s_apb_pwrite == 1'b0) && (s_apb_psel == 1'b1)) begin
            // When Read Requested
            if(s_apb_paddr < baseTempAddr) begin
                //Voltage
                case(s_apb_paddr)
                    C_VOLT_CH0   :  s_apb_prdata       <= voltage_info[0];
                    C_VOLT_CH1   :  s_apb_prdata       <= voltage_info[1];
                    C_VOLT_CH2   :  s_apb_prdata       <= voltage_info[2];
                    C_VOLT_CH3   :  s_apb_prdata       <= voltage_info[3];
                    C_VOLT_CH4   :  s_apb_prdata       <= voltage_info[4];
                    C_VOLT_CH5   :  s_apb_prdata       <= voltage_info[5];
                    C_VOLT_CH6   :  s_apb_prdata       <= voltage_info[6];
                    C_VOLT_CH7   :  s_apb_prdata       <= voltage_info[7];
                    C_VOLT_CH9   :  s_apb_prdata       <= voltage_info[8];
                endcase
            end
            else if(baseTempAddr <= s_apb_paddr && s_apb_paddr < baseInfoAddr) begin
                //Temperature
                if(offset > P_NO_CH_TEMP)
                    s_apb_prdata <= 'h0;
                else
                    s_apb_prdata <= temperature_info[offset];
            end
            else begin
                // Info
                case(s_apb_paddr)
                    no_volts     :  s_apb_prdata       <= P_NO_CH_VOLT;
                    no_temps     :  s_apb_prdata       <= P_NO_CH_TEMP;
                endcase
            end
        end
    end
end

assign s_apb_pready = s_apb_penable & s_apb_psel;

//****************************************************************************//
endmodule
//****************************************************************************//

`default_nettype wire
