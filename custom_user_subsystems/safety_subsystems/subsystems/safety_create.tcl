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

set_shell_parameter AXI_HOST            {}
set_shell_parameter QEP_COUNT_WIDTH     {13}
set_shell_parameter WATCHDOG_TIMEOUT    {100000}
set_shell_parameter IRQ_PRIORITY        {X}
set_shell_parameter IRQ_HOST            {}

proc derive_parameters {param_array} {

}

# Define the procedures used by the create_subsystems_qsys.tcl script
proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_safety_subsystem
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

  file_copy ${v_subsystem_source_path}/../non_qpds_ip/QEP_D3                ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/doc_safety            ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/safety_subsystem.ipx  ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/common.ipx            ${v_project_path}/non_qpds_ip/user

  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_axi_gpio \
            ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_axil2apb \
            ${v_project_path}/non_qpds_ip/user

  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_axi.ipx \
            ${v_project_path}/non_qpds_ip/user

  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_pb_debounce \
            ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../../../modular_design_toolkit/subsystems/common/non_qpds_ip/intel_fpga_general.ipx \
            ${v_project_path}/non_qpds_ip/user

}

# Create the subsystem
proc create_safety_subsystem {} {

  set v_project_path     [get_shell_parameter PROJECT_PATH]
  set v_instance_name    [get_shell_parameter INSTANCE_NAME]
  set v_qep_count_width  [get_shell_parameter QEP_COUNT_WIDTH]
  set v_watchdog_timeout [get_shell_parameter WATCHDOG_TIMEOUT]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys
  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys

  # Create Instances
  add_instance                  safety_block  doc_safety
  set_instance_parameter_value  safety_block  P_QEP_COUNT_WIDTH         ${v_qep_count_width}
  set_instance_parameter_value  safety_block  P_WATCHDOG_TIMEOUT        ${v_watchdog_timeout}

  #---------------------------------------------------------------
  # qep_block - quadrature decoder
  add_instance                  qep_block  QEP_interface
  set_instance_parameter_value  qep_block  P_ENABLE_MONITOR             1
  set_instance_parameter_value  qep_block  P_ENABLE_AVMM                0
  set_instance_parameter_value  qep_block  P_QEP_COUNT_WIDTH            ${v_qep_count_width}

  #---------------------------------------------------------------
  # ctrl_clk_bridge
  add_instance                  ctrl_clk_bridge  altera_clock_bridge
  set_instance_parameter_value  ctrl_clk_bridge  EXPLICIT_CLOCK_RATE    {0}
  set_instance_parameter_value  ctrl_clk_bridge  NUM_CLOCK_OUTPUTS      1

  #---------------------------------------------------------------
  # ctrl_rst_bridge
  add_instance                  ctrl_rst_bridge  altera_reset_bridge
  set_instance_parameter_value  ctrl_rst_bridge  ACTIVE_LOW_RESET       0
  set_instance_parameter_value  ctrl_rst_bridge  SYNCHRONOUS_EDGES      deassert
  set_instance_parameter_value  ctrl_rst_bridge  NUM_RESET_OUTPUTS      1
  set_instance_parameter_value  ctrl_rst_bridge  USE_RESET_REQUEST      0
  set_instance_parameter_value  ctrl_rst_bridge  SYNC_RESET             0

  #---------------------------------------------------------------
  # interval_timer
  add_instance                  interval_timer  altera_avalon_timer
  set_instance_parameter_value  interval_timer  period                  1
  set_instance_parameter_value  interval_timer  periodUnits             "MSEC"
  set_instance_parameter_value  interval_timer  counterSize             32
  set_instance_parameter_value  interval_timer  alwaysRun               0
  set_instance_parameter_value  interval_timer  fixedPeriod             0
  set_instance_parameter_value  interval_timer  snapshot                1
  set_instance_parameter_value  interval_timer  resetOutput             0
  set_instance_parameter_value  interval_timer  timeoutPulseOutput      1

  #---------------------------------------------------------------
  # Push Button Debouncer
  add_instance                  pb_debounce_block  intel_fpga_pb_debounce
  set_instance_parameter_value  pb_debounce_block  P_NUM_CHANNELS       1

  #---------------------------------------------------------------
  # AXI Bridge
  add_instance axi_bridge altera_axi_bridge
  set_instance_parameter_value axi_bridge ACE_LITE_SUPPORT                      {0}
  set_instance_parameter_value axi_bridge ADDR_WIDTH                            {7}
  set_instance_parameter_value axi_bridge AXI_VERSION                           {AXI4-Lite}
  set_instance_parameter_value axi_bridge COMBINED_ACCEPTANCE_CAPABILITY        {16}
  set_instance_parameter_value axi_bridge COMBINED_ISSUING_CAPABILITY           {16}
  set_instance_parameter_value axi_bridge DATA_WIDTH                            {32}
  set_instance_parameter_value axi_bridge ENABLE_CONCURRENT_SUBORDINATE_ACCESS  {0}
  set_instance_parameter_value axi_bridge ENABLE_OOO                            {0}
  set_instance_parameter_value axi_bridge M0_ID_WIDTH                           {8}
  set_instance_parameter_value axi_bridge NO_REPEATED_IDS_BETWEEN_SUBORDINATES  {0}
  set_instance_parameter_value axi_bridge READ_ACCEPTANCE_CAPABILITY            {16}
  set_instance_parameter_value axi_bridge READ_ADDR_USER_WIDTH                  {1}
  set_instance_parameter_value axi_bridge READ_DATA_REORDERING_DEPTH            {1}
  set_instance_parameter_value axi_bridge READ_DATA_USER_WIDTH                  {1}
  set_instance_parameter_value axi_bridge READ_ISSUING_CAPABILITY               {16}
  set_instance_parameter_value axi_bridge S0_ID_WIDTH                           {8}
  set_instance_parameter_value axi_bridge SYNC_RESET                            {0}
  set_instance_parameter_value axi_bridge USE_M0_ARBURST                        {0}
  set_instance_parameter_value axi_bridge USE_M0_ARCACHE                        {0}
  set_instance_parameter_value axi_bridge USE_M0_ARID                           {0}
  set_instance_parameter_value axi_bridge USE_M0_ARLEN                          {0}
  set_instance_parameter_value axi_bridge USE_M0_ARLOCK                         {0}
  set_instance_parameter_value axi_bridge USE_M0_ARQOS                          {0}
  set_instance_parameter_value axi_bridge USE_M0_ARREGION                       {0}
  set_instance_parameter_value axi_bridge USE_M0_ARSIZE                         {0}
  set_instance_parameter_value axi_bridge USE_M0_ARUSER                         {0}
  set_instance_parameter_value axi_bridge USE_M0_AWBURST                        {0}
  set_instance_parameter_value axi_bridge USE_M0_AWCACHE                        {0}
  set_instance_parameter_value axi_bridge USE_M0_AWID                           {0}
  set_instance_parameter_value axi_bridge USE_M0_AWLEN                          {0}
  set_instance_parameter_value axi_bridge USE_M0_AWLOCK                         {0}
  set_instance_parameter_value axi_bridge USE_M0_AWQOS                          {0}
  set_instance_parameter_value axi_bridge USE_M0_AWREGION                       {0}
  set_instance_parameter_value axi_bridge USE_M0_AWSIZE                         {0}
  set_instance_parameter_value axi_bridge USE_M0_AWUSER                         {0}
  set_instance_parameter_value axi_bridge USE_M0_BID                            {0}
  set_instance_parameter_value axi_bridge USE_M0_BRESP                          {1}
  set_instance_parameter_value axi_bridge USE_M0_BUSER                          {0}
  set_instance_parameter_value axi_bridge USE_M0_RID                            {0}
  set_instance_parameter_value axi_bridge USE_M0_RLAST                          {0}
  set_instance_parameter_value axi_bridge USE_M0_RRESP                          {1}
  set_instance_parameter_value axi_bridge USE_M0_RUSER                          {0}
  set_instance_parameter_value axi_bridge USE_M0_WSTRB                          {1}
  set_instance_parameter_value axi_bridge USE_M0_WUSER                          {0}
  set_instance_parameter_value axi_bridge USE_PIPELINE                          {1}
  set_instance_parameter_value axi_bridge USE_S0_ARCACHE                        {0}
  set_instance_parameter_value axi_bridge USE_S0_ARLOCK                         {0}
  set_instance_parameter_value axi_bridge USE_S0_ARPROT                         {1}
  set_instance_parameter_value axi_bridge USE_S0_ARQOS                          {0}
  set_instance_parameter_value axi_bridge USE_S0_ARREGION                       {0}
  set_instance_parameter_value axi_bridge USE_S0_ARUSER                         {0}
  set_instance_parameter_value axi_bridge USE_S0_AWCACHE                        {0}
  set_instance_parameter_value axi_bridge USE_S0_AWLOCK                         {0}
  set_instance_parameter_value axi_bridge USE_S0_AWPROT                         {1}
  set_instance_parameter_value axi_bridge USE_S0_AWQOS                          {0}
  set_instance_parameter_value axi_bridge USE_S0_AWREGION                       {0}
  set_instance_parameter_value axi_bridge USE_S0_AWUSER                         {0}
  set_instance_parameter_value axi_bridge USE_S0_BRESP                          {1}
  set_instance_parameter_value axi_bridge USE_S0_BUSER                          {0}
  set_instance_parameter_value axi_bridge USE_S0_RRESP                          {1}
  set_instance_parameter_value axi_bridge USE_S0_RUSER                          {0}
  set_instance_parameter_value axi_bridge USE_S0_WLAST                          {0}
  set_instance_parameter_value axi_bridge USE_S0_WUSER                          {0}
  set_instance_parameter_value axi_bridge WRITE_ACCEPTANCE_CAPABILITY           {16}
  set_instance_parameter_value axi_bridge WRITE_ADDR_USER_WIDTH                 {1}
  set_instance_parameter_value axi_bridge WRITE_DATA_USER_WIDTH                 {1}
  set_instance_parameter_value axi_bridge WRITE_ISSUING_CAPABILITY              {16}
  set_instance_parameter_value axi_bridge WRITE_RESP_USER_WIDTH                 {1}

  # Create Internal Subsystem Connections
  add_connection    ctrl_clk_bridge.out_clk      safety_block.i_clk
  add_connection    ctrl_clk_bridge.out_clk      qep_block.clock
  add_connection    ctrl_clk_bridge.out_clk      ctrl_rst_bridge.clk
  add_connection    ctrl_clk_bridge.out_clk      interval_timer.clk
  add_connection    ctrl_clk_bridge.out_clk      axi_bridge.clk
  add_connection    ctrl_clk_bridge.out_clk      pb_debounce_block.i_clk

  add_connection    ctrl_rst_bridge.out_reset    safety_block.s_axi_aresetn
  add_connection    ctrl_rst_bridge.out_reset    safety_block.i_reset
  add_connection    ctrl_rst_bridge.out_reset    qep_block.reset
  add_connection    ctrl_rst_bridge.out_reset    interval_timer.reset
  add_connection    ctrl_rst_bridge.out_reset    axi_bridge.clk_reset

  add_connection    axi_bridge.m0                safety_block.s_axi
  add_connection    axi_bridge.m0                interval_timer.s1

  add_connection    qep_block.monitor            safety_block.c_qep_safety

  # Connection between timer and safety function
  add_connection    interval_timer.external_port safety_block.c_timer_safety
  add_connection    pb_debounce_block.o_pb       safety_block.i_reset_safety_n


  # Add interfaces to the boundary of the subsystem
  add_interface          i_clk              clock      sink
  set_interface_property i_clk              export_of  ctrl_clk_bridge.in_clk

  add_interface          i_reset            reset      sink
  set_interface_property i_reset            export_of  ctrl_rst_bridge.in_reset

  add_interface          irq                interrupt  sender
  set_interface_property irq                export_of  interval_timer.irq

  add_interface          s_axi              axi4lite   end
  set_interface_property s_axi              export_of  axi_bridge.s0

  set_interface_property m_apb              export_of  safety_block.m_apb

  add_interface          c_esl_safety       conduit    start
  set_interface_property c_esl_safety       export_of  safety_block.c_esl_safety

  add_interface          c_safety_mem       conduit    start
  set_interface_property c_safety_mem       export_of  safety_block.c_safety_mem

  add_interface          c_powerdown_motor  conduit    start
  set_interface_property c_powerdown_motor  export_of  safety_block.c_powerdown_motor

  add_interface          i_pb               conduit    end
  set_interface_property i_pb               export_of  pb_debounce_block.i_pb

  add_interface          c_qep              conduit    end
  set_interface_property c_qep              export_of  qep_block.conduit_end

  set_connection_parameter_value  axi_bridge.m0/safety_block.s_axi  baseAddress "0x00000040"
  set_connection_parameter_value  axi_bridge.m0/interval_timer.s1   baseAddress "0x00000020"
  lock_avalon_base_address        axi_bridge.m0

  sync_sysinfo_parameters
  save_system

}

# Insert the safety subsystem into the top level Platform Designer system,
# and add interfaces to the boundary of the top
proc edit_top_level_qsys {} {

  set v_project_name  [get_shell_parameter PROJECT_NAME]
  set v_project_path  [get_shell_parameter PROJECT_PATH]
  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  load_system  ${v_project_path}/rtl/${v_project_name}_qsys.qsys
  add_instance ${v_instance_name} ${v_instance_name}

  add_interface           "${v_instance_name}_c_qep"    conduit     end
  set_interface_property  "${v_instance_name}_c_qep"    export_of   ${v_instance_name}.c_qep

  add_interface           "${v_instance_name}_i_pb"    conduit      end
  set_interface_property  "${v_instance_name}_i_pb"    export_of    ${v_instance_name}.i_pb

  sync_sysinfo_parameters
  save_system

}

# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top Platform Designer level
proc add_auto_connections {} {

  set v_instance_name [get_shell_parameter INSTANCE_NAME]
  set v_axi_host      [get_shell_parameter AXI_HOST]
  set v_irq_priority  [get_shell_parameter IRQ_PRIORITY]
  set v_irq_host      [get_shell_parameter IRQ_HOST]

  add_auto_connection   ${v_instance_name}  i_clk                   100000000
  add_auto_connection   ${v_instance_name}  i_reset                 100000000

  if {(${v_axi_host} != "NONE") && (${v_axi_host} != "")} {
    add_auto_connection ${v_instance_name}  s_axi                   ${v_axi_host}_axi_host
  }

  add_auto_connection   ${v_instance_name}  m_apb                   auto_apb_host
  add_auto_connection   ${v_instance_name}  m_apb                   ${v_instance_name}_apb_host

  add_irq_connection    ${v_instance_name}  "irq" ${v_irq_priority} ${v_irq_host}_irq

  add_auto_connection   ${v_instance_name}  c_esl_safety            c_esl_safety

  add_auto_connection   ${v_instance_name}  c_safety_mem            c_safety_mem

  add_auto_connection   ${v_instance_name}  c_powerdown_motor       c_powerdown_fpga

}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

  set v_instance_name [get_shell_parameter INSTANCE_NAME]

  add_qsys_inst_exports_list "${v_instance_name}_c_qep_strobe"      "~drive_0_enc_stb0_n"
  add_qsys_inst_exports_list "${v_instance_name}_c_qep_QEP_A"       "drive_0_qep_a"
  add_qsys_inst_exports_list "${v_instance_name}_c_qep_QEP_B"       "drive_0_qep_b"
  add_qsys_inst_exports_list "${v_instance_name}_c_qep_QEP_I"       ""
  add_qsys_inst_exports_list "${v_instance_name}_i_pb_pb0"          "user_pb_n\[0\]"

}
