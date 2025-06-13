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

# +-----------------------------------
# |
# | ssg_emb_pwm "PWM Interface" for Motor Control
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# |
package require -exact sopc 11.0

# |
# +-----------------------------------

# +-----------------------------------
# | module ssg_emb_pwm
# |
set_module_property     DESCRIPTION                     "Motor Control High Frequency PWM Interface"
set_module_property     NAME                            ssg_emb_pwm
set_module_property     VERSION                         4.0
set_module_property     INTERNAL                        false
set_module_property     OPAQUE_ADDRESS_MAP              true
set_module_property     GROUP                           "Motor Control Suite"
set_module_property     AUTHOR                          acroslan
set_module_property     DISPLAY_NAME                    "High Frequency PWM Interface"
set_module_property     TOP_LEVEL_HDL_FILE              ssg_emb_pwm.v
set_module_property     TOP_LEVEL_HDL_MODULE            ssg_emb_pwm
set_module_property     INSTANTIATE_IN_SYSTEM_MODULE    true
set_module_property     EDITABLE                        true
set_module_property     ANALYZE_HDL                     false
set_module_property     FIX_110_VIP_PATH                false
set_module_property     VALIDATION_CALLBACK             proc_validate
set_module_property     ELABORATION_CALLBACK            proc_elaborate

# |
# +-----------------------------------

# +-----------------------------------
# | files
# |

add_fileset             QUARTUS_SYNTH   QUARTUS_SYNTH proc_generate ""
set_fileset_property    QUARTUS_SYNTH   TOP_LEVEL     ssg_emb_pwm

add_fileset             SIM_VERILOG    SIM_VERILOG   proc_generate  ""
add_fileset             SIM_VHDL       SIM_VHDL      proc_generate  ""

# |
# +-----------------------------------

# +-----------------------------------
# | parameters
# |
# |
# +-----------------------------------

add_parameter            UNIQUE_ID          STRING              "Unknown"
set_parameter_property   UNIQUE_ID          SYSTEM_INFO         {UNIQUE_ID}
set_parameter_property   UNIQUE_ID          HDL_PARAMETER       false
set_parameter_property   UNIQUE_ID          VISIBLE             false

add_parameter           pwmClockRate    LONG
set_parameter_property  pwmClockRate    DEFAULT_VALUE       {0}
set_parameter_property  pwmClockRate    DISPLAY_NAME        {pwmClockRate}
set_parameter_property  pwmClockRate    VISIBLE             {0}
set_parameter_property  pwmClockRate    AFFECTS_GENERATION  {1}
set_parameter_property  pwmClockRate    HDL_PARAMETER       {0}
set_parameter_property  pwmClockRate    SYSTEM_INFO         {clock_rate pwm_clock}
set_parameter_property  pwmClockRate    SYSTEM_INFO_TYPE    {CLOCK_RATE}
set_parameter_property  pwmClockRate    SYSTEM_INFO_ARG     {pwm_clock}

# +-----------------------------------
# | display items
# |
# |
# +-----------------------------------

# +-----------------------------------
# | connection point system clock
# |
add_interface           sys_clock clock         end
set_interface_property  sys_clock ENABLED       true
add_interface_port      sys_clock sys_clk clk   Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point clock
# |
add_interface           pwm_clock   clock       end
set_interface_property  pwm_clock   ENABLED     true
add_interface_port      pwm_clock   pwm_clk clk Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point reset
# |
add_interface           reset   reset               end
set_interface_property  reset   associatedClock     sys_clock
set_interface_property  reset   synchronousEdges    DEASSERT
set_interface_property  reset   ENABLED             true
add_interface_port      reset   reset_n             reset_n Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point pwm_reset
# |
add_interface                   pwm_reset   reset               end
set_interface_property          pwm_reset   associatedClock     pwm_clock
set_interface_property          pwm_reset   synchronousEdges    DEASSERT
set_interface_property          pwm_reset   ENABLED             true
add_interface_port pwm_reset    pwm_reset_n reset_n             Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_slave_0
# |
add_interface           avalon_slave_0  avalon                          end
set_interface_property  avalon_slave_0  addressUnits                    WORDS
set_interface_property  avalon_slave_0  associatedClock                 sys_clock
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
set_interface_property  avalon_slave_0   writeWaitTime                  0

set_interface_property  avalon_slave_0  ENABLED                     true
add_interface_port      avalon_slave_0  avs_write_n write_n         Input   1
add_interface_port      avalon_slave_0  avs_read_n read_n           Input   1
add_interface_port      avalon_slave_0  avs_address address         Input   4
add_interface_port      avalon_slave_0  avs_writedata writedata     Input   32
add_interface_port      avalon_slave_0  avs_readdata readdata       Output  32
# |
# +-----------------------------------

# +-----------------------------------
# | connection point pwm
# |
add_interface pwm conduit end

set_interface_property pwm ENABLED true

add_interface_port pwm encoder_strobe_n     export Output 1
add_interface_port pwm u_h                  export Output 1
add_interface_port pwm u_l                  export Output 1
add_interface_port pwm v_h                  export Output 1
add_interface_port pwm v_l                  export Output 1
add_interface_port pwm w_h                  export Output 1
add_interface_port pwm w_l                  export Output 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point sync_out
# |
add_interface           sync_out conduit    end
set_interface_property  sync_out ENABLED    true
add_interface_port      sync_out sync_out   export Output 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point start_adc
# |
add_interface           start_adc conduit   end
set_interface_property  start_adc ENABLED   true
add_interface_port      start_adc start_adc export Output 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point sync_in
# |
add_interface           sync_in conduit     end
set_interface_property  sync_in ENABLED     true
add_interface_port      sync_in sync_in     export Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point pwm_control
# |
add_interface           pwm_control     conduit         end
set_interface_property  pwm_control     ENABLED         true
add_interface_port      pwm_control     pwm_control     export Input 3
# |
# +-----------------------------------

# +-----------------------------------
# | connection point vu_pwm
# |
add_interface           vu_pwm conduit  end
set_interface_property  vu_pwm ENABLED  true
add_interface_port      vu_pwm vu_pwm   export Input 16
# |
# +-----------------------------------

# +-----------------------------------
# | connection point vv_pwm
# |
add_interface           vv_pwm conduit  end
set_interface_property  vv_pwm ENABLED  true
add_interface_port      vv_pwm vv_pwm   export Input 16
# |
# +-----------------------------------


# +-----------------------------------
# | connection point vw_pwm
# |
add_interface           vw_pwm conduit  end
set_interface_property  vw_pwm ENABLED  true
add_interface_port      vw_pwm vw_pwm   export Input 16
# |
# +-----------------------------------

proc proc_validate {} {
    set pwmClockRate [ get_parameter_value pwmClockRate ]

    set_module_assignment embeddedsw.CMacro.FREQ "${pwmClockRate}"

}

proc proc_generate {toplevel_name} {

  add_fileset_file ssg_emb_pwm.v    VERILOG PATH ssg_emb_pwm.v

  set v_sdc_text "set entity ${toplevel_name}\r\n"
  append v_sdc_text "set unique_id [get_parameter_value UNIQUE_ID]\r\n"
  set v_sdc_file [open "ssg_emb_pwm.sdc" r]
  append v_sdc_text [read ${v_sdc_file}]
  close ${v_sdc_file}

  add_fileset_file ssg_emb_pwm.sdc  SDC     TEXT ${v_sdc_text}

}


proc proc_elaborate {} {

}
