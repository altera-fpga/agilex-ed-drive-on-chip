/* ##################################################################################
 * Copyright (C) 2025 Intel Corporation
 *
 * This software and the related documents are Intel copyrighted materials, and
 * your use of them is governed by the express license under which they were
 * provided to you ("License"). Unless the License provides otherwise, you may
 * not use, modify, copy, publish, distribute, disclose or transmit this software
 * or the related documents without Intel's prior written permission.
 *
 * This software and the related documents are provided as is, with no express
 * or implied warranties, other than those that are expressly stated in the License.
 * ##################################################################################
 */

#include "platform.h"

#include <string.h>

#include "io.h"

#include "demo_cfg.h"
#include "components/qep/qep.h"
#include "components/resolver/AU6805.h"
#include "mc/mc_debug.h"
#include "platform/motors/motor_types.h"
#include "platform/powerboard/powerboard.h"

#include "app_cfg.h"

#include "system.h"
#include "system_shim.h"

platform_t platform;

/**
 * @file platform.c
 *
 * @brief Platform abstraction layer
 */

#define TANDEM_MOTORS (MOTOR_TYPE_TAMAGAWA_RESOLVER)
#define TANDEM_FAMILIES (1<<SYSID_CVSX | 1<<SYSID_MAX10M50 | 1<<SYSID_CVSX_SOCKIT |\
                         1<<SYSID_CVSX_NIOS | 1<<SYSID_MOTOR_MODEL | 1<<SYSID_SAFE_MOTOR_MODEL)

/*!
 * \addtogroup PLATFORM
 *
 * @{
 */

/**
 * Initialise the supported families for this demo
 */
static const device_family_t supported_families[] = {
    {SYSID_MAX10M50,         "MAX 10M50 Dev Kit"               },
    {SYSID_MOTOR_MODEL,      "Motor Model"                     },
    {SYSID_SAFE_MOTOR_MODEL, "Motor Model with Safety Function"},
    {SYSID_CVSX,             "Cyclone V SX Dev Kit"            },
    {SYSID_CVSX_NIOS,        "Cyclone V SX Dev Kit (NIOSII)"   }
};

/*
 * Initialise the supported powerboards for this demo
 *
 * DC input voltage limit for SYSID_PB_LOW_VOLTAGE is set much higher than
 * would be seen form power brick, to cover the battery voltage.
 * This can result in overvoltage conditions due to regeneration not being
 * detected when the power brick is connected, causing the power
 * brick to shutdown resulting in an undervoltage error being reported.
 */
static const powerboard_t supported_powerboards[] = {
    // sysid,                   name,                            axes,
    {SYSID_PB_LOW_VOLTAGE, "Intel Tandem Motion Power     ", (LAST_MULTI_AXIS - FIRST_MULTI_AXIS+1),
    //first_axis,       Last_axis,       motors,        req_families,
    FIRST_MULTI_AXIS, LAST_MULTI_AXIS, TANDEM_MOTORS, TANDEM_FAMILIES,
    // undervoltage, overvoltage, overcurrent, dc_in_undervoltage, dc_in_overvoltage, dc_in_overcurrent, pwm_max_freq
    10, 50, 18, 10, 17, 18, 32}
};

/*
 * Determine what hardware we are running on based on the FPGA SYSID component.
 */
int decode_sysid(unsigned int sysid_base_addr)
{
    int sys_id_errors = 0;
    int i;
    int encoder_select = 0;

    int device_family_bit = 0;

    memset(&platform, 0, sizeof(platform_t));

    // Set default sample rate
    platform.isr_sample_rate = 16;
    platform.adc_sample_rate = 16;

    // Set default commutation
    platform.commutation = FOC_SENSOR;
    debug_printf(DBG_ALWAYS, "[DECODE SYSID] Commutation mode : %d\n", platform.commutation);

    int sys_id = IORD_32DIRECT(sysid_base_addr, 0);

    debug_printf(DBG_DEBUG,  "[DECODE SYSID] Decoding hardware platform from QSYS SYSID data : 0x%08X\n", sys_id);
    debug_printf(DBG_DEBUG,  "[DECODE SYSID] SYSID_VERSION_MAJOR : 0x%02X\n", SYSID_VERSION_MAJOR(sys_id));
    debug_printf(DBG_DEBUG,  "[DECODE SYSID] SYSID_VERSION_MINOR : 0x%02X\n", SYSID_VERSION_MINOR(sys_id));
    debug_printf(DBG_DEBUG,  "[DECODE SYSID] SYSID_POWERBOARD_ID : 0x%02X\n", SYSID_POWERBOARD_ID(sys_id));
    debug_printf(DBG_DEBUG,  "[DECODE SYSID] SYSID_DEVICE_FAMILY : 0x%02X\n", SYSID_DEVICE_FAMILY(sys_id));
    debug_printf(DBG_DEBUG,  "[DECODE SYSID] SYSID_DESIGN_ID     : 0x%02X\n", SYSID_DESIGN_ID(sys_id));

    platform.version_major = SYSID_VERSION_MAJOR(sys_id);
    platform.version_minor = SYSID_VERSION_MINOR(sys_id);
    debug_printf(DBG_ALWAYS, "[DECODE SYSID] Hardware design version: %d.%d\n",
                platform.version_major, platform.version_minor);
    if ((platform.version_major != ACDS_MAJOR_VERSION) || (platform.version_minor != ACDS_MINOR_VERSION)) {
        debug_printf(DBG_FATAL, "[DECODE SYSID] ERROR: Expected version: %d.%d\n",
                ACDS_MAJOR_VERSION, ACDS_MINOR_VERSION);
        sys_id_errors++;
    }

    platform.design_id = SYSID_DESIGN_ID(sys_id);
    if (platform.design_id != 0xFE) {
        //design_id magic number should = 0xFE
        debug_printf(DBG_FATAL,
            "[DECODE SYSID] ERROR: Expected 0xFE in lower byte of SYSID data but received 0x%02X-check FPGA IMAGE!!\n",
            platform.design_id);
        sys_id_errors++;
    }

    // Decode the device family
    platform.device_family = NULL;
    for (i = 0; i < sizeof(supported_families)/sizeof(device_family_t); i++) {
        if (supported_families[i].sysid == SYSID_DEVICE_FAMILY(sys_id)) {
            platform.device_family = (device_family_t *)&supported_families[i];
            device_family_bit = 1<<SYSID_DEVICE_FAMILY(sys_id);
        }
    }
    if (platform.device_family == NULL) {
        sys_id_errors++;
        debug_printf(DBG_FATAL, "[DECODE SYSID] ERROR: Unsupported device family\n");
    } else {
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] FPGA Board     : %s\n", platform.device_family->name);
    }

    // Decode the powerboard type
    platform.powerboard = NULL;
    for (i = 0; i < sizeof(supported_powerboards)/sizeof(powerboard_t); i++) {
        if (supported_powerboards[i].sysid == SYSID_POWERBOARD_ID(sys_id)) {
            platform.powerboard = (powerboard_t *)&supported_powerboards[i];
        }
    }
    if (platform.powerboard == NULL) {
        sys_id_errors++;
        debug_printf(DBG_FATAL, "[DECODE SYSID] ERROR: Unsupported Power board\n");
        //Infinite loop with delay is used to stop the system.
        while (1) {
            OS_SLEEP_MS(1000);
        }
    } else {
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] Power Board    : %s\n", platform.powerboard->name);


        // Check that the device family and powerboard combination is supported
        if ((platform.powerboard->req_family && device_family_bit) == 0) {
            sys_id_errors++;
            debug_printf(DBG_FATAL,
                "[DECODE SYSID] ERROR: Device family from SYSID does not \
                match device family required for power board\n");
        }

        // Check that the powerboard and commutation combination is supported
        if ((platform.commutation != FOC_SENSOR) && (platform.powerboard->sysid != SYSID_PB_LOW_VOLTAGE)) {
            sys_id_errors++;
            debug_printf(DBG_FATAL, "[DECODE SYSID] ERROR: Commutation method not supported on this power board\n");
        }

        if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
            // Set default sample rate for Tandem board
            platform.isr_sample_rate = 32;
            platform.adc_sample_rate = 32;
        }

        powerboard_init();

        // Check the number of axes against the powerboard
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] Power board has %d axes available\n", platform.powerboard->axes);
        if ((platform.powerboard->first_axis <= (platform.powerboard->axes - 1))
                && (platform.powerboard->last_axis <= (platform.powerboard->axes - 1))
                && (platform.powerboard->first_axis <= platform.powerboard->last_axis)
                && ((platform.powerboard->last_axis - platform.powerboard->first_axis) <=
                (platform.powerboard->axes - 1))) {
            for (i = 0; i < platform.powerboard->axes; i++) {
                debug_printf(DBG_ALWAYS, "[DECODE SYSID] Axis %d         : %s\n",
                        i, (platform.powerboard->first_axis <= i) &&
                        (i <= platform.powerboard->last_axis) ? "Enabled" : "Disabled");
            }
            platform.first_drive = platform.powerboard->first_axis;
            platform.last_drive = platform.powerboard->last_axis;
        } else {
            sys_id_errors++;
            debug_printf(DBG_FATAL, "[DECODE SYSID] ERROR: Invalid axis selection\n");
        }

        // Check the number of motor declared
        if ((platform.last_drive - platform.first_drive + 1) <= sizeof(motors)/sizeof(motor_t *)) {
            // Check that the motor types are supported on the power board
            for (i = 0; i <= (platform.last_drive - platform.first_drive); i++) {
                if ((motors[i]->motor_type & platform.powerboard->motors) == 0) {
                    sys_id_errors++;
                    debug_printf(DBG_FATAL, "[DECODE SYSID] ERROR: Motor type: %s not supported by powerboard %s\n",
                            motors[i]->motor_name, platform.powerboard->name);
                } else {
                    debug_printf(DBG_ALWAYS, "[DECODE SYSID] Motor type: %s on axis: %d\n",
                            motors[i]->motor_name, i + platform.first_drive);
                    encoder_select |= (motors[i]->encoder_type)<<(3*i);
                }
            }
        } else {
            sys_id_errors++;
            debug_printf(DBG_FATAL,
                "[DECODE SYSID] ERROR: The motors[] array, length: %d is too short for number of axes: %d\n",
                sizeof(motors)/sizeof(motor_t *), (LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1));
        }
    }

    // Test HSMC_PRSNT signal (inverted from HSMC_PRSNTn in top-level HDL)
    #if (defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE))
        platform.powerboard_present = 1;
    #else
        platform.powerboard_present = (IORD_32DIRECT(IO_IN_BUTTONS_BASE, 0) & HSMC_PRSNTN_MASK) >> HSMC_PRSNTN_SHFT;
    #endif
    if (platform.powerboard_present) {
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] Power board is present\n");
        // Select the correct encoder I/O for each axis
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] Encoder select vector: %8X\n", encoder_select);
        // The encoder is disabled
        // IOWR_32DIRECT(ENCODER_SELECT_BASE, 0, encoder_select);
    } else {
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] Power board is not present\n");
        debug_printf(DBG_ALWAYS, "[DECODE SYSID] Application will run in test mode\n");
    }

    if (sys_id_errors > 0) {
        debug_printf(DBG_FATAL,
            "[DECODE SYSID] ERROR: Unexpected data detected in SYS_ID -\
            check FPGA IMAGE and software configuration!!\n");
    } else {
        debug_printf(DBG_DEBUG, "[DECODE SYSID] SYS_ID data successfully decoded\n");
    }

#ifdef ALT_SYSTEM_MAJOR_VERSION
#ifdef ALT_SYSTEM_MINOR_VERSION
        if ((platform.version_major != ALT_SYSTEM_MAJOR_VERSION) ||
            (platform.version_minor != ALT_SYSTEM_MINOR_VERSION)) {
            debug_printf(DBG_ALWAYS,
                "[DECODE SYSID] WARNING: Software version mismatch: \
                 Software version = %d.%d   SYS_ID Hardware version = %d.%d\n",
                ALT_SYSTEM_MAJOR_VERSION, ALT_SYSTEM_MINOR_VERSION, platform.version_major, platform.version_minor);
        }
#endif
#endif

    if (sys_id_errors > 0) {
        debug_printf(DBG_FATAL,
            "[DECODE SYSID] ERRORS DETECTED:\
            Fix ERROR messages above before continuing. Program stopped!\n\n");
    }
    return sys_id_errors;
}

/*!
 * @}
 */
