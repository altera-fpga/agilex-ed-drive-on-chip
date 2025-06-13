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

#ifndef WAVEFORM_H_
#define WAVEFORM_H_

#include <stdbool.h>

/**
 * @file waveform.h
 *
 * @brief Header file for waveform generation for vibration demo
 */

/*!
 * \addtogroup WAVEFORM Waveform generation
 *
 * Functions to generate a periodic test waveform that can be applied to the motor control system.
 *
 * @{
 */

/**
 * @brief Enumeration to control speed demo waveform
 *
 * Explicit values used as they must be consistent with the tcl gui
 * Values chosen to be compatible with SoC FFT demo
 */
typedef enum {
    DEMO_WAVE_SINE            = 0,     //!< Sine wave
    DEMO_WAVE_TRIANGLE        = 1,     //!< Triangle wave
    DEMO_WAVE_SQUARE          = 2,     //!< Square wave
    DEMO_WAVE_SAWTOOTH        = 3,     //!< Sawtooth wave
    DEMO_WAVE_CONSTANT        = 4       //!< Steady state
} demo_wave_e;

/**
 * Waveform definition and state structure
 */
typedef struct {
    demo_wave_e Shape_enum;
    int Period_int32;            //!< Waveform period in motion_timer ticks
    int QtrPeriod_int32;         //!< Waveform quarter period in motion_timer ticks
    int HalfPeriod_int32;        //!< Waveform half period in motion_timer ticks
    int ThreeQtrPeriod_int32;    //!< Waveform three-quarter period in 16kHz samples
    int offset_int32;            //!< Waveform time offset in motion_timer ticks
    //float Amp_ND_f;             //!< Waveform amplitude, non-dimensional (to be multiplied by fullscale and units)
    int Amp_ND_f;                //!< Waveform amplitude, non-dimensional (to be multiplied by fullscale and units)
    int count_int32;             //!< Instantaneous count value, will increment from zero to (Period_int32-1)
    //float value_ND_f;           //!< Waveform instantaneous output value.
    int value_ND_f;              //!< Waveform instantaneous output value.
    //float limit;                //!< Waveform maximum value
    int limit;                   //!< Waveform maximum value
} waveform_t;

/**
 * @brief Initialise/reset the waveform state
 *
 * @param wPtr    Pointer to waveform structure
 */
void initWaveform(waveform_t *wPtr);

/**
 * @brief Reset waveform count_int32 to zero
 *
 * @param wPtr    Pointer to waveform structure
 */
void resetWaveform(waveform_t *wPtr);

/**
 * @brief Generates the next value in the waveform
 *
 * @param wPtr    Pointer to waveform structure
 */
int updateWaveform(waveform_t *wPtr);

/*!
 * @}
 */

#endif /* WAVEFORM_H_ */
