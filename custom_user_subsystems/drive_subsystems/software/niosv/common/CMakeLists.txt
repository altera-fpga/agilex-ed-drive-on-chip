cmake_minimum_required(VERSION 3.14)

add_subdirectory(../build/bsp bsp)

include(../build/bsp/toolchain.cmake)

project(app)

add_executable(app.elf)

target_sources(app.elf
    PRIVATE
        demo_cfg.c
        main.c
        components/ssg_emb_dsm.c
        components/ssg_emb_pwm.c
        components/ssg_emb_sd_adc.c
        components/dspba/DF_fixp16_alu_av.c
        components/qep/qep.c
        components/qep/qep_fn.c
        components/resolver/AU6805.c
        components/resolver/AU6805_fn.c
        mc/arm_cos_q15.c
        mc/arm_sin_q15.c
        mc/mc.c
        mc/mc_debug.c
        mc/mc_debug_fn.c
        mc/mc_dsp.c
        mc/mc_nios_perf.c
        mc/motion_task.c
        mc/motor_task.c
        mc/foc/foc.c
        motorsim/motor.c
        motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL.c
        perf/altera_avalon_performance_counter.c
        perf/perf_print_formatted_report.c
        platform/common/platform.c
        platform/motors/motor_types.c
        platform/powerboard/adc.c
        platform/powerboard/doc_adc.c
        platform/powerboard/powerboard.c
        waveform/waveform.c
        os/monitor_task.c
        os/debug_print.c
)

target_include_directories(app.elf
    PRIVATE
        .
        components
        components/dspba
        components/qep
        components/resolver
        mc
        mc/foc
        motorsim
        motorsim/dspba_motorsim
        perf
        platform
        platform/common
        platform/motors
        platform/powerboard
        waveform
    PUBLIC
)

target_link_libraries(app.elf
    PRIVATE
        -T "${BspLinkerScript}" -nostdlib
        "${ExtraArchiveLibraries}"
        -Wl,--start-group "${BspLibraryName}" -lc -lstdc++ -lgcc -lm -Wl,--end-group
)

# Create objdump from ELF.
set(objdump app.elf.objdump)
add_custom_command(
    OUTPUT "${objdump}"
    DEPENDS app.elf
    COMMAND "${ToolchainObjdump}" "${ToolchainObjdumpFlags}" app.elf >
            "${objdump}"
    COMMENT "Creating ${objdump}."
    VERBATIM
)
add_custom_target(create-objdump ALL DEPENDS "${objdump}")

# Report space free for stack + heap. Note that the file below is never created
# so the report is always output on build.
set(stack_report_file app.elf.stack_report)
add_custom_command(
    OUTPUT "${stack_report_file}"
    DEPENDS app.elf
    COMMAND niosv-stack-report -p "${ToolchainPrefix}" app.elf
    COMMENT "Reporting memory available for stack + heap in app.elf."
    VERBATIM
)
add_custom_target(niosv-stack-report ALL DEPENDS "${stack_report_file}")
