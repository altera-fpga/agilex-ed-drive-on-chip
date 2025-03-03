# pass in -Gquit_at_end=true to make vsim call exit at the end. Useful for running standalone.
quietly set quit_at_end 0
if {[lsearch $argv -Gquit_at_end=true] != -1} {
    quietly set quit_at_end 1
}

if {$argc > 0} {
    quietly set base_dir $1
} else {
    quietly set base_dir "././../../dsp_builder_gen"
    echo The current directory is: [pwd]
}
quietly set base_dir [file normalize $base_dir]
echo Creating the project under $base_dir

do $base_dir/compile_modelsim_libraries.do
onerror {resume}

if { [string compare [project env] ""] != 0 } {
    quit -sim
    project close
}

if {! [file exists $base_dir/standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters]} {
    file delete -force $base_dir/standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters
}

project new $base_dir standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters
if {! [file exists $base_dir/work/_info]} {
    file delete -force $base_dir/work
    vlib work
}
quietly vmap work $base_dir/work

do "$base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_fpc.do"


quietly set vcomfailed 0
onerror {
    quietly set vcomfailed 1
    resume
}

project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_safe_path_msim.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz.vhd vhdl
puts {Note: Process variables may be optimized out of top-level testbench. Re-compile with the following command to disable optimizations:}
puts {vcom -quiet -O0 $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb.vhd}
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_stm.vhd vhdl
project calculateorder

onerror {resume}

proc report_mismatch {signal cycle} {
    puts "Mismatch in ${signal} at system clock cycle ${cycle}"
    set modelsimvalue [examine ${signal}_dut];
    set stmvalue [examine ${signal}_stm];
    puts "\t${signal} (ModelSim):\t${modelsimvalue}"
    puts "\t${signal} (Simulink):\t${stmvalue}"
}

if {$vcomfailed == 0} {
    onbreak {
        quietly set my_tb [string trim [tb]];
        quietly set regOK [regexp {(.*) ([0-9]+) ([\[address]*) ([.]*)} $my_tb \ match atbfile linenum ignore_this];
        if {$regOK == 1} {
            quietly set simtime [expr $now - 200];
            quietly set cyclenum [expr int($simtime / 50000.000000)];
            if { [catch {exa mismatch_MM_valid_in} mismatch] == 0 && $mismatch } {
                report_mismatch MM_valid_in $cyclenum
            }
            if { [catch {exa mismatch_Vabc_range_V_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Vabc_range_V_cfg $cyclenum
            }
            if { [catch {exa mismatch_Va_V} mismatch] == 0 && $mismatch } {
                report_mismatch Va_V $cyclenum
            }
            if { [catch {exa mismatch_Vb_V} mismatch] == 0 && $mismatch } {
                report_mismatch Vb_V $cyclenum
            }
            if { [catch {exa mismatch_Vc_V} mismatch] == 0 && $mismatch } {
                report_mismatch Vc_V $cyclenum
            }
            if { [catch {exa mismatch_SampleTime_s_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch SampleTime_s_cfg $cyclenum
            }
            if { [catch {exa mismatch_Rphase_ohm_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Rphase_ohm_cfg $cyclenum
            }
            if { [catch {exa mismatch_inv_Lphase_1_H_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch inv_Lphase_1_H_cfg $cyclenum
            }
            if { [catch {exa mismatch_PolePairs_int_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch PolePairs_int_cfg $cyclenum
            }
            if { [catch {exa mismatch_Ke_Vs_rad_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Ke_Vs_rad_cfg $cyclenum
            }
            if { [catch {exa mismatch_Kt_Nm_A_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Kt_Nm_A_cfg $cyclenum
            }
            if { [catch {exa mismatch_inv_J_1_kgm2_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch inv_J_1_kgm2_cfg $cyclenum
            }
            if { [catch {exa mismatch_LoadT_Nm} mismatch] == 0 && $mismatch } {
                report_mismatch LoadT_Nm $cyclenum
            }
            if { [catch {exa mismatch_DC_link_range_V_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch DC_link_range_V_cfg $cyclenum
            }
            if { [catch {exa mismatch_DC_link_V} mismatch] == 0 && $mismatch } {
                report_mismatch DC_link_V $cyclenum
            }
            if { [catch {exa mismatch_Iabc_range_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Iabc_range_cfg $cyclenum
            }
        } else {
            puts "Signal mismatch detected at $my_tb";
        }
        if {$quit_at_end == 1} {
            quit -code 1;
        }
    }
    eval vsim -quiet -suppress 14408 -error 3473 -msgmode both -voptargs="+acc" -t ps standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb $ll
    do $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb.wav.do
# Disable some warnings that occur at the very start of simulation
    quietly set StdArithNoWarnings 1
    run 0ns
    quietly set StdArithNoWarnings 0
    run -all
} else {
    echo At least one module failed to compile, not starting simulation
}

if {$quit_at_end == 1} {
    exit
}
