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

// Description:
// Avalon slave interface for CSR
// ##########################################################################

`default_nettype none

module esl_clk_check_slave_if
  (
   // signals to connect to an Avalon-MM slave interface
   input  wire [1:0]   csr_addr,            // only 3 registers so only 2 bits needed
   output wire [31:0]  csr_readdata,        // internal reg values presented on this interface
   // signals to connect to custom user logic
   input  wire [23:0]  core_status,         // various core status bits are input on this bus
   input  wire [23:0]  cut_count_store,     // stored value of the clock under test counter
   input  wire [23:0]  ref_clk_tc_reg       // stored value if the refclk counter (should = TC)
   );

   // Simple decoder for the slave address

   wire [2:0] address_decode;

   assign     address_decode[0] = (csr_addr[1:0] == 2'b00); //status
   assign     address_decode[1] = (csr_addr[1:0] == 2'b01); //cut_count
   assign     address_decode[2] = (csr_addr[1:0] == 2'b10); //ref_clk_tc

   // Decoded address is used to select which internal register is presented on
   // read data port
   // note this is a combinatorial always block so "reg" style definition required

   reg [23:0] csr_readdata_reg;
   always @ (*)
     begin
        case (address_decode[2:0])
          3'b001: csr_readdata_reg  = core_status;
          3'b010: csr_readdata_reg  = cut_count_store;
          3'b100: csr_readdata_reg  = ref_clk_tc_reg;
          default: csr_readdata_reg = core_status;
        endcase // case(address_decode[2:0])
     end

   // wiring internal signal onto top level port
   assign csr_readdata = {8'b0,csr_readdata_reg};

endmodule

`default_nettype wire
