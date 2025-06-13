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

# create script specific parameters and default values

set_shell_parameter P_TEMP_WIDTH  {8}

# =====================================================================

proc derive_parameters {param_array} {

}

# Define the procedures used by the create_subsystems_qsys.tcl script
proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_hw_subsystem
}

proc post_creation_step {} {
  edit_top_level_qsys
  add_auto_connections
  edit_top_v_file
}

#==========================================================

# Copy files from the shell install directory to the target project directory
proc transfer_files {} {

  set v_project_path            [get_shell_parameter PROJECT_PATH]
  set v_subsystem_source_path   [get_shell_parameter SUBSYSTEM_SOURCE_PATH]

  file_copy ${v_subsystem_source_path}/../non_qpds_ip/doc_hardware             ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/hardware_subsystem.ipx   ${v_project_path}/non_qpds_ip/user
}

# Create the drive subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem
proc create_hw_subsystem {} {

  set v_project_path   [get_shell_parameter PROJECT_PATH]
  set v_instance_name  [get_shell_parameter INSTANCE_NAME]
  set v_p_tempwidth    [get_shell_parameter P_TEMP_WIDTH]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys
  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  # Create instances
  add_instance      ctrl_clk_bridge        altera_clock_bridge
  add_instance      ctrl_rst_bridge        altera_reset_bridge
  add_instance      hardware_block         doc_hardware

  # Set the instance parameters

  #---------------------------------------------------------------
  # cpu_clk_bridge
  set_instance_parameter_value  ctrl_clk_bridge  EXPLICIT_CLOCK_RATE       {0}
  set_instance_parameter_value  ctrl_clk_bridge  NUM_CLOCK_OUTPUTS         1

  #---------------------------------------------------------------
  # cpu_rst_bridge
  set_instance_parameter_value  ctrl_rst_bridge  ACTIVE_LOW_RESET          0
  set_instance_parameter_value  ctrl_rst_bridge  SYNCHRONOUS_EDGES         deassert
  set_instance_parameter_value  ctrl_rst_bridge  NUM_RESET_OUTPUTS         1
  set_instance_parameter_value  ctrl_rst_bridge  USE_RESET_REQUEST         0
  set_instance_parameter_value  ctrl_rst_bridge  SYNC_RESET                0

  #---------------------------------------------------------------
  # hardware_block
  set_instance_parameter_value   hardware_block   P_TEMP_WIDTH             ${v_p_tempwidth}

  # Create internal subsystem connections
  add_connection  ctrl_clk_bridge.out_clk     hardware_block.hw_clk
  add_connection  ctrl_clk_bridge.out_clk     ctrl_rst_bridge.clk
  add_connection  ctrl_rst_bridge.out_reset   hardware_block.hw_reset

  # Add interfaces to the boundary of the subsystem
  add_interface          i_clk          clock      sink
  set_interface_property i_clk          export_of  ctrl_clk_bridge.in_clk
  add_interface          i_reset        reset      sink
  set_interface_property i_reset        export_of  ctrl_rst_bridge.in_reset

  # Exposing start conduit
  add_interface                   c_hardware_esl     conduit      start
  set_interface_property          c_hardware_esl     export_of    hardware_block.c_hardware_esl

  sync_sysinfo_parameters
  save_system

}


proc edit_top_level_qsys {} {

  set v_project_name  [get_shell_parameter PROJECT_NAME]
  set v_project_path  [get_shell_parameter PROJECT_PATH]
  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  load_system  ${v_project_path}/rtl/${v_project_name}_qsys.qsys
  add_instance ${v_instance_name} $v_instance_name

  sync_sysinfo_parameters
  save_system
}


# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top Platform Designer level
proc add_auto_connections {} {
  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  add_auto_connection ${v_instance_name} i_clk          20031299
  add_auto_connection ${v_instance_name} i_reset        20031299
  add_auto_connection ${v_instance_name} c_hardware_esl c_hardware_esl
}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

}