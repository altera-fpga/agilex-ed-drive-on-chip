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

set_shell_parameter AXI_HOST             {}
set_shell_parameter P_ENABLE_SING_BITS   {0}
set_shell_parameter P_ESL_BITS           {0}
set_shell_parameter ESL_CLOCK_FREQ_HZ    {20031299}
set_shell_parameter HW_IP_CLOCK_FREQ_HZ  {100000000}


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

  exec cp -rf ${v_subsystem_source_path}/../non_qpds_ip/hardware_ip \
              ${v_project_path}/non_qpds_ip/user
  file_copy   ${v_subsystem_source_path}/../non_qpds_ip/hardware_ip_subsystem.ipx \
              ${v_project_path}/non_qpds_ip/user
  exec cp -rf ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_axi_gpio \
              ${v_project_path}/non_qpds_ip/shell
  exec cp -rf ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_axil2apb \
              ${v_project_path}/non_qpds_ip/shell
  file_copy   ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_axi.ipx \
              ${v_project_path}/non_qpds_ip/shell
}

# Create the drive subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem
proc create_hw_subsystem {} {

  set v_project_path        [get_shell_parameter PROJECT_PATH]
  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_p_enable_sing_bits  [get_shell_parameter P_ENABLE_SING_BITS]
  set v_p_esl_bits          [get_shell_parameter P_ESL_BITS]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys
  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  # Create instances
  add_instance      ctrl_clk_bridge        altera_clock_bridge
  add_instance      ctrl_rst_bridge        altera_reset_bridge

  add_instance      axi_clk_bridge         altera_clock_bridge
  add_instance      axi_rst_bridge         altera_reset_bridge

  add_instance      hardware_block         hardware_ip

  # Set the instance parameters

  #---------------------------------------------------------------
  # cpu_clk_bridge
  set_instance_parameter_value  ctrl_clk_bridge  EXPLICIT_CLOCK_RATE        {0}
  set_instance_parameter_value  ctrl_clk_bridge  NUM_CLOCK_OUTPUTS          1

  #---------------------------------------------------------------
  # cpu_rst_bridge
  set_instance_parameter_value  ctrl_rst_bridge  ACTIVE_LOW_RESET           0
  set_instance_parameter_value  ctrl_rst_bridge  SYNCHRONOUS_EDGES          deassert
  set_instance_parameter_value  ctrl_rst_bridge  NUM_RESET_OUTPUTS          1
  set_instance_parameter_value  ctrl_rst_bridge  USE_RESET_REQUEST          0
  set_instance_parameter_value  ctrl_rst_bridge  SYNC_RESET                 0

  #---------------------------------------------------------------
  # cpu_clk_bridge
  set_instance_parameter_value  axi_clk_bridge  EXPLICIT_CLOCK_RATE         {0}
  set_instance_parameter_value  axi_clk_bridge  NUM_CLOCK_OUTPUTS           1

  #---------------------------------------------------------------
  # axi_rst_bridge
  set_instance_parameter_value  axi_rst_bridge  ACTIVE_LOW_RESET            1
  set_instance_parameter_value  axi_rst_bridge  SYNCHRONOUS_EDGES           deassert
  set_instance_parameter_value  axi_rst_bridge  NUM_RESET_OUTPUTS           1
  set_instance_parameter_value  axi_rst_bridge  USE_RESET_REQUEST           0
  set_instance_parameter_value  axi_rst_bridge  SYNC_RESET                  0

  #---------------------------------------------------------------
  # Hardware Block

  set_instance_parameter_value hardware_block   P_SINGULAR_BITS             ${v_p_enable_sing_bits}
  set_instance_parameter_value hardware_block   P_TSENSOR_0                 1
  set_instance_parameter_value hardware_block   P_TSENSOR_1                 1
  set_instance_parameter_value hardware_block   P_TSENSOR_2                 0
  set_instance_parameter_value hardware_block   P_TSENSOR_3                 1
  set_instance_parameter_value hardware_block   P_TSENSOR_4                 1

  #---------------------------------------------------------------
  # Create internal subsystem connections
  add_connection  ctrl_clk_bridge.out_clk     hardware_block.clk
  add_connection  ctrl_clk_bridge.out_clk     ctrl_rst_bridge.clk

  add_connection  ctrl_rst_bridge.out_reset   hardware_block.reset

  add_connection  axi_clk_bridge.out_clk      hardware_block.s_axi_aclk
  add_connection  axi_clk_bridge.out_clk      axi_rst_bridge.clk

  add_connection  axi_rst_bridge.out_reset    hardware_block.s_axi_aresetn

  # Add interfaces to the boundary of the subsystem
  add_interface          i_clk          clock      sink
  set_interface_property i_clk          export_of  ctrl_clk_bridge.in_clk

  add_interface          i_reset        reset      sink
  set_interface_property i_reset        export_of  ctrl_rst_bridge.in_reset

  add_interface          s_axi_aclk     clock      sink
  set_interface_property s_axi_aclk     export_of  axi_clk_bridge.in_clk

  add_interface          s_axi_aresetn  reset      sink
  set_interface_property s_axi_aresetn  export_of  axi_rst_bridge.in_reset

  if {${v_p_enable_sing_bits}} {
    add_interface           pwr_good_p          conduit         Output 1
    set_interface_property  pwr_good_p          export_of       hardware_block.dup_pwr_good_p
    add_interface           pwr_good_n          conduit         sink
    set_interface_property  pwr_good_n          export_of       hardware_block.dup_pwr_good_n
    add_interface           temp_good_p         conduit         sink
    set_interface_property  temp_good_p         export_of       hardware_block.dup_temp_good_p
    add_interface           temp_good_n         conduit         sink
    set_interface_property  temp_good_n         export_of       hardware_block.dup_temp_good_n
    add_interface           cram_good_p         conduit         sink
    set_interface_property  cram_good_p         export_of       hardware_block.dup_cram_good_p
    add_interface           cram_good_n         conduit         sink
    set_interface_property  cram_good_n         export_of       hardware_block.dup_cram_good_n
  }

  if {${v_p_esl_bits}} {
    add_interface                   c_hardware_esl     conduit      start
    set_interface_property          c_hardware_esl     export_of    hardware_block.c_hardware_esl
  }

  add_interface           s_axi         conduit         sink
  set_interface_property  s_axi         export_of       hardware_block.s_axi

  sync_sysinfo_parameters
  save_system
}

proc edit_top_level_qsys {} {

  set v_project_name       [get_shell_parameter PROJECT_NAME]
  set v_project_path       [get_shell_parameter PROJECT_PATH]
  set v_instance_name      [get_shell_parameter INSTANCE_NAME]
  set v_p_enable_sing_bits [get_shell_parameter P_ENABLE_SING_BITS]

  load_system ${v_project_path}/rtl/${v_project_name}_qsys.qsys

  add_instance ${v_instance_name} ${v_instance_name}

  if {${v_p_enable_sing_bits}} {
    add_interface               ${v_instance_name}_pwr_good_p       conduit       sink
    set_interface_property      ${v_instance_name}_pwr_good_p       export_of     ${v_instance_name}.pwr_good_p
    add_interface               ${v_instance_name}_pwr_good_n       conduit       sink
    set_interface_property      ${v_instance_name}_pwr_good_n       export_of     ${v_instance_name}.pwr_good_n

    add_interface               ${v_instance_name}_temp_good_p       conduit       sink
    set_interface_property      ${v_instance_name}_temp_good_p       export_of     ${v_instance_name}.temp_good_p
    add_interface               ${v_instance_name}_temp_good_n       conduit       sink
    set_interface_property      ${v_instance_name}_temp_good_n       export_of     ${v_instance_name}.temp_good_n

    add_interface               ${v_instance_name}_cram_good_p       conduit       sink
    set_interface_property      ${v_instance_name}_cram_good_p       export_of     ${v_instance_name}.cram_good_p
    add_interface               ${v_instance_name}_cram_good_n       conduit       sink
    set_interface_property      ${v_instance_name}_cram_good_n       export_of     ${v_instance_name}.cram_good_n
  }

  sync_sysinfo_parameters
  save_system
}

# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top Platform Designer level
proc add_auto_connections {} {
  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_is_esl              [get_shell_parameter P_ESL_BITS]
  set v_axi_host            [get_shell_parameter AXI_HOST]
  set v_esl_clk_freq        [get_shell_parameter ESL_CLOCK_FREQ_HZ]
  set v_hw_ip_clk_freq      [get_shell_parameter HW_IP_CLOCK_FREQ_HZ]

  if {${v_is_esl}} {
    add_auto_connection ${v_instance_name} i_clk            ${v_esl_clk_freq}
    add_auto_connection ${v_instance_name} i_reset          ${v_esl_clk_freq}
    add_auto_connection ${v_instance_name} c_hardware_esl   c_hardware_esl
  } else {
    add_auto_connection ${v_instance_name} i_clk            ${v_hw_ip_clk_freq}
    add_auto_connection ${v_instance_name} i_reset          ${v_hw_ip_clk_freq}
  }

    add_auto_connection ${v_instance_name} s_axi_aclk       ${v_hw_ip_clk_freq}
    add_auto_connection ${v_instance_name} s_axi_aresetn    ${v_hw_ip_clk_freq}

  if {(${v_axi_host} != "NONE") && (${v_axi_host} != "")} {
    add_auto_connection ${v_instance_name} s_axi            ${v_axi_host}_axi_host
  }
}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

  set v_instance_name [get_shell_parameter INSTANCE_NAME]
  set v_p_enable_sing_bits [get_shell_parameter P_ENABLE_SING_BITS]

  if {${v_p_enable_sing_bits}} {
    add_top_port_list output ""  ${v_instance_name}_pwr_good_p
    add_qsys_inst_exports_list   ${v_instance_name}_pwr_good_p_dup_pwr_good_p    ${v_instance_name}_pwr_good_p
    add_top_port_list output ""  ${v_instance_name}_pwr_good_n
    add_qsys_inst_exports_list   ${v_instance_name}_pwr_good_n_dup_pwr_good_n    ${v_instance_name}_pwr_good_n

    add_top_port_list output ""  ${v_instance_name}_temp_good_p
    add_qsys_inst_exports_list   ${v_instance_name}_temp_good_p_dup_temp_good_p  ${v_instance_name}_temp_good_p
    add_top_port_list output ""  ${v_instance_name}_temp_good_n
    add_qsys_inst_exports_list   ${v_instance_name}_temp_good_n_dup_temp_good_n  ${v_instance_name}_temp_good_n

    add_top_port_list output ""  ${v_instance_name}_cram_good_p
    add_qsys_inst_exports_list   ${v_instance_name}_cram_good_p_dup_cram_good_p  ${v_instance_name}_cram_good_p
    add_top_port_list output ""  ${v_instance_name}_cram_good_n
    add_qsys_inst_exports_list   ${v_instance_name}_cram_good_n_dup_cram_good_n  ${v_instance_name}_cram_good_n
  }

}