/* ##################################################################################
 * Copyright (C) 2025 Altera Corporation
 *
 * This software and the related documents are Altera copyrighted materials, and
 * your use of them is governed by the express license under which they were
 * provided to you ("License"). Unless the License provides otherwise, you may
 * not use, modify, copy, publish, distribute, disclose or transmit this software
 * or the related documents without Altera's prior written permission.
 *
 * This software and the related documents are provided as is, with no express
 * or implied warranties, other than those that are expressly stated in the License.
 * ##################################################################################
 */

#include <string.h>
#include <stdio.h>

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"
#include "io.h"

#include "main.h"

#include "mc/mc.h"
#include "mc/mc_debug.h"
#include "mc/motor_task.h"
#include "platform/platform_linker.h"
#include "platform/common/platform.h"

#ifdef TCM_D_SPAN
    static waveform_t dp_waveform[LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1] __attribute__((section(".tcm_d")));
#else
    static waveform_t dp_waveform[LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1];
#endif

/**
 * @file motion_task.c
 *
 * @brief Motion demo task
 */

/*!
 * \addtogroup MOTION
 *
 * @{
 */


/**
 * @brief Timer callback function for motion task.
 *
 * Takes input from gui and forwards speed command or position set point to motor_task, with
 * demo waveform settings superimposed.
 *
 */
void motion_task_tmr_cb(void *ptmr, void *parg)
{
    static int demo_count = 0;
    static int homing = 0;
    static int seconds = 0;
    static int drive_demo_mode[LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1];
    int pos_sec;
    int pos_10;

    if (debug_waveform_demo_update_check()) {
        for (int dn = platform.first_drive; dn <= platform.last_drive; dn++) {

            waveform_input_params_t waveform;

            if (debug_waveform_demo_parameters(dn, &waveform) == 0) {
                dp_waveform[dn].count_int32 = 0;
                dp_waveform[dn].Period_int32 = waveform.period;
                dp_waveform[dn].offset_int32 = waveform.offset;
                // Convert gui input period and offset in ms to timer ticks
                dp_waveform[dn].Period_int32 =
                        dp_waveform[dn].Period_int32*OS_TMR_CFG_TICKS_PER_SEC/1000/MOTION_TMR_PERIOD;
                dp_waveform[dn].offset_int32 =
                        dp_waveform[dn].offset_int32*OS_TMR_CFG_TICKS_PER_SEC/1000/MOTION_TMR_PERIOD;
                dp_waveform[dn].HalfPeriod_int32 = dp_waveform[dn].Period_int32 / 2;
                dp_waveform[dn].QtrPeriod_int32  = dp_waveform[dn].HalfPeriod_int32 / 2;
                dp_waveform[dn].ThreeQtrPeriod_int32 =
                        dp_waveform[dn].HalfPeriod_int32 + dp_waveform[dn].QtrPeriod_int32;
                dp_waveform[dn].Shape_enum = waveform.shape;

                drive_demo_mode[dn] = waveform.mode;

                if (drive_demo_mode[dn] == 1) {
                    // Position demo
                    // Waveform amplitude, non-dimensional (to be multiplied by fullscale and units)
                    dp_waveform[dn].Amp_ND_f = waveform.cmd_wave_amp * (65536 / 360);
                    dp_waveform[dn].limit = 65536;
                } else {
                    // Waveform amplitude, non-dimensional (to be multiplied by fullscale and units)
                    dp_waveform[dn].Amp_ND_f = waveform.cmd_wave_amp;
                    dp_waveform[dn].limit = 2500;
                }
            }
        }
        debug_waveform_demo_update_clear();
    }

    for (int dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        switch (drive_demo_mode[dn]) {
        default:
            // Speed demo
            int wave_res_speed = updateWaveform(&dp_waveform[dn]);

            adjust_speed(dn, (wave_res_speed << SPEED_FRAC_BITS));
            break;

        case 1:
            // Position demo
            int wave_res_pos = updateWaveform(&dp_waveform[dn]);

            adjust_pos_setpoint(dn, wave_res_pos);
            break;

        case 2:
            // Show demo - clock wheels
            // Axis 0 moves 1/8 rotation per second to line up with the graphics attached to the motor shafts
            // Axis 1 moves 1/8 rotation each time axis 0 returns to zero position
            // When axis 1 has complete one revolution, both axes return to 0 at a higher speed.
            if (dn == platform.first_drive) {
                // Handle both axes on the same pass
                demo_count++;
                if (demo_count >= OS_TMR_CFG_TICKS_PER_SEC/4) {
                    // counts seconds
                    demo_count = 0;
                    seconds++;
                    if (homing == 0) {
                        set_speed_limit(0, 100 << SPEED_FRAC_BITS);
                        set_speed_limit(1, 100 << SPEED_FRAC_BITS);
                        demo_count = 0;
                        if (seconds > 64) {
                            // One cycle complete - return to home position
                            seconds = 0;
                            pos_sec = 0;
                            pos_10 = 0;
                            homing = 1;
                        } else {
                            // Calculate new positions based on elapsed time
                            pos_sec = seconds*65536/8;
                            pos_10 = (seconds/8)*65536/8;
                            set_pos_setpoint(0, pos_sec);
                            set_pos_setpoint(1, pos_10);
                        }
                    } else {
                        // Moving to home position
                        set_speed_limit(0, 480 << SPEED_FRAC_BITS);
                        set_speed_limit(1, 60 << SPEED_FRAC_BITS);
                        set_pos_setpoint(0, 0);
                        set_pos_setpoint(1, 0);
                        if (seconds >= 10) {
                            // Both axes should have returned to home position by now
                            seconds = 0;
                            homing = 0;
                        }
                    }
                }
            }
            break;
        }
    }
}

void motion_task_init(void)
{
    for (int dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        initWaveform(&dp_waveform[dn]);
        dp_waveform[dn].Period_int32 = 200; // Waveform period in motion_timer ticks
        dp_waveform[dn].offset_int32 = 0;
        dp_waveform[dn].limit = 65536;
    }
}

/*!
 * @}
 */
