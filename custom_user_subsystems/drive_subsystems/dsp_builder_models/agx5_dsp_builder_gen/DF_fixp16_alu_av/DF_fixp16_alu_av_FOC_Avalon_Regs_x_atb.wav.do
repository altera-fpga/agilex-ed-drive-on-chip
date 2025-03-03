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
add wave -noupdate -format Logic /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/clk
add wave -noupdate -format Logic /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/areset
add wave -noupdate -format Logic /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/h_areset
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/qv_s_stm
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Valpha_s_stm 32 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Vbeta_s_stm 32 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Iq_s_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Id_s_stm 16 10 signed
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Ready_s_stm
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Vuvwin_0_stm 16 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Vuvwin_1_stm 16 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Vuvwin_2_stm 16 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/AxisOut_s_stm 8 0 unsigned
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/dv
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/dv_stm
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/axisin 8 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/axisin_stm 8 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/Iu 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Iu_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/Iw 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Iw_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/Torque 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Torque_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/phi_el 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/phi_el_stm 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/Kp_cfg 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Kp_cfg_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/Ki_cfg 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/Ki_cfg_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/I_Sat_Limit_cfg 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/I_Sat_Limit_cfg_stm 16 10 signed
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/MaxV 16 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/MaxV_stm 16 0 unsigned
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/reset
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/reset_stm
add wave -noupdate -divider {Bus Ports}
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/busIn_writedata_stm 32 0 unsigned
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/busIn_address_stm 6 0 unsigned
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/busIn_write_stm
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/sim/busIn_read_stm
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/busOut_readdatavalid
add_fixpt_wave /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/busOut_readdata 32 0 unsigned
add wave -noupdate -format Logical /standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb/dut/busOut_waitrequest
TreeUpdate [SetDefaultTree]
