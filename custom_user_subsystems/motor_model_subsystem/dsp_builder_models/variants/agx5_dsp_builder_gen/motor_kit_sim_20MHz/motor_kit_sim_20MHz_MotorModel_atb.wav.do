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
add wave -noupdate -format Logic /motor_kit_sim_20MHz_MotorModel_atb/dut/clk
add wave -noupdate -format Logic /motor_kit_sim_20MHz_MotorModel_atb/dut/areset
add wave -noupdate -format Logic /motor_kit_sim_20MHz_MotorModel_atb/dut/h_areset
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/u_h_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/v_h_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/w_h_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/u_l_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/v_l_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/w_l_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/powerdown_p_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/powerdown_n_stm
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/ia_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/ia_sd_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/ib_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/ib_sd_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/ic_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/ic_sd_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/Va_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/Va_sd_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/Vb_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/Vb_sd_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/Vc_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/Vc_sd_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/QEP_A
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/QEP_A_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/QEP_B
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/QEP_B_stm
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_atb/dut/Theta_one_turn_k 16 16 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_atb/sim/Theta_one_turn_k_stm 16 16 unsigned
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/V_DC_link_sd
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/V_DC_link_sd_stm
add wave -noupdate -divider {Bus Ports}
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_atb/sim/busIn_writedata_stm 32 0 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_atb/sim/busIn_address_stm 6 0 unsigned
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/busIn_write_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/busIn_read_stm
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/busOut_readdatavalid
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/busOut_readdatavalid_stm
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_atb/dut/busOut_readdata 32 0 unsigned
add_fixpt_wave /motor_kit_sim_20MHz_MotorModel_atb/sim/busOut_readdata_stm 32 0 unsigned
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/dut/busOut_waitrequest
add wave -noupdate -format Logical /motor_kit_sim_20MHz_MotorModel_atb/sim/busOut_waitrequest_stm
TreeUpdate [SetDefaultTree]
