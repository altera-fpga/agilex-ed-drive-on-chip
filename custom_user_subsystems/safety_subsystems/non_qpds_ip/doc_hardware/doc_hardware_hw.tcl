###################################################################################
# Copyright (C) 2025 Altera Corporation
#
# This software and the related documents are Altera copyrighted materials, and
# your use of them is governed by the express license under which they were
# provided to you ("License"). Unless the License provides otherwise, you may
# not use, modify, copy, publish, distribute, disclose or transmit this software
# or the related documents without Altera's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.
###################################################################################

package require -exact qsys 23.1

############################################################################
# Module Properties
############################################################################

set_module_property NAME                         doc_hardware
set_module_property DESCRIPTION                  "DoC Hardware IP to read Voltage/Temp from SDM using mailbox"
set_module_property DISPLAY_NAME                 "DoC Hardware"
set_module_property VERSION                      1.0
set_module_property GROUP                        "Safe Drive on Chip"
set_module_property DATASHEET_URL                http://www.intel.com
set_module_property EDITABLE                     false
set_module_property AUTHOR                       "Intel Corporation"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property INTERNAL                     false
set_module_property VALIDATION_CALLBACK          val_callback
set_module_property ELABORATION_CALLBACK         elab_callback

############################################################################
# Module File Dependencies
############################################################################

add_fileset          QUARTUS_SYNTH QUARTUS_SYNTH gen_callback ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL     doc_hardware

# ADD FILES....
add_fileset_file    rtl/doc_hardware.sv         SYSTEMVERILOG PATH rtl/doc_hardware.sv
add_fileset_file    rtl/doc_hw_main_ctrl.sv     SYSTEMVERILOG PATH rtl/doc_hw_main_ctrl.sv
add_fileset_file    rtl/doc_hw_cmd.sv           SYSTEMVERILOG PATH rtl/doc_hw_cmd.sv
add_fileset_file    rtl/doc_hw_commands.sv      SYSTEMVERILOG PATH rtl/doc_hw_commands.sv
add_fileset_file    rtl/doc_hw_rsp.sv           SYSTEMVERILOG PATH rtl/doc_hw_rsp.sv
add_fileset_file    rtl/doc_hw_pkg_hw.sv        SYSTEMVERILOG PATH rtl/doc_hw_pkg_hw.sv

############################################################################
# Module parameters
############################################################################

add_parameter          P_TEMP_WIDTH   INTEGER              8
set_parameter_property P_TEMP_WIDTH   DEFAULT_VALUE        8
set_parameter_property P_TEMP_WIDTH   DISPLAY_NAME         "Number of Temp Bits Present"
set_parameter_property P_TEMP_WIDTH   ENABLED              true
set_parameter_property P_TEMP_WIDTH   UNITS                None
set_parameter_property P_TEMP_WIDTH   VISIBLE              true
set_parameter_property P_TEMP_WIDTH   AFFECTS_ELABORATION  true
set_parameter_property P_TEMP_WIDTH   HDL_PARAMETER        true

############################################################################
# Interfaces
############################################################################

add_interface          hw_clk clock                         end
set_interface_property hw_clk ENABLED                       true
set_interface_property hw_clk EXPORT_OF                     ""
set_interface_property hw_clk PORT_NAME_MAP                 ""
set_interface_property hw_clk CMSIS_SVD_VARIABLES           ""
set_interface_property hw_clk SVD_ADDRESS_GROUP             ""
set_interface_property hw_clk IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hw_clk SV_INTERFACE_TYPE             ""
set_interface_property hw_clk SV_INTERFACE_MODPORT_TYPE     ""

add_interface_port     hw_clk hw_clk clk Input 1

add_parameter DERIVED_CLOCK_RATE INTEGER                    0
set_parameter_property DERIVED_CLOCK_RATE DISPLAY_NAME      "Derived clock rate"
set_parameter_property DERIVED_CLOCK_RATE DESCRIPTION       {Clock rate derived from system_info}
set_parameter_property DERIVED_CLOCK_RATE UNITS             Hertz
set_parameter_property DERIVED_CLOCK_RATE SYSTEM_INFO       { CLOCK_RATE "hw_clk" }
set_parameter_property DERIVED_CLOCK_RATE SYSTEM_INFO_TYPE  {CLOCK_RATE}
set_parameter_property DERIVED_CLOCK_RATE ENABLED           false
set_parameter_property DERIVED_CLOCK_RATE VISIBLE           false

add_interface          hw_reset reset                         end
set_interface_property hw_reset associatedClock               hw_clk
set_interface_property hw_reset synchronousEdges              DEASSERT
set_interface_property hw_reset ENABLED                       true
set_interface_property hw_reset EXPORT_OF                     ""
set_interface_property hw_reset PORT_NAME_MAP                 ""
set_interface_property hw_reset CMSIS_SVD_VARIABLES           ""
set_interface_property hw_reset SVD_ADDRESS_GROUP             ""
set_interface_property hw_reset IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hw_reset SV_INTERFACE_TYPE             ""
set_interface_property hw_reset SV_INTERFACE_MODPORT_TYPE     ""

add_interface_port     hw_reset hw_reset reset_n Input 1

############################################################################
# Conduits
############################################################################

# Hardware -> ESL Conduits

add_interface          c_hardware_esl    conduit              start
set_interface_property c_hardware_esl    ENABLED              true
set_interface_property c_hardware_esl    EXPORT_OF            ""
set_interface_property c_hardware_esl    PORT_NAME_MAP        ""
set_interface_property c_hardware_esl    CMSIS_SVD_VARIABLES  ""
set_interface_property c_hardware_esl    SVD_ADDRESS_GROUP    ""

add_interface_port     c_hardware_esl    pwr_good_p           pwr_good_p           Output 1
add_interface_port     c_hardware_esl    pwr_good_n           pwr_good_n           Output 1

add_interface_port     c_hardware_esl    temp_good_p          temp_good_p          Output 1
add_interface_port     c_hardware_esl    temp_good_n          temp_good_n          Output 1

add_interface_port     c_hardware_esl    cram_good_p          cram_good_p          Output 1
add_interface_port     c_hardware_esl    cram_good_n          cram_good_n          Output 1

# temp value output 6 for 6-bits --- 0-60 range...

proc val_callback {} {

}

proc elab_callback {} {

}

proc gen_callback { entity } {

}
