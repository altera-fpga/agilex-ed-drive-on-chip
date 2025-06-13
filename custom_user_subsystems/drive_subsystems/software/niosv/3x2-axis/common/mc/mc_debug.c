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

/**
 * @file mc_debug.c
 *
 * @brief Interface functions for system console debug GUI
 */

#include "mc_debug.h"

#include <stdio.h>

#include "io.h"
#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#include "mc/mc_params.h"
#include "mc/mc.h"
#include "mc/motor_task.h"
#include "mc/mc_nios_perf.h"
#include "platform/common/platform.h"

#include "main.h"
#include "app_cfg.h"

/**
 * (Re-)initialize the gui at startup or after error or mode change.
 *
 */
void write_to_gui(void)
{
    drive_params *dp = get_dp();
    system_params *sp = get_sp();
    int dn;

    if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
        debug_write_status(0, DOC_DBG_ADC_TYPE, DEFAULT_ADC_TYPE);
    }

    debug_write_status(0, DOC_DBG_DEMO_MODE, sp->demo_mode);
    debug_write_status(0, DOC_DBG_ADC_TYPE, sp->lvmc_adc_type);
    debug_write_status(0, DOC_DBG_BUTTON_DSP_MODE, sp->dsp_mode);

    // Leave this as 0 to platform.last_drive for debug interface
    for (dn = 0; dn <= platform.last_drive; dn++) {
        debug_write_status(dn, DOC_DBG_I_PI_KP, dp[dn].motor->iq_kp);
        debug_write_status(dn, DOC_DBG_I_PI_KI, dp[dn].motor->iq_ki);
        debug_write_status(dn, DOC_DBG_SPEED_PI_KP, dp[dn].motor->speed_kp);
        debug_write_status(dn, DOC_DBG_SPEED_PI_KI, dp[dn].motor->speed_ki);

        debug_write_status(dn, DOC_DBG_SPEED_SETP0, dp[dn].speed_request>>SPEED_FRAC_BITS);
        debug_write_status(dn, DOC_DBG_AXIS_SELECT, 0);

        debug_write_status(dn, DOC_DBG_POS_SETP0, dp[dn].pos_request);
        debug_write_status(dn, DOC_DBG_WAVE_DEMO_MODE, dp[dn].pos_speed_demo_mode);
        debug_write_status(dn, DOC_DBG_POS_SPEED_LIMIT, dp[dn].pos_speed_limit>>SPEED_FRAC_BITS);
        debug_write_status(dn, DOC_DBG_POS_PI_KP, dp[dn].motor->pos_kp);
    }
}

/**
 * Update parameters from the gui.
 */
void read_from_gui(void)
{
    drive_params *dp = get_dp();
    system_params *sp = get_sp();
    int dn;

    sp->axis_select = debug_read_command(0, DOC_DBG_AXIS_SELECT);
    if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
        sp->dc_dc_cmd_v = debug_read_command(0, DOC_DBG_DCDC_V_SETP0);
    }

    for (dn = 0; dn <= platform.last_drive; dn++) {

        dp[dn].motor->id_kp = debug_read_command(dn, DOC_DBG_I_PI_KP);
        dp[dn].motor->id_ki = debug_read_command(dn, DOC_DBG_I_PI_KI);
        dp[dn].motor->iq_kp = debug_read_command(dn, DOC_DBG_I_PI_KP);
        dp[dn].motor->iq_ki = debug_read_command(dn, DOC_DBG_I_PI_KI);
        dp[dn].motor->speed_kp = debug_read_command(dn, DOC_DBG_SPEED_PI_KP);
        dp[dn].motor->speed_ki = debug_read_command(dn, DOC_DBG_SPEED_PI_KI);

        dp[dn].speed_request = debug_read_command(dn, DOC_DBG_SPEED_SETP0) << SPEED_FRAC_BITS;

        int temp_pos_mode = debug_read_command(dn, DOC_DBG_WAVE_DEMO_MODE);

        if (temp_pos_mode != dp[dn].pos_speed_demo_mode) {
            //Reset the multi-turn position when switching to/from position mode
            dp[dn].pos_turns = 0;
        }
        dp[dn].pos_speed_demo_mode = temp_pos_mode;
        if (dp[dn].pos_speed_demo_mode != 2) {
            // don't update the speed limit in clock demo mode as it is controlled by the demo code
            dp[dn].pos_speed_limit = debug_read_command(dn, DOC_DBG_POS_SPEED_LIMIT) << SPEED_FRAC_BITS;
        }
        dp[dn].motor->pos_kp = debug_read_command(dn, DOC_DBG_POS_PI_KP);

    }
}

/*!
 * \addtogroup DEBUG_MSG Debug Message Handling
 *
 * Mechanism to handle debug output to console
 *
 * @{
 */
/*
 * Initialise the debug buffers and debug output filter
 */
void init_debug_output(void)
{
    int i;

    char *debug_ptr = (char *)SYS_CONSOLE_DEBUG_RAM_BASE;

    for (i = 0; i < SYS_CONSOLE_DEBUG_RAM_SIZE_VALUE; i++) {
        *debug_ptr = 0;
        debug_ptr++;
    }
}

/**
 * @brief Wait for console input without blocking RTOS thread
 *
 */
char debug_waitchar(int level, char *str, int en)
{
    if (en) {
        debug_printf(level, str);
        while (feof(stdin)) {
            OS_SLEEP_MS(100);
        }

        int result_debug_waitchar = getc(stdin);

        if (result_debug_waitchar == 0) {
            debug_printf(DBG_ALWAYS, "Interaction with user failed");
            return 0;
        } else {
            return result_debug_waitchar;
        }
    } else {
        return 0;
    }
}


void debug_set_latency(int latency1, int latency2)
{
    debug_write_status(0, DOC_DBG_LATENCY1, latency1);
    debug_write_status(0, DOC_DBG_LATENCY2, latency2);
}

void debug_update_drive_params(int dn, drive_params *dp)
{
    if (dn >= FIRST_MULTI_AXIS && dn <= LAST_MULTI_AXIS) {
        debug_write_status(dn, DOC_DBG_DRIVE_STATE, dp->state_act);
        debug_write_status(dn, DOC_DBG_SPEED, dp->encoder.speed_encoder >> SPEED_FRAC_BITS);
        dp->pos_16q16_avg = (1*dp->pos_16q16 + (64-1)*dp->pos_16q16_avg)/64;
        debug_write_status(dn, DOC_DBG_POSITION, dp->pos_16q16_avg);
    }
}

void debug_update_sys_params(app_state_e app_state, calc_type_e dsp_mode, short dc_dc_v_fb)
{
    debug_write_status(0, DOC_DBG_APP_STATE, app_state);
    debug_write_status(0, DOC_DBG_RUNTIME, OS_TIME_SEC());
    debug_write_status(0, DOC_DBG_DSP_MODE, dsp_mode);
    debug_write_status(0, DOC_DBG_DC_DC_V_LINK, dc_dc_v_fb);
}

int debug_read_reset(void)
{
    int reset = debug_read_command(0, DOC_DBG_BUTTON_DRIVE_RESET);

    if (reset) {
        debug_write_status(0, DOC_DBG_BUTTON_DRIVE_RESET, 0);
    }
    return reset;
}

demo_mode_e debug_read_demo_mode(void)
{
    return (demo_mode_e)debug_read_command(0, DOC_DBG_DEMO_MODE);
}

int debug_read_adc_type(void)
{
    return (int)debug_read_command(0, DOC_DBG_ADC_TYPE);
}

calc_type_e debug_read_dsp_mode(void)
{
   return (calc_type_e)debug_read_command(0, DOC_DBG_BUTTON_DSP_MODE);
}

void debug_update_dc_dc_setp(short setp)
{
    debug_write_status(0, DOC_DBG_DCDC_V_SETP0, setp);
}

void debug_update_drive_status(int drive_index, int new_status)
{
    if (drive_index >= FIRST_MULTI_AXIS && drive_index <= LAST_MULTI_AXIS) {
        debug_write_status(drive_index, DOC_DBG_DRIVE_STATE, new_status);
    }
}

/*!
 * @}
 */

/*!
 * @}
 */
