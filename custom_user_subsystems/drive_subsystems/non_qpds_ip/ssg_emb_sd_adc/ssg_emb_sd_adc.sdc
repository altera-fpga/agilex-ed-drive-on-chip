# ##########################################################################
# Copyright 2015 - 2024 Intel Corporation.
#
# This software and the related documents are Intel copyrighted materials, f
# and your use of them is governed by the express license under which they
# were provided to you ("License"). Unless the License provides otherwise,
# you may not use, modify, copy, publish, distribute, disclose or transmit
# this software or the related documents without Intel's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.
# ##########################################################################


# commands to set entity and unique_id are inserted by the hw.tcl if the Quartus version used does not
# support entity-bound SDCs. e.g.:
#   set entity ssg_emb_pwm
#   set unique_id test_sys_ssg_emb_pwm_0_ssg_emb_pwm_0

set inst [get_current_instance]

if {$inst == ""} {

  foreach instance [get_entity_instances $entity] {
    set path_comb [string map {"|" "_"} $instance]
    if { [string first $path_comb $unique_id ] > 0 || [string first $unique_id $path_comb] > 0} {
      set inst $instance
    }
  }
}

proc apply_cdc {from_list to_list} {

  set from_keepers [get_keepers $from_list -nowarn]
  set to_keepers   [get_keepers $to_list   -nowarn]

  set size_from_keepers [get_collection_size $from_keepers]
  set size_to_keepers   [get_collection_size $to_keepers]

  if {$size_from_keepers > 0 && $size_to_keepers > 0} {

    if {$size_from_keepers > 1 && $size_to_keepers > 1} {
      set_max_skew  -from $from_keepers -to $to_keepers -get_skew_value_from_clock_period min_clock_period -skew_value_multiplier 0.8
    }
    set_max_delay -from $from_keepers -to $to_keepers 100
    set_min_delay -from $from_keepers -to $to_keepers -100

    #avoid set_net_delay being executed during synthesis
    if { ![string equal "quartus_syn" $::TimeQuestInfo(nameofexecutable)] } {
      set_net_delay -from $from_keepers -to $to_keepers -max -get_value_from_clock_period min_clock_period -value_multiplier 0.8
    }
  }
}

apply_cdc "$inst|ack_toggle"                 "$inst|ack_toggle_meta"
apply_cdc "$inst|req_toggle"                 "$inst|req_toggle_meta"
apply_cdc "$inst|control_reg_src[*]"         "$inst|control_reg_adc[*]"
apply_cdc "$inst|set_irq_counter_reg_src[*]" "$inst|set_irq_counter_reg_adc[*]"
apply_cdc "$inst|overcurrent_x"              "$inst|overcurrent_xx"
apply_cdc "$inst|offset_u_reg_src[*]"        "$inst|offset_u_reg_adc[*]"
apply_cdc "$inst|offset_v_reg_src[*]"        "$inst|offset_v_reg_adc[*]"
apply_cdc "$inst|offset_w_reg_src[*]"        "$inst|offset_w_reg_adc[*]"
apply_cdc "$inst|i_peak_reg_src[*]"          "$inst|i_peak_reg_adc[*]"

apply_cdc "$inst|diff_u|start_r"             "$inst|diff_u|start_sync_adc"
apply_cdc "$inst|diff_v|start_r"             "$inst|diff_v|start_sync_adc"
apply_cdc "$inst|diff_w|start_r"             "$inst|diff_w|start_sync_adc"
