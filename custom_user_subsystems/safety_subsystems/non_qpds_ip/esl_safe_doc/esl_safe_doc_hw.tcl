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

package require -exact qsys 23.1

############################################################################
# Module Properties
############################################################################
set_module_property NAME                         esl_safe_doc
set_module_property DESCRIPTION                  "Safe DoC ESL"
set_module_property DISPLAY_NAME                 "Safe DoC ESL"
set_module_property VERSION                      1.0
set_module_property GROUP                        "Safe DoC - ESL"
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

add_fileset          QUARTUS_SYNTH QUARTUS_SYNTH    gen_callback ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL        esl_safe_doc

add_fileset_file    rtl/complimentary_bit_pkg.sv        SYSTEMVERILOG PATH rtl/complimentary_bit_pkg.sv
add_fileset_file    rtl/esl_comp_inputs.sv              SYSTEMVERILOG PATH rtl/esl_comp_inputs.sv
add_fileset_file    rtl/esl_window_check.sv             SYSTEMVERILOG PATH rtl/esl_window_check.sv
add_fileset_file    rtl/esl_safe_doc.sv                 SYSTEMVERILOG PATH rtl/esl_safe_doc.sv
add_fileset_file  sdc/esl_safe_doc.sdc                  SDC_ENTITY    PATH sdc/esl_safe_doc.sdc {NO_SDC_PROMOTION}

add_fileset_file    rtl/esl_clk_check_cut_count.sv      SYSTEMVERILOG PATH rtl/esl_clk_check_cut_count.sv
add_fileset_file    rtl/esl_clk_check_flag_gen.sv       SYSTEMVERILOG PATH rtl/esl_clk_check_flag_gen.sv
add_fileset_file    rtl/esl_clk_check_freq_comp.sv      SYSTEMVERILOG PATH rtl/esl_clk_check_freq_comp.sv
add_fileset_file    rtl/esl_clk_check_fsm.sv            SYSTEMVERILOG PATH rtl/esl_clk_check_fsm.sv
add_fileset_file    rtl/esl_clk_check_ref_clk_count.sv  SYSTEMVERILOG PATH rtl/esl_clk_check_ref_clk_count.sv
add_fileset_file    rtl/esl_clk_check.sv                SYSTEMVERILOG PATH rtl/esl_clk_check.sv


############################################################################
# Module parameters
############################################################################

add_parameter          P_MAX_TEMP           INTEGER             40
set_parameter_property P_MAX_TEMP           DEFAULT_VALUE       40
set_parameter_property P_MAX_TEMP           DISPLAY_NAME        "Maximum Allowed Chip Temperature"
set_parameter_property P_MAX_TEMP           ENABLED             true
set_parameter_property P_MAX_TEMP           UNITS               None
set_parameter_property P_MAX_TEMP           VISIBLE             true
set_parameter_property P_MAX_TEMP           AFFECTS_ELABORATION true
set_parameter_property P_MAX_TEMP           HDL_PARAMETER       true

add_parameter          P_MIN_TEMP           INTEGER             0
set_parameter_property P_MIN_TEMP           DEFAULT_VALUE       0
set_parameter_property P_MIN_TEMP           DISPLAY_NAME        "Maximum Allowed Chip Temperature"
set_parameter_property P_MIN_TEMP           ENABLED             true
set_parameter_property P_MIN_TEMP           UNITS               None
set_parameter_property P_MIN_TEMP           VISIBLE             true
set_parameter_property P_MIN_TEMP           AFFECTS_ELABORATION true
set_parameter_property P_MIN_TEMP           HDL_PARAMETER       true

add_parameter          P_TEMP_WIDTH         INTEGER             8
set_parameter_property P_TEMP_WIDTH         DEFAULT_VALUE       8
set_parameter_property P_TEMP_WIDTH         DISPLAY_NAME        "Number of Temp Bits Present"
set_parameter_property P_TEMP_WIDTH         ENABLED             true
set_parameter_property P_TEMP_WIDTH         UNITS               None
set_parameter_property P_TEMP_WIDTH         VISIBLE             true
set_parameter_property P_TEMP_WIDTH         AFFECTS_ELABORATION true
set_parameter_property P_TEMP_WIDTH         HDL_PARAMETER       true

add_parameter          P_DATA_WIDTH         INTEGER             9
set_parameter_property P_DATA_WIDTH         DEFAULT_VALUE       9
set_parameter_property P_DATA_WIDTH         DISPLAY_NAME        "Number of Compli Inputs"
set_parameter_property P_DATA_WIDTH         ENABLED             true
set_parameter_property P_DATA_WIDTH         UNITS               None
set_parameter_property P_DATA_WIDTH         VISIBLE             true
set_parameter_property P_DATA_WIDTH         AFFECTS_ELABORATION true
set_parameter_property P_DATA_WIDTH         HDL_PARAMETER       true

add_parameter          P_WAIT_LIMIT_MS      INTEGER             1
set_parameter_property P_WAIT_LIMIT_MS      DEFAULT_VALUE       1
set_parameter_property P_WAIT_LIMIT_MS      DISPLAY_NAME        "Initial Wait Time (ms)"
set_parameter_property P_WAIT_LIMIT_MS      ENABLED             true
set_parameter_property P_WAIT_LIMIT_MS      UNITS               None
set_parameter_property P_WAIT_LIMIT_MS      VISIBLE             true
set_parameter_property P_WAIT_LIMIT_MS      AFFECTS_ELABORATION true
set_parameter_property P_WAIT_LIMIT_MS      HDL_PARAMETER       true

add_parameter          P_WAIT_COUNTER_WIDTH INTEGER             34
set_parameter_property P_WAIT_COUNTER_WIDTH DEFAULT_VALUE       34
set_parameter_property P_WAIT_COUNTER_WIDTH DISPLAY_NAME        "Initial Wait Counter Width"
set_parameter_property P_WAIT_COUNTER_WIDTH ENABLED             true
set_parameter_property P_WAIT_COUNTER_WIDTH UNITS               None
set_parameter_property P_WAIT_COUNTER_WIDTH VISIBLE             true
set_parameter_property P_WAIT_COUNTER_WIDTH AFFECTS_ELABORATION true
set_parameter_property P_WAIT_COUNTER_WIDTH HDL_PARAMETER       true

add_parameter          P_ESL_CLK_FREQ_HZ    INTEGER             0
set_parameter_property P_ESL_CLK_FREQ_HZ    DEFAULT_VALUE       0
set_parameter_property P_ESL_CLK_FREQ_HZ    DISPLAY_NAME        "ESL Clock Frequency (Hz)"
set_parameter_property P_ESL_CLK_FREQ_HZ    ENABLED             false
set_parameter_property P_ESL_CLK_FREQ_HZ    UNITS               Hertz
set_parameter_property P_ESL_CLK_FREQ_HZ    VISIBLE             true
set_parameter_property P_ESL_CLK_FREQ_HZ    AFFECTS_ELABORATION true
set_parameter_property P_ESL_CLK_FREQ_HZ    HDL_PARAMETER       true
set_parameter_property P_ESL_CLK_FREQ_HZ    DERIVED             true

add_parameter          P_CLK_HPS_FREQ_HZ    INTEGER             0
set_parameter_property P_CLK_HPS_FREQ_HZ    DEFAULT_VALUE       0
set_parameter_property P_CLK_HPS_FREQ_HZ    DISPLAY_NAME        "HPS Clock Frequency (Hz)"
set_parameter_property P_CLK_HPS_FREQ_HZ    ENABLED             false
set_parameter_property P_CLK_HPS_FREQ_HZ    UNITS               Hertz
set_parameter_property P_CLK_HPS_FREQ_HZ    VISIBLE             true
set_parameter_property P_CLK_HPS_FREQ_HZ    AFFECTS_ELABORATION true
set_parameter_property P_CLK_HPS_FREQ_HZ    HDL_PARAMETER       true
set_parameter_property P_CLK_HPS_FREQ_HZ    DERIVED             true

add_parameter          P_CLK_FPGA_FREQ_HZ   INTEGER             0
set_parameter_property P_CLK_FPGA_FREQ_HZ   DEFAULT_VALUE       0
set_parameter_property P_CLK_FPGA_FREQ_HZ   DISPLAY_NAME        "FPGA Clock Frequency (Hz)"
set_parameter_property P_CLK_FPGA_FREQ_HZ   ENABLED             false
set_parameter_property P_CLK_FPGA_FREQ_HZ   UNITS               Hertz
set_parameter_property P_CLK_FPGA_FREQ_HZ   VISIBLE             true
set_parameter_property P_CLK_FPGA_FREQ_HZ   AFFECTS_ELABORATION true
set_parameter_property P_CLK_FPGA_FREQ_HZ   HDL_PARAMETER       true
set_parameter_property P_CLK_FPGA_FREQ_HZ   DERIVED             true

add_parameter          P_WINDOW_PERIOD      INTEGER             1000
set_parameter_property P_WINDOW_PERIOD      DEFAULT_VALUE       1000
set_parameter_property P_WINDOW_PERIOD      DISPLAY_NAME        "Window Check Period (us)"
set_parameter_property P_WINDOW_PERIOD      ENABLED             false
set_parameter_property P_WINDOW_PERIOD      UNITS               Hertz
set_parameter_property P_WINDOW_PERIOD      VISIBLE             true
set_parameter_property P_WINDOW_PERIOD      AFFECTS_ELABORATION true
set_parameter_property P_WINDOW_PERIOD      HDL_PARAMETER       true
set_parameter_property P_WINDOW_PERIOD      DERIVED             true

add_parameter          P_WINDOW_TOLERANCE   INTEGER             300
set_parameter_property P_WINDOW_TOLERANCE   DEFAULT_VALUE       300
set_parameter_property P_WINDOW_TOLERANCE   DISPLAY_NAME        "Window Check Tolerance (us)"
set_parameter_property P_WINDOW_TOLERANCE   ENABLED             false
set_parameter_property P_WINDOW_TOLERANCE   UNITS               Hertz
set_parameter_property P_WINDOW_TOLERANCE   VISIBLE             true
set_parameter_property P_WINDOW_TOLERANCE   AFFECTS_ELABORATION true
set_parameter_property P_WINDOW_TOLERANCE   HDL_PARAMETER       true
set_parameter_property P_WINDOW_TOLERANCE   DERIVED             true

############################################################################
# Interfaces
############################################################################

add_interface          esl_clk clock                            end
set_interface_property esl_clk ENABLED                          true
set_interface_property esl_clk EXPORT_OF                        ""
set_interface_property esl_clk PORT_NAME_MAP                    ""
set_interface_property esl_clk CMSIS_SVD_VARIABLES              ""
set_interface_property esl_clk SVD_ADDRESS_GROUP                ""
set_interface_property esl_clk IPXACT_REGISTER_MAP_VARIABLES    ""
set_interface_property esl_clk SV_INTERFACE_TYPE                ""
set_interface_property esl_clk SV_INTERFACE_MODPORT_TYPE        ""

add_interface_port     esl_clk esl_clk clk Input 1

add_interface          clk_hps clock                            end
set_interface_property clk_hps ENABLED                          true
set_interface_property clk_hps EXPORT_OF                        ""
set_interface_property clk_hps PORT_NAME_MAP                    ""
set_interface_property clk_hps CMSIS_SVD_VARIABLES              ""
set_interface_property clk_hps SVD_ADDRESS_GROUP                ""
set_interface_property clk_hps IPXACT_REGISTER_MAP_VARIABLES    ""
set_interface_property clk_hps SV_INTERFACE_TYPE                ""
set_interface_property clk_hps SV_INTERFACE_MODPORT_TYPE        ""

add_interface_port     clk_hps clk_hps clk Input 1

add_interface          clk_fpga clock                           end
set_interface_property clk_fpga ENABLED                         true
set_interface_property clk_fpga EXPORT_OF                       ""
set_interface_property clk_fpga PORT_NAME_MAP                   ""
set_interface_property clk_fpga CMSIS_SVD_VARIABLES             ""
set_interface_property clk_fpga SVD_ADDRESS_GROUP               ""
set_interface_property clk_fpga IPXACT_REGISTER_MAP_VARIABLES   ""
set_interface_property clk_fpga SV_INTERFACE_TYPE               ""
set_interface_property clk_fpga SV_INTERFACE_MODPORT_TYPE       ""

add_interface_port     clk_fpga clk_fpga clk Input 1

add_parameter DERIVED_CLOCK_RATE INTEGER 0
set_parameter_property DERIVED_CLOCK_RATE DISPLAY_NAME          "Derived clock rate"
set_parameter_property DERIVED_CLOCK_RATE DESCRIPTION           {Clock rate derived from system_info}
set_parameter_property DERIVED_CLOCK_RATE UNITS                 Hertz
set_parameter_property DERIVED_CLOCK_RATE SYSTEM_INFO           { CLOCK_RATE "esl_clk" }
set_parameter_property DERIVED_CLOCK_RATE SYSTEM_INFO_TYPE      {CLOCK_RATE}
set_parameter_property DERIVED_CLOCK_RATE ENABLED               false
set_parameter_property DERIVED_CLOCK_RATE VISIBLE               false

add_parameter DERIVED_CLOCK_RATE_HPS INTEGER 0
set_parameter_property DERIVED_CLOCK_RATE_HPS DISPLAY_NAME      "Derived HPS clock rate"
set_parameter_property DERIVED_CLOCK_RATE_HPS DESCRIPTION       {Clock rate derived from system_info}
set_parameter_property DERIVED_CLOCK_RATE_HPS UNITS             Hertz
set_parameter_property DERIVED_CLOCK_RATE_HPS SYSTEM_INFO       { CLOCK_RATE "clk_hps" }
set_parameter_property DERIVED_CLOCK_RATE_HPS SYSTEM_INFO_TYPE  {CLOCK_RATE}
set_parameter_property DERIVED_CLOCK_RATE_HPS ENABLED           false
set_parameter_property DERIVED_CLOCK_RATE_HPS VISIBLE           false

add_parameter DERIVED_CLOCK_RATE_FPGA INTEGER 0
set_parameter_property DERIVED_CLOCK_RATE_FPGA DISPLAY_NAME     "Derived FPGA clock rate"
set_parameter_property DERIVED_CLOCK_RATE_FPGA DESCRIPTION      {Clock rate derived from system_info}
set_parameter_property DERIVED_CLOCK_RATE_FPGA UNITS            Hertz
set_parameter_property DERIVED_CLOCK_RATE_FPGA SYSTEM_INFO      { CLOCK_RATE "clk_fpga" }
set_parameter_property DERIVED_CLOCK_RATE_FPGA SYSTEM_INFO_TYPE {CLOCK_RATE}
set_parameter_property DERIVED_CLOCK_RATE_FPGA ENABLED          false
set_parameter_property DERIVED_CLOCK_RATE_FPGA VISIBLE          false

add_interface          esl_reset reset                          end
set_interface_property esl_reset associatedClock                esl_clk
set_interface_property esl_reset synchronousEdges               DEASSERT
set_interface_property esl_reset ENABLED                        true
set_interface_property esl_reset EXPORT_OF                      ""
set_interface_property esl_reset PORT_NAME_MAP                  ""
set_interface_property esl_reset CMSIS_SVD_VARIABLES            ""
set_interface_property esl_reset SVD_ADDRESS_GROUP              ""
set_interface_property esl_reset IPXACT_REGISTER_MAP_VARIABLES  ""
set_interface_property esl_reset SV_INTERFACE_TYPE              ""
set_interface_property esl_reset SV_INTERFACE_MODPORT_TYPE      ""

add_interface_port     esl_reset esl_reset reset_n Input 1

############################################################################
# Conduits
############################################################################

# Add Safety -> ESL Connections
add_interface          c_esl_safety conduit                     end
set_interface_property c_esl_safety ENABLED                     true
set_interface_property c_esl_safety EXPORT_OF                   ""
set_interface_property c_esl_safety PORT_NAME_MAP               ""
set_interface_property c_esl_safety CMSIS_SVD_VARIABLES         ""
set_interface_property c_esl_safety SVD_ADDRESS_GROUP           ""

add_interface_port c_esl_safety quad_error_p            quad_error_p        Input 1
add_interface_port c_esl_safety quad_error_n            quad_error_n        Input 1
add_interface_port c_esl_safety fpga_is_safe_p          fpga_is_safe_p      Input 1
add_interface_port c_esl_safety fpga_is_safe_n          fpga_is_safe_n      Input 1
add_interface_port c_esl_safety fpga_compare_good_p     fpga_compare_good_p Input 1
add_interface_port c_esl_safety fpga_compare_good_n     fpga_compare_good_n Input 1
add_interface_port c_esl_safety compare_timeout         compare_timeout     Input 1
add_interface_port c_esl_safety heartbeat_fusa          heartbeat_fusa      Input 1
add_interface_port c_esl_safety heartbeat_timer         heartbeat_timer     Input 1
add_interface_port c_esl_safety reset_safety_n          reset_safety_n      Input 1

# Add Hardware -> ESL
add_interface          c_hardware_esl conduit                   end
set_interface_property c_hardware_esl ENABLED                   true
set_interface_property c_hardware_esl EXPORT_OF                 ""
set_interface_property c_hardware_esl PORT_NAME_MAP             ""
set_interface_property c_hardware_esl CMSIS_SVD_VARIABLES       ""
set_interface_property c_hardware_esl SVD_ADDRESS_GROUP         ""

add_interface_port c_hardware_esl pwr_good_p           pwr_good_p           Input 1
add_interface_port c_hardware_esl pwr_good_n           pwr_good_n           Input 1
add_interface_port c_hardware_esl temp_good_p          temp_good_p          Input 1
add_interface_port c_hardware_esl temp_good_n          temp_good_n          Input 1
add_interface_port c_hardware_esl cram_good_p          cram_good_p          Input 1
add_interface_port c_hardware_esl cram_good_n          cram_good_n          Input 1

# HPS -> ESL
add_interface          c_esl_hps conduit                    end
set_interface_property c_esl_hps ENABLED                    true
set_interface_property c_esl_hps EXPORT_OF                  ""
set_interface_property c_esl_hps PORT_NAME_MAP              ""
set_interface_property c_esl_hps CMSIS_SVD_VARIABLES        ""
set_interface_property c_esl_hps SVD_ADDRESS_GROUP          ""

add_interface_port c_esl_hps hps_is_safe_p          hps_is_safe_p           Input  1
add_interface_port c_esl_hps hps_is_safe_n          hps_is_safe_n           Input  1
add_interface_port c_esl_hps hps_compare_good_p     hps_compare_good_p      Input  1
add_interface_port c_esl_hps hps_compare_good_n     hps_compare_good_n      Input  1
add_interface_port c_esl_hps motor_powerdown_dup_p  motor_powerdown_p       Output 1
add_interface_port c_esl_hps motor_powerdown_dup_n  motor_powerdown_n       Output 1

# ESL OUTPUT
add_interface          c_esl conduit                    start
set_interface_property c_esl ENABLED                    true
set_interface_property c_esl EXPORT_OF                  ""
set_interface_property c_esl PORT_NAME_MAP              ""
set_interface_property c_esl CMSIS_SVD_VARIABLES        ""
set_interface_property c_esl SVD_ADDRESS_GROUP          ""

add_interface_port     c_esl    motor_powerdown_p    motor_powerdown_p      Output 1
add_interface_port     c_esl    motor_powerdown_n    motor_powerdown_n      Output 1

# ---------------------------------------------------------------------------- #
# ECC Error Conduit
# ---------------------------------------------------------------------------- #
add_interface            c_memory_fault  conduit           end
set_interface_property   c_memory_fault  ENABLED           true
add_interface_port       c_memory_fault  memory_fault_p    p                Input 1
add_interface_port       c_memory_fault  memory_fault_n    n                Input 1

proc val_callback {} {

}

proc elab_callback {} {

  set v_clock_rate    [ get_parameter_value DERIVED_CLOCK_RATE ]
  set_parameter_value P_ESL_CLK_FREQ_HZ ${v_clock_rate}
  set v_clock_rate    [ get_parameter_value DERIVED_CLOCK_RATE_HPS ]
  set_parameter_value P_CLK_HPS_FREQ_HZ ${v_clock_rate}
  set v_clock_rate    [ get_parameter_value DERIVED_CLOCK_RATE_FPGA ]
  set_parameter_value P_CLK_FPGA_FREQ_HZ ${v_clock_rate}

}

proc gen_callback { entity } {

}
