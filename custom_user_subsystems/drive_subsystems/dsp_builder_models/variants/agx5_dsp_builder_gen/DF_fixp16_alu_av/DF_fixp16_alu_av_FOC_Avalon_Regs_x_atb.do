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

if {! [file exists $base_dir/standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x]} {
    file delete -force $base_dir/standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x
}

project new $base_dir standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x
if {! [file exists $base_dir/work/_info]} {
    file delete -force $base_dir/work
    vlib work
}
quietly vmap work $base_dir/work

do "$base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_x_fpc.do"


quietly set vcomfailed 0
onerror {
    quietly set vcomfailed 1
    resume
}

project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_safe_path_msim.vhd vhdl
project addfile $base_dir/DF_fixp16_alu_av/standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x.vhd vhdl
project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs.vhd vhdl
project addfile $base_dir/DF_fixp16_alu_av/busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz.vhd vhdl
puts {Note: Process variables may be optimized out of top-level testbench. Re-compile with the following command to disable optimizations:}
puts {vcom -quiet -O0 $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb.vhd}
project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb.vhd vhdl
project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_x_stm.vhd vhdl
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
            quietly set cyclenum [expr int($simtime / 10000.000000)];
            if { [catch {exa mismatch_dv} mismatch] == 0 && $mismatch } {
                report_mismatch dv $cyclenum
            }
            if { [catch {exa mismatch_axisin} mismatch] == 0 && $mismatch } {
                report_mismatch axisin $cyclenum
            }
            if { [catch {exa mismatch_Iu} mismatch] == 0 && $mismatch } {
                report_mismatch Iu $cyclenum
            }
            if { [catch {exa mismatch_Iw} mismatch] == 0 && $mismatch } {
                report_mismatch Iw $cyclenum
            }
            if { [catch {exa mismatch_Torque} mismatch] == 0 && $mismatch } {
                report_mismatch Torque $cyclenum
            }
            if { [catch {exa mismatch_phi_el} mismatch] == 0 && $mismatch } {
                report_mismatch phi_el $cyclenum
            }
            if { [catch {exa mismatch_Kp_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Kp_cfg $cyclenum
            }
            if { [catch {exa mismatch_Ki_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch Ki_cfg $cyclenum
            }
            if { [catch {exa mismatch_I_Sat_Limit_cfg} mismatch] == 0 && $mismatch } {
                report_mismatch I_Sat_Limit_cfg $cyclenum
            }
            if { [catch {exa mismatch_MaxV} mismatch] == 0 && $mismatch } {
                report_mismatch MaxV $cyclenum
            }
            if { [catch {exa mismatch_reset} mismatch] == 0 && $mismatch } {
                report_mismatch reset $cyclenum
            }
        } else {
            puts "Signal mismatch detected at $my_tb";
        }
        if {$quit_at_end == 1} {
            quit -code 1;
        }
    }
    eval vsim -quiet -suppress 14408 -error 3473 -msgmode both -voptargs="+acc" -t ps standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb $ll
    do $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb.wav.do
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
