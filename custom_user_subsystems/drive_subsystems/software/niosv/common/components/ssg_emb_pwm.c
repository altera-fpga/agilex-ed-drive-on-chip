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

/**
 * @file ssg_emb_pwm.c
 *
 * @brief PWM interface
 */

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#if defined __SSG_EMB_PWM

#include "ssg_emb_pwm.h"

#include "io.h"

#include "mc/mc_debug.h"
#include "platform/common/platform.h"

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup PWM PWM Interface
 *
 * @brief PWM module initialisation
 *
 * @{
 */
int pwm_init(drive_params *dp)
{
    if (platform.adc_sample_rate > platform.powerboard->pwm_max_freq) {
        return PWM_SAMPLE_RATE_TOO_HIGH;
    }

    // Calculate PWM counter limit from PWM module clock rate and desired adc sample rate
    platform.pwm_count = DRIVE0_DOC_PWM_FREQ/(platform.adc_sample_rate * 1000);

    pwm_setup(dp);

    return PWM_OK;
}

/*!
 * \addtogroup PWM PWM Interface
 *
 * @brief PWM module enable
 *
 * @{
 */
int pwm_enable(drive_params *dp)
{
    unsigned int dn;
    unsigned int base_address;

    for (dn = 0; dn <= platform.last_drive; dn++) {
        base_address = dp[dn].DOC_PWM_BASE_ADDR;
        IOWR_16DIRECT(base_address, PWM_CONTROL, 1);
    }
    return PWM_OK;
}

/*!
 * \addtogroup PWM PWM Interface
 *
 * @brief PWM module disable
 *
 * @{
 */
int pwm_disable(drive_params *dp)
{
    unsigned int dn;
    unsigned int base_address;

    for (dn = 0; dn <= platform.last_drive; dn++) {
        base_address = dp[dn].DOC_PWM_BASE_ADDR;
        IOWR_16DIRECT(base_address, PWM_CONTROL, 0);
    }
    return PWM_OK;
}

/*!
 * \addtogroup PWM PWM Interface
 *
 * @brief Update PWM module settings
 *
 * @{
 */
int pwm_setup(drive_params *dp)
{
    unsigned int dn;
    unsigned int base_address;
    int adc_trigger;

    // ADC trigger time
#if (SD_ADC_FILTER == ADC_D_10US)
    // Theoretically,9.6us centred around PWM max
    // 4.8us trigger offset
    // adc_trigger = (48*(DRIVE0_DOC_PWM_FREQ/1000000))/10;

    // In real design, use 2us instead of 4.8 us,
    // because in the high-speed mode (adc_sample_rate = 64 or more),
    // The Tandem board got quite large FET switching noise, by experiment, 2us will minimize
    // the switching noise during the high-speed mode.
    adc_trigger = (20*(DRIVE0_DOC_PWM_FREQ/1000000))/10;
#else
    // Theoretically, 4.8us centred around PWM max
    // 2.4us trigger offset
    // adc_trigger = (24*(DRIVE0_DOC_PWM_FREQ/1000000))/10;

    // In real design, use 2us instead of 2.4 us,
    // because in the high-speed mode (adc_sample_rate = 64 or more),
    // The Tandem board got quite large FET switching noise, by experiment, 2us will minimize
    // the switching noise during the high-speed mode.

    adc_trigger = (20*(DRIVE0_DOC_PWM_FREQ/1000000))/10;
#endif

    for (dn = 0; dn <= platform.last_drive; dn++) {
        base_address = dp[dn].DOC_PWM_BASE_ADDR;
        IOWR_16DIRECT(base_address, PWM_CONTROL, 0);

        IOWR_16DIRECT(base_address, PWM_MAX, platform.pwm_count);
#ifdef PWM_DEAD_TIME_NSEC
        //IOWR_16DIRECT(base_address, PWM_BLOCK, (PWM_DEAD_TIME_NSEC/1000)*(DRIVE0_DOC_PWM_FREQ/1000000));
        IOWR_16DIRECT(base_address, PWM_BLOCK, (PWM_DEAD_TIME_NSEC)*(DRIVE0_DOC_PWM_FREQ/1000000));
#else
        // Dead time is set to 2us
        IOWR_16DIRECT(base_address, PWM_BLOCK, 2*(DRIVE0_DOC_PWM_FREQ/1000000));
#endif
        IOWR_16DIRECT(base_address, PWM_TRIGGER_UP, (platform.pwm_count - adc_trigger));
        IOWR_16DIRECT(base_address, PWM_TRIGGER_DOWN, adc_trigger);

        // Set outputs to mid-point
        dp[dn].vu_pwm = (platform.pwm_count+1)/2-1;
        dp[dn].vv_pwm = (platform.pwm_count+1)/2-1;
        dp[dn].vw_pwm = (platform.pwm_count+1)/2-1;
        pwm_update(dp[dn].DOC_PWM_BASE_ADDR, dp[dn].vu_pwm, dp[dn].vv_pwm, dp[dn].vw_pwm, 0x7, 0x0);

        IOWR_16DIRECT(base_address, PWM_CONTROL, 1);
    }
    return PWM_OK;
}

/*!
 * \addtogroup PWM PWM Interface
 *
 * @brief Write new output requirement to PWM module
 *
 * @{
 */
void pwm_update(int base_address, unsigned short Vu_PWM, unsigned short Vv_PWM,
                unsigned short Vw_PWM, int wvu_en, int pwm_direct)
{
    //Write PWM values
    IOWR_16DIRECT(base_address, PWM_DIRECT_INTERFACE, pwm_direct);
    if (pwm_direct == 0) {
        IOWR_16DIRECT(base_address, PWM_U, Vu_PWM);
        IOWR_16DIRECT(base_address, PWM_V, Vv_PWM);
        IOWR_16DIRECT(base_address, PWM_W, Vw_PWM);
    }

    //Write Enable disables
    IOWR_16DIRECT(base_address, PWM_HALL_EN, wvu_en);

}


/*!
 * @}
 */

/*!
 * @}
 */

#endif    // defined __SSG_EMB_PWM
