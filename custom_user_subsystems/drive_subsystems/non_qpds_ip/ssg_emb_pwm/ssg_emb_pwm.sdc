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

# command to set entity and unique_id are inserted by the hw.tcl if the Quartus version used does not
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

# CDC Helper procedures
proc apply_cdc_single {from_list to_list {delay 100} {multiplier 0.8}} {
  set from_keepers [get_keepers $from_list -nowarn]
  set to_keepers [get_keepers $to_list -nowarn]

  if {[get_collection_size $from_keepers] > 0} {
    set_min_delay -from $from_keepers -to $to_keepers -$delay
    set_max_delay -from $from_keepers -to $to_keepers $delay
    set_net_delay -from $from_keepers -to $to_keepers -max -get_value_from_clock_period \
                    min_clock_period -value_multiplier $multiplier
  }
}

proc apply_cdc_multi {from_list to_list {delay 100} {multiplier 0.8}} {
  set from_keepers [get_keepers $from_list -nowarn]
  set to_keepers [get_keepers $to_list -nowarn]

  if {[get_collection_size $from_keepers] > 0} {
    if {[get_collection_size $from_keepers] > 1} {
        set_max_skew -from $from_keepers -to $to_keepers -get_skew_value_from_clock_period \
                    min_clock_period -skew_value_multiplier $multiplier
    }
    set_min_delay -from $from_keepers -to $to_keepers -$delay
    set_max_delay -from $from_keepers -to $to_keepers $delay
    set_net_delay -from $from_keepers -to $to_keepers -max -get_value_from_clock_period \
                    min_clock_period -value_multiplier $multiplier
  }
}

proc apply_cdc_singlebit_cdc {instance_src instance_dst} {
  apply_cdc_single "${instance_src}"  "${instance_dst}"
}

proc apply_cdc_multibit_cdc {instance_src instance_dst} {

  apply_cdc_multi "${instance_src}"  "${instance_dst}"
}

apply_cdc_singlebit_cdc "$inst|pwm_encoder_strobe"      "$inst|encoder_strobe_s1"
apply_cdc_singlebit_cdc "$inst|start_adc_stretch"       "$inst|adc_strobe_s1"
apply_cdc_multibit_cdc  "$inst|block_reg_src[*]"        "$inst|block_reg_r[*]"
apply_cdc_multibit_cdc  "$inst|max_reg_src[*]"          "$inst|max_reg_r[*]"
apply_cdc_multibit_cdc  "$inst|pwm_reg_src[*][*]"       "$inst|pwm_reg_r[*][*]"
apply_cdc_multibit_cdc  "$inst|trigger_down_reg_src[*]" "$inst|trigger_down_reg_r[*]"
apply_cdc_multibit_cdc  "$inst|trigger_up_reg_src[*]*"  "$inst|trigger_up_reg_r[*]"
apply_cdc_multibit_cdc  "$inst|control_reg_src[*]*"     "$inst|control_reg_r[*]"
apply_cdc_multibit_cdc  "$inst|hall_enable_reg_src[*]"  "$inst|hall_enable_reg_r[*]"

apply_cdc_multibit_cdc  "$inst|pwm_control_src[*]"      "$inst|pwm_control_r[*]"
apply_cdc_single        "$inst|ack_toggle"              "$inst|ack_toggle_meta"
apply_cdc_single        "$inst|req_toggle"              "$inst|req_toggle_meta"

# if the gate_h outputs cross a clock domain then set a CDC exception
foreach_in_collection src_keeper [get_keepers -nowarn "$inst|gate_h[*]"] {

  # may have multiple fan-outs - need to cut timing on each one independently
  foreach_in_collection dst_keeper [get_fanouts $src_keeper] {

    set src_clk [get_object_info -name [get_clocks -of_objects $src_keeper]]
    set dst_clk [get_object_info -name [get_clocks -of_objects $dst_keeper]]

    if {[string match $src_clk $dst_clk] == 0} {
      set_min_delay -from $src_keeper -to $dst_keeper -100
      set_max_delay -from $src_keeper -to $dst_keeper 100
      set_net_delay -from $src_keeper -to $dst_keeper -max -get_value_from_clock_period \
                    min_clock_period -value_multiplier 0.8
    }
  }
}
