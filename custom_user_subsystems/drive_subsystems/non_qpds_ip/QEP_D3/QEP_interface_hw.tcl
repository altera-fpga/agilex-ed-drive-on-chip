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


# QEP_interface "QEP interface" v1.0

# request TCL package from ACDS 13.1
package require -exact qsys 13.1



# module QEP_interface
set_module_property     DESCRIPTION                     ""
set_module_property     NAME                            QEP_interface
set_module_property     VERSION                         1.0
set_module_property     INTERNAL                        false
set_module_property     OPAQUE_ADDRESS_MAP              true
set_module_property     GROUP                           "Motor Control Suite"
set_module_property     AUTHOR                          sbrown
set_module_property     DISPLAY_NAME                    "QEP interface"
set_module_property     INSTANTIATE_IN_SYSTEM_MODULE    true
set_module_property     EDITABLE                        true
set_module_property     ANALYZE_HDL                     AUTO
set_module_property     REPORT_TO_TALKBACK              false
set_module_property     ALLOW_GREYBOX_GENERATION        false

set_module_property     VALIDATION_CALLBACK              my_validate
set_module_property     ELABORATION_CALLBACK            my_elab

add_parameter          P_ENABLE_AVMM           INTEGER              1
set_parameter_property P_ENABLE_AVMM           DEFAULT_VALUE        1
set_parameter_property P_ENABLE_AVMM           DISPLAY_NAME         "Enable Avalon MM Interface"
set_parameter_property P_ENABLE_AVMM           DESCRIPTION          "Enable Avalon MM Interface for control"
set_parameter_property P_ENABLE_AVMM           DISPLAY_HINT         "Boolean"
set_parameter_property P_ENABLE_AVMM           ALLOWED_RANGES       {0:1}
set_parameter_property P_ENABLE_AVMM           AFFECTS_ELABORATION  true
set_parameter_property P_ENABLE_AVMM           AFFECTS_VALIDATION   true
set_parameter_property P_ENABLE_AVMM           HDL_PARAMETER        true
set_parameter_property P_ENABLE_AVMM           VISIBLE              true
set_parameter_property P_ENABLE_AVMM           ENABLED              true
set_parameter_property P_ENABLE_AVMM           DERIVED              false
set_parameter_property P_ENABLE_AVMM           UNITS                None

add_parameter          P_ENABLE_MONITOR        INTEGER              0
set_parameter_property P_ENABLE_MONITOR        DEFAULT_VALUE        0
set_parameter_property P_ENABLE_MONITOR        DISPLAY_NAME         "Enable Monitor Interface"
set_parameter_property P_ENABLE_MONITOR        DESCRIPTION          "Enable Monitor Interface containing encoder count and error"
set_parameter_property P_ENABLE_MONITOR        DISPLAY_HINT         "Boolean"
set_parameter_property P_ENABLE_MONITOR        ALLOWED_RANGES       {0:1}
set_parameter_property P_ENABLE_MONITOR        AFFECTS_ELABORATION  true
set_parameter_property P_ENABLE_MONITOR        HDL_PARAMETER        false
set_parameter_property P_ENABLE_MONITOR        VISIBLE              true
set_parameter_property P_ENABLE_MONITOR        ENABLED              true
set_parameter_property P_ENABLE_MONITOR        DERIVED              false
set_parameter_property P_ENABLE_MONITOR        UNITS                None

add_parameter          P_EN_ENCODER_ERR_IP     INTEGER              0
set_parameter_property P_EN_ENCODER_ERR_IP     DEFAULT_VALUE        0
set_parameter_property P_EN_ENCODER_ERR_IP     DISPLAY_NAME         "Enable Encoder Error Input"
set_parameter_property P_EN_ENCODER_ERR_IP     DESCRIPTION          "Enable error input from the encoder"
set_parameter_property P_EN_ENCODER_ERR_IP     DISPLAY_HINT         "Boolean"
set_parameter_property P_EN_ENCODER_ERR_IP     ALLOWED_RANGES       {0:1}
set_parameter_property P_EN_ENCODER_ERR_IP     AFFECTS_ELABORATION  false
set_parameter_property P_EN_ENCODER_ERR_IP     AFFECTS_VALIDATION   false
set_parameter_property P_EN_ENCODER_ERR_IP     HDL_PARAMETER        true
set_parameter_property P_EN_ENCODER_ERR_IP     VISIBLE              false
set_parameter_property P_EN_ENCODER_ERR_IP     ENABLED              true
set_parameter_property P_EN_ENCODER_ERR_IP     DERIVED              false
set_parameter_property P_EN_ENCODER_ERR_IP     UNITS                None

add_parameter          P_ENABLE_INDEX_CAPTURE  INTEGER              0
set_parameter_property P_ENABLE_INDEX_CAPTURE  DEFAULT_VALUE        0
set_parameter_property P_ENABLE_INDEX_CAPTURE  DISPLAY_NAME         "Enable Index Capture"
set_parameter_property P_ENABLE_INDEX_CAPTURE  DESCRIPTION          "Enable count capture on detection of the index pulse (if Avalon MM interface is disabled)"
set_parameter_property P_ENABLE_INDEX_CAPTURE  DISPLAY_HINT         "Boolean"
set_parameter_property P_ENABLE_INDEX_CAPTURE  ALLOWED_RANGES       {0:1}
set_parameter_property P_ENABLE_INDEX_CAPTURE  AFFECTS_ELABORATION  false
set_parameter_property P_ENABLE_INDEX_CAPTURE  HDL_PARAMETER        true
set_parameter_property P_ENABLE_INDEX_CAPTURE  VISIBLE              true
set_parameter_property P_ENABLE_INDEX_CAPTURE  ENABLED              false
set_parameter_property P_ENABLE_INDEX_CAPTURE  DERIVED              false
set_parameter_property P_ENABLE_INDEX_CAPTURE  UNITS                None

add_parameter          P_ENABLE_INDEX_RESET    INTEGER              0
set_parameter_property P_ENABLE_INDEX_RESET    DEFAULT_VALUE        0
set_parameter_property P_ENABLE_INDEX_RESET    DISPLAY_NAME         "Enable Index Reset"
set_parameter_property P_ENABLE_INDEX_RESET    DESCRIPTION          "Enable reset of the counter on detection of the index pulse (if Avalon MM interface is disabled)"
set_parameter_property P_ENABLE_INDEX_RESET    ALLOWED_RANGES       {0:1}
set_parameter_property P_ENABLE_INDEX_RESET    DISPLAY_HINT         "Boolean"
set_parameter_property P_ENABLE_INDEX_RESET    AFFECTS_ELABORATION  false
set_parameter_property P_ENABLE_INDEX_RESET    HDL_PARAMETER        true
set_parameter_property P_ENABLE_INDEX_RESET    VISIBLE              true
set_parameter_property P_ENABLE_INDEX_RESET    ENABLED              false
set_parameter_property P_ENABLE_INDEX_RESET    DERIVED              false
set_parameter_property P_ENABLE_INDEX_RESET    UNITS                None

add_parameter          P_REVERSE_DIRECTION     INTEGER              0
set_parameter_property P_REVERSE_DIRECTION     DEFAULT_VALUE        0
set_parameter_property P_REVERSE_DIRECTION     DISPLAY_NAME         "Reverse Direction"
set_parameter_property P_REVERSE_DIRECTION     DESCRIPTION          "Reverse the direction - equivalent to swapping A and B inputs (if Avalon MM interface is disabled)"
set_parameter_property P_REVERSE_DIRECTION     ALLOWED_RANGES       {0:1}
set_parameter_property P_REVERSE_DIRECTION     DISPLAY_HINT         "Boolean"
set_parameter_property P_REVERSE_DIRECTION     AFFECTS_ELABORATION  false
set_parameter_property P_REVERSE_DIRECTION     HDL_PARAMETER        true
set_parameter_property P_REVERSE_DIRECTION     VISIBLE              true
set_parameter_property P_REVERSE_DIRECTION     ENABLED              false
set_parameter_property P_REVERSE_DIRECTION     DERIVED              false
set_parameter_property P_REVERSE_DIRECTION     UNITS                None

add_parameter          P_MAX_COUNT             INTEGER              32768
set_parameter_property P_MAX_COUNT             DEFAULT_VALUE        32768
set_parameter_property P_MAX_COUNT             DISPLAY_NAME         "Maximum counter value"
set_parameter_property P_MAX_COUNT             AFFECTS_ELABORATION  false
set_parameter_property P_MAX_COUNT             HDL_PARAMETER        true
set_parameter_property P_MAX_COUNT             VISIBLE              true
set_parameter_property P_MAX_COUNT             ENABLED              false
set_parameter_property P_MAX_COUNT             UNITS                None

add_parameter          P_QEP_COUNT_WIDTH       INTEGER              13
set_parameter_property P_QEP_COUNT_WIDTH       DEFAULT_VALUE        13
set_parameter_property P_QEP_COUNT_WIDTH       DISPLAY_NAME         "Width of the Quadrature Counter"
set_parameter_property P_QEP_COUNT_WIDTH       DESCRIPTION          "0 => linear encoder counter width 32 bits and Maximum Counter Value is used. Non-zero sets rotary counter width and Maximum Counter Value is ignored"
set_parameter_property P_QEP_COUNT_WIDTH       AFFECTS_ELABORATION  false
set_parameter_property P_QEP_COUNT_WIDTH       HDL_PARAMETER        true
set_parameter_property P_QEP_COUNT_WIDTH       VISIBLE              true
set_parameter_property P_QEP_COUNT_WIDTH       ENABLED              false
set_parameter_property P_QEP_COUNT_WIDTH       UNITS                None

# file sets

add_fileset             QUARTUS_SYNTH   QUARTUS_SYNTH   "" ""
set_fileset_property    QUARTUS_SYNTH   TOP_LEVEL       QEP_top
set_fileset_property    QUARTUS_SYNTH   ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file        QEP_top.v       VERILOG PATH    QEP_top.v TOP_LEVEL_FILE
add_fileset_file        debounce.v      VERILOG PATH    debounce.v
add_fileset_file        QEPcounter.v    VERILOG PATH    QEPcounter.v
add_fileset_file        QEPdecoder.v    VERILOG PATH    QEPdecoder.v

add_fileset             SIM_VERILOG     SIM_VERILOG "" ""
set_fileset_property    SIM_VERILOG     TOP_LEVEL QEP_top
set_fileset_property    SIM_VERILOG     ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file        QEP_top.v       VERILOG PATH QEP_top.v
add_fileset_file        debounce.v      VERILOG PATH debounce.v
add_fileset_file        QEPcounter.v    VERILOG PATH QEPcounter.v
add_fileset_file        QEPdecoder.v    VERILOG PATH QEPdecoder.v

# connection point clock

add_interface           clock clock                 end
set_interface_property  clock clockRate             0
set_interface_property  clock ENABLED               true
set_interface_property  clock EXPORT_OF             ""
set_interface_property  clock PORT_NAME_MAP         ""
set_interface_property  clock CMSIS_SVD_VARIABLES   ""
set_interface_property  clock SVD_ADDRESS_GROUP     ""

add_interface_port clock clk clk Input 1

# connection point reset

add_interface           reset   reset               end
set_interface_property  reset   associatedClock     clock
set_interface_property  reset   synchronousEdges    DEASSERT
set_interface_property  reset   ENABLED             true
set_interface_property  reset   EXPORT_OF           ""
set_interface_property  reset   PORT_NAME_MAP       ""
set_interface_property  reset   CMSIS_SVD_VARIABLES ""
set_interface_property  reset   SVD_ADDRESS_GROUP   ""

add_interface_port reset reset_n reset_n Input 1

# connection point avalon_slave_0

add_interface           avalon_slave_0  avalon end
set_interface_property  avalon_slave_0  addressUnits                    WORDS
set_interface_property  avalon_slave_0  associatedClock                 clock
set_interface_property  avalon_slave_0  associatedReset                 reset
set_interface_property  avalon_slave_0  bitsPerSymbol                   8
set_interface_property  avalon_slave_0  burstOnBurstBoundariesOnly      false
set_interface_property  avalon_slave_0  burstcountUnits                 WORDS
set_interface_property  avalon_slave_0  explicitAddressSpan             0
set_interface_property  avalon_slave_0  holdTime                        0
set_interface_property  avalon_slave_0  linewrapBursts                  false
set_interface_property  avalon_slave_0  maximumPendingReadTransactions  0
set_interface_property  avalon_slave_0  readLatency                     0
set_interface_property  avalon_slave_0  readWaitTime                    1
set_interface_property  avalon_slave_0  setupTime                       0
set_interface_property  avalon_slave_0  timingUnits                     Cycles
set_interface_property  avalon_slave_0  writeWaitTime                   0
set_interface_property  avalon_slave_0  ENABLED                         true
set_interface_property  avalon_slave_0  EXPORT_OF                       ""
set_interface_property  avalon_slave_0  PORT_NAME_MAP                   ""
set_interface_property  avalon_slave_0  CMSIS_SVD_VARIABLES             ""
set_interface_property  avalon_slave_0  SVD_ADDRESS_GROUP               ""

add_interface_port avalon_slave_0           avs_write_n write_n     Input                   1
add_interface_port avalon_slave_0           avs_read_n read_n       Input                   1
add_interface_port avalon_slave_0           avs_address address     Input                   4
add_interface_port avalon_slave_0           avs_writedata writedata Input                   32
add_interface_port avalon_slave_0           avs_readdata readdata   Output                  32
set_interface_assignment avalon_slave_0     embeddedsw.configuration.isFlash                0
set_interface_assignment avalon_slave_0     embeddedsw.configuration.isMemoryDevice         0
set_interface_assignment avalon_slave_0     embeddedsw.configuration.isNonVolatileStorage   0
set_interface_assignment avalon_slave_0     embeddedsw.configuration.isPrintableDevice      0

# connection point conduit_end

add_interface           conduit_end conduit                 end
set_interface_property  conduit_end associatedClock         clock
set_interface_property  conduit_end associatedReset         reset
set_interface_property  conduit_end ENABLED                 true
set_interface_property  conduit_end EXPORT_OF               ""
set_interface_property  conduit_end PORT_NAME_MAP           ""
set_interface_property  conduit_end CMSIS_SVD_VARIABLES     ""
set_interface_property  conduit_end SVD_ADDRESS_GROUP       ""

add_interface_port  conduit_end strobe  export  Input 1
add_interface_port  conduit_end QEP_A   export  Input 1
add_interface_port  conduit_end QEP_B   export  Input 1
add_interface_port  conduit_end QEP_I   export  Input 1

add_interface           monitor     conduit                 start
set_interface_property  monitor     associatedClock         clock
set_interface_property  monitor     associatedReset         reset
set_interface_property  monitor     ENABLED                 false
set_interface_property  monitor     EXPORT_OF               ""
set_interface_property  monitor     PORT_NAME_MAP           ""
set_interface_property  monitor     CMSIS_SVD_VARIABLES     ""
set_interface_property  monitor     SVD_ADDRESS_GROUP       ""

add_interface_port monitor QEP_count qep_count Output 32
add_interface_port monitor QEP_error qep_error Output 1

proc my_elab {} {

  if { [get_parameter_value P_ENABLE_AVMM] == 0} {
    set_interface_property avalon_slave_0 ENABLED false
  } else {
    set_interface_property avalon_slave_0 ENABLED true
  }

  if { [get_parameter_value P_ENABLE_MONITOR] == 0} {
    set_interface_property monitor ENABLED false
  } else {
    set_interface_property monitor ENABLED true
  }

}
proc my_validate {} {

  if { [get_parameter_value P_ENABLE_AVMM] == 0} {
    set_parameter_property P_ENABLE_INDEX_CAPTURE  ENABLED  true
    set_parameter_property P_ENABLE_INDEX_RESET    ENABLED  true
    set_parameter_property P_REVERSE_DIRECTION     ENABLED  true
    set_parameter_property P_MAX_COUNT             ENABLED  true
  } else {
    set_parameter_property P_ENABLE_INDEX_CAPTURE  ENABLED  false
    set_parameter_property P_ENABLE_INDEX_RESET    ENABLED  false
    set_parameter_property P_REVERSE_DIRECTION     ENABLED  false
    set_parameter_property P_MAX_COUNT             ENABLED  false
  }

}
