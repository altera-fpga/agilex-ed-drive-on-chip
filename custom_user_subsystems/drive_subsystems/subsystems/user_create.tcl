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

# Define the procedures used by the create_subsystems_qsys.tcl script

proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {

}

proc post_creation_step {} {
  edit_top_level_qsys
}

proc post_connection_step {} {

}

# =====================================================================

proc derive_parameters {param_array} {

  upvar $param_array p_array

  # =====================================================================
  # Resolve interdependencies

  # Find all instances of the drive subsystem, group them by avmm_host,
  # then sort each group by ascending drive number.
  # Each drive subsystem within a group needs to have a sync signal
  # daisy chained to each other, in order from lowest to highest drive
  # number

  array set v_drive_sync_chains {}

  for {set id 0} {$id < $p_array(project,id)} {incr id} {

    if {($p_array($id,type) == "user")} {
      set v_script_name [file tail $p_array($id,script)]

      if {(${v_script_name} == "drive_create.tcl")} {

        set v_subsystem_name $p_array($id,name)

        foreach v_sublist $p_array($id,params) {
          foreach {name value} $v_sublist {
            if {[string eq $name "AVMM_HOST"]} {
              set v_avmm_host $value
            }
            if {[string eq $name "DRIVE_NUMBER"]} {
              set v_drive_number $value
            }
          }
        }

        set v_entry [list ${v_subsystem_name} ${v_drive_number}]

        puts "entry - $v_entry"

        if {[info exists v_drive_sync_chains(${v_avmm_host})]} {
          lappend v_drive_sync_chains(${v_avmm_host}) $v_entry
        } else {
          set v_drive_sync_chains(${v_avmm_host}) [list $v_entry]
        }

      }
    }
  }

  # Convert array to list for shell parameter purposes
  set v_drive_sync_chains_list []

  foreach key [array names v_drive_sync_chains] {

    # Sort by ascending drive number
    set v_drive_sync_chain [lsort -integer -index 1 $v_drive_sync_chains($key)]

    # Remove drive numbers (not needed as list is sorted)
    set v_drive_names_list []
    foreach v_drive $v_drive_sync_chain {

      set v_drive_name [lindex ${v_drive} 0]
      lappend v_drive_names_list ${v_drive_name}

    }

    lappend v_drive_sync_chains_list $v_drive_names_list
  }

  # List of list of drive subsystem names ordered by ascending drive number
  set_shell_parameter DRV_DRIVE_SYNC_CHAINS $v_drive_sync_chains_list

}

#==========================================================

# Copy files from the shell install directory to the target project directory
proc transfer_files {} {

  set v_project_path            [get_shell_parameter PROJECT_PATH]
  set v_subsystem_source_path   [get_shell_parameter SUBSYSTEM_SOURCE_PATH]

  file_copy   ${v_subsystem_source_path}/qar_fileset.txt ${v_project_path}/scripts
  file_copy   ${v_subsystem_source_path}/../toolkit/     ${v_project_path}

}

# Create the drive subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem
proc create_drive_subsystem {} {

}

# Insert the drive subsystem into the top level Platform Designer system,
# and add interfaces to the boundary of the top level
proc edit_top_level_qsys {} {

  set v_project_name        [get_shell_parameter PROJECT_NAME]
  set v_project_path        [get_shell_parameter PROJECT_PATH]
  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_drive_sync_chains   [get_shell_parameter DRV_DRIVE_SYNC_CHAINS]

  load_system ${v_project_path}/rtl/${v_project_name}_qsys.qsys

  # Connect drive subsystem sync inputs/outputs for each avmm host group
  puts "add connections - $v_drive_sync_chains"

  foreach v_drive_sync_chain $v_drive_sync_chains {

    set v_num_drives [llength ${v_drive_sync_chain}]

    if {${v_num_drives} >= 2} {

      set v_drive_a_name [lindex ${v_drive_sync_chain} 0]

      for {set v_idx 1} {${v_idx} < ${v_num_drives}} {incr v_idx} {

        set v_drive_b_name [lindex ${v_drive_sync_chain} ${v_idx}]

        add_connection  ${v_drive_a_name}.c_sync_out  ${v_drive_b_name}.c_sync_in

        set v_drive_a_name ${v_drive_b_name}

      }

    }

  }

  sync_sysinfo_parameters
  save_system

}

# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top Platform Designer level
proc add_auto_connections {} {

}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

}