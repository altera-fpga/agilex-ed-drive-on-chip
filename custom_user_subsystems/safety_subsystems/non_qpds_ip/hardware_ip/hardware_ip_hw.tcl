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

# Hardware tcl wrap-around for new rx-tx link (axis streaming)

package require -exact qsys 24.1

############################################################################
# Module Properties
############################################################################
set_module_property NAME                         hardware_ip
set_module_property DESCRIPTION                  "DoC Hardware IP"
set_module_property DISPLAY_NAME                 "DoC Hardware IP"
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL     hardware_ip

# ADD FILES....
add_fileset_file    rtl/hardware_ip.sv                             SYSTEMVERILOG PATH rtl/hardware_ip.sv
add_fileset_file    rtl/hw_main_ctrl.sv                            SYSTEMVERILOG PATH rtl/hw_main_ctrl.sv
add_fileset_file    rtl/hw_cmd.sv                                  SYSTEMVERILOG PATH rtl/hw_cmd.sv
add_fileset_file    rtl/hw_command_gen.sv                          SYSTEMVERILOG PATH rtl/hw_command_gen.sv
add_fileset_file    rtl/hw_rsp.sv                                  SYSTEMVERILOG PATH rtl/hw_rsp.sv
add_fileset_file    rtl/hw_memory.sv                               SYSTEMVERILOG PATH rtl/hw_memory.sv
add_fileset_file    rtl/doc_hw_mailbox_self.sv                     SYSTEMVERILOG PATH rtl/doc_hw_mailbox_self.sv
add_fileset_file    rtl/altera_config_stream_endpoint_wrapper.sv   SYSTEMVERILOG PATH \
                                                                    rtl/altera_config_stream_endpoint_wrapper.sv
add_fileset_file    rtl/hw_avmm_fsm.sv                             SYSTEMVERILOG PATH rtl/hw_avmm_fsm.sv
add_fileset_file    rtl/hw_agilex_5.sv                             SYSTEMVERILOG PATH rtl/hw_agilex_5.sv
add_fileset_file    rtl/pkg_hardware_ip.sv                         SYSTEMVERILOG PATH rtl/pkg_hardware_ip.sv

############################################################################
# Device Family + Mailbox Param
############################################################################
add_parameter          DEVICE STRING                ""
set_parameter_property DEVICE DISPLAY_NAME          "Device"
#forces family to always match PD
set_parameter_property DEVICE SYSTEM_INFO           DEVICE
set_parameter_property DEVICE HDL_PARAMETER         false
set_parameter_property DEVICE DESCRIPTION           "Device"
#Shows value, but must match family chosen
set_parameter_property DEVICE ENABLED               false
set_parameter_property DEVICE VISIBLE               true

add_parameter          P_SPEED_GRADE STRING         ""
set_parameter_property P_SPEED_GRADE DISPLAY_NAME   "Device Speed Grade"
#forces family to always match PD
set_parameter_property P_SPEED_GRADE SYSTEM_INFO    DEVICE_SPEEDGRADE
set_parameter_property P_SPEED_GRADE HDL_PARAMETER  true
set_parameter_property P_SPEED_GRADE DESCRIPTION    "Device Speed Grade"
#Shows value, but must match family chosen
set_parameter_property P_SPEED_GRADE ENABLED        false
set_parameter_property P_SPEED_GRADE VISIBLE        true
set_parameter_property P_SPEED_GRADE DERIVED        true

add_parameter          P_FAMILY STRING              ""
set_parameter_property P_FAMILY DISPLAY_NAME        "Device Family"
#forces family to always match PD
set_parameter_property P_FAMILY SYSTEM_INFO         device_family
set_parameter_property P_FAMILY ALLOWED_RANGES      {"Agilex 5" "Agilex 7"}
set_parameter_property P_FAMILY HDL_PARAMETER       true
set_parameter_property P_FAMILY DESCRIPTION         "Device Family"
#Shows value, but must match family chosen
set_parameter_property P_FAMILY ENABLED             false
set_parameter_property P_FAMILY VISIBLE             true
set_parameter_property P_FAMILY DERIVED             true

add_parameter          P_AG5_SERIES STRING          ""
set_parameter_property P_AG5_SERIES DISPLAY_NAME    "Agilex 5 Device Series"
set_parameter_property P_AG5_SERIES ALLOWED_RANGES  {"D" "E"}
set_parameter_property P_AG5_SERIES HDL_PARAMETER   true
set_parameter_property P_AG5_SERIES DESCRIPTION     "Agilex 5 Device Series"
#Shows value, but must match family chosen
set_parameter_property P_AG5_SERIES ENABLED         false
set_parameter_property P_AG5_SERIES VISIBLE         true
set_parameter_property P_AG5_SERIES DERIVED         true

add_parameter          P_AG5_DENSITY STRING         ""
set_parameter_property P_AG5_DENSITY DISPLAY_NAME   "Agilex 5 Device Density (10kLEs)"
set_parameter_property P_AG5_DENSITY ALLOWED_RANGES {"005" "007" "008" "010" "013" "025" "028" "031" "043" "051" "052" "064" "065"}
set_parameter_property P_AG5_DENSITY HDL_PARAMETER  true
set_parameter_property P_AG5_DENSITY DESCRIPTION    "Agilex 5 Device  Density (10kLEs)"
#Shows value, but must match family chosen
set_parameter_property P_AG5_DENSITY ENABLED        false
set_parameter_property P_AG5_DENSITY VISIBLE        true
set_parameter_property P_AG5_DENSITY DERIVED        true

############################################################################
# Number of X Channel Parameters
############################################################################

#Untouched --- Number of Voltage Channels Same Through Devices
add_parameter          P_NO_CH_VOLT   INTEGER              9
set_parameter_property P_NO_CH_VOLT   DEFAULT_VALUE        9
set_parameter_property P_NO_CH_VOLT   DISPLAY_NAME         "Number of Available Voltage Channels"
set_parameter_property P_NO_CH_VOLT   ENABLED              true
set_parameter_property P_NO_CH_VOLT   UNITS                None
set_parameter_property P_NO_CH_VOLT   VISIBLE              true
set_parameter_property P_NO_CH_VOLT   AFFECTS_ELABORATION  true
set_parameter_property P_NO_CH_VOLT   HDL_PARAMETER        true

add_parameter          P_NO_CH_TEMP   INTEGER              5
set_parameter_property P_NO_CH_TEMP   DEFAULT_VALUE        5
set_parameter_property P_NO_CH_TEMP   DISPLAY_NAME         "Number of Available Temperature Channels"
set_parameter_property P_NO_CH_TEMP   ENABLED              true
set_parameter_property P_NO_CH_TEMP   UNITS                None
set_parameter_property P_NO_CH_TEMP   VISIBLE              true
set_parameter_property P_NO_CH_TEMP   AFFECTS_ELABORATION  true
set_parameter_property P_NO_CH_TEMP   HDL_PARAMETER        true
set_parameter_property P_NO_CH_TEMP   DERIVED              true

############################################################################
# AXI Param + Singular Bits
############################################################################
add_parameter          P_S_AXI_ADDR_WIDTH  INTEGER              8
set_parameter_property P_S_AXI_ADDR_WIDTH  DEFAULT_VALUE        8
set_parameter_property P_S_AXI_ADDR_WIDTH  ALLOWED_RANGES       {3:32}
set_parameter_property P_S_AXI_ADDR_WIDTH  DISPLAY_NAME         "AXI / APB Address Width"
set_parameter_property P_S_AXI_ADDR_WIDTH  ENABLED              false
set_parameter_property P_S_AXI_ADDR_WIDTH  UNITS                None
set_parameter_property P_S_AXI_ADDR_WIDTH  VISIBLE              true
set_parameter_property P_S_AXI_ADDR_WIDTH  AFFECTS_ELABORATION  true
set_parameter_property P_S_AXI_ADDR_WIDTH  HDL_PARAMETER        true

add_parameter          P_S_AXI_DATA_WIDTH  INTEGER              32
set_parameter_property P_S_AXI_DATA_WIDTH  DEFAULT_VALUE        32
set_parameter_property P_S_AXI_DATA_WIDTH  DISPLAY_NAME         "AXI / APB Data Width"
set_parameter_property P_S_AXI_DATA_WIDTH  ENABLED              false
set_parameter_property P_S_AXI_DATA_WIDTH  UNITS                None
set_parameter_property P_S_AXI_DATA_WIDTH  VISIBLE              true
set_parameter_property P_S_AXI_DATA_WIDTH  AFFECTS_ELABORATION  true
set_parameter_property P_S_AXI_DATA_WIDTH  HDL_PARAMETER        true

add_parameter          P_SINGULAR_BITS     BOOLEAN              false ""
set_parameter_property P_SINGULAR_BITS     DEFAULT_VALUE        false
set_parameter_property P_SINGULAR_BITS     DISPLAY_NAME         "Enable Singular Output Bits"
set_parameter_property P_SINGULAR_BITS     UNITS                None
set_parameter_property P_SINGULAR_BITS     VISIBLE              true
set_parameter_property P_SINGULAR_BITS     AFFECTS_ELABORATION  true
set_parameter_property P_SINGULAR_BITS     HDL_PARAMETER        false

############################################################################
# Temperature Sensor CheckBoxes
############################################################################
proc add_tsensors {} {
    for {set v_i 0} {${v_i} < 13} {incr {v_i}} {
        if {${v_i} < 5} {
            add_parameter          P_TSENSOR_${v_i}    BOOLEAN              true ""
            set_parameter_property P_TSENSOR_${v_i}    DEFAULT_VALUE        true
            set_parameter_property P_TSENSOR_${v_i}    DISPLAY_NAME         "Sensor ${v_i}"
            set_parameter_property P_TSENSOR_${v_i}    UNITS                None
            set_parameter_property P_TSENSOR_${v_i}    VISIBLE              true
            set_parameter_property P_TSENSOR_${v_i}    AFFECTS_ELABORATION  true
            set_parameter_property P_TSENSOR_${v_i}    HDL_PARAMETER        false
        } else {
            add_parameter          P_TSENSOR_${v_i}    BOOLEAN              false ""
            set_parameter_property P_TSENSOR_${v_i}    DEFAULT_VALUE        false
            set_parameter_property P_TSENSOR_${v_i}    DISPLAY_NAME         "Sensor ${v_i}"
            set_parameter_property P_TSENSOR_${v_i}    UNITS                None
            set_parameter_property P_TSENSOR_${v_i}    VISIBLE              true
            set_parameter_property P_TSENSOR_${v_i}    AFFECTS_ELABORATION  true
            set_parameter_property P_TSENSOR_${v_i}    HDL_PARAMETER        false
        }
    }
}
add_tsensors

############################################################################
# Index Convert
############################################################################

proc add_index_convert {} {
    for {set v_i 0} {${v_i} < 13} {incr v_i} {
        if {${v_i} < 5} {
            add_parameter          P_INDEX_CONVERT_${v_i}   INTEGER              ${v_i}
            set_parameter_property P_INDEX_CONVERT_${v_i}   DEFAULT_VALUE        ${v_i}
            set_parameter_property P_INDEX_CONVERT_${v_i}   DISPLAY_NAME         ""
            set_parameter_property P_INDEX_CONVERT_${v_i}   ENABLED              true
            set_parameter_property P_INDEX_CONVERT_${v_i}   UNITS                None
            set_parameter_property P_INDEX_CONVERT_${v_i}   VISIBLE              false
            set_parameter_property P_INDEX_CONVERT_${v_i}   AFFECTS_ELABORATION  true
            set_parameter_property P_INDEX_CONVERT_${v_i}   HDL_PARAMETER        true
            set_parameter_property P_INDEX_CONVERT_${v_i}   DERIVED              true
        } else {
            add_parameter          P_INDEX_CONVERT_${v_i}   INTEGER              13
            set_parameter_property P_INDEX_CONVERT_${v_i}   DEFAULT_VALUE        13
            set_parameter_property P_INDEX_CONVERT_${v_i}   DISPLAY_NAME         ""
            set_parameter_property P_INDEX_CONVERT_${v_i}   ENABLED              true
            set_parameter_property P_INDEX_CONVERT_${v_i}   UNITS                None
            set_parameter_property P_INDEX_CONVERT_${v_i}   VISIBLE              false
            set_parameter_property P_INDEX_CONVERT_${v_i}   AFFECTS_ELABORATION  true
            set_parameter_property P_INDEX_CONVERT_${v_i}   HDL_PARAMETER        true
            set_parameter_property P_INDEX_CONVERT_${v_i}   DERIVED              true
        }
    }
}
add_index_convert

############################################################################
# Req Sensor
############################################################################

proc add_req_tempsens {} {
    for {set v_i 0} {${v_i} < 13} {incr v_i} {
        add_parameter          P_REQ_TEMPSENS_${v_i}   INTEGER              13
        set_parameter_property P_REQ_TEMPSENS_${v_i}   DEFAULT_VALUE        13
        set_parameter_property P_REQ_TEMPSENS_${v_i}   DISPLAY_NAME         ""
        set_parameter_property P_REQ_TEMPSENS_${v_i}   ENABLED              true
        set_parameter_property P_REQ_TEMPSENS_${v_i}   UNITS                None
        set_parameter_property P_REQ_TEMPSENS_${v_i}   VISIBLE              false
        set_parameter_property P_REQ_TEMPSENS_${v_i}   AFFECTS_ELABORATION  true
        set_parameter_property P_REQ_TEMPSENS_${v_i}   HDL_PARAMETER        true
        set_parameter_property P_REQ_TEMPSENS_${v_i}   DERIVED              true
    }
}
add_req_tempsens

############################################################################
# Interfaces
############################################################################

add_interface          clk clock                            end
set_interface_property clk ENABLED                          true
set_interface_property clk EXPORT_OF                        ""
set_interface_property clk PORT_NAME_MAP                    ""
set_interface_property clk CMSIS_SVD_VARIABLES              ""
set_interface_property clk SVD_ADDRESS_GROUP                ""
set_interface_property clk IPXACT_REGISTER_MAP_VARIABLES    ""
set_interface_property clk SV_INTERFACE_TYPE                ""
set_interface_property clk SV_INTERFACE_MODPORT_TYPE        ""

add_interface_port     clk clk clk Input 1

add_parameter DERIVED_CLOCK_RATE INTEGER 0
set_parameter_property DERIVED_CLOCK_RATE DISPLAY_NAME      "Derived clock rate"
set_parameter_property DERIVED_CLOCK_RATE DESCRIPTION       {Clock rate derived from system_info}
set_parameter_property DERIVED_CLOCK_RATE UNITS             Hertz
set_parameter_property DERIVED_CLOCK_RATE SYSTEM_INFO       { CLOCK_RATE "clk" }
set_parameter_property DERIVED_CLOCK_RATE SYSTEM_INFO_TYPE  {CLOCK_RATE}
set_parameter_property DERIVED_CLOCK_RATE ENABLED           false
set_parameter_property DERIVED_CLOCK_RATE VISIBLE           false

add_interface          reset reset                          end
set_interface_property reset associatedClock                clk
set_interface_property reset synchronousEdges               DEASSERT
set_interface_property reset ENABLED                        true
set_interface_property reset EXPORT_OF                      ""
set_interface_property reset PORT_NAME_MAP                  ""
set_interface_property reset CMSIS_SVD_VARIABLES            ""
set_interface_property reset SVD_ADDRESS_GROUP              ""
set_interface_property reset IPXACT_REGISTER_MAP_VARIABLES  ""
set_interface_property reset SV_INTERFACE_TYPE              ""
set_interface_property reset SV_INTERFACE_MODPORT_TYPE      ""

add_interface_port     reset reset reset Input 1

# ---------------------------------------------------------------------------- #
# Clock
# ---------------------------------------------------------------------------- #
add_interface            s_axi_aclk  clock           end
set_interface_property   s_axi_aclk  clockRate       0
set_interface_property   s_axi_aclk  ENABLED         true
add_interface_port       s_axi_aclk  s_axi_aclk clk  Input 1

# ---------------------------------------------------------------------------- #
# Reset
# ---------------------------------------------------------------------------- #
add_interface            s_axi_aresetn   reset             end
set_interface_property   s_axi_aresetn   associatedClock   s_axi_aclk
set_interface_property   s_axi_aresetn   synchronousEdges  DEASSERT
set_interface_property   s_axi_aresetn   ENABLED           true
add_interface_port       s_axi_aresetn   s_axi_aresetn     reset_n     Input   1

# ---------------------------------------------------------------------------- #
# AXI4Lite interface 0
# ---------------------------------------------------------------------------- #
add_interface          s_axi axi4lite             end
set_interface_property s_axi associatedClock      s_axi_aclk
set_interface_property s_axi associatedReset      s_axi_aresetn
set_interface_property s_axi ENABLED              true
set_interface_property s_axi EXPORT_OF            s_axi
set_interface_property s_axi PORT_NAME_MAP        ""
set_interface_property s_axi CMSIS_SVD_VARIABLES  ""
set_interface_property s_axi SVD_ADDRESS_GROUP    ""

add_interface_port s_axi s_axi_awaddr  awaddr  Input   P_S_AXI_ADDR_WIDTH
add_interface_port s_axi s_axi_awvalid awvalid Input   1
add_interface_port s_axi s_axi_awready awready Output  1
add_interface_port s_axi s_axi_wdata   wdata   Input   P_S_AXI_DATA_WIDTH
add_interface_port s_axi s_axi_wready  wready  Output  1
add_interface_port s_axi s_axi_wvalid  wvalid  Input   1
add_interface_port s_axi s_axi_wstrb   wstrb   Input   (P_S_AXI_DATA_WIDTH/8)
add_interface_port s_axi s_axi_bresp   bresp   Output  2
add_interface_port s_axi s_axi_bvalid  bvalid  Output  1
add_interface_port s_axi s_axi_bready  bready  Input   1
add_interface_port s_axi s_axi_rdata   rdata   Output  P_S_AXI_DATA_WIDTH
add_interface_port s_axi s_axi_rresp   rresp   Output  2
add_interface_port s_axi s_axi_rvalid  rvalid  Output  1
add_interface_port s_axi s_axi_rready  rready  Input   1
add_interface_port s_axi s_axi_araddr  araddr  Input   P_S_AXI_ADDR_WIDTH
add_interface_port s_axi s_axi_arvalid arvalid Input   1
add_interface_port s_axi s_axi_arready arready Output  1
add_interface_port s_axi s_axi_awprot  awprot  Input   3
add_interface_port s_axi s_axi_arprot  arprot  Input   3

############################################################################
# Conduit Control
############################################################################

# Hardware -> ESL Conduits

add_interface          c_hardware_esl    conduit              start
set_interface_property c_hardware_esl    ENABLED              true
set_interface_property c_hardware_esl    EXPORT_OF            ""
set_interface_property c_hardware_esl    PORT_NAME_MAP        ""
set_interface_property c_hardware_esl    CMSIS_SVD_VARIABLES  ""
set_interface_property c_hardware_esl    SVD_ADDRESS_GROUP    ""

add_interface_port     c_hardware_esl    pwr_good_p           pwr_good_p           Output 1
add_interface_port     c_hardware_esl    pwr_good_n           pwr_good_n           Output 1

add_interface_port     c_hardware_esl    temp_good_p          temp_good_p          Output 1
add_interface_port     c_hardware_esl    temp_good_n          temp_good_n          Output 1

add_interface_port     c_hardware_esl    cram_good_p          cram_good_p          Output 1
add_interface_port     c_hardware_esl    cram_good_n          cram_good_n          Output 1

############################################################################
# Output Conduit Control
############################################################################

add_interface           dup_pwr_good_p        conduit              start
set_interface_property  dup_pwr_good_p        ENABLED              false
set_interface_property  dup_pwr_good_p        EXPORT_OF            dup_pwr_good_p
set_interface_property  dup_pwr_good_p        PORT_NAME_MAP        ""
set_interface_property  dup_pwr_good_p        CMSIS_SVD_VARIABLES  ""
set_interface_property  dup_pwr_good_p        SVD_ADDRESS_GROUP    ""
add_interface_port      dup_pwr_good_p        dup_pwr_good_p       dup_pwr_good_p     Output 1

add_interface           dup_pwr_good_n        conduit              start
set_interface_property  dup_pwr_good_n        ENABLED              false
set_interface_property  dup_pwr_good_n        EXPORT_OF            dup_pwr_good_n
set_interface_property  dup_pwr_good_n        PORT_NAME_MAP        ""
set_interface_property  dup_pwr_good_n        CMSIS_SVD_VARIABLES  ""
set_interface_property  dup_pwr_good_n        SVD_ADDRESS_GROUP    ""
add_interface_port      dup_pwr_good_n        dup_pwr_good_n       dup_pwr_good_n     Output 1

add_interface           dup_temp_good_p       conduit              start
set_interface_property  dup_temp_good_p       ENABLED              false
set_interface_property  dup_temp_good_p       EXPORT_OF            dup_temp_good_p
set_interface_property  dup_temp_good_p       PORT_NAME_MAP        ""
set_interface_property  dup_temp_good_p       CMSIS_SVD_VARIABLES  ""
set_interface_property  dup_temp_good_p       SVD_ADDRESS_GROUP    ""
add_interface_port      dup_temp_good_p       dup_temp_good_p      dup_temp_good_p    Output 1

add_interface           dup_temp_good_n       conduit              start
set_interface_property  dup_temp_good_n       ENABLED              false
set_interface_property  dup_temp_good_n       EXPORT_OF            ""
set_interface_property  dup_temp_good_n       PORT_NAME_MAP        ""
set_interface_property  dup_temp_good_n       CMSIS_SVD_VARIABLES  ""
set_interface_property  dup_temp_good_n       SVD_ADDRESS_GROUP    ""
add_interface_port      dup_temp_good_n       dup_temp_good_n      dup_temp_good_n    Output 1

add_interface           dup_cram_good_p       conduit              start
set_interface_property  dup_cram_good_p       ENABLED              false
set_interface_property  dup_cram_good_p       EXPORT_OF            ""
set_interface_property  dup_cram_good_p       PORT_NAME_MAP        ""
set_interface_property  dup_cram_good_p       CMSIS_SVD_VARIABLES  ""
set_interface_property  dup_cram_good_p       SVD_ADDRESS_GROUP    ""
add_interface_port      dup_cram_good_p       dup_cram_good_p      dup_cram_good_p    Output 1

add_interface           dup_cram_good_n       conduit              start
set_interface_property  dup_cram_good_n       ENABLED              false
set_interface_property  dup_cram_good_n       EXPORT_OF            ""
set_interface_property  dup_cram_good_n       PORT_NAME_MAP        ""
set_interface_property  dup_cram_good_n       CMSIS_SVD_VARIABLES  ""
set_interface_property  dup_cram_good_n       SVD_ADDRESS_GROUP    ""
add_interface_port      dup_cram_good_n       dup_cram_good_n      dup_cram_good_n    Output 1


# ---------------------------------------------------------------------------- #
#                               parse_device
# splits the Agilex 5 OPN into its constituent parts, returning an array
# ---------------------------------------------------------------------------- #
proc parse_device {device} {

  set part_device ${device}
  set part_rebuilt ""

  regexp  {([[:alpha:]][[:digit:]])} ${part_device} part_family
  set part_device [string replace ${part_device} 0 1 ""]
  append part_rebuilt ${part_family}

  regexp  {([[:alpha:]])} ${part_device} part_series
  set part_device [string replace ${part_device} 0 0 ""]
  append part_rebuilt ${part_series}

  regexp  {([[:alpha:]])} ${part_device} part_spec
  set part_device [string replace ${part_device} 0 0 ""]
  append part_rebuilt ${part_spec}

  regexp  {([[:digit:]]{3})} ${part_device} part_density
  set part_device [string replace ${part_device} 0 2 ""]
  append part_rebuilt ${part_density}

  regexp  {([[:alpha:]])} ${part_device} part_group
  set part_device [string replace ${part_device} 0 0 ""]
  append part_rebuilt ${part_group}

  regexp  {([[:alpha:]][[:digit:]]{2}[[:alpha:]])} ${part_device} part_package
  set part_device [string replace ${part_device} 0 3 ""]
  append part_rebuilt ${part_package}

  regexp  {([[:alpha:]])} ${part_device} part_op_temp
  set part_device [string replace ${part_device} 0 0 ""]
  append part_rebuilt ${part_op_temp}

  regexp  {([[:digit:]])} ${part_device} part_speed
  set part_device [string replace ${part_device} 0 0 ""]
  append part_rebuilt ${part_speed}

  regexp  {([[:alpha:]])} ${part_device} part_power
  set part_device [string replace ${part_device} 0 0 ""]
  append part_rebuilt ${part_power}

  regexp  {([[:alnum:]]*)} ${part_device} part_opt
  append part_rebuilt ${part_opt}

  if {[string equal ${part_rebuilt} ${device}] != 1} {
    send_message Warning "Parsing device number failed: Original ${device}; Rebuilt ${part_rebuilt}"
  }

  array set device_specs "
    FAMILY  ${part_family}
    SERIES  ${part_series}
    SPEC    ${part_spec}
    DENSITY ${part_density}
    GROUP   ${part_group}
    PACKAGE ${part_package}
    OP_TEMP ${part_op_temp}
    SPEED   ${part_speed}
    POWER   ${part_power}
    OPT     ${part_opt}
  "

  parray device_specs

  return [array get device_specs]
}

# ---------------------------------------------------------------------------- #
# Validation Callback
# ---------------------------------------------------------------------------- #
proc val_callback {} {
  set v_channel_count 0
  for {set v_i 0} {${v_i} < 13} {incr v_i} {
    set v_p [get_parameter_value P_TSENSOR_${v_i}]
    if {${v_p}} {
      send_message Info "Required Sensor: ${v_i}"
      set_parameter_value P_REQ_TEMPSENS_${v_i}  ${v_i}
      set_parameter_value P_INDEX_CONVERT_${v_i}  ${v_channel_count}
      incr v_channel_count
    } else {
      set_parameter_value P_INDEX_CONVERT_${v_i}  13
    }
  }

  send_message Info "Number of Channels: ${v_channel_count}"
  set_parameter_value P_NO_CH_TEMP ${v_channel_count}

  for {set v_x 0} {${v_x} < 13} {incr v_x} {
    send_message Info "Index Convert: [get_parameter_value P_INDEX_CONVERT_${v_x}]"
  }

  array set v_device_info [parse_device [get_parameter_value DEVICE]]

  set_parameter_value P_AG5_SERIES   $v_device_info(SERIES)
  set_parameter_value P_AG5_DENSITY  $v_device_info(DENSITY)

}

# ---------------------------------------------------------------------------- #
# Elaboration Callback
# ---------------------------------------------------------------------------- #

proc elab_callback {} {
    set v_s [get_parameter_value P_SINGULAR_BITS]
    if {${v_s}} {
        set_interface_property  dup_pwr_good_p       ENABLED              true
        set_interface_property  dup_pwr_good_n       ENABLED              true
        set_interface_property  dup_temp_good_p      ENABLED              true
        set_interface_property  dup_temp_good_n      ENABLED              true
        set_interface_property  dup_cram_good_p      ENABLED              true
        set_interface_property  dup_cram_good_n      ENABLED              true
    } else {
        send_message Info "Conduit Singular Bits Turned Off"
    }

    # Add Mailbox Instance
    set v_dev_fam [get_parameter_value P_FAMILY]
    if {${v_dev_fam} == "Agilex 7"} {
        add_hdl_instance doc_hw_mailbox intel_fpga_mailbox_avst_client 2.0.0
        set_instance_parameter_value doc_hw_mailbox {ENABLE_STATUS} {0}
        set_instance_parameter_value doc_hw_mailbox {ENABLE_STREAM} {0}
        set_instance_parameter_value doc_hw_mailbox {STREAM_WIDTH} {32}
        set_instance_parameter_value doc_hw_mailbox {ENABLE_URGENT} {0}

    } elseif {${v_dev_fam} == "Agilex 5"} {
      add_hdl_instance doc_hw_ag5_mailbox intel_mailbox_client 1.0.1
      set_instance_parameter_value doc_hw_ag5_mailbox {CMD_FIFO_DEPTH} {2}
      set_instance_parameter_value doc_hw_ag5_mailbox {RSP_FIFO_DEPTH} {2}
      set_instance_parameter_value doc_hw_ag5_mailbox {HAS_OFFLOAD}    {0}

    }

    add_hdl_instance             axil2apb intel_fpga_axil2apb 1.0
    set_instance_parameter_value axil2apb {P_S_AXI_ADDR_WIDTH} [get_parameter_value P_S_AXI_ADDR_WIDTH]
    set_instance_parameter_value axil2apb {P_S_AXI_DATA_WIDTH} [get_parameter_value P_S_AXI_DATA_WIDTH]
    set_instance_parameter_value axil2apb {P_WATCHDOG_EN}      {1}

}

proc gen_callback { entity } {

}

proc board_check {} {

}
