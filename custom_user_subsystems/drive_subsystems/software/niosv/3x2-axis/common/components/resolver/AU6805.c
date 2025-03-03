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

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#if (defined DRIVE0_DOC_RSLVR_PIO_BASE) || (defined DRIVE1_DOC_RSLVR_PIO_BASE)

#include "AU6805.h"

#include "altera_avalon_spi.h"
#include "altera_avalon_spi_regs.h"
#include "io.h"

#include "demo_cfg.h"
#include "components/encoder_priv.h"
#include "components/ssg_emb_dsm.h"
#include "components/ssg_emb_pwm.h"
#include "components/qep/qep.h"
#include "mc/mc.h"
#include "mc/mc_debug.h"
#include "platform/common/platform.h"
#include "platform/motors/motor_types.h"
#include "platform/powerboard/doc_adc.h"

#include "app_cfg.h"


static encoder_priv_struct encoders[LAST_MULTI_AXIS - FIRST_MULTI_AXIS + 1];

/**
 * @file AU6805.c
 *
 * @brief Source file for Tamagawa resolver encoder SPI interface
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup RESOLVER
 *
 * @{
 */

/** @name Encoder Maximum count
 *
 * Set this define to the post-quadrature maximum count for quadrature encoders. Defined as a
 * macro to simplify and speed up the maths.
 *
 * The Tamagawa resolver is a 2x resolver with two cycles per motor revolution. To compensate
 * for this in the qep equivalent output, use 2x the pulses per revolution for  the maximum
 * count.
 *
 * @{
 */
#define ENCODER_MAX_COUNT (4096*2)
/*!
 * @}
 */

/**
 * @brief Reset the Resolver interface
 *
 * Leaves the interface ion absolute position output mode
 *
 * @param dp    Pointer to drive_params structure
 */
void au6805_Reset(drive_params *dp)
{
    // Set system reset mode
    au6805_Write(dp, (AU6805_BIST_MODE_RESET<<AU6805_SET_BIST_MODE_OFST)
                     | (AU6805_OUTPUT_MODE_PULSE<<AU6805_SET_OUTPUT_MODE_OFST)
                     | (AU6805_SERIAL_OUTPUT_MODE_ANGLE<<AU6805_SET_SERIAL_OUTPUT_MODE_OFST));
    OS_SLEEP_MS(50);

    // Clear reset
    au6805_Write(dp, (AU6805_OUTPUT_MODE_PULSE<<AU6805_SET_OUTPUT_MODE_OFST)
                     | (AU6805_SERIAL_OUTPUT_MODE_ANGLE<<AU6805_SET_SERIAL_OUTPUT_MODE_OFST));
}

/**
 * @brief Application specific initialisation of resolver interface
 *
 * @param dp    Pointer to drive_params structure
 */
int au6805_Init(drive_params *dp)
{

    // Reset the encoder
    au6805_Reset(dp);

    // Clear errors warnings
    au6805_Clear_Errors(dp);

    // Get sensor data
    au6805_Read_Sensor(dp);

    // Setup QEP maximum count and direction for encoder equivalent output from the resolver interface
    qep_Write(dp->DOC_QEP_BASE_ADDR, QEP_MAX_COUNT_REG, ENCODER_MAX_COUNT-1);
    qep_Write(dp->DOC_QEP_BASE_ADDR, QEP_CONTROL_REG, (dp->motor->dir&1)<<QEP_CONTROL_DIRECTION_OFST);

    return dp->phi_mech;
}

/**
 * @brief Write to the AU6805 Control register
 *
 * The AU6805 has two separate SPI slaves with a common clock but incompatible
 * clock polarity modes so we use two Nios SPI peripherals. For the control
 * register we have a connection on the MOSI pin only.
 *
 * The AU6805 has only one writeable register and there is no address to be
 * shifted out first. We send the data over the MOSI pin and the unconnected
 * MISO pin.
 *
 * @param dp    Pointer to drive_params structure
 * @param data    Data to be written to AU6805 serial output
 */
void au6805_Write(drive_params *dp, unsigned short data)
{
    unsigned short status;
    unsigned int base_addr = dp->DOC_RSLVR_SPI_CTRL_BASE_ADDR;

    // Setup SS output
    IOWR_ALTERA_AVALON_SPI_SLAVE_SEL(base_addr, 1);

    // Wait for Tx ready then send the command
    do {
      status = IORD_ALTERA_AVALON_SPI_STATUS(base_addr);
    } while ((status & ALTERA_AVALON_SPI_STATUS_TRDY_MSK) == 0);
    IOWR_ALTERA_AVALON_SPI_TXDATA(base_addr, data);

    // Wait for Tx done
    do {
      status = IORD_ALTERA_AVALON_SPI_STATUS(base_addr);
    } while ((status & ALTERA_AVALON_SPI_STATUS_TMT_MSK) == 0);
}

/**
 * @brief Read the AU6805 Resolver serial output register
 *
 * The AU6805 has two separate SPI slaves with a common clock but incompatible
 * clock polarity modes so we use two Nios SPI peripherals. For the serial
 * output register we have a connection on the MISO pin only.
 *
 * The AU6805 has only one readable reg and there is no address to be shifted
 * out first. We must send something over the unconnected MOSI pin and capture
 * the read data on the MISO pin. Parity bits are not checked.
 *
 * @param dp Pointer to drive_params structure
 *
 * @return Serial output data from the AU6805
 */
unsigned short au6805_Read(drive_params *dp)
{
    unsigned short status;
    unsigned short data;
    unsigned int base_addr = dp->DOC_RSLVR_SPI_POSN_BASE_ADDR;

    // Setup SS output
    IOWR_ALTERA_AVALON_SPI_SLAVE_SEL(base_addr, 1);

    // Wait for Tx ready then send the command
    do {
      status = IORD_ALTERA_AVALON_SPI_STATUS(base_addr);
    } while ((status & ALTERA_AVALON_SPI_STATUS_TRDY_MSK) == 0);
    // Send dummy data
    IOWR_ALTERA_AVALON_SPI_TXDATA(base_addr, 0);

    // Wait for Tx done
    do {
      status = IORD_ALTERA_AVALON_SPI_STATUS(base_addr);
    } while ((status & ALTERA_AVALON_SPI_STATUS_TMT_MSK) == 0);

    // Return the data that was shifted in whilst we were sending
    data = IORD_ALTERA_AVALON_SPI_RXDATA(base_addr);
    return data;
}

/**
 * @brief Read AU6805 Resolver interface errors and save in application specific way
 *
 * Serial output must be in Pulse Output mode Setting[01]
 *
 * @param dp Pointer to drive_params structure
 */
void au6805_Read_Errors(drive_params *dp)
{
    encoders[dp->drive].sensor_error_bits =
        (au6805_Read(dp) & AU6805_OUTPUT_PULSE_ERR_MSK)>>AU6805_OUTPUT_PULSE_ERR_OFST;
}

/**
 * @brief Clear AU6805 Resolver interface errors in application specific way
 *
 * @param dp    Pointer to drive_params structure
 */
void au6805_Clear_Errors(drive_params *dp)
{
    unsigned int base_addr = dp->DOC_RSLVR_PIO_BASE_ADDR;

    // Toggle ERRSTB output
    IOWR_32DIRECT(base_addr, 0, 1);
    OS_SLEEP_MS(1);
    IOWR_32DIRECT(base_addr, 0, 0);

}

/**
 * @brief Read sensor data
 *
 * Nothing to read from the resolver, so hard code values
 *
 * @param dp    Pointer to drive_params structure
 */
void au6805_Read_Sensor(drive_params *dp)
{
    encoders[dp->drive].encoder_multiturn_bits = 0;

    encoders[dp->drive].encoder_length = 12;
    encoders[dp->drive].encoder_multiturn = 0;
    encoders[dp->drive].encoder_version = 0;
    dp->encoder.mphase = 0;

    encoders[dp->drive].encoder_mask = (1<<(encoders[dp->drive].encoder_length)) - 1;
    encoders[dp->drive].encoder_turns_mask = 0;
    encoders[dp->drive].encoder_singleturn_bits = encoders[dp->drive].encoder_length;

    // For Resolver with low resolution we use an averaging filter
    encoders[dp->drive].encoder_speed_acc = 0;
    encoders[dp->drive].encoder_speed_ave = 0;
    encoders[dp->drive].encoder_filter_length = 4;
}

/**
 * @brief AU6805 Resolver absolute position read
 *
 * Called once at start up to get initial position
 *
 * @param dp    Pointer to drive_params structure
 */
void au6805_Read_Absolute_Position(drive_params *dp)
{
    dp->encoder.raw = au6805_Read(dp) & 0xFFF;

    encoders[dp->drive].encoder_turns = 0;

    // Create 23 bit normalised position data, masking the data bits
    dp->encoder.enc_data = (dp->encoder.raw * ((8388608<<7)/ENCODER_MAX_COUNT)>>7);
    dp->encoder.turns_delta = 0;
    encoders[dp->drive].encoder_data_prev = dp->encoder.enc_data;

    dp->encoder.speed_encoder = 0;

    dp->phi_mech = (dp->encoder.enc_data >> (23 - 16)) & 0xffff;
    dp->phi_elec = (dp->motor->pole_pairs*(unsigned int)dp->phi_mech + dp->encoder.mphase) & 0xffff;
}

/**
 * @brief AU6805 Resolver position read
 *
 * During normal operation we use the equivalent pulse output mode and read the 12-bit
 * position via the QEP interface
 *
 * @param dp    Pointer to drive_params structure
 * @param sp    Pointer to system_params structure
 */
void au6805_Read_Position(drive_params *dp, system_params *sp)
{
    int delta_phi;

    dp->encoder.raw = qep_Read(dp->DOC_QEP_BASE_ADDR, QEP_COUNT_CAPTURE_REG);

    // Create 23 bit normalised position data, masking the data bits
    // 8388608 = 2^23(24 bits) ENCODER_MAX_COUNT = 4096*2 =2^13(14 bits)
    // (((8388608<<7)/ENCODER_MAX_COUNT)>>7) = 1024 = 2^10(11 bits)
    // By looking at data sheet for AU6805. encoder.raw is 12 bits.
    // encoder.enc_data = 23 bits.
    dp->encoder.enc_data = (dp->encoder.raw * ((8388608<<7)/ENCODER_MAX_COUNT)>>7);
    delta_phi = dp->encoder.enc_data - encoders[dp->drive].encoder_data_prev;
    if (delta_phi > 0x3fffff) {
        delta_phi -= 0x7fffff;
        dp->encoder.turns_delta = -1;
    } else if (delta_phi < -0x3fffff) {
        delta_phi += 0x7fffff;
        dp->encoder.turns_delta = + 1;
    } else {
        dp->encoder.turns_delta = 0;
    }
    encoders[dp->drive].encoder_data_prev = dp->encoder.enc_data;

    if (sp->app_state != APP_ENCODER_RESET) {
        // Position difference is 23 bits representing one turn.
        // v = (phi1 - phi0)/2^^23/(t1 - t0)
        // Result in rpm, so v = (phi1 - phi0)/2^^23/(t1 - t0)*60
        // ==>v = delta_phi*k ==> v = delta_phi*(1/8388608)*isr sample rate (kHz)*1000 * 60
        // ==>v = delta_phi*0.007153*isr sample rate
        // Actual calculation is adjusted to introduce some fractional bits
        // biggest sample rate 32 = 2^5
        // if isr sample rate = 16, encoder.speed_encoder = delta_phi* 117*16/(2^10)
        // encoder.speed_encoder =  delta_phi* 2^4/(2^10) = delta_phi/(2^6)
        // if isr sample rate = 32, encoder.speed_encoder = delta_phi/(2^5)

        dp->encoder.speed_encoder = (117*delta_phi*platform.isr_sample_rate)>>(14-SPEED_FRAC_BITS);

        // Speed observer
        // SpeedEst[k+1] = p*RawSpeedEstFromEdgesInTimestep[k+1] + (1-p)*SpeedEst[k]
        //
        // In theory, p=(Timestep/Filter time constant)
        // The Timestep at 16kHz is 1/16000 and the motor electrical and mechanical times constants are around 4ms from:
        // Tamagawa data sheet
        //
        // Hence we can set p=1/64 without losing any speed detail in theory,
        // and even setting it much lower like 1/256 is
        // probably still fine if it makes the signal cleaner.
        // When we run at higher update frequencies, p should be scaled down accordingly.
        // Initially set p = 1 and scale everything by 64 (2^6)
        encoders[dp->drive].encoder_speed_ave =
                (1*dp->encoder.speed_encoder + (64-1)*encoders[+dp->drive].encoder_speed_ave)/64;

        dp->encoder.speed_encoder = encoders[dp->drive].encoder_speed_ave;

        dp->phi_mech = (dp->encoder.enc_data >> 7) & 0xffff;

        dp->phi_elec = (dp->motor->pole_pairs*(unsigned int)dp->phi_mech + dp->encoder.mphase) & 0xffff;
    }
}

/**
 * @brief AU6805 Resolver encoder offset calibration
 *
 * @param dp    Pointer to drive_params structure
 * @param sp    Pointer to system_params structure
 */
void au6805_Service(drive_params *dp, system_params *sp)
{
    unsigned short pwm = 0;

    // Set PWM to midpoint
    dp->vu_pwm = platform.pwm_count/2;
    dp->vv_pwm = platform.pwm_count/2;
    dp->vw_pwm = platform.pwm_count/2;
    pwm_update(dp->DOC_PWM_BASE_ADDR, dp->vu_pwm, dp->vv_pwm, dp->vw_pwm, 0x7, 0x0);

    adc_overcurrent_enable(dp, 1);
    //TODO: if ever we default to MAX10 ADC then we must enable threshold error detection here
    IOWR_16DIRECT(dp->DOC_SM_BASE_ADDR, SM_CONTROL, DSM_CONTROL_TO_PRECHARGE);
    debug_printf(DBG_DEBUG, "---> STATE %i of Motor\n",
            IORD_16DIRECT(dp->DOC_SM_BASE_ADDR, SM_STATUS) >> DSM_STATUS_STATE_OFFSET);
    OS_SLEEP_MS(50);

    IOWR_16DIRECT(dp->DOC_SM_BASE_ADDR, SM_CONTROL, DSM_CONTROL_TO_PRERUN);
    debug_printf(DBG_DEBUG, "---> STATE %i of Motor\n",
            IORD_16DIRECT(dp->DOC_SM_BASE_ADDR, SM_STATUS) >> DSM_STATUS_STATE_OFFSET);
    OS_SLEEP_MS(50);

    dp->enable_drive = 1;

    IOWR_16DIRECT(dp->DOC_SM_BASE_ADDR, SM_CONTROL, DSM_CONTROL_TO_RUN);
    debug_printf(DBG_DEBUG, "---> STATE %i of Motor ( Motor ON )\n",
            IORD_16DIRECT(dp->DOC_SM_BASE_ADDR, SM_STATUS) >> DSM_STATUS_STATE_OFFSET);
    OS_SLEEP_MS(50);

    // Drive a fixed PWM value
    pwm = (unsigned short)((dp->motor->calibration_v*(long long int)platform.pwm_count)/
                        (long long int)sp->dc_dc_v_scaled);
    dp->vu_pwm = platform.pwm_count/2 + pwm;
    dp->vv_pwm = platform.pwm_count/2 - pwm;
    dp->vw_pwm = platform.pwm_count/2 - pwm;
    pwm_update(dp->DOC_PWM_BASE_ADDR, dp->vu_pwm, dp->vv_pwm, dp->vw_pwm, 0x7, 0x0);

    OS_SLEEP_MS(100);

    sp->app_state = APP_ENCODER_RESET;
    OS_SLEEP_MS(50);

    // Force encoder count to 0 and set offset to 1/4 turn
    qep_Write(dp->DOC_QEP_BASE_ADDR, QEP_COUNT_REG, 0);
    OS_SLEEP_MS(100);
    dp->encoder.turns_delta = 0;
    dp->pos_16q16 = 0;
    dp->pos_16q16_avg = 0;
    dp->pos_turns = 0;
    dp->encoder.mphase = 0x0;

    // Reset PWM to idle value and disable
    dp->vu_pwm = platform.pwm_count/2;
    dp->vv_pwm = platform.pwm_count/2;
    dp->vw_pwm = platform.pwm_count/2;
    pwm_update(dp->DOC_PWM_BASE_ADDR, dp->vu_pwm, dp->vv_pwm, dp->vw_pwm, 0x7, 0x0);

    dp->enable_drive  = 0;

    adc_overcurrent_enable(dp, 0);
    dsm_init(dp->DOC_SM_BASE_ADDR);
    debug_printf(DBG_INFO, "QEP initialised to: %d\n", qep_Read(dp->DOC_QEP_BASE_ADDR, QEP_COUNT_REG));

    debug_printf(DBG_INFO, "---> ------------------------------------\n");
    debug_printf(DBG_INFO, "---> <Control value of phi 16 bit>\n");
    debug_printf(DBG_INFO, "---> mphase             : %X\n", (unsigned short)dp->encoder.mphase);
    debug_printf(DBG_INFO, "---> ------------------------------------\n");
}

/*!
 * @}
 */

/*!
 * @}
 */

#endif
