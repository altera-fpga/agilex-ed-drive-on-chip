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

# +-----------------------------------
# |
# | ssg_emb_sd_adc "Sigma-Delta ADC Interface" v1.1
# | Motor Control Sigma-Delta ADC Interface
# |
# |    ./ssg_emb_sd_adc.v syn, sim
# |    ./ssg_emb_sd_adc_dec128.v syn, sim
# |    ./ssg_emb_sd_adc_dec16.v syn, sim
# |    ./ssg_emb_sd_adc_diff.v syn, sim
# |
# | 1.2  Move over current detection to adc clock domain to avoid clock crossing problems
# |      Add capture registers for over current detection
# | 1.3  Synchronize control reg bits
# |      Tidy up some synthesis warnings
# | 1.4 Use shorter counter value when decimation rate is set to lower value so that
# |     conversion time is reduced
# | 1.5  Add third motor phase and enable bit for over current detection to allow
# |      for checking 2 or 3 phases
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# |
package require -exact sopc 11.0
# |
# +-----------------------------------

# +-----------------------------------
# | module ssg_emb_sd_adc
# |
set_module_property     DESCRIPTION                     "Motor Control Sigma-Delta ADC Interface"
set_module_property     NAME                            ssg_emb_sd_adc
set_module_property     VERSION                         1.5
set_module_property     INTERNAL                        false
set_module_property     OPAQUE_ADDRESS_MAP              true
set_module_property     GROUP                           "Motor Control Suite"
set_module_property     AUTHOR                          acroslan
set_module_property     DISPLAY_NAME                    "Sigma-Delta ADC Interface"
set_module_property     TOP_LEVEL_HDL_FILE              ssg_emb_sd_adc.v
set_module_property     TOP_LEVEL_HDL_MODULE            ssg_emb_sd_adc
set_module_property     INSTANTIATE_IN_SYSTEM_MODULE    true
set_module_property     EDITABLE                        true
set_module_property     ANALYZE_HDL                     FALSE
set_module_property     FIX_110_VIP_PATH                false
set_module_property     VALIDATION_CALLBACK             proc_validate
set_module_property     ELABORATION_CALLBACK            proc_elaborate

# +-----------------------------------

# +-----------------------------------
# | files
# | files
# |

add_fileset QUARTUS_SYNTH   QUARTUS_SYNTH   proc_generate ""
set_fileset_property        QUARTUS_SYNTH   TOP_LEVEL     ssg_emb_sd_adc

add_fileset SIM_VERILOG    SIM_VERILOG      proc_generate ""
add_fileset SIM_VHDL       SIM_VHDL         proc_generate ""

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

# +-----------------------------------
# | display items
# |
# |
# +-----------------------------------

# +-----------------------------------
# | connection point clock
# |
add_interface           clock   clock       end
set_interface_property  clock   clockRate   0
set_interface_property  clock   ENABLED     true
add_interface_port      clock   clk clk     Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point reset
# |
add_interface           reset reset             end
set_interface_property  reset associatedClock   clock
set_interface_property  reset synchronousEdges  DEASSERT

set_interface_property reset ENABLED true

add_interface_port reset reset_n reset_n Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point irq
# |
add_interface           irq     interrupt                   end
set_interface_property  irq     associatedAddressablePoint  avalon_slave
set_interface_property  irq     associatedClock             clock
set_interface_property  irq     associatedReset             reset
set_interface_property  irq     ENABLED                     true
add_interface_port      irq     avs_irq irq                 Output 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_slave
# |
add_interface           avalon_slave    avalon                          end
set_interface_property  avalon_slave    addressUnits                    WORDS
set_interface_property  avalon_slave    associatedClock                 clock
set_interface_property  avalon_slave    associatedReset                 reset
set_interface_property  avalon_slave    bitsPerSymbol                   8
set_interface_property  avalon_slave    burstOnBurstBoundariesOnly      false
set_interface_property  avalon_slave    burstcountUnits                 WORDS
set_interface_property  avalon_slave    explicitAddressSpan             0
set_interface_property  avalon_slave    holdTime                        0
set_interface_property  avalon_slave    linewrapBursts                  false
set_interface_property  avalon_slave    maximumPendingReadTransactions  0
set_interface_property  avalon_slave    readLatency                     0
set_interface_property  avalon_slave    readWaitTime                    1
set_interface_property  avalon_slave    setupTime                       0
set_interface_property  avalon_slave    timingUnits                     Cycles
set_interface_property  avalon_slave    writeWaitTime                   0

set_interface_property  avalon_slave    ENABLED         true
add_interface_port      avalon_slave    avs_write_n     write_n     Input 1
add_interface_port      avalon_slave    avs_read_n      read_n      Input 1
add_interface_port      avalon_slave    avs_address     address     Input 4
add_interface_port      avalon_slave    avs_writedata   writedata   Input 32
add_interface_port      avalon_slave    avs_readdata    readdata    Output 32
# |
# +-----------------------------------

# +-----------------------------------
# | connection point clock_adc
# |
add_interface           clock_adc clock         end
set_interface_property  clock_adc clockRate     0
set_interface_property  clock_adc ENABLED       true
add_interface_port      clock_adc clk_adc clk   Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point reset
# |
add_interface           reset_adc_n     reset               end
set_interface_property  reset_adc_n     associatedClock     clock_adc
set_interface_property  reset_adc_n     synchronousEdges    DEASSERT
set_interface_property  reset_adc_n     ENABLED             true
add_interface_port      reset_adc_n     reset_adc_n reset_n Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point adc
# |
add_interface           adc conduit end
set_interface_property  adc ENABLED true

add_interface_port adc sync_dat_u   export Input    1
add_interface_port adc sync_dat_v   export Input    1
add_interface_port adc sync_dat_w   export Input    1
add_interface_port adc overcurrent  export Output   1
add_interface_port adc Iu_reg       export Output   16
add_interface_port adc Iw_reg       export Output   16
# |
# +-----------------------------------

# +-----------------------------------
# | connection point start
# |
add_interface               start conduit   end
set_interface_property      start ENABLED   true
add_interface_port start    start export    Input 1
# |
# +-----------------------------------

proc proc_validate {} {

}

proc proc_generate {toplevel_name} {

  add_fileset_file ssg_emb_sd_adc.v                VERILOG PATH ssg_emb_sd_adc.v
  add_fileset_file ssg_emb_sd_adc_dec128.v         VERILOG PATH ssg_emb_sd_adc_dec128.v
  add_fileset_file ssg_emb_sd_adc_dec64.v          VERILOG PATH ssg_emb_sd_adc_dec64.v
  add_fileset_file ssg_emb_sd_adc_dec16.v          VERILOG PATH ssg_emb_sd_adc_dec16.v
  add_fileset_file ssg_emb_sd_adc_diff.v           VERILOG PATH ssg_emb_sd_adc_diff.v
  add_fileset_file psg_ecfs_lvdcdc_sd_adc.v        VERILOG PATH psg_ecfs_lvdcdc_sd_adc.v
  add_fileset_file psg_ecfs_lvdcdc_sd_adc_dec128.v VERILOG PATH psg_ecfs_lvdcdc_sd_adc_dec128.v
  add_fileset_file psg_ecfs_lvdcdc_sd_adc_diff.v   VERILOG PATH psg_ecfs_lvdcdc_sd_adc_diff.v

  set v_sdc_text "set entity ${toplevel_name}\r\n"
  append v_sdc_text "set unique_id [get_parameter_value UNIQUE_ID]\r\n"
  set v_sdc_file [open "ssg_emb_sd_adc.sdc" r]
  append v_sdc_text [read ${v_sdc_file}]
  close $v_sdc_file

  add_fileset_file ssg_emb_sd_adc.sdc  SDC     TEXT $v_sdc_text

}

proc proc_elaborate {} {

}
