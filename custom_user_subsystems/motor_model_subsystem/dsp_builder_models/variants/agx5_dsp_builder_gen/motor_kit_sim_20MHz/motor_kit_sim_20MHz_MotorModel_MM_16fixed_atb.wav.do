onerror {resume}

# obtain Modelsim version and extract the NN.Nc part after vsim
quietly set vsim_ver [regexp -inline {vsim (\d+\.\d+)(\w?)} [vsim -version]]
quietly set has_fixpt_radix 0
if {[lindex $vsim_ver 1] == 10.2} {
    if {[lindex $vsim_ver 2] >= "d"} {
        quietly set has_fixpt_radix 1
    }
} elseif {[lindex $vsim_ver 1] > 10.2} {
    quietly set has_fixpt_radix 1
}

proc add_fixpt_wave {name width frac_width signed} {
    global has_fixpt_radix
    if {$frac_width > 0 && $has_fixpt_radix} {
        set type "[string index $signed 0]fix${width}_En${frac_width}"
        if {[lsearch [radix names] $type] < 0} {
            if {$signed == "signed"} {
                radix define $type -fixed -signed -fraction $frac_width
            } else {
                radix define $type -fixed -fraction $frac_width
            }
        }
        add wave -noupdate -format Literal -radix $type $name
    } else {
        add wave -noupdate -format Literal -radix $signed $name
    }
}

add wave -noupdate -divider {Input Ports}
add wave -noupdate -format Logic /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/clk
add wave -noupdate -format Logic /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/areset
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_1_valid_in_tpl_stm
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_2_channel_in_tpl_stm 8 0 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_12_PolePairs_int_tpl_stm 16 14 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_13_Ke_Vs_rad_tpl_stm 16 16 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_17_DC_link_tpl_stm 16 6 signed
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_3_Va_V_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_4_Vb_V_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_5_Vc_V_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_6_u_l_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_7_v_l_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_8_w_l_tpl_stm
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_9_SampleTime_s_tpl_stm 16 39 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_10_Rphase_ohm_tpl_stm 16 16 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_11_inv_Lphase_1_H_tpl_stm 16 6 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_14_Kt_Nm_A_tpl_stm 16 16 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_15_inv_J_1_kgm2_tpl_stm 16 0 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_16_LoadT_Nm_tpl_stm 16 14 signed
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_18_Powerdown_p_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/in_19_Powerdown_n_tpl_stm
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_1_valid_out_tpl
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_1_valid_out_tpl_stm
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_2_channel_out_tpl 8 0 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_2_channel_out_tpl_stm 8 0 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_3_did_dt_A_s_tpl 33 15 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_3_did_dt_A_s_tpl_stm 33 15 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_4_diq_dt_A_s_tpl 33 15 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_4_diq_dt_A_s_tpl_stm 33 15 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_8_id_A_tpl 27 16 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_8_id_A_tpl_stm 27 16 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_9_iq_A_tpl 27 16 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_9_iq_A_tpl_stm 27 16 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_10_T_Nm_tpl 20 14 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_10_T_Nm_tpl_stm 20 14 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_5_ia_A_tpl 16 9 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_5_ia_A_tpl_stm 16 9 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_6_ib_A_tpl 16 9 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_6_ib_A_tpl_stm 16 9 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_7_ic_A_tpl 16 9 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_7_ic_A_tpl_stm 16 9 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_11_Vd_V_tpl 16 6 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_11_Vd_V_tpl_stm 16 6 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_12_Vq_V_tpl 16 6 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_12_Vq_V_tpl_stm 16 6 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_13_dTheta_dt_rad_s_k_tpl 32 20 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_13_dTheta_dt_rad_s_k_tpl_stm 32 20 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_14_Theta_one_turn_k_tpl 16 16 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_14_Theta_one_turn_k_tpl_stm 16 16 unsigned
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_15_QEP_A_tpl
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_15_QEP_A_tpl_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_16_QEP_B_tpl
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_16_QEP_B_tpl_stm
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_17_DC_link_A_tpl 19 10 signed
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_17_DC_link_A_tpl_stm 19 10 signed
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/dut/out_18_ready_tpl
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb/sim/out_18_ready_tpl_stm
TreeUpdate [SetDefaultTree]
