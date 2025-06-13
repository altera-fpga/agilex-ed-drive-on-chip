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

# Create script specific parameters and default values

set_shell_parameter P_MAX_TEMP              {60}
set_shell_parameter P_MIN_TEMP              {0}
set_shell_parameter P_TEMP_WIDTH            {8}
set_shell_parameter P_DATA_WIDTH            {9}
set_shell_parameter P_WAIT_LIMIT_MS         {1}
set_shell_parameter P_WAIT_COUNTER_WIDTH    {16}
# Setting the ESL clock to an "arbitrary" value to provide "heterogeneity" to the design
# as the ESL should be "external" to the FPGA chip, hence its clock is not synchronized
# or derived from any clock used by other Safety IP.
set_shell_parameter ESL_CLOCK_FREQ_HZ       {20031299}
set_shell_parameter FPGA_CH_CLOCK_FREQ_HZ   {100000000}

# =====================================================================

proc derive_parameters {param_array} {

}

# Define the procedures used by the create_subsystems_qsys.tcl script
proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_esl_subsystem
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

  file_copy ${v_subsystem_source_path}/../non_qpds_ip/esl_safe_doc      ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/esl_subsystem.ipx ${v_project_path}/non_qpds_ip/user
}

# Create the drive subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem
proc create_esl_subsystem {} {

  set v_project_path          [get_shell_parameter PROJECT_PATH]
  set v_instance_name         [get_shell_parameter INSTANCE_NAME]
  set v_p_maxtemp             [get_shell_parameter P_MAX_TEMP]
  set v_p_mintemp             [get_shell_parameter P_MIN_TEMP]
  set v_p_tempwidth           [get_shell_parameter P_TEMP_WIDTH]
  set v_p_datawidth           [get_shell_parameter P_DATA_WIDTH]
  set v_p_waitlimit_ms        [get_shell_parameter P_WAIT_LIMIT_MS]
  set v_p_wait_counter_width  [get_shell_parameter P_WAIT_COUNTER_WIDTH]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys
  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  # Create instances
  add_instance ctrl_clk_bridge          altera_clock_bridge
  add_instance ctrl_rst_bridge          altera_reset_bridge
  add_instance esl_block                esl_safe_doc

  # Set the instance parameters

  #---------------------------------------------------------------
  # cpu_clk_bridge
  set_instance_parameter_value  ctrl_clk_bridge  EXPLICIT_CLOCK_RATE    {0}
  set_instance_parameter_value  ctrl_clk_bridge  NUM_CLOCK_OUTPUTS      1

  #---------------------------------------------------------------
  # cpu_rst_bridge
  set_instance_parameter_value  ctrl_rst_bridge  ACTIVE_LOW_RESET       0
  set_instance_parameter_value  ctrl_rst_bridge  SYNCHRONOUS_EDGES      deassert
  set_instance_parameter_value  ctrl_rst_bridge  NUM_RESET_OUTPUTS      1
  set_instance_parameter_value  ctrl_rst_bridge  USE_RESET_REQUEST      0
  set_instance_parameter_value  ctrl_rst_bridge  SYNC_RESET             0

  #---------------------------------------------------------------
  # shared_mem
  set_instance_parameter_value   esl_block       P_MAX_TEMP             ${v_p_maxtemp}
  set_instance_parameter_value   esl_block       P_MIN_TEMP             ${v_p_mintemp}
  set_instance_parameter_value   esl_block       P_TEMP_WIDTH           ${v_p_tempwidth}
  set_instance_parameter_value   esl_block       P_DATA_WIDTH           ${v_p_datawidth}
  set_instance_parameter_value   esl_block       P_WAIT_LIMIT_MS        ${v_p_waitlimit_ms}
  set_instance_parameter_value   esl_block       P_WAIT_COUNTER_WIDTH   ${v_p_wait_counter_width}

  # Create internal subsystem connections
  add_connection  ctrl_clk_bridge.out_clk     esl_block.esl_clk
  add_connection  ctrl_clk_bridge.out_clk     ctrl_rst_bridge.clk
  add_connection  ctrl_rst_bridge.out_reset   esl_block.esl_reset

  # Add interfaces to the boundary of the subsystem
  add_interface          i_clk          clock      sink
  set_interface_property i_clk          export_of  ctrl_clk_bridge.in_clk

  add_interface          clk_hps        clock      sink
  set_interface_property clk_hps        export_of  esl_block.clk_hps

  add_interface          clk_fpga       clock      sink
  set_interface_property clk_fpga       export_of  esl_block.clk_fpga

  add_interface          i_reset        reset      sink
  set_interface_property i_reset        export_of  ctrl_rst_bridge.in_reset

  # Exposing ESL End Conduits
  add_interface             c_memory_fault    conduit      end
  set_interface_property    c_memory_fault    export_of    esl_block.c_memory_fault

  add_interface             c_esl_safety      conduit      end
  set_interface_property    c_esl_safety      export_of    esl_block.c_esl_safety

  add_interface             c_hardware_esl    conduit      end
  set_interface_property    c_hardware_esl    export_of    esl_block.c_hardware_esl

  add_interface             c_esl_hps         conduit      end
  set_interface_property    c_esl_hps         export_of    esl_block.c_esl_hps

  add_interface             c_esl             conduit      start
  set_interface_property    c_esl             export_of    esl_block.c_esl

  sync_sysinfo_parameters
  save_system
}


proc edit_top_level_qsys {} {

  set v_project_name  [get_shell_parameter PROJECT_NAME]
  set v_project_path  [get_shell_parameter PROJECT_PATH]
  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  load_system  ${v_project_path}/rtl/${v_project_name}_qsys.qsys
  add_instance ${v_instance_name} ${v_instance_name}

  add_interface             "${v_instance_name}_c_esl_hps"    conduit      end
  set_interface_property    "${v_instance_name}_c_esl_hps"    export_of    ${v_instance_name}.c_esl_hps

  sync_sysinfo_parameters
  save_system
}


# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top qsys level
proc add_auto_connections {} {
  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_esl_clk_freq        [get_shell_parameter ESL_CLOCK_FREQ_HZ]
  set v_fpga_ch_clk_freq    [get_shell_parameter FPGA_CH_CLOCK_FREQ_HZ]

  add_auto_connection ${v_instance_name} i_clk          ${v_esl_clk_freq}
  add_auto_connection ${v_instance_name} i_reset        ${v_esl_clk_freq}

  add_auto_connection ${v_instance_name} c_esl_safety   c_esl_safety
  add_auto_connection ${v_instance_name} c_hardware_esl c_hardware_esl
  add_auto_connection ${v_instance_name} c_esl          c_powerdown_esl
  add_auto_connection ${v_instance_name} clk_hps        h2f_user0_clock
  add_auto_connection ${v_instance_name} clk_fpga       ${v_fpga_ch_clk_freq}

  add_auto_connection ${v_instance_name} c_memory_fault c_memory_fault

}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  add_qsys_inst_exports_list    "${v_instance_name}_c_esl_hps_hps_is_safe_p"          "hps_gpo\[0\]"
  add_qsys_inst_exports_list    "${v_instance_name}_c_esl_hps_hps_is_safe_n"          "hps_gpo\[1\]"
  add_qsys_inst_exports_list    "${v_instance_name}_c_esl_hps_hps_compare_good_p"     "hps_gpo\[2\]"
  add_qsys_inst_exports_list    "${v_instance_name}_c_esl_hps_hps_compare_good_n"     "hps_gpo\[3\]"
  add_qsys_inst_exports_list    "${v_instance_name}_c_esl_hps_motor_powerdown_p"      "hps_gpi\[0\]"
  add_qsys_inst_exports_list    "${v_instance_name}_c_esl_hps_motor_powerdown_n"      "hps_gpi\[1\]"

}