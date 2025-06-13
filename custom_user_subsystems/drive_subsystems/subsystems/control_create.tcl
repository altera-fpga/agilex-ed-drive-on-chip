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

set_shell_parameter AVMM_HOST                   {}
set_shell_parameter DUAL_PORT_ENABLE            {0}
set_shell_parameter AVMM_HOST_1                 {}
set_shell_parameter RAM_WITH_AXI4_INTERFACE     {0}
set_shell_parameter DISABLE_SVM_DUMP            {0}
set_shell_parameter DISABLE_SAFETY_DUMP         {0}
set_shell_parameter SVM_DUMP_SIZE_BYTES         {524288.0}
set_shell_parameter DEBUG_RAM_SIZE_BYTES        {4096.0}

# =====================================================================

proc derive_parameters {param_array} {

}

# Define the procedures used by the create_subsystems_qsys.tcl script
proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_drive_subsystem
}

proc post_creation_step {} {
  edit_top_level_qsys
  add_auto_connections
  edit_top_v_file
}

#==========================================================

# Copy files from the shell install directory to the target project directory
proc transfer_files {} {

}

# Create the drive subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem
proc create_drive_subsystem {} {

  set v_project_path            [get_shell_parameter PROJECT_PATH]
  set v_instance_name           [get_shell_parameter INSTANCE_NAME]
  set v_dual_port_enable        [get_shell_parameter DUAL_PORT_ENABLE]
  set v_ram_with_axi4_interface [get_shell_parameter RAM_WITH_AXI4_INTERFACE]
  set v_disable_svm_dump        [get_shell_parameter DISABLE_SVM_DUMP]
  set v_disable_safety_dump     [get_shell_parameter DISABLE_SAFETY_DUMP]
  set v_svm_dump_size_bytes     [get_shell_parameter SVM_DUMP_SIZE_BYTES]
  set v_debug_ram_size_bytes    [get_shell_parameter DEBUG_RAM_SIZE_BYTES]

    # In case of 2 AXI interfaces, following is the readDuringWriteMode_Mixed setting,
    # #2 AXI4 Interfaces --> "S1 NEW_DATA; S2 OLD_DATA"
    # #1 AXI4 Interface  --> "DONT_CARE"
    # In case of AVMM interface, readDuringWriteMode_Mixed has only one legal value "DONT_CARE"

  set v_num_of_axi_interfaces         1
  set v_dual_port_setting             0
  set v_mixed_mode_rd_during_wr_mode  "DONT_CARE"

  if ${v_ram_with_axi4_interface} {
    set v_ram_interface_prefix  "axi_"
    if ${v_dual_port_enable} {
      set v_num_of_axi_interfaces           2
      set v_mixed_mode_rd_during_wr_mode    "S1 NEW_DATA; S2 OLD_DATA"
    }
  } else {
    set v_ram_interface_prefix  ""
    # Possible values {SinglePort-0; DualPort-1; SimpleDualPort-2}
    if ${v_dual_port_enable} {
      set v_dual_port_setting 1
    }
  }
  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  # Create instances
  add_instance ctrl_clk_bridge          altera_clock_bridge
  add_instance ctrl_rst_bridge          altera_reset_bridge
  add_instance sys_ctrl_mm_bridge       altera_avalon_mm_bridge

  if {!$v_disable_svm_dump} {
    add_instance doc_svm_dump               intel_onchip_memory
  }
  add_instance doc_sys_console_debug_ram    intel_onchip_memory
  if {!$v_disable_safety_dump} {
    add_instance doc_safety_dump            intel_onchip_memory
  }

  # Set the instance parameters
  #---------------------------------------------------------------
  # cpu_clk_bridge
  set_instance_parameter_value  ctrl_clk_bridge  EXPLICIT_CLOCK_RATE        {100000000.0}
  set_instance_parameter_value  ctrl_clk_bridge  NUM_CLOCK_OUTPUTS          1

  #---------------------------------------------------------------
  # cpu_rst_bridge
  set_instance_parameter_value  ctrl_rst_bridge  ACTIVE_LOW_RESET           0
  set_instance_parameter_value  ctrl_rst_bridge  SYNCHRONOUS_EDGES          deassert
  set_instance_parameter_value  ctrl_rst_bridge  NUM_RESET_OUTPUTS          1
  set_instance_parameter_value  ctrl_rst_bridge  USE_RESET_REQUEST          0
  set_instance_parameter_value  ctrl_rst_bridge  SYNC_RESET                 0

  #---------------------------------------------------------------
  # sys_ctrl_mm_bridge
  set_instance_parameter_value  sys_ctrl_mm_bridge  SYNC_RESET              0

  set_instance_parameter_value  sys_ctrl_mm_bridge  DATA_WIDTH              32
  set_instance_parameter_value  sys_ctrl_mm_bridge  SYMBOL_WIDTH            8

  set_instance_parameter_value  sys_ctrl_mm_bridge  ADDRESS_WIDTH           0
  set_instance_parameter_value  sys_ctrl_mm_bridge  USE_AUTO_ADDRESS_WIDTH  1
  set_instance_parameter_value  sys_ctrl_mm_bridge  ADDRESS_UNITS           SYMBOLS

  set_instance_parameter_value  sys_ctrl_mm_bridge  MAX_BURST_SIZE          1
  set_instance_parameter_value  sys_ctrl_mm_bridge  LINEWRAPBURSTS          0

  set_instance_parameter_value  sys_ctrl_mm_bridge  MAX_PENDING_RESPONSES   4
  set_instance_parameter_value  sys_ctrl_mm_bridge  MAX_PENDING_WRITES      0
  set_instance_parameter_value  sys_ctrl_mm_bridge  PIPELINE_COMMAND        1
  set_instance_parameter_value  sys_ctrl_mm_bridge  PIPELINE_RESPONSE       1

  set_instance_parameter_value  sys_ctrl_mm_bridge  USE_RESPONSE            0

  set_instance_parameter_value  sys_ctrl_mm_bridge  USE_WRITERESPONSE       0

  #---------------------------------------------------------------
  # doc_svm_dump
  #   interfaceType: {AVMM-0; AXI4-1}
  #   interfaceType: AXI4-1:
  #       AXI_interface:  Number of AXI interfaces {1 or 2}
  #       dualport     :  Not Applicable
  #   interfaceType: AVMM-0:
  #       AXI_interface: Not Applicable
  #       dualport     : {SinglePort-0; DualPort-1; SimpleDualPort-2}
  if {!$v_disable_svm_dump} {
    set_instance_parameter_value doc_svm_dump   AXI_interface                         ${v_num_of_axi_interfaces}
    set_instance_parameter_value doc_svm_dump   allowInSystemMemoryContentEditor      {0}
    set_instance_parameter_value doc_svm_dump   blockType                             {AUTO}
    set_instance_parameter_value doc_svm_dump   clockEnable                           {0}
    set_instance_parameter_value doc_svm_dump   copyInitFile                          {0}
    set_instance_parameter_value doc_svm_dump   dataWidth                             {32}
    set_instance_parameter_value doc_svm_dump   dataWidth2                            {32}
    set_instance_parameter_value doc_svm_dump   dualPort                              ${v_dual_port_setting}
    set_instance_parameter_value doc_svm_dump   ecc_check                             {0}
    set_instance_parameter_value doc_svm_dump   ecc_encoder_bypass                    {0}
    set_instance_parameter_value doc_svm_dump   ecc_pipeline_reg                      {0}
    set_instance_parameter_value doc_svm_dump   enPRInitMode                          {0}
    set_instance_parameter_value doc_svm_dump   enableDiffWidth                       {0}
    set_instance_parameter_value doc_svm_dump   gui_debugaccess                       {0}
    set_instance_parameter_value doc_svm_dump   idWidth                               {3}
    set_instance_parameter_value doc_svm_dump   initMemContent                        {1}
    set_instance_parameter_value doc_svm_dump   initializationFileName                {}
    set_instance_parameter_value doc_svm_dump   instanceID                            {NONE}
    set_instance_parameter_value doc_svm_dump   interfaceType                         ${v_ram_with_axi4_interface}
    set_instance_parameter_value doc_svm_dump   lvl1OutputRegA                        {0}
    set_instance_parameter_value doc_svm_dump   lvl1OutputRegB                        {0}
    set_instance_parameter_value doc_svm_dump   lvl2OutputRegA                        {0}
    set_instance_parameter_value doc_svm_dump   lvl2OutputRegB                        {0}
    set_instance_parameter_value doc_svm_dump   memorySize                            ${v_svm_dump_size_bytes}
    set_instance_parameter_value doc_svm_dump   poison_enable                         {0}
    set_instance_parameter_value doc_svm_dump   readDuringWriteMode_Mixed             ${v_mixed_mode_rd_during_wr_mode}
    set_instance_parameter_value doc_svm_dump   resetrequest_enabled                  {1}
    set_instance_parameter_value doc_svm_dump   singleClockOperation                  {0}
    set_instance_parameter_value doc_svm_dump   tightly_coupled_ecc                   {0}
    set_instance_parameter_value doc_svm_dump   useNonDefaultInitFile                 {0}
    set_instance_parameter_value doc_svm_dump   writable                              {1}
  }

  #---------------------------------------------------------------
  # doc_sys_console_debug_ram
  set_instance_parameter_value doc_sys_console_debug_ram   AXI_interface                    ${v_num_of_axi_interfaces}
  set_instance_parameter_value doc_sys_console_debug_ram   allowInSystemMemoryContentEditor {0}
  set_instance_parameter_value doc_sys_console_debug_ram   blockType                        {AUTO}
  set_instance_parameter_value doc_sys_console_debug_ram   clockEnable                      {0}
  set_instance_parameter_value doc_sys_console_debug_ram   copyInitFile                     {0}
  set_instance_parameter_value doc_sys_console_debug_ram   dataWidth                        {32}
  set_instance_parameter_value doc_sys_console_debug_ram   dataWidth2                       {32}
  set_instance_parameter_value doc_sys_console_debug_ram   dualPort                         ${v_dual_port_setting}
  set_instance_parameter_value doc_sys_console_debug_ram   ecc_check                        {0}
  set_instance_parameter_value doc_sys_console_debug_ram   ecc_encoder_bypass               {0}
  set_instance_parameter_value doc_sys_console_debug_ram   ecc_pipeline_reg                 {0}
  set_instance_parameter_value doc_sys_console_debug_ram   enPRInitMode                     {0}
  set_instance_parameter_value doc_sys_console_debug_ram   enableDiffWidth                  {0}
  set_instance_parameter_value doc_sys_console_debug_ram   gui_debugaccess                  {0}
  set_instance_parameter_value doc_sys_console_debug_ram   idWidth                          {3}
  set_instance_parameter_value doc_sys_console_debug_ram   initMemContent                   {1}
  set_instance_parameter_value doc_sys_console_debug_ram   initializationFileName           {}
  set_instance_parameter_value doc_sys_console_debug_ram   instanceID                       {NONE}
  set_instance_parameter_value doc_sys_console_debug_ram   interfaceType                    ${v_ram_with_axi4_interface}
  set_instance_parameter_value doc_sys_console_debug_ram   lvl1OutputRegA                   {0}
  set_instance_parameter_value doc_sys_console_debug_ram   lvl1OutputRegB                   {0}
  set_instance_parameter_value doc_sys_console_debug_ram   lvl2OutputRegA                   {0}
  set_instance_parameter_value doc_sys_console_debug_ram   lvl2OutputRegB                   {0}
  set_instance_parameter_value doc_sys_console_debug_ram   memorySize                       ${v_debug_ram_size_bytes}
  set_instance_parameter_value doc_sys_console_debug_ram   poison_enable                    {0}
  set_instance_parameter_value doc_sys_console_debug_ram   readDuringWriteMode_Mixed        ${v_mixed_mode_rd_during_wr_mode}
  set_instance_parameter_value doc_sys_console_debug_ram   resetrequest_enabled             {1}
  set_instance_parameter_value doc_sys_console_debug_ram   singleClockOperation             {0}
  set_instance_parameter_value doc_sys_console_debug_ram   tightly_coupled_ecc              {0}
  set_instance_parameter_value doc_sys_console_debug_ram   useNonDefaultInitFile            {0}
  set_instance_parameter_value doc_sys_console_debug_ram   writable                         {1}

  #---------------------------------------------------------------
  # doc_safety_dump
  #   interfaceType: {AVMM-0; AXI4-1}
  #   interfaceType: AXI4-1:
  #       AXI_interface: Number of AXI interfaces {1 or 2}
  #       dualport     : Not Applicable
  #   interfaceType: AVMM-0:
  #       AXI_interface: Not Applicable
  #       dualport     : {SinglePort-0; DualPort-1; SimpleDualPort-2}
  if {!$v_disable_safety_dump} {
    set_instance_parameter_value doc_safety_dump   AXI_interface                         ${v_num_of_axi_interfaces}
    set_instance_parameter_value doc_safety_dump   allowInSystemMemoryContentEditor      {0}
    set_instance_parameter_value doc_safety_dump   blockType                             {AUTO}
    set_instance_parameter_value doc_safety_dump   clockEnable                           {0}
    set_instance_parameter_value doc_safety_dump   copyInitFile                          {0}
    set_instance_parameter_value doc_safety_dump   dataWidth                             {32}
    set_instance_parameter_value doc_safety_dump   dataWidth2                            {32}
    set_instance_parameter_value doc_safety_dump   dualPort                              ${v_dual_port_setting}
    set_instance_parameter_value doc_safety_dump   ecc_check                             {0}
    set_instance_parameter_value doc_safety_dump   ecc_encoder_bypass                    {0}
    set_instance_parameter_value doc_safety_dump   ecc_pipeline_reg                      {0}
    set_instance_parameter_value doc_safety_dump   enPRInitMode                          {0}
    set_instance_parameter_value doc_safety_dump   enableDiffWidth                       {0}
    set_instance_parameter_value doc_safety_dump   gui_debugaccess                       {0}
    set_instance_parameter_value doc_safety_dump   idWidth                               {3}
    set_instance_parameter_value doc_safety_dump   initMemContent                        {1}
    set_instance_parameter_value doc_safety_dump   initializationFileName                {}
    set_instance_parameter_value doc_safety_dump   instanceID                            {NONE}
    set_instance_parameter_value doc_safety_dump   interfaceType                         ${v_ram_with_axi4_interface}
    set_instance_parameter_value doc_safety_dump   lvl1OutputRegA                        {0}
    set_instance_parameter_value doc_safety_dump   lvl1OutputRegB                        {0}
    set_instance_parameter_value doc_safety_dump   lvl2OutputRegA                        {0}
    set_instance_parameter_value doc_safety_dump   lvl2OutputRegB                        {0}
    set_instance_parameter_value doc_safety_dump   memorySize                            {64.0}
    set_instance_parameter_value doc_safety_dump   poison_enable                         {0}
    set_instance_parameter_value doc_safety_dump   readDuringWriteMode_Mixed             ${v_mixed_mode_rd_during_wr_mode}
    set_instance_parameter_value doc_safety_dump   resetrequest_enabled                  {1}
    set_instance_parameter_value doc_safety_dump   singleClockOperation                  {0}
    set_instance_parameter_value doc_safety_dump   tightly_coupled_ecc                   {0}
    set_instance_parameter_value doc_safety_dump   useNonDefaultInitFile                 {0}
    set_instance_parameter_value doc_safety_dump   writable                              {1}
  }

  # Create internal subsystem connections
  add_connection  ctrl_clk_bridge.out_clk       ctrl_rst_bridge.clk
  add_connection  ctrl_clk_bridge.out_clk       sys_ctrl_mm_bridge.clk
  if {!${v_disable_svm_dump}} {
    add_connection  ctrl_clk_bridge.out_clk     doc_svm_dump.clk1
  }

  add_connection  ctrl_clk_bridge.out_clk       doc_sys_console_debug_ram.clk1
  if {!${v_disable_safety_dump}} {
    add_connection  ctrl_clk_bridge.out_clk     doc_safety_dump.clk1
  }

  add_connection  ctrl_rst_bridge.out_reset     sys_ctrl_mm_bridge.reset
  if {!${v_disable_svm_dump}} {
    add_connection  ctrl_rst_bridge.out_reset   doc_svm_dump.reset1
  }

  add_connection  ctrl_rst_bridge.out_reset     doc_sys_console_debug_ram.reset1
  if {!${v_disable_safety_dump}} {
    add_connection  ctrl_rst_bridge.out_reset   doc_safety_dump.reset1
  }

  if {!${v_disable_svm_dump}} {
    add_connection  sys_ctrl_mm_bridge.m0       doc_svm_dump.${v_ram_interface_prefix}s1
  }

  add_connection  sys_ctrl_mm_bridge.m0         doc_sys_console_debug_ram.${v_ram_interface_prefix}s1
  if {!${v_disable_safety_dump}} {
    add_connection  sys_ctrl_mm_bridge.m0       doc_safety_dump.${v_ram_interface_prefix}s1
  }

  # Add interfaces to the boundary of the subsystem
  add_interface          i_clk            clock      sink
  set_interface_property i_clk            export_of  ctrl_clk_bridge.in_clk

  add_interface          i_reset          reset      sink
  set_interface_property i_reset          export_of  ctrl_rst_bridge.in_reset

  add_interface          i_cpu_mm_agent   avalon     agent
  set_interface_property i_cpu_mm_agent   export_of  sys_ctrl_mm_bridge.s0

  # Add fixed base addresses
  if {!${v_disable_svm_dump}} {
    set_connection_parameter_value  sys_ctrl_mm_bridge.m0/doc_svm_dump.${v_ram_interface_prefix}s1 \
                                    baseAddress   "0x00000000"
  }
  set_connection_parameter_value    sys_ctrl_mm_bridge.m0/doc_sys_console_debug_ram.${v_ram_interface_prefix}s1 \
                                    baseAddress   "0x00080000"

  if {!${v_disable_safety_dump}} {
    set_connection_parameter_value  sys_ctrl_mm_bridge.m0/doc_safety_dump.${v_ram_interface_prefix}s1 \
                                    baseAddress   "0x00081000"
  }

  if {!${v_disable_svm_dump}} {
    lock_avalon_base_address    doc_svm_dump.${v_ram_interface_prefix}s1
  }
  lock_avalon_base_address      doc_sys_console_debug_ram.${v_ram_interface_prefix}s1

  if {!${v_disable_safety_dump}} {
    lock_avalon_base_address    doc_safety_dump.${v_ram_interface_prefix}s1
  }

  #---------------------------------------------------------------

  if {${v_dual_port_enable}} {

    add_instance sys_ctrl_mm_bridge_1     altera_avalon_mm_bridge

    #---------------------------------------------------------------
    # sys_ctrl_mm_bridge_1
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   SYNC_RESET                0

    set_instance_parameter_value  sys_ctrl_mm_bridge_1   DATA_WIDTH                32
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   SYMBOL_WIDTH              8

    set_instance_parameter_value  sys_ctrl_mm_bridge_1   ADDRESS_WIDTH             0
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   USE_AUTO_ADDRESS_WIDTH    1
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   ADDRESS_UNITS             SYMBOLS

    set_instance_parameter_value  sys_ctrl_mm_bridge_1   MAX_BURST_SIZE            1
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   LINEWRAPBURSTS            0

    set_instance_parameter_value  sys_ctrl_mm_bridge_1   MAX_PENDING_RESPONSES     4
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   MAX_PENDING_WRITES        0
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   PIPELINE_COMMAND          1
    set_instance_parameter_value  sys_ctrl_mm_bridge_1   PIPELINE_RESPONSE         1

    set_instance_parameter_value  sys_ctrl_mm_bridge_1   USE_RESPONSE              0

    set_instance_parameter_value  sys_ctrl_mm_bridge_1   USE_WRITERESPONSE         0

    # Add internal connections
    add_connection  ctrl_clk_bridge.out_clk     sys_ctrl_mm_bridge_1.clk

    add_connection  ctrl_rst_bridge.out_reset   sys_ctrl_mm_bridge_1.reset

    if {!${v_disable_svm_dump}} {
        add_connection  sys_ctrl_mm_bridge_1.m0     doc_svm_dump.${v_ram_interface_prefix}s2
    }
    add_connection  sys_ctrl_mm_bridge_1.m0         doc_sys_console_debug_ram.${v_ram_interface_prefix}s2

    if {!${v_disable_safety_dump}} {
        add_connection  sys_ctrl_mm_bridge_1.m0     doc_safety_dump.${v_ram_interface_prefix}s2
    }

    # Add interfaces to the boundary of the subsystem
    add_interface          i_cpu_mm_agent_1   avalon     agent
    set_interface_property i_cpu_mm_agent_1   export_of  sys_ctrl_mm_bridge_1.s0

    # Add fixed base addresses
    if {!${v_disable_svm_dump}} {
        set_connection_parameter_value  sys_ctrl_mm_bridge_1.m0/doc_svm_dump.${v_ram_interface_prefix}s2 \
                                        baseAddress   "0x00000000"
    }
    set_connection_parameter_value      sys_ctrl_mm_bridge_1.m0/doc_sys_console_debug_ram.${v_ram_interface_prefix}s2 \
                                        baseAddress   "0x00080000"
    if {!${v_disable_safety_dump}} {
        set_connection_parameter_value  sys_ctrl_mm_bridge_1.m0/doc_safety_dump.${v_ram_interface_prefix}s2 \
                                        baseAddress   "0x00081000"
    }

    if {!${v_disable_svm_dump}} {
        lock_avalon_base_address  doc_svm_dump.${v_ram_interface_prefix}s2
    }
    lock_avalon_base_address  doc_sys_console_debug_ram.${v_ram_interface_prefix}s2

    if {!${v_disable_safety_dump}} {
        lock_avalon_base_address  doc_safety_dump.${v_ram_interface_prefix}s2
    }

  }

  sync_sysinfo_parameters
  save_system

}

# Insert the Control subsystem into the top level Platform Designer system, and add interfaces
# to the boundary of the top level Platform Designer system
proc edit_top_level_qsys {} {

  set v_project_name  [get_shell_parameter PROJECT_NAME]
  set v_project_path  [get_shell_parameter PROJECT_PATH]
  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  load_system ${v_project_path}/rtl/${v_project_name}_qsys.qsys

  add_instance ${v_instance_name} ${v_instance_name}

  sync_sysinfo_parameters
  save_system

}

# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top Platform Designer level.
proc add_auto_connections {} {

  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_avmm_host           [get_shell_parameter AVMM_HOST]
  set v_dual_port_enable    [get_shell_parameter DUAL_PORT_ENABLE]
  set v_avmm_host_1         [get_shell_parameter AVMM_HOST_1]

# Connect the subsystem to 100MHz clock/reset domain
  add_auto_connection   ${v_instance_name}  i_clk   100000000
  add_auto_connection   ${v_instance_name}  i_reset 100000000
  add_avmm_connections  i_cpu_mm_agent      ${v_avmm_host}

  if $v_dual_port_enable {
    add_avmm_connections i_cpu_mm_agent_1   $v_avmm_host_1
  }

}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

}