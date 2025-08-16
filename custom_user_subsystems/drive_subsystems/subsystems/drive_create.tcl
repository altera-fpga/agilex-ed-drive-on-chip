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

# Create script specific parameters and default values

set_shell_parameter DRIVE_NUMBER            "0"
set_shell_parameter AVMM_HOST               {}

set_shell_parameter ADC_IRQ_PRIORITY        "X"
set_shell_parameter ADC_IRQ_HOST            ""
set_shell_parameter ADC_POW_IRQ_PRIORITY    "X"
set_shell_parameter ADC_POW_IRQ_HOST        ""
set_shell_parameter ENABLE_RESOLVER         "1"

set_shell_parameter PERIPH_CLOCK_FREQ_HZ    {100000000}
set_shell_parameter PWM_CLOCK_FREQ_HZ       {300000000}
set_shell_parameter ADC_CLOCK_FREQ_HZ       {20000000}
set_shell_parameter SPI_CLOCK_FREQ_HZ       {1000000}

# =====================================================================

proc derive_parameters {param_array} {

}

# Define the procedures used by the create_subsystems_qsys.tcl script
proc pre_creation_step {} {
  transfer_files
}

proc creation_step {} {
  create_drive_subsystem
}

proc post_creation_step {} {
  edit_top_level_qsys
  add_auto_connections
  edit_top_v_file
}

#==========================================================

# Copy files from the shell install directory to the target project directory
proc transfer_files {} {

  set v_project_path            [get_shell_parameter PROJECT_PATH]
  set v_subsystem_source_path   [get_shell_parameter SUBSYSTEM_SOURCE_PATH]
  set v_family                  [get_shell_parameter FAMILY]

  file mkdir        ${v_project_path}/non_qpds_ip/dsp_builder_models
  file mkdir        ${v_project_path}/non_qpds_ip/dsp_builder_gen
  file_copy         ${v_subsystem_source_path}/../dsp_builder_models/DF_fixp16_alu_av \
                    ${v_project_path}/non_qpds_ip/dsp_builder_models

  set v_model_dir     "${v_project_path}/non_qpds_ip/dsp_builder_models/DF_fixp16_alu_av"
  set v_model_name    "DF_fixp16_alu_av"

  # Needs to be relative to the model directory
  set v_rtl_dir       "./../../dsp_builder_gen"

  if {($v_family == "Agilex 5")} {
      file_copy ${v_subsystem_source_path}/../dsp_builder_models/variants/agx5_dsp_builder_gen \
                ${v_project_path}/non_qpds_ip/dsp_builder_gen
  } elseif {($v_family == "Agilex 3")} {
      file_copy ${v_subsystem_source_path}/../dsp_builder_models/variants/agx3_dsp_builder_gen \
                ${v_project_path}/non_qpds_ip/dsp_builder_gen
  }

  file_copy ${v_subsystem_source_path}/../non_qpds_ip/ssg_emb_dsm            ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/ssg_emb_pwm            ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/ssg_emb_sd_adc         ${v_project_path}/non_qpds_ip/user

  file_copy ${v_subsystem_source_path}/../non_qpds_ip/drive_subsystem.ipx    ${v_project_path}/non_qpds_ip/user

  file_copy ${v_subsystem_source_path}/../non_qpds_ip/QEP_D3                 ${v_project_path}/non_qpds_ip/user
  file_copy ${v_subsystem_source_path}/../non_qpds_ip/common.ipx             ${v_project_path}/non_qpds_ip/user

  set v_enable_resolver [get_shell_parameter ENABLE_RESOLVER]

  if {${v_enable_resolver} != 0} {
    set v_instance_name   [get_shell_parameter INSTANCE_NAME]
    set v_drive_qsf       [open ${v_project_path}/quartus/user/${v_instance_name}_vpin.qsf w]

    puts  ${v_drive_qsf} "set_instance_assignment -to \"${v_instance_name}_c_rslvr_spi_ctrl_MOSI\" -name VIRTUAL_PIN ON"
    puts  ${v_drive_qsf} "set_instance_assignment -to \"${v_instance_name}_c_rslvr_spi_ctrl_SCLK\" -name VIRTUAL_PIN ON"
    puts  ${v_drive_qsf} "set_instance_assignment -to \"${v_instance_name}_c_rslvr_spi_ctrl_SS_n\" -name VIRTUAL_PIN ON"

    puts  ${v_drive_qsf} "set_instance_assignment -to \"${v_instance_name}_c_rslvr_spi_posn_MOSI\" -name VIRTUAL_PIN ON"
    puts  ${v_drive_qsf} "set_instance_assignment -to \"${v_instance_name}_c_rslvr_spi_posn_SCLK\" -name VIRTUAL_PIN ON"
    puts  ${v_drive_qsf} "set_instance_assignment -to \"${v_instance_name}_c_rslvr_spi_posn_SS_n\" -name VIRTUAL_PIN ON"

    close ${v_drive_qsf}

  }

}

# Create the drive subsystem, add the required IP, parameterize it as appropriate,
# add internal connections, and add interfaces to the boundary of the subsystem
proc create_drive_subsystem {} {

  set v_project_path    [get_shell_parameter PROJECT_PATH]
  set v_instance_name   [get_shell_parameter INSTANCE_NAME]
  set v_enable_resolver [get_shell_parameter ENABLE_RESOLVER]
  set v_periph_clk_freq [get_shell_parameter PERIPH_CLOCK_FREQ_HZ]
  set v_pwm_clk_freq    [get_shell_parameter PWM_CLOCK_FREQ_HZ]
  set v_adc_clk_freq    [get_shell_parameter ADC_CLOCK_FREQ_HZ]
  set v_spi_clk_freq    [get_shell_parameter SPI_CLOCK_FREQ_HZ]

  create_system ${v_instance_name}
  save_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys
  load_system   ${v_project_path}/rtl/user/${v_instance_name}.qsys


  # 100MHz - periph
  # 300MHz - pwm
  # 20MHz  - adc

  add_instance  periph_clock_bridge   altera_clock_bridge
  add_instance  pwm_clock_bridge      altera_clock_bridge
  add_instance  adc_clock_bridge      altera_clock_bridge

  add_instance  periph_reset_bridge   altera_reset_bridge
  add_instance  pwm_reset_bridge      altera_reset_bridge
  add_instance  adc_reset_bridge      altera_reset_bridge

  add_instance  avmm_bridge           altera_avalon_mm_bridge

  add_instance  doc_adc               ssg_emb_sd_adc

  add_instance  conduit_splitter      ecfs_conduit_splitter

  add_instance  doc_adc_pow           ssg_emb_sd_adc
  add_instance  doc_pwm               ssg_emb_pwm
  add_instance  doc_sm                ssg_emb_dsm
  add_instance  doc_qep               QEP_interface

  if {${v_enable_resolver} != 0} {
    add_instance  doc_rslvr_spi_ctrl  altera_avalon_spi
    add_instance  doc_rslvr_spi_posn  altera_avalon_spi
    add_instance  doc_rslvr_pio       altera_avalon_pio
    add_instance  hall_pio            altera_avalon_pio
  }

  add_instance  doc_foc_fixp          DF_fixp16_alu_av_FOC

  # Set the instance parameters
  set_instance_parameter_value  periph_clock_bridge   EXPLICIT_CLOCK_RATE ${v_periph_clk_freq}

  set_instance_parameter_value  pwm_clock_bridge      EXPLICIT_CLOCK_RATE ${v_pwm_clk_freq}

  set_instance_parameter_value  adc_clock_bridge      EXPLICIT_CLOCK_RATE ${v_adc_clk_freq}

  # avmm_bridge
  set_instance_parameter_value  avmm_bridge   SYNC_RESET                0
  set_instance_parameter_value  avmm_bridge   DATA_WIDTH                32
  set_instance_parameter_value  avmm_bridge   SYMBOL_WIDTH              8
  set_instance_parameter_value  avmm_bridge   ADDRESS_WIDTH             0
  set_instance_parameter_value  avmm_bridge   USE_AUTO_ADDRESS_WIDTH    1
  set_instance_parameter_value  avmm_bridge   ADDRESS_UNITS             SYMBOLS
  set_instance_parameter_value  avmm_bridge   MAX_BURST_SIZE            1
  set_instance_parameter_value  avmm_bridge   LINEWRAPBURSTS            0
  set_instance_parameter_value  avmm_bridge   MAX_PENDING_RESPONSES     4
  set_instance_parameter_value  avmm_bridge   MAX_PENDING_WRITES        0
  set_instance_parameter_value  avmm_bridge   PIPELINE_COMMAND          1
  set_instance_parameter_value  avmm_bridge   PIPELINE_RESPONSE         1
  set_instance_parameter_value  avmm_bridge   USE_RESPONSE              0
  set_instance_parameter_value  avmm_bridge   USE_WRITERESPONSE         0

  # ecfs_conduit_splitter
  set_instance_parameter_value  conduit_splitter  OUTPUT_NUM            3

  if {${v_enable_resolver} != 0} {

    # doc_rslvr_spi_ctrl
    set_instance_parameter_value  doc_rslvr_spi_ctrl  masterSPI                             1
    set_instance_parameter_value  doc_rslvr_spi_ctrl  numberOfSlaves                        1
    set_instance_parameter_value  doc_rslvr_spi_ctrl  targetClockRate                       ${v_spi_clk_freq}
    set_instance_parameter_value  doc_rslvr_spi_ctrl  insertDelayBetweenSlaveSelectAndSClk  0
    set_instance_parameter_value  doc_rslvr_spi_ctrl  dataWidth                             12
    set_instance_parameter_value  doc_rslvr_spi_ctrl  lsbOrderedFirst                       1
    set_instance_parameter_value  doc_rslvr_spi_ctrl  clockPolarity                         1
    set_instance_parameter_value  doc_rslvr_spi_ctrl  clockPhase                            0
    set_instance_parameter_value  doc_rslvr_spi_ctrl  insertSync                            1
    set_instance_parameter_value  doc_rslvr_spi_ctrl  syncRegDepth                          2

    # doc_rslvr_spi_posn
    set_instance_parameter_value  doc_rslvr_spi_posn  masterSPI                             1
    set_instance_parameter_value  doc_rslvr_spi_posn  numberOfSlaves                        1
    set_instance_parameter_value  doc_rslvr_spi_posn  targetClockRate                       ${v_spi_clk_freq}
    set_instance_parameter_value  doc_rslvr_spi_posn  insertDelayBetweenSlaveSelectAndSClk  0
    set_instance_parameter_value  doc_rslvr_spi_posn  dataWidth                             16
    set_instance_parameter_value  doc_rslvr_spi_posn  lsbOrderedFirst                       1
    set_instance_parameter_value  doc_rslvr_spi_posn  clockPolarity                         1
    set_instance_parameter_value  doc_rslvr_spi_posn  clockPhase                            1
    set_instance_parameter_value  doc_rslvr_spi_posn  insertSync                            1
    set_instance_parameter_value  doc_rslvr_spi_posn  syncRegDepth                          2

    # doc_rslvr_pio
    set_instance_parameter_value  doc_rslvr_pio       width                                 2
    set_instance_parameter_value  doc_rslvr_pio       direction                             InOut
    set_instance_parameter_value  doc_rslvr_pio       resetValue                            0x0
    set_instance_parameter_value  doc_rslvr_pio       bitModifyingOutReg                    0
    set_instance_parameter_value  doc_rslvr_pio       captureEdge                           0
    set_instance_parameter_value  doc_rslvr_pio       generateIRQ                           0
    set_instance_parameter_value  doc_rslvr_pio       simDoTestBenchWiring                  0

    # hall_pio
    set_instance_parameter_value  hall_pio            width                                 3
    set_instance_parameter_value  hall_pio            direction                             Input
    set_instance_parameter_value  hall_pio            captureEdge                           0
    set_instance_parameter_value  hall_pio            generateIRQ                           0
    set_instance_parameter_value  hall_pio            simDoTestBenchWiring                  0

  }

  # Create internal subsystem connections
  add_connection    periph_clock_bridge.out_clk     periph_reset_bridge.clk
  add_connection    periph_clock_bridge.out_clk     avmm_bridge.clk
  add_connection    periph_clock_bridge.out_clk     doc_adc.clock
  add_connection    periph_clock_bridge.out_clk     doc_adc_pow.clock
  add_connection    periph_clock_bridge.out_clk     doc_pwm.sys_clock
  add_connection    periph_clock_bridge.out_clk     doc_sm.clock
  add_connection    periph_clock_bridge.out_clk     doc_qep.clock

  if {${v_enable_resolver} != 0} {
    add_connection  periph_clock_bridge.out_clk     doc_rslvr_spi_ctrl.clk
    add_connection  periph_clock_bridge.out_clk     doc_rslvr_spi_posn.clk
    add_connection  periph_clock_bridge.out_clk     doc_rslvr_pio.clk
    add_connection  periph_clock_bridge.out_clk     hall_pio.clk
  }

  add_connection    periph_clock_bridge.out_clk     doc_foc_fixp.clock

  add_connection    periph_reset_bridge.out_reset   avmm_bridge.reset
  add_connection    periph_reset_bridge.out_reset   doc_adc.reset
  add_connection    periph_reset_bridge.out_reset   doc_adc_pow.reset
  add_connection    periph_reset_bridge.out_reset   doc_pwm.reset
  add_connection    periph_reset_bridge.out_reset   doc_sm.reset
  add_connection    periph_reset_bridge.out_reset   doc_qep.reset

  if {${v_enable_resolver} != 0} {
    add_connection  periph_reset_bridge.out_reset   doc_rslvr_spi_ctrl.reset
    add_connection  periph_reset_bridge.out_reset   doc_rslvr_spi_posn.reset
    add_connection  periph_reset_bridge.out_reset   doc_rslvr_pio.reset
    add_connection  periph_reset_bridge.out_reset   hall_pio.reset
  }
  add_connection    periph_reset_bridge.out_reset   doc_foc_fixp.clock_reset
  add_connection    periph_reset_bridge.out_reset   doc_foc_fixp.bus_reset

  add_connection    pwm_clock_bridge.out_clk        pwm_reset_bridge.clk
  add_connection    pwm_clock_bridge.out_clk        doc_pwm.pwm_clock

  add_connection    pwm_reset_bridge.out_reset      doc_pwm.pwm_reset

  add_connection    adc_clock_bridge.out_clk        adc_reset_bridge.clk
  add_connection    adc_clock_bridge.out_clk        doc_adc.clock_adc
  add_connection    adc_clock_bridge.out_clk        doc_adc_pow.clock_adc

  add_connection    adc_reset_bridge.out_reset      doc_adc.reset_adc_n
  add_connection    adc_reset_bridge.out_reset      doc_adc_pow.reset_adc_n

  add_connection    avmm_bridge.m0                  doc_adc.avalon_slave
  add_connection    avmm_bridge.m0                  doc_adc_pow.avalon_slave
  add_connection    avmm_bridge.m0                  doc_pwm.avalon_slave_0
  add_connection    avmm_bridge.m0                  doc_sm.avalon_slave_0
  add_connection    avmm_bridge.m0                  doc_qep.avalon_slave_0

  if {${v_enable_resolver} != 0} {
    add_connection  avmm_bridge.m0                  doc_rslvr_spi_ctrl.spi_control_port
    add_connection  avmm_bridge.m0                  doc_rslvr_spi_posn.spi_control_port
    add_connection  avmm_bridge.m0                  doc_rslvr_pio.s1
    add_connection  avmm_bridge.m0                  hall_pio.s1
  }
  add_connection    avmm_bridge.m0                  doc_foc_fixp.bus

  add_connection    doc_pwm.start_adc               conduit_splitter.conduit_input

  add_connection    conduit_splitter.conduit_output_0    doc_adc.start
  add_connection    conduit_splitter.conduit_output_1    doc_adc_pow.start

  add_connection    doc_pwm.pwm_control             doc_sm.pwm_control

  # Add interfaces to the boundary of the subsystem
  add_interface           i_clock_periph    clock       sink
  set_interface_property  i_clock_periph    export_of   periph_clock_bridge.in_clk

  add_interface           i_reset_periph    reset       sink
  set_interface_property  i_reset_periph    export_of   periph_reset_bridge.in_reset

  add_interface           i_clock_pwm       clock       sink
  set_interface_property  i_clock_pwm       export_of   pwm_clock_bridge.in_clk

  add_interface           i_reset_pwm       reset       sink
  set_interface_property  i_reset_pwm       export_of   pwm_reset_bridge.in_reset

  add_interface           i_clock_adc       clock       sink
  set_interface_property  i_clock_adc       export_of   adc_clock_bridge.in_clk

  add_interface           i_reset_adc       reset       sink
  set_interface_property  i_reset_adc       export_of   adc_reset_bridge.in_reset

  add_interface           i_avmm_agent      avalon      agent
  set_interface_property  i_avmm_agent      export_of   avmm_bridge.s0

  add_interface           o_adc_irq         interrupt   sender
  set_interface_property  o_adc_irq         export_of   doc_adc.irq

  add_interface           c_adc             conduit     end
  set_interface_property  c_adc             export_of   doc_adc.adc

  add_interface           o_adc_start       conduit     end
  set_interface_property  o_adc_start       export_of   conduit_splitter.conduit_output_2

  add_interface           o_adc_pow_irq     interrupt   sender
  set_interface_property  o_adc_pow_irq     export_of   doc_adc_pow.irq

  add_interface           c_adc_pow         conduit     end
  set_interface_property  c_adc_pow         export_of   doc_adc_pow.adc

  add_interface           c_pwm             conduit     end
  set_interface_property  c_pwm             export_of   doc_pwm.pwm

  add_interface           c_sync_out        conduit     end
  set_interface_property  c_sync_out        export_of   doc_pwm.sync_out

  add_interface           c_sync_in         conduit     end
  set_interface_property  c_sync_in         export_of   doc_pwm.sync_in

  add_interface           c_vu_pwm          conduit     end
  set_interface_property  c_vu_pwm          export_of   doc_pwm.vu_pwm

  add_interface           c_vv_pwm          conduit     end
  set_interface_property  c_vv_pwm          export_of   doc_pwm.vv_pwm

  add_interface           c_vw_pwm          conduit     end
  set_interface_property  c_vw_pwm          export_of   doc_pwm.vw_pwm

  add_interface           c_monitor         conduit     end
  set_interface_property  c_monitor         export_of   doc_sm.monitor

  add_interface           c_qep             conduit     end
  set_interface_property  c_qep             export_of   doc_qep.conduit_end

  if {${v_enable_resolver} != 0} {
    add_interface           c_rslvr_spi_ctrl    conduit     end
    set_interface_property  c_rslvr_spi_ctrl    export_of   doc_rslvr_spi_ctrl.external

    add_interface           c_rslvr_spi_posn    conduit     end
    set_interface_property  c_rslvr_spi_posn    export_of   doc_rslvr_spi_posn.external

    add_interface           c_rslvr_pio         conduit     end
    set_interface_property  c_rslvr_pio         export_of   doc_rslvr_pio.external_connection

    add_interface           c_hall_pio          conduit     end
    set_interface_property  c_hall_pio          export_of   hall_pio.external_connection
  }

  add_interface             c_foc_exp           conduit     end
  set_interface_property    c_foc_exp           export_of   doc_foc_fixp.exp

  # Add fixed base addresses
  set_connection_parameter_value  avmm_bridge.m0/doc_foc_fixp.bus                       baseAddress "0x00000000"
  set_connection_parameter_value  avmm_bridge.m0/doc_qep.avalon_slave_0                 baseAddress "0x00000100"
  set_connection_parameter_value  avmm_bridge.m0/doc_pwm.avalon_slave_0                 baseAddress "0x00000140"
  set_connection_parameter_value  avmm_bridge.m0/doc_adc_pow.avalon_slave               baseAddress "0x00000180"
  set_connection_parameter_value  avmm_bridge.m0/doc_adc.avalon_slave                   baseAddress "0x000001c0"

  if {${v_enable_resolver} != 0} {
    set_connection_parameter_value  avmm_bridge.m0/doc_rslvr_spi_posn.spi_control_port  baseAddress "0x00000200"
    set_connection_parameter_value  avmm_bridge.m0/doc_rslvr_spi_ctrl.spi_control_port  baseAddress "0x00000220"
    set_connection_parameter_value  avmm_bridge.m0/hall_pio.s1                          baseAddress "0x00000240"
    set_connection_parameter_value  avmm_bridge.m0/doc_rslvr_pio.s1                     baseAddress "0x00000250"
  }
  set_connection_parameter_value  avmm_bridge.m0/doc_sm.avalon_slave_0                  baseAddress "0x00000260"

  lock_avalon_base_address      doc_foc_fixp.bus
  lock_avalon_base_address      doc_qep.avalon_slave_0
  lock_avalon_base_address      doc_pwm.avalon_slave_0
  lock_avalon_base_address      doc_adc_pow.avalon_slave
  lock_avalon_base_address      doc_adc.avalon_slave

  if {${v_enable_resolver} != 0} {
    lock_avalon_base_address    doc_rslvr_spi_posn.spi_control_port
    lock_avalon_base_address    doc_rslvr_spi_ctrl.spi_control_port
    lock_avalon_base_address    hall_pio.s1
    lock_avalon_base_address    doc_rslvr_pio.s1
  }
  lock_avalon_base_address      doc_sm.avalon_slave_0

  sync_sysinfo_parameters
  save_system

}

# Insert the motor model subsystem into the top level qsys system, and add interfaces
# to the boundary of the top level qsys system
proc edit_top_level_qsys {} {

  set v_project_name    [get_shell_parameter PROJECT_NAME]
  set v_project_path    [get_shell_parameter PROJECT_PATH]
  set v_instance_name   [get_shell_parameter INSTANCE_NAME]
  set v_enable_resolver [get_shell_parameter ENABLE_RESOLVER]

  load_system  ${v_project_path}/rtl/${v_project_name}_qsys.qsys

  add_instance ${v_instance_name} ${v_instance_name}

  add_interface           "${v_instance_name}_c_adc"                conduit     end
  set_interface_property  "${v_instance_name}_c_adc"                export_of   ${v_instance_name}.c_adc

  add_interface           "${v_instance_name}_c_adc_pow"            conduit     end
  set_interface_property  "${v_instance_name}_c_adc_pow"            export_of   ${v_instance_name}.c_adc_pow

  add_interface           "${v_instance_name}_c_pwm"                conduit     end
  set_interface_property  "${v_instance_name}_c_pwm"                export_of   ${v_instance_name}.c_pwm

  add_interface           "${v_instance_name}_c_adc_pow"            conduit     end
  set_interface_property  "${v_instance_name}_c_adc_pow"            export_of   ${v_instance_name}.c_adc_pow

  add_interface           "${v_instance_name}_c_vu_pwm"             conduit     end
  set_interface_property  "${v_instance_name}_c_vu_pwm"             export_of   ${v_instance_name}.c_vu_pwm

  add_interface           "${v_instance_name}_c_vv_pwm"             conduit     end
  set_interface_property  "${v_instance_name}_c_vv_pwm"             export_of   ${v_instance_name}.c_vv_pwm

  add_interface           "${v_instance_name}_c_vw_pwm"             conduit     end
  set_interface_property  "${v_instance_name}_c_vw_pwm"             export_of   ${v_instance_name}.c_vw_pwm

  add_interface           "${v_instance_name}_c_qep"                conduit     end
  set_interface_property  "${v_instance_name}_c_qep"                export_of   ${v_instance_name}.c_qep

  add_interface           "${v_instance_name}_c_monitor"            conduit     end
  set_interface_property  "${v_instance_name}_c_monitor"            export_of   ${v_instance_name}.c_monitor

  add_interface           "${v_instance_name}_c_foc_exp"            conduit     end
  set_interface_property  "${v_instance_name}_c_foc_exp"            export_of   ${v_instance_name}.c_foc_exp

  if {${v_enable_resolver} != 0} {
    add_interface           "${v_instance_name}_c_rslvr_pio"        conduit     end
    set_interface_property  "${v_instance_name}_c_rslvr_pio"        export_of   ${v_instance_name}.c_rslvr_pio

    add_interface           "${v_instance_name}_c_rslvr_spi_ctrl"   conduit     end
    set_interface_property  "${v_instance_name}_c_rslvr_spi_ctrl"   export_of   ${v_instance_name}.c_rslvr_spi_ctrl

    add_interface           "${v_instance_name}_c_rslvr_spi_posn"   conduit     end
    set_interface_property  "${v_instance_name}_c_rslvr_spi_posn"   export_of   ${v_instance_name}.c_rslvr_spi_posn

    add_interface           "${v_instance_name}_c_hall_pio"         conduit     end
    set_interface_property  "${v_instance_name}_c_hall_pio"         export_of   ${v_instance_name}.c_hall_pio
  }

  sync_sysinfo_parameters
  save_system

}

# Enable a subset of subsystem interfaces to be available for auto-connection
# to other subsystems at the top qsys level
proc add_auto_connections {} {

  set v_instance_name         [get_shell_parameter INSTANCE_NAME]
  set v_avmm_host             [get_shell_parameter AVMM_HOST]
  set v_adc_irq_priority      [get_shell_parameter ADC_IRQ_PRIORITY]
  set v_adc_irq_host          [get_shell_parameter ADC_IRQ_HOST]
  set v_adc_pow_irq_priority  [get_shell_parameter ADC_POW_IRQ_PRIORITY]
  set v_adc_pow_irq_host      [get_shell_parameter ADC_POW_IRQ_HOST]
  set v_periph_clk_freq       [get_shell_parameter PERIPH_CLOCK_FREQ_HZ]
  set v_pwm_clk_freq          [get_shell_parameter PWM_CLOCK_FREQ_HZ]
  set v_adc_clk_freq          [get_shell_parameter ADC_CLOCK_FREQ_HZ]

# Connect the subsystem ip to #MHz clock/reset domain
  add_auto_connection ${v_instance_name} i_clock_periph ${v_periph_clk_freq}
  add_auto_connection ${v_instance_name} i_reset_periph ${v_periph_clk_freq}

  add_auto_connection ${v_instance_name} i_clock_pwm    ${v_pwm_clk_freq}
  add_auto_connection ${v_instance_name} i_reset_pwm    ${v_pwm_clk_freq}

  add_auto_connection ${v_instance_name} i_clock_adc    ${v_adc_clk_freq}
  add_auto_connection ${v_instance_name} i_reset_adc    ${v_adc_clk_freq}

  add_avmm_connections i_avmm_agent $v_avmm_host

  if {(${v_adc_irq_host} != "NONE") && (${v_adc_irq_host} != "")} {
    add_irq_connection ${v_instance_name} "o_adc_irq" ${v_adc_irq_priority} ${v_adc_irq_host}_irq
  }

  if {(${v_adc_pow_irq_host} != "NONE") && (${v_adc_pow_irq_host} != "")} {
    add_irq_connection ${v_instance_name} "o_adc_pow_irq" ${v_adc_pow_irq_priority} ${v_adc_pow_irq_host}_irq
  }

}

# Insert lines of code into the top level hdl file
proc edit_top_v_file {} {

  set v_instance_name       [get_shell_parameter INSTANCE_NAME]
  set v_drive_number        [get_shell_parameter DRIVE_NUMBER ]
  set v_enable_resolver     [get_shell_parameter ENABLE_RESOLVER]

  add_declaration_list wire "\[15:0\]" "drive_${v_drive_number}_Iu_reg"
  add_declaration_list wire "\[15:0\]" "drive_${v_drive_number}_Iw_reg"
  add_declaration_list wire "\[15:0\]" "drive_${v_drive_number}_vu_pwm"
  add_declaration_list wire "\[15:0\]" "drive_${v_drive_number}_vv_pwm"
  add_declaration_list wire "\[15:0\]" "drive_${v_drive_number}_vw_pwm"

  add_declaration_list wire "" "drive_${v_drive_number}_overcurrent"

  add_declaration_list wire "" "drive_${v_drive_number}_enc_stb0_n"

  if {${v_enable_resolver} != 0} {
    add_top_port_list output "" "${v_instance_name}_c_rslvr_spi_ctrl_MOSI"
    add_top_port_list output "" "${v_instance_name}_c_rslvr_spi_ctrl_SCLK"
    add_top_port_list output "" "${v_instance_name}_c_rslvr_spi_ctrl_SS_n"

    add_top_port_list output "" "${v_instance_name}_c_rslvr_spi_posn_MOSI"
    add_top_port_list output "" "${v_instance_name}_c_rslvr_spi_posn_SCLK"
    add_top_port_list output "" "${v_instance_name}_c_rslvr_spi_posn_SS_n"

    add_declaration_list wire "\[1:0\]" "${v_instance_name}_c_rslvr_pio_inout_port"
  }

  add_qsys_inst_exports_list "${v_instance_name}_c_foc_exp_data_Iu"       "drive_${v_drive_number}_Iu_reg"
  add_qsys_inst_exports_list "${v_instance_name}_c_foc_exp_data_Iw"       "drive_${v_drive_number}_Iw_reg"
  add_qsys_inst_exports_list "${v_instance_name}_c_foc_exp_data_vu_pwm"   "drive_${v_drive_number}_vu_pwm"
  add_qsys_inst_exports_list "${v_instance_name}_c_foc_exp_data_vv_pwm"   "drive_${v_drive_number}_vv_pwm"
  add_qsys_inst_exports_list "${v_instance_name}_c_foc_exp_data_vw_pwm"   "drive_${v_drive_number}_vw_pwm"

  add_qsys_inst_exports_list "${v_instance_name}_c_vu_pwm_export"         "drive_${v_drive_number}_vu_pwm"
  add_qsys_inst_exports_list "${v_instance_name}_c_vv_pwm_export"         "drive_${v_drive_number}_vv_pwm"
  add_qsys_inst_exports_list "${v_instance_name}_c_vw_pwm_export"         "drive_${v_drive_number}_vw_pwm"

  add_qsys_inst_exports_list "${v_instance_name}_c_adc_sync_dat_u"        "drive_${v_drive_number}_ia_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_sync_dat_v"        "drive_${v_drive_number}_ib_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_sync_dat_w"        "drive_${v_drive_number}_ic_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_Iu_reg"            "drive_${v_drive_number}_Iu_reg"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_Iw_reg"            "drive_${v_drive_number}_Iw_reg"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_overcurrent"       "drive_${v_drive_number}_overcurrent"

  add_qsys_inst_exports_list "${v_instance_name}_c_adc_pow_sync_dat_u"    "drive_${v_drive_number}_Va_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_pow_sync_dat_v"    "drive_${v_drive_number}_Vb_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_pow_sync_dat_w"    "drive_${v_drive_number}_Vc_sd"
  add_qsys_inst_exports_list "${v_instance_name}_c_adc_pow_overcurrent"   ""

  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_overcurrent"             "drive_${v_drive_number}_overcurrent"
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_overvoltage"             "1'b0"
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_undervoltage"            "1'b0"
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_chopper"                 "1'b0"
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_dc_link_clk_err"         "1'b0"
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_mosfet_err"              "1'b0"
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_error_out"               ""
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_overcurrent_latch"       ""
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_overvoltage_latch"       ""
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_undervoltage_latch"      ""
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_dc_link_clk_err_latch"   ""
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_mosfet_err_latch"        ""
  add_qsys_inst_exports_list "${v_instance_name}_c_monitor_chopper_latch"           ""

  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_encoder_strobe_n"  "drive_${v_drive_number}_enc_stb0_n"
  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_u_h"               "drive_${v_drive_number}_pwm_u_h"
  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_u_l"               "drive_${v_drive_number}_pwm_u_l"
  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_v_h"               "drive_${v_drive_number}_pwm_v_h"
  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_v_l"               "drive_${v_drive_number}_pwm_v_l"
  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_w_h"               "drive_${v_drive_number}_pwm_w_h"
  add_qsys_inst_exports_list "${v_instance_name}_c_pwm_w_l"               "drive_${v_drive_number}_pwm_w_l"

  add_qsys_inst_exports_list "${v_instance_name}_c_qep_strobe"            "~drive_${v_drive_number}_enc_stb0_n"
  add_qsys_inst_exports_list "${v_instance_name}_c_qep_QEP_A"             "drive_${v_drive_number}_qep_a"
  add_qsys_inst_exports_list "${v_instance_name}_c_qep_QEP_B"             "drive_${v_drive_number}_qep_b"
  add_qsys_inst_exports_list "${v_instance_name}_c_qep_QEP_I"             ""

  if {${v_enable_resolver} != 0} {
    add_qsys_inst_exports_list "${v_instance_name}_c_hall_pio_export"       ""

    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_ctrl_MISO"   "1'b0"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_ctrl_MOSI"   "${v_instance_name}_c_rslvr_spi_ctrl_MOSI"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_ctrl_SCLK"   "${v_instance_name}_c_rslvr_spi_ctrl_SCLK"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_ctrl_SS_n"   "${v_instance_name}_c_rslvr_spi_ctrl_SS_n"

    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_posn_MISO"   "1'b0"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_posn_MOSI"   "${v_instance_name}_c_rslvr_spi_posn_MOSI"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_posn_SCLK"   "${v_instance_name}_c_rslvr_spi_posn_SCLK"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_spi_posn_SS_n"   "${v_instance_name}_c_rslvr_spi_posn_SS_n"

    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_pio_in_port"     "${v_instance_name}_c_rslvr_pio_inout_port"
    add_qsys_inst_exports_list "${v_instance_name}_c_rslvr_pio_out_port"    "${v_instance_name}_c_rslvr_pio_inout_port"
  }

}
