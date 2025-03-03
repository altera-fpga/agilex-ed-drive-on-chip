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

# Create script specific parameters and default values

set_shell_parameter AXI_HOST                {}
set_shell_parameter AXI_HOST_1              {}
set_shell_parameter APB_HOST                {}
set_shell_parameter APB_HOST_1              {}
set_shell_parameter P_S_AXI_ADDR_WIDTH      {4}
set_shell_parameter S0_BUS_TYPE             {AXI4-Lite}
set_shell_parameter S1_BUS_TYPE             {APB}
set_shell_parameter SHMEM_SUB_CLOCK_FREQ_HZ {100000000}

# =====================================================================

proc derive_parameters {param_array} {

}

# Define the procedures used by the create_subsystems_qsys.tcl script
proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_shared_mem_subsystem
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

  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_shared_mem \
              ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/shared_mem_subsystem.ipx \
              ${v_project_path}/non_qpds_ip/user

}

# Create the shared memory subsystem, add the required IP, parameterize it as appropriate,
# Add internal connections, and add interfaces to the boundary of the subsystem
proc create_shared_mem_subsystem {} {

  set v_project_path        [get_shell_parameter PROJECT_PATH]
  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_s_axi_addr_width    [get_shell_parameter P_S_AXI_ADDR_WIDTH]
  set v_s0_bus_type         [get_shell_parameter S0_BUS_TYPE]
  set v_s1_bus_type         [get_shell_parameter S1_BUS_TYPE]
  set v_shmem_sub_clk_freq  [get_shell_parameter SHMEM_SUB_CLOCK_FREQ_HZ]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys
  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  # Create instances

  add_instance ctrl_clk_bridge          altera_clock_bridge
  add_instance ctrl_rst_bridge          altera_reset_bridge

  add_instance shared_mem               intel_fpga_shared_mem

  # Set the instance parameters

  #---------------------------------------------------------------
  # cpu_clk_bridge
  set_instance_parameter_value  ctrl_clk_bridge  EXPLICIT_CLOCK_RATE    ${v_shmem_sub_clk_freq}
  set_instance_parameter_value  ctrl_clk_bridge  NUM_CLOCK_OUTPUTS      1

  #---------------------------------------------------------------
  # cpu_rst_bridge
  set_instance_parameter_value  ctrl_rst_bridge  ACTIVE_LOW_RESET       0
  set_instance_parameter_value  ctrl_rst_bridge  SYNCHRONOUS_EDGES      deassert
  set_instance_parameter_value  ctrl_rst_bridge  NUM_RESET_OUTPUTS      1
  set_instance_parameter_value  ctrl_rst_bridge  USE_RESET_REQUEST      0
  set_instance_parameter_value  ctrl_rst_bridge  SYNC_RESET             0

  #---------------------------------------------------------------
  # shred_mem
  set_instance_parameter_value  shared_mem  P_S_AXI_ADDR_WIDTH          ${v_s_axi_addr_width}
  set_instance_parameter_value  shared_mem  S0_BUS_TYPE                 ${v_s0_bus_type}
  set_instance_parameter_value  shared_mem  S1_BUS_TYPE                 ${v_s1_bus_type}

  # Create internal subsystem connections
  add_connection  ctrl_clk_bridge.out_clk     shared_mem.s_axi_aclk
  add_connection  ctrl_clk_bridge.out_clk     ctrl_rst_bridge.clk

  add_connection  ctrl_rst_bridge.out_reset   shared_mem.s_axi_aresetn

  # Add interfaces to the boundary of the subsystem
  add_interface                 i_clk           clock       sink
  set_interface_property        i_clk           export_of   ctrl_clk_bridge.in_clk

  add_interface                 i_reset         reset       sink
  set_interface_property        i_reset         export_of   ctrl_rst_bridge.in_reset

  if {${v_s0_bus_type} == "APB"} {
    add_interface               s0_apb          apb         end
    set_interface_property      s0_apb          export_of   shared_mem.s0_apb
    lock_avalon_base_address    shared_mem.s0_apb
  } else {
    add_interface               s0_axi          axi4lite    end
    set_interface_property      s0_axi          export_of   shared_mem.s0_axi
    lock_avalon_base_address    shared_mem.s0_axi
  }

  if {${v_s1_bus_type} == "APB"} {
    add_interface               s1_apb          apb         end
    set_interface_property      s1_apb          export_of   shared_mem.s1_apb
    lock_avalon_base_address    shared_mem.s1_apb
  } else {
    add_interface               s1_axi          axi4lite    end
    set_interface_property      s1_axi          export_of   shared_mem.s1_axi
    lock_avalon_base_address    shared_mem.s1_axi
  }

  add_interface                 c_memory_fault  conduit     start
  set_interface_property        c_memory_fault  export_of   shared_mem.c_memory_fault

  add_interface                 c_safety_mem    conduit     end
  set_interface_property        c_safety_mem    export_of   shared_mem.c_safety_mem

  sync_sysinfo_parameters
  save_system

}

# Insert the shared memory subsystem into the top level Platform Designer system,
# and add interfaces to the boundary of the top level
proc edit_top_level_qsys {} {

  set v_project_name  [get_shell_parameter PROJECT_NAME]
  set v_project_path  [get_shell_parameter PROJECT_PATH]
  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  load_system  ${v_project_path}/rtl/${v_project_name}_qsys.qsys
  add_instance ${v_instance_name} ${v_instance_name}

  sync_sysinfo_parameters
  save_system

}

# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top Platform Designer level
proc add_auto_connections {} {

  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_s0_bus_type         [get_shell_parameter S0_BUS_TYPE]
  set v_s1_bus_type         [get_shell_parameter S1_BUS_TYPE]

  set v_axi_host            [get_shell_parameter AXI_HOST]
  set v_axi_host_1          [get_shell_parameter AXI_HOST_1]
  set v_apb_host            [get_shell_parameter APB_HOST]
  set v_apb_host_1          [get_shell_parameter APB_HOST_1]
  set v_shmem_sub_clk_freq  [get_shell_parameter SHMEM_SUB_CLOCK_FREQ_HZ]

  add_auto_connection       ${v_instance_name}      i_clk           ${v_shmem_sub_clk_freq}
  add_auto_connection       ${v_instance_name}      i_reset         ${v_shmem_sub_clk_freq}

  if {(${v_axi_host} != "NONE") && (${v_axi_host} != "")} {
    if {${v_s0_bus_type} != "APB"} {
      add_auto_connection   ${v_instance_name}      s0_axi          ${v_axi_host}_axi_host
    }
  }

  if {(${v_axi_host_1} != "NONE") && (${v_axi_host_1} != "")} {
    if {${v_s1_bus_type} != "APB"} {
      add_auto_connection   ${v_instance_name}      s1_axi          ${v_axi_host_1}_axi_host
    }
  }

  if {(${v_apb_host} != "NONE") && (${v_apb_host} != "")} {
    if {${v_s0_bus_type} == "APB"} {
      add_auto_connection   ${v_instance_name}      s0_apb          ${v_apb_host}_apb_host
    }
  }

  if {(${v_apb_host_1} != "NONE") && (${v_apb_host_1} != "")} {
    if {${v_s1_bus_type} == "APB"} {
      add_auto_connection   ${v_instance_name}      s1_apb          ${v_apb_host_1}_apb_host
    }
  }

  add_auto_connection       ${v_instance_name}      c_safety_mem    c_safety_mem
  add_auto_connection       ${v_instance_name}      c_memory_fault  c_memory_fault

}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

}