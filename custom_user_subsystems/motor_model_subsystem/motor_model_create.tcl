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

# create script specific parameters and default values

set_shell_parameter DRIVE_NUMBER "0"
# Possible values "NONE" or "auto" or empty {}
set_shell_parameter AVMM_HOST {}
# Possible values 0 / 1
set_shell_parameter EN_POWERDOWN "0"

# =====================================================================

proc derive_parameters {param_array} {

}

# define the procedures used by the create_subsystems_qsys.tcl script

proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_motor_model_subsystem
}

proc post_creation_step {} {
  edit_top_level_qsys
  add_auto_connections
  edit_top_v_file
}

#==========================================================

# Copy files from the Motor Model Subsystem install directory to the target project directory

proc transfer_files {} {

  set v_shell_design_root [get_shell_parameter SHELL_DESIGN_ROOT]
  set v_project_path      [get_shell_parameter PROJECT_PATH]
  set v_instance_name     [get_shell_parameter INSTANCE_NAME]
  set v_family            [get_shell_parameter FAMILY]
  #set v_subsys_dir        "${v_shell_design_root}/motor_model_subsystem"
  set v_subsys_dir        [get_shell_parameter SUBSYSTEM_SOURCE_PATH]



  file_copy   ${v_subsys_dir}/non_qpds_ip/motor_model_conduit_split  ${v_project_path}/non_qpds_ip/user
  file_copy   ${v_subsys_dir}/non_qpds_ip/motor_model_subsystem.ipx  ${v_project_path}/non_qpds_ip/user


  file mkdir  ${v_project_path}/non_qpds_ip/dsp_builder_models
  file mkdir  ${v_project_path}/non_qpds_ip/dsp_builder_gen
  file_copy ${v_subsys_dir}/dsp_builder_models/motor_kit_sim_20MHz    ${v_project_path}/non_qpds_ip/dsp_builder_models

  set v_model_dir   "${v_project_path}/non_qpds_ip/dsp_builder_models/motor_kit_sim_20MHz"
  set v_model_name  "motor_kit_sim_20MHz"

  # needs to be relative to the model directory
  set v_rtl_dir     "./../../dsp_builder_gen"

  #::hls_build_pkg::dsp_builder_build ${v_model_dir} ${v_model_name} ${v_family} ${v_rtl_dir}
  file_copy ${v_subsys_dir}/dsp_builder_models/dsp_builder_gen    ${v_project_path}/non_qpds_ip/

}

# create the motor model subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem

proc create_motor_model_subsystem {} {

  set v_project_path   [get_shell_parameter PROJECT_PATH]
  set v_instance_name  [get_shell_parameter INSTANCE_NAME]
  set v_en_powerdown   [get_shell_parameter EN_POWERDOWN]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  add_instance  clock_bridge    altera_clock_bridge
  add_instance  reset_bridge    altera_reset_bridge
  add_instance  motor_model     motor_kit_sim_20MHz_MotorModel
  add_instance  conduit_split   motor_model_conduit_split

  set_instance_parameter_value  conduit_split   P_EN_POWERDOWN     $v_en_powerdown

  add_connection clock_bridge.out_clk reset_bridge.clk
  add_connection clock_bridge.out_clk motor_model.clock

  add_connection reset_bridge.out_reset motor_model.clock_reset
  add_connection reset_bridge.out_reset motor_model.bus_reset

  add_connection conduit_split.exp   motor_model.exp

  add_interface          i_clk  clock           sink
  set_interface_property i_clk  export_of       clock_bridge.in_clk

  add_interface          i_rst  reset           sink
  set_interface_property i_rst  export_of       reset_bridge.in_reset

  add_interface          i_avmm_agent avalon    agent
  set_interface_property i_avmm_agent export_of motor_model.bus

  add_interface          c_export conduit       end
  set_interface_property c_export export_of     conduit_split.c_export

  if {${v_en_powerdown} != 0} {
    add_interface          c_powerdown_esl conduit     end_esl
    set_interface_property c_powerdown_esl export_of   conduit_split.c_powerdown_esl

    add_interface          c_powerdown_fpga conduit     end_fpga
    set_interface_property c_powerdown_fpga export_of   conduit_split.c_powerdown_fpga

    add_interface          c_powerdown_hps conduit     end_hps
    set_interface_property c_powerdown_hps export_of   conduit_split.c_powerdown_hps

    add_connection         clock_bridge.out_clk    conduit_split.i_clk
  }

  sync_sysinfo_parameters
  save_system

}

# insert the motor model subsystem into the top level qsys system, and add interfaces
# to the boundary of the top level qsys system

proc edit_top_level_qsys {} {

  set v_project_name  [get_shell_parameter PROJECT_NAME]
  set v_project_path  [get_shell_parameter PROJECT_PATH]
  set v_instance_name [get_shell_parameter INSTANCE_NAME]
  set v_en_powerdown  [get_shell_parameter EN_POWERDOWN]

  load_system ${v_project_path}/rtl/${v_project_name}_qsys.qsys

  add_instance ${v_instance_name} ${v_instance_name}

  add_interface          "${v_instance_name}_c_export" conduit     end
  set_interface_property "${v_instance_name}_c_export" export_of   ${v_instance_name}.c_export

  if {${v_en_powerdown} != 0} {
    add_interface          "${v_instance_name}_c_powerdown_hps" conduit     end
    set_interface_property "${v_instance_name}_c_powerdown_hps" export_of   ${v_instance_name}.c_powerdown_hps
  }

  sync_sysinfo_parameters
  save_system

}

# enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top qsys level

proc add_auto_connections {} {

  set v_instance_name [get_shell_parameter INSTANCE_NAME]
  set v_avmm_host     [get_shell_parameter AVMM_HOST]
  set v_en_powerdown  [get_shell_parameter EN_POWERDOWN]

  add_auto_connection ${v_instance_name} i_clk 20000000
  add_auto_connection ${v_instance_name} i_rst 20000000

  if {${v_en_powerdown} != 0} {
    add_auto_connection ${v_instance_name} c_powerdown_esl   c_powerdown_esl
    add_auto_connection ${v_instance_name} c_powerdown_fpga  c_powerdown_fpga
    add_auto_connection ${v_instance_name} c_powerdown_hps   c_powerdown_hps
  }

  add_avmm_connections i_avmm_agent ${v_avmm_host}

}

# insert lines of code into the top level hdl file

proc edit_top_v_file {} {

  set v_instance_name [get_shell_parameter INSTANCE_NAME]
  set v_drive_number  [get_shell_parameter DRIVE_NUMBER ]
  set v_en_powerdown  [get_shell_parameter EN_POWERDOWN]

  add_declaration_list wire "" "drive_${v_drive_number}_ia_sd"
  add_declaration_list wire "" "drive_${v_drive_number}_ib_sd"
  add_declaration_list wire "" "drive_${v_drive_number}_ic_sd"

  add_declaration_list wire "" "drive_${v_drive_number}_Va_sd"
  add_declaration_list wire "" "drive_${v_drive_number}_Vb_sd"
  add_declaration_list wire "" "drive_${v_drive_number}_Vc_sd"

  add_declaration_list wire "" "drive_${v_drive_number}_pwm_u_h"
  add_declaration_list wire "" "drive_${v_drive_number}_pwm_v_h"
  add_declaration_list wire "" "drive_${v_drive_number}_pwm_w_h"
  add_declaration_list wire "" "drive_${v_drive_number}_pwm_u_l"
  add_declaration_list wire "" "drive_${v_drive_number}_pwm_v_l"
  add_declaration_list wire "" "drive_${v_drive_number}_pwm_w_l"

  add_declaration_list wire "" "drive_${v_drive_number}_qep_a"
  add_declaration_list wire "" "drive_${v_drive_number}_qep_b"

  add_declaration_list wire "\[15:0\]" "drive_${v_drive_number}_Theta_one_turn_k"
  add_declaration_list wire ""         "drive_${v_drive_number}_V_DC_link_sd"

  # assumed that the motor model will only be used in conjunction with the driver
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_u_h"                    "drive_${v_drive_number}_pwm_u_h"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_v_h"                    "drive_${v_drive_number}_pwm_v_h"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_w_h"                    "drive_${v_drive_number}_pwm_w_h"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_u_l"                    "drive_${v_drive_number}_pwm_u_l"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_v_l"                    "drive_${v_drive_number}_pwm_v_l"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_w_l"                    "drive_${v_drive_number}_pwm_w_l"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_Theta_one_turn_k"       "drive_${v_drive_number}_Theta_one_turn_k"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_QEP_A"                  "drive_${v_drive_number}_qep_a"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_QEP_B"                  "drive_${v_drive_number}_qep_b"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_ia_sd"                  "drive_${v_drive_number}_ia_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_ib_sd"                  "drive_${v_drive_number}_ib_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_ic_sd"                  "drive_${v_drive_number}_ic_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_Va_sd"                  "drive_${v_drive_number}_Va_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_Vb_sd"                  "drive_${v_drive_number}_Vb_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_Vc_sd"                  "drive_${v_drive_number}_Vc_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_export_data_V_DC_link_sd"           "drive_${v_drive_number}_V_DC_link_sd"

  if {${v_en_powerdown} != 0} {

    add_qsys_inst_exports_list    "${v_instance_name}_c_powerdown_hps_motor_powerdown_p"      "hps_gpo\[4\]"
    add_qsys_inst_exports_list    "${v_instance_name}_c_powerdown_hps_motor_powerdown_n"      "hps_gpo\[5\]"

  }

}