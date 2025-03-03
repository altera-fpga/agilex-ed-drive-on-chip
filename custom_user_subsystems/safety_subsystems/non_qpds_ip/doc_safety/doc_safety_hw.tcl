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

# Hardware tcl wrap-around for new rx-tx link (axis streaming)

package require -exact qsys 23.1

############################################################################
# Module Properties
############################################################################
set_module_property NAME                         doc_safety
set_module_property DESCRIPTION                  "DoC Safety FPGA channel implementation"
set_module_property DISPLAY_NAME                 "DoC Safety"
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL     doc_safety

add_fileset_file    rtl/pkg_doc_safety.sv                SYSTEMVERILOG PATH rtl/pkg_doc_safety.sv
add_fileset_file    rtl/pkg_doc_safety_cc.sv             SYSTEMVERILOG PATH rtl/pkg_doc_safety_cc.sv
add_fileset_file    rtl/doc_safety_cross_comparison.sv   SYSTEMVERILOG PATH rtl/doc_safety_cross_comparison.sv
add_fileset_file    rtl/doc_safety_payload_generator.sv  SYSTEMVERILOG PATH rtl/doc_safety_payload_generator.sv
add_fileset_file    rtl/doc_safety_heartbeat.sv          SYSTEMVERILOG PATH rtl/doc_safety_heartbeat.sv
add_fileset_file    rtl/doc_safety_speed_est.sv          SYSTEMVERILOG PATH rtl/doc_safety_speed_est.sv
add_fileset_file    rtl/doc_safety_function.sv           SYSTEMVERILOG PATH rtl/doc_safety_function.sv
add_fileset_file    rtl/doc_safety.sv                    SYSTEMVERILOG PATH rtl/doc_safety.sv

############################################################################
# Module parameters
############################################################################
add_parameter          P_S_AXI_ADDR_WIDTH  INTEGER              5
set_parameter_property P_S_AXI_ADDR_WIDTH  DEFAULT_VALUE        5
set_parameter_property P_S_AXI_ADDR_WIDTH  ALLOWED_RANGES       {5:32}
set_parameter_property P_S_AXI_ADDR_WIDTH  DISPLAY_NAME         "AXI Address Width"
set_parameter_property P_S_AXI_ADDR_WIDTH  ENABLED              true
set_parameter_property P_S_AXI_ADDR_WIDTH  UNITS                None
set_parameter_property P_S_AXI_ADDR_WIDTH  VISIBLE              true
set_parameter_property P_S_AXI_ADDR_WIDTH  AFFECTS_ELABORATION  true
set_parameter_property P_S_AXI_ADDR_WIDTH  HDL_PARAMETER        true

add_parameter          P_S_AXI_DATA_WIDTH  INTEGER              32
set_parameter_property P_S_AXI_DATA_WIDTH  DEFAULT_VALUE        32
set_parameter_property P_S_AXI_DATA_WIDTH  DISPLAY_NAME         "AXI Data Width"
set_parameter_property P_S_AXI_DATA_WIDTH  ENABLED              false
set_parameter_property P_S_AXI_DATA_WIDTH  UNITS                None
set_parameter_property P_S_AXI_DATA_WIDTH  VISIBLE              true
set_parameter_property P_S_AXI_DATA_WIDTH  AFFECTS_ELABORATION  true
set_parameter_property P_S_AXI_DATA_WIDTH  HDL_PARAMETER        true

add_parameter          P_M_APB_ADDR_WIDTH  INTEGER              4
set_parameter_property P_M_APB_ADDR_WIDTH  DEFAULT_VALUE        4
set_parameter_property P_M_APB_ADDR_WIDTH  ALLOWED_RANGES       {3:32}
set_parameter_property P_M_APB_ADDR_WIDTH  DISPLAY_NAME         "APB Address Width"
set_parameter_property P_M_APB_ADDR_WIDTH  ENABLED              false
set_parameter_property P_M_APB_ADDR_WIDTH  UNITS                None
set_parameter_property P_M_APB_ADDR_WIDTH  VISIBLE              true
set_parameter_property P_M_APB_ADDR_WIDTH  AFFECTS_ELABORATION  true
set_parameter_property P_M_APB_ADDR_WIDTH  HDL_PARAMETER        true

add_parameter          P_M_APB_DATA_WIDTH  INTEGER              32
set_parameter_property P_M_APB_DATA_WIDTH  DEFAULT_VALUE        32
set_parameter_property P_M_APB_DATA_WIDTH  DISPLAY_NAME         "APB Data Width"
set_parameter_property P_M_APB_DATA_WIDTH  ENABLED              false
set_parameter_property P_M_APB_DATA_WIDTH  UNITS                None
set_parameter_property P_M_APB_DATA_WIDTH  VISIBLE              true
set_parameter_property P_M_APB_DATA_WIDTH  AFFECTS_ELABORATION  true
set_parameter_property P_M_APB_DATA_WIDTH  HDL_PARAMETER        true

add_parameter          P_SPEED_CC_MARGIN_RPM   INTEGER              130
set_parameter_property P_SPEED_CC_MARGIN_RPM   DEFAULT_VALUE        130
set_parameter_property P_SPEED_CC_MARGIN_RPM   DISPLAY_NAME         "Speed Cross Comparison Margin (RPM)"
set_parameter_property P_SPEED_CC_MARGIN_RPM   ENABLED              true
set_parameter_property P_SPEED_CC_MARGIN_RPM   UNITS                None
set_parameter_property P_SPEED_CC_MARGIN_RPM   VISIBLE              true
set_parameter_property P_SPEED_CC_MARGIN_RPM   AFFECTS_ELABORATION  true
set_parameter_property P_SPEED_CC_MARGIN_RPM   HDL_PARAMETER        true

add_parameter          P_WATCHDOG_TIMEOUT  INTEGER              100_000
set_parameter_property P_WATCHDOG_TIMEOUT  DEFAULT_VALUE        100_000
set_parameter_property P_WATCHDOG_TIMEOUT  DISPLAY_NAME         "Cross Comparison Watchdog Timeout Period (Clock Cycles)"
set_parameter_property P_WATCHDOG_TIMEOUT  ENABLED              true
set_parameter_property P_WATCHDOG_TIMEOUT  UNITS                None
set_parameter_property P_WATCHDOG_TIMEOUT  VISIBLE              true
set_parameter_property P_WATCHDOG_TIMEOUT  AFFECTS_ELABORATION  true
set_parameter_property P_WATCHDOG_TIMEOUT  HDL_PARAMETER        true

add_parameter          P_QEP_COUNT_WIDTH   INTEGER              13
set_parameter_property P_QEP_COUNT_WIDTH   DEFAULT_VALUE        13
set_parameter_property P_QEP_COUNT_WIDTH   DISPLAY_NAME         "Width of the QEP Counter signal (rotary encoder resolution)"
set_parameter_property P_QEP_COUNT_WIDTH   ENABLED              true
set_parameter_property P_QEP_COUNT_WIDTH   UNITS                None
set_parameter_property P_QEP_COUNT_WIDTH   VISIBLE              true
set_parameter_property P_QEP_COUNT_WIDTH   AFFECTS_ELABORATION  true
set_parameter_property P_QEP_COUNT_WIDTH   HDL_PARAMETER        true

add_parameter          P_CLK_FREQ_HZ       INTEGER              0
set_parameter_property P_CLK_FREQ_HZ       DEFAULT_VALUE        0
set_parameter_property P_CLK_FREQ_HZ       DISPLAY_NAME         "Clock Frequency (Hz)"
set_parameter_property P_CLK_FREQ_HZ       ENABLED              false
set_parameter_property P_CLK_FREQ_HZ       UNITS                Hertz
set_parameter_property P_CLK_FREQ_HZ       VISIBLE              true
set_parameter_property P_CLK_FREQ_HZ       AFFECTS_ELABORATION  true
set_parameter_property P_CLK_FREQ_HZ       HDL_PARAMETER        true
set_parameter_property P_CLK_FREQ_HZ       DERIVED              true

############################################################################
# Interfaces
############################################################################
add_interface          i_clk clock                              end
set_interface_property i_clk ENABLED                            true
set_interface_property i_clk EXPORT_OF                          ""
set_interface_property i_clk PORT_NAME_MAP                      ""
set_interface_property i_clk CMSIS_SVD_VARIABLES                ""
set_interface_property i_clk SVD_ADDRESS_GROUP                  ""
set_interface_property i_clk IPXACT_REGISTER_MAP_VARIABLES      ""
set_interface_property i_clk SV_INTERFACE_TYPE                  ""
set_interface_property i_clk SV_INTERFACE_MODPORT_TYPE          ""

add_interface_port     i_clk clk clk Input 1
add_parameter          DERIVED_CLOCK_RATE  INTEGER              0
set_parameter_property DERIVED_CLOCK_RATE  DISPLAY_NAME         "Derived clock rate"
set_parameter_property DERIVED_CLOCK_RATE  DESCRIPTION          {Clock rate derived from system_info}
set_parameter_property DERIVED_CLOCK_RATE  UNITS                Hertz
set_parameter_property DERIVED_CLOCK_RATE  SYSTEM_INFO          { CLOCK_RATE "i_clk" }
set_parameter_property DERIVED_CLOCK_RATE  SYSTEM_INFO_TYPE     {CLOCK_RATE}
set_parameter_property DERIVED_CLOCK_RATE  ENABLED              false
set_parameter_property DERIVED_CLOCK_RATE  VISIBLE              true

add_interface          i_reset reset                            end
set_interface_property i_reset associatedClock                  i_clk
set_interface_property i_reset synchronousEdges                 DEASSERT
set_interface_property i_reset ENABLED                          true
set_interface_property i_reset EXPORT_OF                        ""
set_interface_property i_reset PORT_NAME_MAP                    ""
set_interface_property i_reset CMSIS_SVD_VARIABLES              ""
set_interface_property i_reset SVD_ADDRESS_GROUP                ""
set_interface_property i_reset IPXACT_REGISTER_MAP_VARIABLES    ""
set_interface_property i_reset SV_INTERFACE_TYPE                ""
set_interface_property i_reset SV_INTERFACE_MODPORT_TYPE        ""

add_interface_port     i_reset reset_n reset_n Input 1

# ---------------------------------------------------------------------------- #
# Reset
# ---------------------------------------------------------------------------- #
add_interface            s_axi_aresetn   reset             end
set_interface_property   s_axi_aresetn   associatedClock   i_clk
set_interface_property   s_axi_aresetn   synchronousEdges  DEASSERT
set_interface_property   s_axi_aresetn   ENABLED           true
add_interface_port       s_axi_aresetn   s_axi_aresetn     reset_n     Input   1

add_interface          i_reset_safety_n conduit                       end
set_interface_property i_reset_safety_n ENABLED                       true
set_interface_property i_reset_safety_n EXPORT_OF                     ""
set_interface_property i_reset_safety_n PORT_NAME_MAP                 ""
set_interface_property i_reset_safety_n CMSIS_SVD_VARIABLES           ""
set_interface_property i_reset_safety_n SVD_ADDRESS_GROUP             ""
set_interface_property i_reset_safety_n IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property i_reset_safety_n SV_INTERFACE_TYPE             ""
set_interface_property i_reset_safety_n SV_INTERFACE_MODPORT_TYPE     ""

add_interface_port     i_reset_safety_n reset_safety_n_i pb0 Input 1

# Conduit End from QEP to Safety
add_interface          c_qep_safety conduit              end
set_interface_property c_qep_safety associatedClock      i_clk
set_interface_property c_qep_safety associatedReset      i_reset
set_interface_property c_qep_safety ENABLED              true
set_interface_property c_qep_safety EXPORT_OF            ""
set_interface_property c_qep_safety PORT_NAME_MAP        ""
set_interface_property c_qep_safety CMSIS_SVD_VARIABLES  ""
set_interface_property c_qep_safety SVD_ADDRESS_GROUP    ""

add_interface_port     c_qep_safety qep_count  qep_count  Input 32
add_interface_port     c_qep_safety qep_error  qep_error  Input 1

# Conduit End from Timer to Safety
add_interface          c_timer_safety conduit              end
set_interface_property c_timer_safety ENABLED              true
set_interface_property c_timer_safety EXPORT_OF            ""
set_interface_property c_timer_safety PORT_NAME_MAP        ""
set_interface_property c_timer_safety CMSIS_SVD_VARIABLES  ""
set_interface_property c_timer_safety SVD_ADDRESS_GROUP    ""
# the irq goes from the timer to the HPS - the safety block doesn't see it
# add_interface_port c_timer_safety irq export Input 1

add_interface_port     c_timer_safety timer_pulse  export Input 1

# Conduit End from Safety to Shared Memory
add_interface          c_safety_mem conduit               start
set_interface_property c_safety_mem ENABLED               true
set_interface_property c_safety_mem EXPORT_OF             ""
set_interface_property c_safety_mem PORT_NAME_MAP         ""
set_interface_property c_safety_mem CMSIS_SVD_VARIABLES   ""
set_interface_property c_safety_mem SVD_ADDRESS_GROUP     ""

add_interface_port     c_safety_mem reset_safety_mem_n_o  reset_safety_n  Output 1

# Conduit End from Safety to motor
add_interface          c_powerdown_motor conduit               start
set_interface_property c_powerdown_motor ENABLED               true
set_interface_property c_powerdown_motor EXPORT_OF             ""
set_interface_property c_powerdown_motor PORT_NAME_MAP         ""
set_interface_property c_powerdown_motor CMSIS_SVD_VARIABLES   ""
set_interface_property c_powerdown_motor SVD_ADDRESS_GROUP     ""

add_interface_port     c_powerdown_motor motor_powerdown_p  motor_powerdown_p  Output 1
add_interface_port     c_powerdown_motor motor_powerdown_n  motor_powerdown_n  Output 1

# Conduit Start from Safety Function to ESL
add_interface          c_esl_safety conduit              start
set_interface_property c_esl_safety ENABLED              true
set_interface_property c_esl_safety EXPORT_OF            ""
set_interface_property c_esl_safety PORT_NAME_MAP        ""
set_interface_property c_esl_safety CMSIS_SVD_VARIABLES  ""
set_interface_property c_esl_safety SVD_ADDRESS_GROUP    ""

add_interface_port c_esl_safety quad_error_p         quad_error_p         Output 1
add_interface_port c_esl_safety quad_error_n         quad_error_n         Output 1
add_interface_port c_esl_safety fpga_is_safe_p       fpga_is_safe_p       Output 1
add_interface_port c_esl_safety fpga_is_safe_n       fpga_is_safe_n       Output 1
add_interface_port c_esl_safety fpga_compare_good_p  fpga_compare_good_p  Output 1
add_interface_port c_esl_safety fpga_compare_good_n  fpga_compare_good_n  Output 1
add_interface_port c_esl_safety compare_timeout      compare_timeout      Output 1
add_interface_port c_esl_safety heartbeat_fusa       heartbeat_fusa       Output 1
add_interface_port c_esl_safety heartbeat_timer      heartbeat_timer      Output 1
add_interface_port c_esl_safety reset_safety_n_o     reset_safety_n       Output 1

# ---------------------------------------------------------------------------- #
# AXI4Lite interface
# ---------------------------------------------------------------------------- #
add_interface          s_axi axi4lite                   end
set_interface_property s_axi associatedClock            i_clk
set_interface_property s_axi associatedReset            s_axi_aresetn
set_interface_property s_axi ENABLED                    true
set_interface_property s_axi EXPORT_OF                  ""
set_interface_property s_axi PORT_NAME_MAP              ""
set_interface_property s_axi CMSIS_SVD_VARIABLES        ""
set_interface_property s_axi SVD_ADDRESS_GROUP          ""

add_interface_port s_axi s_axi_awaddr  awaddr  Input    P_S_AXI_ADDR_WIDTH
add_interface_port s_axi s_axi_awvalid awvalid Input    1
add_interface_port s_axi s_axi_awready awready Output   1
add_interface_port s_axi s_axi_wdata   wdata   Input    P_S_AXI_DATA_WIDTH
add_interface_port s_axi s_axi_wready  wready  Output   1
add_interface_port s_axi s_axi_wvalid  wvalid  Input    1
add_interface_port s_axi s_axi_wstrb   wstrb   Input    (P_S_AXI_DATA_WIDTH/8)
add_interface_port s_axi s_axi_bresp   bresp   Output   2
add_interface_port s_axi s_axi_bvalid  bvalid  Output   1
add_interface_port s_axi s_axi_bready  bready  Input    1
add_interface_port s_axi s_axi_rdata   rdata   Output   P_S_AXI_DATA_WIDTH
add_interface_port s_axi s_axi_rresp   rresp   Output   2
add_interface_port s_axi s_axi_rvalid  rvalid  Output   1
add_interface_port s_axi s_axi_rready  rready  Input    1
add_interface_port s_axi s_axi_araddr  araddr  Input    P_S_AXI_ADDR_WIDTH
add_interface_port s_axi s_axi_arvalid arvalid Input    1
add_interface_port s_axi s_axi_arready arready Output   1
add_interface_port s_axi s_axi_awprot  awprot  Input    3
add_interface_port s_axi s_axi_arprot  arprot  Input    3

# ---------------------------------------------------------------------------- #
# APB interface
# ---------------------------------------------------------------------------- #
add_interface          m_apb apb                  start
set_interface_property m_apb associatedClock      i_clk
set_interface_property m_apb associatedReset      s_axi_aresetn
set_interface_property m_apb ENABLED              true
set_interface_property m_apb EXPORT_OF            ""
set_interface_property m_apb PORT_NAME_MAP        ""
set_interface_property m_apb CMSIS_SVD_VARIABLES  ""
set_interface_property m_apb SVD_ADDRESS_GROUP    ""

add_interface_port m_apb m_apb_paddr    paddr   Output  P_M_APB_ADDR_WIDTH
add_interface_port m_apb m_apb_pwrite   pwrite  Output  1
add_interface_port m_apb m_apb_psel     psel    Output  1
add_interface_port m_apb m_apb_penable  penable Output  1
add_interface_port m_apb m_apb_pwdata   pwdata  Output  P_M_APB_DATA_WIDTH
add_interface_port m_apb m_apb_prdata   prdata  Input   P_M_APB_DATA_WIDTH
add_interface_port m_apb m_apb_pready   pready  Input   1

proc val_callback {} {

}

proc elab_callback {} {
  set v_clock_rate    [ get_parameter_value DERIVED_CLOCK_RATE ]

  set_parameter_value P_CLK_FREQ_HZ ${v_clock_rate}

  add_hdl_instance doc_safety_axil2apb intel_fpga_axil2apb 1.0
  set_instance_parameter_value doc_safety_axil2apb {P_S_AXI_ADDR_WIDTH} [get_parameter_value P_S_AXI_ADDR_WIDTH]
  set_instance_parameter_value doc_safety_axil2apb {P_S_AXI_DATA_WIDTH} [get_parameter_value P_S_AXI_DATA_WIDTH]
  set_instance_parameter_value doc_safety_axil2apb {P_WATCHDOG_EN}      {1}
}

proc gen_callback { entity } {

}
