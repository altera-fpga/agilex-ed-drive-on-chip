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

set inst [get_current_instance]

set_false_path -to [get_keepers ${inst}|heartbeat_fusa_meta]
set_false_path -to [get_keepers ${inst}|heartbeat_timer_meta]
set_false_path -to [get_keepers ${inst}|compare_timeout_meta]
set_false_path -to [get_keepers ${inst}|comp_calculation|allCompli_meta*]

proc apply_cdc {from_list to_list {is_bus 1}} {
  if {[get_collection_size $from_list] > 0 && [get_collection_size $to_list] > 0} {

    if {$is_bus} {
      set_max_skew  -from $from_list -to $to_list -get_skew_value_from_clock_period \
                src_clock_period -skew_value_multiplier 0.8
    }
    set_max_delay -from $from_list -to $to_list 100
    set_min_delay -from $from_list -to $to_list -100

    #avoid set_net_delay being executed during synthesis
    if { ![string equal "quartus_syn" $::TimeQuestInfo(nameofexecutable)] } {
      set_net_delay -from $from_list -to $to_list -max -get_value_from_clock_period \
                dst_clock_period -value_multiplier 0.8
    }
  }
}

apply_cdc [get_keepers "$inst|clk_hps_check|u_esl_clk_check_fsm|en_cut_count_reg"] \
                [get_keepers "$inst|clk_hps_check|u_esl_clk_check_cut_count|en_cut_count_dly"] 0
apply_cdc [get_keepers "$inst|clk_hps_check|u_esl_clk_check_fsm|reset_cut_count_reg"] \
                [get_keepers "$inst|clk_hps_check|u_esl_clk_check_cut_count|reset_cut_count_dly"] 0

apply_cdc [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_fsm|en_cut_count_reg"] \
                [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_cut_count|en_cut_count_dly"] 0
apply_cdc [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_fsm|reset_cut_count_reg"] \
                [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_cut_count|reset_cut_count_dly"] 0

set_false_path -from [get_fanins -async [get_keepers ${inst}|hps_aresetn_sr[*]]]     -to \
                [get_keepers ${inst}|hps_aresetn_sr[*]]
set_false_path -from [get_fanins -async [get_keepers ${inst}|fpga_aresetn_sr[*]]]    -to \
                [get_keepers ${inst}|fpga_aresetn_sr[*]]
set_false_path -from [get_fanins -async [get_keepers ${inst}|safety_aresetn_sr[*]]]  -to \
                [get_keepers ${inst}|safety_aresetn_sr[*]]
set_false_path -from [get_fanins -async [get_keepers ${inst}|esl_aresetn_sr[*]]]     -to \
                [get_keepers ${inst}|esl_aresetn_sr[*]]
set_false_path -from [get_fanins -async [get_keepers ${inst}|areset_n_sr[*]]]        -to \
                [get_keepers ${inst}|areset_n_sr[*]]

apply_cdc [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_freq_comp|comp_too_high"] \
                [get_keepers "$inst|clk_fpga_check|comp_too_high_meta"] 0
apply_cdc [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_freq_comp|comp_too_low"] \
                [get_keepers "$inst|clk_fpga_check|comp_too_low_meta"] 0
apply_cdc [get_keepers "$inst|clk_hps_check|u_esl_clk_check_freq_comp|comp_too_high"] \
                [get_keepers "$inst|clk_hps_check|comp_too_high_meta"] 0
apply_cdc [get_keepers "$inst|clk_hps_check|u_esl_clk_check_freq_comp|comp_too_low"] \
                [get_keepers "$inst|clk_hps_check|comp_too_low_meta"] 0

apply_cdc [get_keepers "$inst|clk_hps_check|u_esl_clk_check_cut_count|cut_count_disabled"] \
                [get_keepers "$inst|clk_hps_check|u_esl_clk_check_cut_count|cut_count_disabled_dly"] 0
apply_cdc [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_cut_count|cut_count_disabled"] \
                [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_cut_count|cut_count_disabled_dly"] 0

apply_cdc [get_keepers "$inst|clk_hps_check|u_esl_clk_check_cut_count|reset_cut_count_cdc"] \
                [get_keepers "$inst|clk_hps_check|u_esl_clk_check_cut_count|reset_ack_dly"] 0
apply_cdc [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_cut_count|reset_cut_count_cdc"] \
                [get_keepers "$inst|clk_fpga_check|u_esl_clk_check_cut_count|reset_ack_dly"] 0
