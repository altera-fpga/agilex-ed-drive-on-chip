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

if {! [file exists $base_dir/motor_kit_sim_20MHz_MotorModel]} {
    file delete -force $base_dir/motor_kit_sim_20MHz_MotorModel
}

project new $base_dir motor_kit_sim_20MHz_MotorModel
if {! [file exists $base_dir/work/_info]} {
    file delete -force $base_dir/work
    vlib work
}
quietly vmap work $base_dir/work

do "$base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_fpc.do"


quietly set vcomfailed 0
onerror {
    quietly set vcomfailed 1
    resume
}

project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_safe_path_msim.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_CurrentScale.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse1.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse2.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse4.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse5.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_VoltageScale.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz.vhd vhdl
puts {Note: Process variables may be optimized out of top-level testbench. Re-compile with the following command to disable optimizations:}
puts {vcom -quiet -O0 $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_atb.vhd}
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_atb.vhd vhdl
project addfile $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_stm.vhd vhdl
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
            if { [catch {exa mismatch_ia_sd} mismatch] == 0 && $mismatch } {
                report_mismatch ia_sd $cyclenum
            }
            if { [catch {exa mismatch_ib_sd} mismatch] == 0 && $mismatch } {
                report_mismatch ib_sd $cyclenum
            }
            if { [catch {exa mismatch_ic_sd} mismatch] == 0 && $mismatch } {
                report_mismatch ic_sd $cyclenum
            }
            if { [catch {exa mismatch_Va_sd} mismatch] == 0 && $mismatch } {
                report_mismatch Va_sd $cyclenum
            }
            if { [catch {exa mismatch_Vb_sd} mismatch] == 0 && $mismatch } {
                report_mismatch Vb_sd $cyclenum
            }
            if { [catch {exa mismatch_Vc_sd} mismatch] == 0 && $mismatch } {
                report_mismatch Vc_sd $cyclenum
            }
            if { [catch {exa mismatch_QEP_A} mismatch] == 0 && $mismatch } {
                report_mismatch QEP_A $cyclenum
            }
            if { [catch {exa mismatch_QEP_B} mismatch] == 0 && $mismatch } {
                report_mismatch QEP_B $cyclenum
            }
            if { [catch {exa mismatch_Theta_one_turn_k} mismatch] == 0 && $mismatch } {
                report_mismatch Theta_one_turn_k $cyclenum
            }
            if { [catch {exa mismatch_V_DC_link_sd} mismatch] == 0 && $mismatch } {
                report_mismatch V_DC_link_sd $cyclenum
            }
        } else {
            puts "Signal mismatch detected at $my_tb";
        }
        if {$quit_at_end == 1} {
            quit -code 1;
        }
    }
    eval vsim -quiet -suppress 14408 -error 3473 -msgmode both -voptargs="+acc" -t ps motor_kit_sim_20MHz_MotorModel_atb $ll
    do $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_atb.wav.do
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
