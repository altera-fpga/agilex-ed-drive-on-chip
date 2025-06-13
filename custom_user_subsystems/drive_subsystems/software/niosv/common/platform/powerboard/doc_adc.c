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


#include "doc_adc.h"

#include <stdlib.h>

#ifdef __ALTERA_MODULAR_DUAL_ADC
#include "altera_modular_dual_adc.h"
#endif
#include "io.h"
#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"

#include "components/ssg_emb_dsm.h"
#include "components/ssg_emb_sd_adc.h"
#include "mc/mc_debug.h"
#include "platform/common/platform.h"
#include "perf/altera_avalon_performance_counter.h"
#include "motorsim/motor_functions.h"        //motor simulation inside deferred_irq_task()
#include "motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL.h"
#include "motorsim/dspba_motorsim/DF_fixp16_alu_av_MOTORMODEL_mmap.h"

#include "app_cfg.h"


#define OFFSET_ACCUM_ISR_COUNT      256
// Sigma delta offset limit is set to 1.25% (820/65536)
#define CURRENT_OFFSET_LIMIT        820
// MAX10 offset limit is slightly higher at 1.5% (62/4096) to allow for noise in ribbon cable
#define MAX10_CURRENT_OFFSET_LIMIT   62

#ifdef __ALTERA_MODULAR_DUAL_ADC
#define MAX10_OFFSET 2048

/**
 * \addtogroup PLATFORM
 *
 * @{
 */

/**
 * \addtogroup ADC
 *
 * @{
 */

/**
 * Constant used to normalize MAX10 readings to Sigma-delta readings.
 */
static int scale = 12803;
#endif

/**
 * @file doc_adc.c
 *
 * @brief Drive on chip ADC interface
 */

#if defined __SSG_EMB_SD_ADC

void adc_sd_setup(drive_params *dp)
{
    // I_ref are a function of desired current limit (depends on motor)
    // and ADC scaling (depends on powerboard and chosen ADCs)
    // Iref = 511 is full scale reading for the low resolution free running overcurrent detection ADC

    // Motor phase currents
    ssg_emb_adc_setup(dp->DOC_ADC_BASE_ADDR, 32767, 32767, 32767, 1000, SD_ADC_FILTER<<ADC_D_OFST, 1);
    // Motor phase feedback voltages
    ssg_emb_adc_setup(dp->DOC_ADC_POW_BASE_ADDR, 32767, 32767, 32767, 1000, SD_ADC_FILTER<<ADC_D_OFST, 1);


}

void adc_sd_overcurrent_enable(drive_params *dp, int enable)
{
    ssg_emb_adc_overcurrent_enable(dp->DOC_ADC_BASE_ADDR, enable);
}

/**
 * Read Sigma delta ADCs
 *
 * Reading direct rather than calling ssg_emb_adc_read() gives a slight perfomance boost.
 *
 * @param dp
 */
void adc_sd_read(drive_params *dp, system_params *sp)
{
    // Motor phase currents, V phase is only available on Tandem board and is not used
    // except for trapezoidal commutation.

    // Motor phase currents iu_measure, iv and iw: 16 bits Sigma-Delta ADC
    // (ADC interface:16 bits. Interface rtl: ip\ssg_emb_sd_adc)
    // 1024 counts/A. Data type:sfix16_En10. Convert this value to
    // range 0 to 1 (ufix16_En16). 2^16/1024 = 64;  2^15/1024 = 32.
    // This means -32A will be 0 and 32A will be 1.
    // Schematic page 12: +/-32A current measurement. Current is sensed across 0.01 resistor. I=V/R = V/0.01 = 100*V
    // Motor phase currents Altera MAX10 ADC: 81.9 counts/A, convert this value to 16 bits, same as Sigma-Delta ADC:
    // MAX10 ADC read back value * 1024/81.9 = MAX10 ADC read back value * 12803/1024

    dp->sd_drive_adc.iu_measure = (short) IORD_16DIRECT(dp->DOC_ADC_BASE_ADDR, ADC_I_U);
    dp->sd_drive_adc.iw = (short) IORD_16DIRECT(dp->DOC_ADC_BASE_ADDR, ADC_I_W);

        dp->sd_drive_adc.iv = (short) IORD_16DIRECT(dp->DOC_ADC_BASE_ADDR, ADC_I_V);
        // Calculate iu due to noisy on measured iu signal.
        // (Iu is close to 20MHz clock on pcb so it catches some noise.)
        if (dp->drive == FIRST_MULTI_AXIS) {
            dp->sd_drive_adc.iu = 0 - dp->sd_drive_adc.iv - dp->sd_drive_adc.iw;
        } else {
            // By analysis previous shutdown cases, it can be seen that
            // remaining spikes on Axis 1 are causing the problem
            // and we saw iv spikes in the same direction as iu spikes but around 25% of the size for Axis 1.
            // use P as the reduction factor (P=0.25) Apply following equation to cancel out spike.
            // iu_axis1 = (P*iu_m_axis1 - iv_m_axis1 - iw_m_axis1)/(1 + P) where iu_m_axis1 is iu measured on axis1 etc.

            dp->sd_drive_adc.iu =
                (((dp->sd_drive_adc.iu_measure>>2)  - dp->sd_drive_adc.iv - dp->sd_drive_adc.iw)<<2) / 5;
        }
        // Motor phase feedback voltages
        // Motor phase voltage vu,vv and vw 16 bits Sigma-Delta ADC
        // (ADC interface:16 bits. Interface rtl: ip\ssg_emb_sd_adc)
        // 545 counts/V. Data type:sfix16_En9. Convert this value to
        // range 0 to 1 (ufix16_En16). 2^16/545 = 120;  2^15/545 = 60.
        // This means -60V will be 0 and 60V will be 1.
        // Schematic page 11: 60.16V -->0.32V full range resolution. Voltage is sensed across 100/18700 divider.
        // 0.32*(18700+100)/100 = 0.32*188 = 60.16V
        // Motor phase voltages Altera MAX10 ADC: 67.7 counts/V

        dp->sd_drive_adc.vu = (short) IORD_16DIRECT(dp->DOC_ADC_POW_BASE_ADDR, ADC_I_U);
        dp->sd_drive_adc.vv = (short) IORD_16DIRECT(dp->DOC_ADC_POW_BASE_ADDR, ADC_I_V);
        dp->sd_drive_adc.vw = (short) IORD_16DIRECT(dp->DOC_ADC_POW_BASE_ADDR, ADC_I_W);


    if (dp->drive == FIRST_MULTI_AXIS) {

        // Need to read the value of the DC-DC Voltage link output, to calculate other values.
        // This can be read from the motor model register directly.
        sp->dc_dc_v_scaled = (short)IORD_32DIRECT(dp->DOC_MOTORMODEL_BASE_ADDR,
            MOTOR_KIT_SIM_20MHZ_MOTORMODEL_AVALONREGISTERS_DC_LINK_V_INPUT * DSPBA_bytes_per_word)/(constScaleVoltage);
        sp->sd_platform_adc.dc_dc_v_fb = sp->dc_dc_v_scaled * (dp->motor->V_DC_link_scale_V);
    }
}

void adc_sd_irq_acknowledge(drive_params *dp)
{
    IOWR_16DIRECT(dp->DOC_ADC_BASE_ADDR, ADC_IRQ_ACK, 1);
}

void adc_sd_irq_enable(drive_params *dp)
{
    IOWR_16DIRECT(dp->DOC_ADC_BASE_ADDR, ADC_IRQ_ACK, 0);
}

void adc_sd_debug_oc(drive_params *dp)
{
    debug_printf(DBG_ERROR, "Axis %d: I_U:%d\t\tI_W:%d\t\t\n", dp->drive,
            (short) IORD_16DIRECT(dp->DOC_ADC_BASE_ADDR, OC_CAPTURE_U),
            (short) IORD_16DIRECT(dp->DOC_ADC_BASE_ADDR, OC_CAPTURE_W));
    debug_printf(DBG_ERROR, "Axis %d: I_Ref:%d\n", dp->drive,
            IORD_16DIRECT(dp->DOC_ADC_BASE_ADDR, ADC_I_PEAK));
}

#endif    // defined __SSG_EMB_SD_ADC

#ifdef __ALTERA_MODULAR_DUAL_ADC
alt_modular_adc_dev * adc_dev;

/**
 * Set up the MAX 10 ADC using the Nios HAL driver.
 *
 * @param dp
 */
void adc_max10_setup(drive_params *dp)
{
    adc_dev = altera_modular_adc_open("/dev/max10_adc_sample_store_csr");
    adc_stop(MAX10_ADC_SEQUENCER_CSR_BASE);
    adc_set_mode_run_once(MAX10_ADC_SEQUENCER_CSR_BASE);
}

void adc_max10_overcurrent_enable(drive_params *dp, int enable)
{
    if (dp->drive == FIRST_MULTI_AXIS) {
    }
}

/**
 * Read the MAX 10 ADC sample store.
 *
 * Copy samples to drive_params struct for later use. Current readings are offset to remove
 * the offset applied by the LT1999 sense amplifiers.
 *
 * Motor phase currents are offset and then scaled so that they represent the same physical units as
 * the sigma-delta converters, even though they are treated as being dimensionless.
 *
 * @param dp        Pointer to drive parameters struct
 * @param dn        Index to current drive axis
 */
void adc_max10_read(drive_params *dp, system_params *sp)
{
    alt_u32 tmp;

    // The PCB footprint for the pin header J20 on the MAX10 dev kit is incorrect with the odd
    // and even rows of pins swapped, when you consider a ribbon cable connected with an IDC
    // header. The net effect is that the inputs to ADC1 and 2 are swapped. This is accounted
    // for in the code below.
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 0);
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 4);
    dp[0].max10_drive_adc.iv = (short)(((int)((tmp & 0xFFF) - dp[0].max10_drive_adc.offset_v) * scale)/1024);
    dp[0].max10_drive_adc.vv = (tmp>>16) & 0xFFF;
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 8);
    dp[0].max10_drive_adc.iw = (short)(((int)((tmp & 0xFFF) - dp[0].max10_drive_adc.offset_w) * scale)/1024);
    dp[0].max10_drive_adc.iu = (short)(((int)(((tmp>>16) & 0xFFF) - dp[0].max10_drive_adc.offset_u) * scale)/1024);
    dp[0].max10_drive_adc.iu_measure = dp[0].max10_drive_adc.iu;
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 12);
    dp[0].max10_drive_adc.vw = tmp & 0xFFF;
    dp[0].max10_drive_adc.vu = (tmp>>16) & 0xFFF;
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 16);
    sp->max10_platform_adc.dc_dc_v_fb = (tmp>>16) & 0xFFF;
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 20);
    dp[1].max10_drive_adc.vv = tmp & 0xFFF;
    dp[1].max10_drive_adc.iv = (short)(((int)(((tmp>>16) & 0xFFF) - dp[1].max10_drive_adc.offset_v) * scale)/1024);
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 24);
    dp[1].max10_drive_adc.iu = (short)(((int)((tmp & 0xFFF) - dp[1].max10_drive_adc.offset_u) * scale)/1024);
    dp[1].max10_drive_adc.iu_measure = dp[1].max10_drive_adc.iu;
    dp[1].max10_drive_adc.iw = (short)(((int)(((tmp>>16) & 0xFFF) - dp[1].max10_drive_adc.offset_w) * scale)/1024);
    tmp = IORD_32DIRECT(MAX10_ADC_SAMPLE_STORE_CSR_BASE, 28);
    dp[1].max10_drive_adc.vu = tmp & 0xFFF;
    dp[1].max10_drive_adc.vw = (tmp>>16) & 0xFFF;
}

void adc_max10_irq_acknowledge(drive_params *dp)
{

}

void adc_max10_irq_enable(drive_params *dp)
{

}

void adc_max10_debug_oc(drive_params *dp)
{
    debug_printf(DBG_ERROR, "No overcurrent capture available on this platform\n");
}

/*
 * Initialise the MAX ADC threshold violation sink.
 *
 * Disable error latches and outputs and clear any existing status
 */
void max10_adc_threshold_init(int base_address)
{
    adc_max10_threshold_write(base_address, THR_CAPTURE_UNDER_ENABLE_REG, 0);
    adc_max10_threshold_write(base_address, THR_CAPTURE_OVER_ENABLE_REG, 0);
    adc_max10_threshold_write(base_address, THR_OUTPUT_UNDER_ENABLE_REG, 0);
    adc_max10_threshold_write(base_address, THR_OUTPUT_OVER_ENABLE_REG, 0);
    adc_max10_threshold_write(base_address, THR_CLEAR_UNDER_ERROR_REG, THR_ALL_CHANNEL_MASK);
    adc_max10_threshold_write(base_address, THR_CLEAR_OVER_ERROR_REG, THR_ALL_CHANNEL_MASK);
}

#endif    // __ALTERA_MODULAR_DUAL_ADC

void adc_setup(drive_params *dp)
{
    adc_sd_setup(dp);
#ifdef __ALTERA_MODULAR_DUAL_ADC
    if (dp->drive == FIRST_MULTI_AXIS) {
        adc_max10_setup(dp);
    }
#endif
}

void adc_threshold_init(void)
{
#ifdef __ALTERA_MODULAR_DUAL_ADC
    max10_adc_threshold_init(ECFS_DOC_THRESHOLD_SINK_BASE);
#endif
}

void adc_overcurrent_enable(drive_params *dp, int enable)
{
    adc_sd_overcurrent_enable(dp, enable);
#ifdef __ALTERA_MODULAR_DUAL_ADC
    if (dp->drive == FIRST_MULTI_AXIS) {
        adc_max10_overcurrent_enable(dp, enable);
    }
#endif
}

void adc_read(drive_params *dp, system_params *sp)
{
    adc_sd_read(dp, sp);

#ifdef __ALTERA_MODULAR_DUAL_ADC
    if (dp->drive == FIRST_MULTI_AXIS) {
        adc_max10_read(dp, sp);
    }
#endif
}

void adc_irq_acknowledge(drive_params *dp)
{
    adc_sd_irq_acknowledge(dp);
}

void adc_irq_enable(drive_params *dp)
{
    adc_sd_irq_enable(dp);
}

void adc_debug_oc(drive_params *dp)
{
    adc_sd_debug_oc(dp);
}

/**
 * Used during startup to determine ADC zero offsets which can then be used to
 * correct ADC readings in control loop.
 *
 * @param dp        pointer to single drive parameters struct
 */
void adc_offset_accumulate(drive_params *dp)
{
    if (dp->Offset_start_calc < (OFFSET_ACCUM_ISR_COUNT + 1)) {
        dp->sd_drive_adc.offset_u_acc +=  dp->sd_drive_adc.iu_measure;
        dp->sd_drive_adc.offset_v_acc +=  dp->sd_drive_adc.iv;
        dp->sd_drive_adc.offset_w_acc +=  dp->sd_drive_adc.iw;
#ifdef __ALTERA_MODULAR_DUAL_ADC
        dp->max10_drive_adc.offset_u_acc += dp->max10_drive_adc.iu;
        dp->max10_drive_adc.offset_v_acc += dp->max10_drive_adc.iv;
        dp->max10_drive_adc.offset_w_acc += dp->max10_drive_adc.iw;
#endif
        dp->Offset_start_calc++;
    } else {
        dp->Offset_start_calc = 0;
    }
}

/**
 * ADC IRQ Check & Offset Current Calculation
 *
 * Read current values in idle state and average over OFFSET_ACCUM_ISR_COUNT readings. If the calculated offset
 * is too high, report an error.
 *
 * The Sigma delta ADC peripherals have a hardware offset register, MAX10 ADC offset is applied in software. The
 * offsets are initially set to half full scale and then overwritten when the final offset value is calculated.
 *
 * A timeout error is signalled if the drive IRQ is not called at a high enough rate.
 *
 * On the Tandem Motion power there is no way to setup an idle current in the DC-DC boost converter so the offsets
 * are calculated from the average of the offsets measured on the other channels.
 *
 * @param dp        pointer to drive parameters struct array
 * @return
 */
int adc_offset_calculation(drive_params *dp)
{
    int dn = 0;
    short error = 0;
    int timeout;

    debug_printf(DBG_DEBUG, "ADC Offset calc\n");
    for (dn = platform.first_drive; dn <= platform.last_drive; dn++) {
        timeout = 0;
        dp[dn].Offset_start_calc = 0;
        dp[dn].enable_drive = 0;

        // Reset hardware offsets before (re-)calculating
        IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_U, 32767);
        IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_V, 32767);
        IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_W, 32767);

        if (platform.powerboard->sysid == SYSID_PB_LOW_VOLTAGE) {
            IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_D,
                (1<<ADC_3PH_EN_OFST | 1<<ADC_UVOLT_EN_OFST | SD_ADC_FILTER<<ADC_D_OFST));
        } else {
            IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_D, (1<<ADC_UVOLT_EN_OFST | SD_ADC_FILTER<<ADC_D_OFST));
        }
        IOWR_16DIRECT(dp[dn].DOC_SM_BASE_ADDR, SM_CONTROL, DSM_CONTROL_TO_PRECHARGE);

        OS_SLEEP_MS(50);

        debug_printf(DBG_DEBUG, "---> --------------------------------------------------\n");
        debug_printf(DBG_DEBUG, "---> STATE %i of Motor\n", IORD_16DIRECT(dp[dn].DOC_SM_BASE_ADDR,
                SM_STATUS) >> DSM_STATUS_STATE_OFFSET);

        dp[dn].sd_drive_adc.offset_u_acc = 0;
        dp[dn].sd_drive_adc.offset_v_acc = 0;
        dp[dn].sd_drive_adc.offset_w_acc = 0;
        dp[dn].sd_drive_adc.offset_u = 0;
        dp[dn].sd_drive_adc.offset_v = 0;
        dp[dn].sd_drive_adc.offset_w = 0;
#ifdef __ALTERA_MODULAR_DUAL_ADC
        dp[dn].max10_drive_adc.offset_u_acc = 0;
        dp[dn].max10_drive_adc.offset_v_acc = 0;
        dp[dn].max10_drive_adc.offset_w_acc = 0;
        // Initial offset is half the full range. Applied during adc read function and then updated by this Fn.
        dp[dn].max10_drive_adc.offset_u = 2048;
        dp[dn].max10_drive_adc.offset_v = 2048;
        dp[dn].max10_drive_adc.offset_w = 2048;
#endif
        // Set start for offset calculation in ISR
        dp[dn].Offset_start_calc = 1;

        // Wait for offset calculation to finish
        debug_printf(DBG_DEBUG, "---> Axis %d: Offset calc\n", dn);
        while ((dp[dn].Offset_start_calc > 0) && (timeout < 100)) {
            // deferred_irq_task() in motor_task.c sets dp[dn].Offset_start_calc = 0 when
            // sp.app_state == APP_ADC_CALIBRATION (motor_task() in motor_task.c)
            // in the modified code, this while loop is run only once during check condition
            // "while (adc_offset_calculation(dp) > 0)" in motor_task() , since we force the
            // application to move to APP_ADC_CALIBRATION state once it enters the while
            // (adc_offset_calculation(dp) > 0) loop
            OS_SLEEP_MS(10);
            // debug_printf(DBG_ERROR, "o_s_c %d\n", dp[dn].Offset_start_calc);
            timeout++;
        }
        if (dp[dn].Offset_start_calc > 0) {
            error = error + (1<<dn);
            debug_printf(DBG_ERROR, "---> ADC calibration failed due to timeout,%d\n", dp[dn].Offset_start_calc);
        } else {
            dp[dn].sd_drive_adc.offset_u = (short)(dp[dn].sd_drive_adc.offset_u_acc / OFFSET_ACCUM_ISR_COUNT);
            dp[dn].sd_drive_adc.offset_v = (short)(dp[dn].sd_drive_adc.offset_v_acc / OFFSET_ACCUM_ISR_COUNT);
            dp[dn].sd_drive_adc.offset_w = (short)(dp[dn].sd_drive_adc.offset_w_acc / OFFSET_ACCUM_ISR_COUNT);
#ifdef __ALTERA_MODULAR_DUAL_ADC
            // Correct for scaling of accumulated values and add half full range bias to create final offset
            dp[dn].max10_drive_adc.offset_u =
                (short)(2048 + (dp[dn].max10_drive_adc.offset_u_acc*1024)/(OFFSET_ACCUM_ISR_COUNT*scale));
            dp[dn].max10_drive_adc.offset_v =
                (short)(2048 + (dp[dn].max10_drive_adc.offset_v_acc*1024)/(OFFSET_ACCUM_ISR_COUNT*scale));
            dp[dn].max10_drive_adc.offset_w =
                (short)(2048 + (dp[dn].max10_drive_adc.offset_w_acc*1024)/(OFFSET_ACCUM_ISR_COUNT*scale));
#endif
            debug_printf(DBG_DEBUG, "---> Sigma-Delta offset U: %i\n", dp[dn].sd_drive_adc.offset_u);
            debug_printf(DBG_DEBUG, "---> Sigma-Delta offset V: %i\n", dp[dn].sd_drive_adc.offset_v);
            debug_printf(DBG_DEBUG, "---> Sigma-Delta offset W: %i\n", dp[dn].sd_drive_adc.offset_w);
#ifdef __ALTERA_MODULAR_DUAL_ADC
            debug_printf(DBG_DEBUG, "---> MAX10 Offset U: %i\n", abs(dp[dn].max10_drive_adc.offset_u - 2048));
            debug_printf(DBG_DEBUG, "---> MAX10 Offset V: %i\n", abs(dp[dn].max10_drive_adc.offset_v - 2048));
            debug_printf(DBG_DEBUG, "---> MAX10 Offset W: %i\n", abs(dp[dn].max10_drive_adc.offset_w - 2048));
#endif
            if ((abs(dp[dn].sd_drive_adc.offset_u) > CURRENT_OFFSET_LIMIT)
                    || (abs(dp[dn].sd_drive_adc.offset_v) > CURRENT_OFFSET_LIMIT)
                    || (abs(dp[dn].sd_drive_adc.offset_w) > CURRENT_OFFSET_LIMIT)
#ifdef __ALTERA_MODULAR_DUAL_ADC
                    || (abs(dp[dn].max10_drive_adc.offset_u - 2048) > MAX10_CURRENT_OFFSET_LIMIT)
                    || (abs(dp[dn].max10_drive_adc.offset_v - 2048) > MAX10_CURRENT_OFFSET_LIMIT)
                    || (abs(dp[dn].max10_drive_adc.offset_w - 2048) > MAX10_CURRENT_OFFSET_LIMIT)
#endif
                ) {
                // condition to skip the error and to continue the initialisation
                // of components (APP_ADC_SKIP, APP_DRIVE_SIM)
                #if (defined(MOTOR_KIT_SIM_20MHZ_MOTORMODEL_0_BASE))
                    debug_printf(DBG_DEBUG, "---> MOTORSIM CHANGE: We forced the application to\
                        run this code when the powerboard is not connected\n");
                    IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_U, (32767 + dp[dn].sd_drive_adc.offset_u));
                    IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_V, (32767 + dp[dn].sd_drive_adc.offset_v));
                    IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_W, (32767 + dp[dn].sd_drive_adc.offset_w));
                #else
                    error = error + (1<<(platform.powerboard->axes + dn));
                    debug_printf(DBG_ERROR, "Error: ---> Axis %d: Offset calc unsuccessful!\n", dn);
                #endif
            } else {    //&& (platform.powerboard_present == 1) brings here (APP_ADC_SKIP, APP_DRIVE_SIM)
                // Write new offset to hardware
                IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_U, (32767 + dp[dn].sd_drive_adc.offset_u));
                IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_V, (32767 + dp[dn].sd_drive_adc.offset_v));
                IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_OFFSET_W, (32767 + dp[dn].sd_drive_adc.offset_w));
                debug_printf(DBG_DEBUG, "---> Axis %d: Offset calc successful!\n", dn);
            }
        }
        dp[dn].enable_drive = 0;
        IOWR_16DIRECT(dp[dn].DOC_ADC_BASE_ADDR, ADC_D, SD_ADC_FILTER<<ADC_D_OFST);
        IOWR_16DIRECT(dp[dn].DOC_SM_BASE_ADDR, SM_CONTROL, DSM_CONTROL_TO_INIT);

        if (error == 0) {
            IOWR_16DIRECT(dp[dn].DOC_ADC_POW_BASE_ADDR, ADC_OFFSET_U, 32767);
            IOWR_16DIRECT(dp[dn].DOC_ADC_POW_BASE_ADDR, ADC_OFFSET_V, 32767);
            IOWR_16DIRECT(dp[dn].DOC_ADC_POW_BASE_ADDR, ADC_OFFSET_W, 32767);
        }
    }

    return error;
}
/*!
 * @}
 */

/*!
 * @}
 */
