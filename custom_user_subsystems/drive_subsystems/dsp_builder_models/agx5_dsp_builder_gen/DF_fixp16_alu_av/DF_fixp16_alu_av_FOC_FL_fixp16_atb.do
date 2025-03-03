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

if {! [file exists $base_dir/DF_fixp16_alu_av_FOC_FL_fixp16]} {
    file delete -force $base_dir/DF_fixp16_alu_av_FOC_FL_fixp16
}

project new $base_dir DF_fixp16_alu_av_FOC_FL_fixp16
if {! [file exists $base_dir/work/_info]} {
    file delete -force $base_dir/work
    vlib work
}
quietly vmap work $base_dir/work

do "$base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_fpc.do"


quietly set vcomfailed 0
onerror {
    quietly set vcomfailed 1
    resume
}

project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_safe_path_msim.vhd vhdl
project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16.vhd vhdl
puts {Note: Process variables may be optimized out of top-level testbench. Re-compile with the following command to disable optimizations:}
puts {vcom -quiet -O0 $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_atb.vhd}
project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_atb.vhd vhdl
project addfile $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_stm.vhd vhdl
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
            if { [catch {exa mismatch_out_1_qv_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_1_qv_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_2_qc_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_2_qc_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_3_valid_out_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_3_valid_out_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_4_axis_out_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_4_axis_out_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_5_Valpha_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_5_Valpha_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_6_Vbeta_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_6_Vbeta_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_7_IntegralD_out_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_7_IntegralD_out_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_8_IntegralQ_out_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_8_IntegralQ_out_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_9_Iq_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_9_Iq_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_10_Id_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_10_Id_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_11_0_uvw_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_11_0_uvw_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_11_1_uvw_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_11_1_uvw_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_11_2_uvw_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_11_2_uvw_tpl $cyclenum
            }
            if { [catch {exa mismatch_out_12_ready_tpl} mismatch] == 0 && $mismatch } {
                report_mismatch out_12_ready_tpl $cyclenum
            }
        } else {
            puts "Signal mismatch detected at $my_tb";
        }
        if {$quit_at_end == 1} {
            quit -code 1;
        }
    }
    eval vsim -quiet -suppress 14408 -error 3473 -msgmode both -voptargs="+acc" -t ps DF_fixp16_alu_av_FOC_FL_fixp16_atb $ll
    do $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_atb.wav.do
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
