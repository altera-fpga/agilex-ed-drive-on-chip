
proc checkDepends {dst src} {
    if {! [file exists $dst]} { return 1 }
    if {[file mtime $dst] < [file mtime $src]} { return 1 }
    return 0
}

if {[checkDepends "$base_dir/work/dspba_library_package/_primary.dat" "$base_dir/Libraries/vhdl/base/dspba_library_package.vhd"] || [checkDepends "$base_dir/work/dspba_library_package/_primary.dat" "$base_dir/Libraries/vhdl/base/dspba_library.vhd"]} {
    vcom -quiet -93  "$base_dir/Libraries/vhdl/base/dspba_library_package.vhd"
    vcom -quiet -93  "$base_dir/Libraries/vhdl/base/dspba_library.vhd"
}
if {[checkDepends "$base_dir/work/dspba_sim_library_package/_primary.dat" "$base_dir/Libraries/vhdl/sim/dspba_sim_library_package.vhd"]} {
    vcom -quiet -93  "$base_dir/Libraries/vhdl/sim/dspba_sim_library_package.vhd"
}
