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
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_atb/dut/clk
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_atb/dut/areset
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_atb/dut/h_areset
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/Iu_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/Iw_stm 16 10 signed
add wave -noupdate -divider {Output Ports}
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/dut/vu_pwm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/vu_pwm_stm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/dut/vv_pwm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/vv_pwm_stm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/dut/vw_pwm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/vw_pwm_stm 16 0 unsigned
add wave -noupdate -divider {Bus Ports}
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/busIn_writedata_stm 32 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/sim/busIn_address_stm 6 0 unsigned
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_atb/sim/busIn_write_stm
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_atb/sim/busIn_read_stm
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_atb/dut/busOut_readdatavalid
add_fixpt_wave /DF_fixp16_alu_av_FOC_atb/dut/busOut_readdata 32 0 unsigned
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_atb/dut/busOut_waitrequest
TreeUpdate [SetDefaultTree]
