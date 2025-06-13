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

# The Validation Callback proc is called by Platform Designer each time the user modifies a parameter in the IP GUI.
# The Elaboration Callback is called after validation, and also based on PD system changes. Its purpose is to
# define dynamically generated interfaces and signals.
# See the Platform Designer User Guide for further details of how the module properties are used.

############################################################################
# Module Properties
############################################################################
set_module_property NAME                         motor_model_conduit_split
set_module_property DESCRIPTION                  "Conduit Split for Safety Applications"
set_module_property DISPLAY_NAME                 "Motor Model Conduit Split"
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL     motor_model_conduit_split

add_fileset_file    rtl/motor_model_conduit_split.sv    SYSTEMVERILOG   PATH \
                    rtl/motor_model_conduit_split.sv
add_fileset_file    sdc/motor_model_conduit_split.sdc   SDC_ENTITY      PATH \
                    sdc/motor_model_conduit_split.sdc {NO_SDC_PROMOTION}

############################################################################
# Module parameters
############################################################################

add_parameter          P_EN_POWERDOWN      INTEGER              1
set_parameter_property P_EN_POWERDOWN      DEFAULT_VALUE        1
set_parameter_property P_EN_POWERDOWN      DISPLAY_NAME         "Enable Powerdown_p/_n input conduit"
set_parameter_property P_EN_POWERDOWN      DESCRIPTION \
    "Enable Powerdown_p/_n input conduit - if unticked then the Powerdown_p/n will be tied deasserted"
set_parameter_property P_EN_POWERDOWN      ALLOWED_RANGES       {0:1}
set_parameter_property P_EN_POWERDOWN      DISPLAY_HINT         "Boolean"
set_parameter_property P_EN_POWERDOWN      AFFECTS_ELABORATION  true
set_parameter_property P_EN_POWERDOWN      HDL_PARAMETER        true
set_parameter_property P_EN_POWERDOWN      VISIBLE              true

############################################################################
# Interfaces
############################################################################

add_interface           i_clk           clock               end
set_interface_property  i_clk           ENABLED             true
set_interface_property  i_clk           EXPORT_OF           ""
set_interface_property  i_clk           PORT_NAME_MAP       ""
set_interface_property  i_clk           CMSIS_SVD_VARIABLES ""
set_interface_property  i_clk           SVD_ADDRESS_GROUP   ""
set_interface_property  i_clk           IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property  i_clk           SV_INTERFACE_TYPE   ""
set_interface_property  i_clk           SV_INTERFACE_MODPORT_TYPE ""
add_interface_port      i_clk           clk clk Input 1

add_interface           exp             conduit end
set_interface_property  exp             ENABLED true
add_interface_port      exp             o_u_h               data_u_h                Output 1
set_port_property       o_u_h           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_v_h               data_v_h                Output 1
set_port_property       o_v_h           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_w_h               data_w_h                Output 1
set_port_property       o_w_h           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_u_l               data_u_l                Output 1
set_port_property       o_u_l           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_v_l               data_v_l                Output 1
set_port_property       o_v_l           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_w_l               data_w_l                Output 1
set_port_property       o_w_l           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_powerdown_p       data_powerdown_p        Output 1
set_port_property       o_powerdown_p   VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             o_powerdown_n       data_powerdown_n        Output 1
set_port_property       o_powerdown_n   VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_ia_sd             data_ia_sd              Input 1
set_port_property       i_ia_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_ib_sd             data_ib_sd              Input 1
set_port_property       i_ib_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_ic_sd             data_ic_sd              Input 1
set_port_property       i_ic_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_Va_sd             data_Va_sd              Input 1
set_port_property       i_Va_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_Vb_sd             data_Vb_sd              Input 1
set_port_property       i_Vb_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_Vc_sd             data_Vc_sd              Input 1
set_port_property       i_Vc_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_QEP_A             data_QEP_A              Input 1
set_port_property       i_QEP_A         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_QEP_B             data_QEP_B              Input 1
set_port_property       i_QEP_B         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      exp             i_Theta_one_turn_k  data_Theta_one_turn_k   Input 16
add_interface_port      exp             i_V_DC_link_sd      data_V_DC_link_sd       Input 1
set_port_property       i_V_DC_link_sd  VHDL_TYPE           STD_LOGIC_VECTOR

add_interface           c_export        conduit             end
set_interface_property  c_export        ENABLED             true
add_interface_port      c_export        i_u_h               data_u_h                Input 1
set_port_property       i_u_h           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        i_v_h               data_v_h                Input 1
set_port_property       i_v_h           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        i_w_h               data_w_h                Input 1
set_port_property       i_w_h           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        i_u_l               data_u_l                Input 1
set_port_property       i_u_l           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        i_v_l               data_v_l                Input 1
set_port_property       i_v_l           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        i_w_l               data_w_l                Input 1
set_port_property       i_w_l           VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_ia_sd             data_ia_sd              Output 1
set_port_property       o_ia_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_ib_sd             data_ib_sd              Output 1
set_port_property       o_ib_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_ic_sd             data_ic_sd              Output 1
set_port_property       o_ic_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_Va_sd             data_Va_sd              Output 1
set_port_property       o_Va_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_Vb_sd             data_Vb_sd              Output 1
set_port_property       o_Vb_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_Vc_sd             data_Vc_sd              Output 1
set_port_property       o_Vc_sd         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_QEP_A             data_QEP_A              Output 1
set_port_property       o_QEP_A         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_QEP_B             data_QEP_B              Output 1
set_port_property       o_QEP_B         VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_export        o_Theta_one_turn_k  data_Theta_one_turn_k   Output 16
add_interface_port      c_export        o_V_DC_link_sd      data_V_DC_link_sd       Output 1
set_port_property       o_V_DC_link_sd  VHDL_TYPE           STD_LOGIC_VECTOR

add_interface           c_powerdown_esl     conduit             end
add_interface_port      c_powerdown_esl     i_powerdown_esl_p   motor_powerdown_p   Input 1
set_port_property       i_powerdown_esl_p   VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_powerdown_esl     i_powerdown_esl_n   motor_powerdown_n   Input 1
set_port_property       i_powerdown_esl_n   VHDL_TYPE           STD_LOGIC_VECTOR

add_interface           c_powerdown_fpga    conduit end
add_interface_port      c_powerdown_fpga    i_powerdown_fpga_p  motor_powerdown_p   Input 1
set_port_property       i_powerdown_fpga_p  VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_powerdown_fpga    i_powerdown_fpga_n  motor_powerdown_n   Input 1
set_port_property       i_powerdown_fpga_n  VHDL_TYPE           STD_LOGIC_VECTOR

add_interface           c_powerdown_hps     conduit end
add_interface_port      c_powerdown_hps     i_powerdown_hps_p   motor_powerdown_p   Input 1
set_port_property       i_powerdown_hps_p   VHDL_TYPE           STD_LOGIC_VECTOR
add_interface_port      c_powerdown_hps     i_powerdown_hps_n   motor_powerdown_n   Input 1
set_port_property       i_powerdown_hps_n   VHDL_TYPE           STD_LOGIC_VECTOR

proc val_callback {} {

}

proc elab_callback {} {
  if { [get_parameter_value P_EN_POWERDOWN] == 0} {
    set_interface_property  i_clk             ENABLED    false
    set_interface_property  c_powerdown_esl   ENABLED    false
    set_interface_property  c_powerdown_fpga  ENABLED    false
    set_interface_property  c_powerdown_hps   ENABLED    false
  } else {
    set_interface_property  i_clk             ENABLED    true
    set_interface_property  c_powerdown_esl   ENABLED    true
    set_interface_property  c_powerdown_fpga  ENABLED    true
    set_interface_property  c_powerdown_hps   ENABLED    true
  }
}

proc gen_callback { entity } {

}
