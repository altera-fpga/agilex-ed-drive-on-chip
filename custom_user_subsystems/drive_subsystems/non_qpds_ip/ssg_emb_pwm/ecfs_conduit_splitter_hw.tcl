###################################################################################
# Copyright (C) 2025 Intel Corporation
#
# This software and the related documents are Intel copyrighted materials, and
# your use of them is governed by the express license under which they were
# provided to you ("License"). Unless the License provides otherwise, you may
# not use, modify, copy, publish, distribute, disclose or transmit this software
# or the related documents without Intel's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.
###################################################################################

# +-----------------------------------
# | request TCL package from ACDS 9.1
# |
package require -exact sopc 9.1
# |
# +-----------------------------------

# +-----------------------------------
# | module conduit splitter
# |
set_module_property     DESCRIPTION                     "A conduit signal splitter"
set_module_property     NAME                            ecfs_conduit_splitter
set_module_property     VERSION                         15.1
set_module_property     INTERNAL                        false
set_module_property     GROUP                           "Motor Control Suite"
set_module_property     AUTHOR                          "Altera Corporation"
set_module_property     DISPLAY_NAME                    "ECFS Conduit Splitter"
set_module_property     DATASHEET_URL                   http://www.altera.com/literature/ug/ug_embedded_ip.pdf
set_module_property     TOP_LEVEL_HDL_FILE              ecfs_conduit_splitter.v
set_module_property     TOP_LEVEL_HDL_MODULE            ecfs_conduit_splitter
set_module_property     INSTANTIATE_IN_SYSTEM_MODULE    true
set_module_property     EDITABLE                        false
set_module_property     ELABORATION_CALLBACK            elaborate
# |
# +-----------------------------------

# +-----------------------------------
# | files
# |
add_file ecfs_conduit_splitter.v {SYNTHESIS SIMULATION}
# |
# +-----------------------------------

# +-----------------------------------
# | parameters
# |
add_parameter           OUTPUT_NUM  INTEGER             2
set_parameter_property  OUTPUT_NUM  ALLOWED_RANGES      {0:5}
set_parameter_property  OUTPUT_NUM  DISPLAY_NAME        NUM_OF_OUTPUT_PORTS
set_parameter_property  OUTPUT_NUM  UNITS               None
set_parameter_property  OUTPUT_NUM  DISPLAY_HINT        ""
set_parameter_property  OUTPUT_NUM  AFFECTS_GENERATION  true
set_parameter_property  OUTPUT_NUM  IS_HDL_PARAMETER    true

add_interface       conduit_input conduit       end
add_interface_port  conduit_input conduit_input export Input 1

proc elaborate {} {
    set v_output_num [get_parameter_value OUTPUT_NUM]
    for { set v_i 0 } { ${v_i} <  ${v_output_num} } { incr v_i } {
        set v_port_name "conduit_output_${v_i}"
        add_interface ${v_port_name} conduit start
        set_interface_property ${v_port_name} ENABLED true
        add_interface_port ${v_port_name} ${v_port_name} export Output 1
    }
}
