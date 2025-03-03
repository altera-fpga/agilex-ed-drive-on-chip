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
# | ssg_emb_dsm "Drive System Monitor" v1.2
# | Drive System Monitor
# |
# | D:/project/Industrial/MotorControl/components/ssg_emb_dsm/hdl/ssg_emb_dsm.v
# |
# |    ./ssg_emb_dsm.v syn, sim
# |
# | 1.2 extra IDLE state to DSM which can be used to disable the PWM
# |     under software control
# |     Correct operation of state machine so that (e1 | e3) term does not mask
# |     remainder of state machine and prevent pwm being disable under fault condition.
# | 1.3 [03/02/16] Keep PWM enabled so that counter and triggers operate and result in IRQ from ADC
# |     New preinit state to ignore errors while system is brought up
# |     Reset to preinit state when status bits are cleared
# | 1.4 Set unused chopper error status bit to 0 rather than 1
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# |
package require -exact sopc 11.0
# |
# +-----------------------------------

# +-----------------------------------
# | module ssg_emb_dsm
# |
set_module_property     DESCRIPTION                     "Drive System Monitor"
set_module_property     NAME                            ssg_emb_dsm
set_module_property     VERSION                         1.4
set_module_property     INTERNAL                        false
set_module_property     OPAQUE_ADDRESS_MAP              true
set_module_property     GROUP                           "Motor Control Suite"
set_module_property     AUTHOR                          acroslan
set_module_property     DISPLAY_NAME                    "Drive System Monitor"
set_module_property     TOP_LEVEL_HDL_FILE              ssg_emb_dsm.v
set_module_property     TOP_LEVEL_HDL_MODULE            ssg_emb_dsm
set_module_property     INSTANTIATE_IN_SYSTEM_MODULE    true
set_module_property     EDITABLE                        true
set_module_property     ANALYZE_HDL                     FALSE
set_module_property     STATIC_TOP_LEVEL_MODULE_NAME    ssg_emb_dsm
set_module_property     FIX_110_VIP_PATH                false
# |
# +-----------------------------------

# +-----------------------------------
# | files
# |
add_file ssg_emb_dsm.v {SYNTHESIS SIMULATION}
# |
# +-----------------------------------

# +-----------------------------------
# | connection point clock
# |
add_interface               clock   clock       end
set_interface_property      clock   clockRate   0
set_interface_property      clock   ENABLED     true
add_interface_port          clock   clk clk Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point reset
# |
add_interface           reset   reset               end
set_interface_property  reset   associatedClock     clock
set_interface_property  reset   synchronousEdges    DEASSERT
set_interface_property  reset   ENABLED             true
add_interface_port      reset   reset_n reset_n     Input 1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_slave_0
# |
add_interface           avalon_slave_0  avalon                          end
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

set_interface_property  avalon_slave_0  ENABLED         true
add_interface_port      avalon_slave_0  avs_write_n     write_n     Input   1
add_interface_port      avalon_slave_0  avs_read_n      read_n      Input   1
add_interface_port      avalon_slave_0  avs_address     address     Input   1
add_interface_port      avalon_slave_0  avs_writedata   writedata   Input   32
add_interface_port      avalon_slave_0  avs_readdata    readdata    Output  32
# |
# +-----------------------------------

# +-----------------------------------
# | connection point monitor
# |
add_interface monitor conduit end

set_interface_property monitor ENABLED true

add_interface_port  monitor     overcurrent             export Input    1
add_interface_port  monitor     overvoltage             export Input    1
add_interface_port  monitor     undervoltage            export Input    1
add_interface_port  monitor     chopper                 export Input    1
add_interface_port  monitor     dc_link_clk_err         export Input    1
add_interface_port  monitor     mosfet_err              export Input    1
add_interface_port  monitor     error_out               export Output   1
add_interface_port  monitor     overcurrent_latch       export Output   1
add_interface_port  monitor     overvoltage_latch       export Output   1
add_interface_port  monitor     undervoltage_latch      export Output   1
add_interface_port  monitor     dc_link_clk_err_latch   export Output   1
add_interface_port  monitor     mosfet_err_latch        export Output   1
add_interface_port  monitor     chopper_latch           export Output   1
# |
# +-----------------------------------

# +-----------------------------------
# | connection point pwm_control
# |
add_interface           pwm_control conduit     end
set_interface_property  pwm_control ENABLED     true
add_interface_port      pwm_control pwm_control export Output 3
# |
# +-----------------------------------
