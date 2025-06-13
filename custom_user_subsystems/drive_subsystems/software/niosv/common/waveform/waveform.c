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

#include "waveform.h"

#include <math.h>

#include "mc/mc.h"
#include "mc/mc_debug.h"

/**
 * @file waveform.c
 *
 * @brief Waveform generation for motor control demo
 */

/*!
 * \addtogroup WAVEFORM
 *
 * @{
 */

// Don't want to force double opertaions by using M_PI from mat.h
#define TWO_PI_F (2 * 3.1415926f)

void initWaveform(waveform_t *wPtr)
{
    wPtr->Shape_enum = DEMO_WAVE_CONSTANT;
    wPtr->Period_int32 = 0;
    wPtr->HalfPeriod_int32 = 0;
    wPtr->QtrPeriod_int32 = 0;
    wPtr->ThreeQtrPeriod_int32 = 0;
    wPtr->offset_int32 = 0;
    //wPtr->Amp_ND_f = 0.0f;
    wPtr->Amp_ND_f = 0;
    wPtr->count_int32 = 0;
    //wPtr->value_ND_f = 0.0f;
    wPtr->value_ND_f = 0;
}

void resetWaveform(waveform_t *wPtr)
{
    wPtr->count_int32 = 0;
}

int updateWaveform(waveform_t *wPtr)
{
    int countAfterOffset_int32 = 0;
    int countMinusOffset_int32 = 0;
    int countPlusMinusHalfPeriod_int32 = 0;
    int countPlusMinusQtrPeriod_int32 = 0;

    //float waveformValueNorm_ND_f = 0.0f;
    int waveformValueNorm_ND_f = 0;

    // Update countAfterOffset (creates positive count after subtracting offset):
    countMinusOffset_int32 = wPtr->count_int32 - wPtr->offset_int32;
    if (countMinusOffset_int32 < 0) {
        countAfterOffset_int32 = countMinusOffset_int32 + wPtr->Period_int32;
    } else {
        countAfterOffset_int32 = countMinusOffset_int32;
    }

    // Update counter for the next cycle:
    if (wPtr->count_int32 >= (wPtr->Period_int32 - 1)) {
        wPtr->count_int32 = 0;
    } else {
        wPtr->count_int32++;
    }

    switch (wPtr->Shape_enum) {
    case DEMO_WAVE_SAWTOOTH:
        if (countAfterOffset_int32 < wPtr->HalfPeriod_int32) {
            countPlusMinusHalfPeriod_int32 = countAfterOffset_int32;
        } else {
            countPlusMinusHalfPeriod_int32 = countAfterOffset_int32 - wPtr->Period_int32;
        }
        // Multiply by 2 to scale to full
        // period and multiply by invPeriod to create signal with
        // plus/minus amplitude of 1:
        //waveformValueNorm_ND_f = (2.0f * countPlusMinusHalfPeriod_int32) / wPtr->Period_int32;
        waveformValueNorm_ND_f =  (2 * countPlusMinusHalfPeriod_int32 * wPtr->Amp_ND_f) / wPtr->Period_int32;
        break;

    case DEMO_WAVE_SQUARE:
        if (countAfterOffset_int32 < wPtr->HalfPeriod_int32) {
            //waveformValueNorm_ND_f = 1.0f;
            waveformValueNorm_ND_f = 1 * wPtr->Amp_ND_f;
        } else {
            //waveformValueNorm_ND_f = -1.0f;
            waveformValueNorm_ND_f = -1 * wPtr->Amp_ND_f;
        }
        break;

    case DEMO_WAVE_TRIANGLE:
        if (countAfterOffset_int32 < wPtr->QtrPeriod_int32) {
            countPlusMinusQtrPeriod_int32 = countAfterOffset_int32;
        } else {
            if (countAfterOffset_int32 < wPtr->ThreeQtrPeriod_int32) {
                countPlusMinusQtrPeriod_int32 = wPtr->HalfPeriod_int32 - countAfterOffset_int32;
            } else {
                countPlusMinusQtrPeriod_int32 = countAfterOffset_int32 - wPtr->Period_int32;
            }
        }
        // Multiply countPlusMinusHalfPeriod_int32 by 4 to scale to full
        // period and multiply by invPeriod to create signal with
        // plus/minus amplitude of 1:
        //waveformValueNorm_ND_f = (4.0f * countPlusMinusQtrPeriod_int32) / wPtr->Period_int32;
        waveformValueNorm_ND_f =   (4 * countPlusMinusQtrPeriod_int32 * wPtr->Amp_ND_f) / wPtr->Period_int32;
        break;

    case DEMO_WAVE_SINE:
        //waveformValueNorm_ND_f = sin((TWO_PI_F * countAfterOffset_int32) / wPtr->Period_int32);
        waveformValueNorm_ND_f = wPtr->Amp_ND_f * sin((TWO_PI_F * countAfterOffset_int32) / wPtr->Period_int32);
        break;

    case DEMO_WAVE_CONSTANT:
        //waveformValueNorm_ND_f = 0.0;
        waveformValueNorm_ND_f = 0;
        break;
    default:
        //waveformValueNorm_ND_f = 0.0;
        waveformValueNorm_ND_f = 0;
        break;
    }

    // Scale to requested amplitude and apply limit
    //wPtr->value_ND_f = ABS_MAX(waveformValueNorm_ND_f * wPtr->Amp_ND_f, wPtr->limit);
    wPtr->value_ND_f = ABS_MAX(waveformValueNorm_ND_f, wPtr->limit);
    return waveformValueNorm_ND_f;
}

/*!
 * @}
 */
