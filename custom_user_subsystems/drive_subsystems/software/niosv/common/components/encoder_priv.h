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

#ifndef ENCODER_PRIV_H_
#define ENCODER_PRIV_H_

/**
 * @file mc.h
 *
 * @brief Header file for motor control demo
 */

/*!
 * \addtogroup COMPONENTS
 *
 * @{
 */

/*!
 * \addtogroup ENCODER
 *
 * @{
 */
/**
 * @brief Data structure to hold private encoder parameters in an encoder independent way
 */
typedef struct {
    int encoder_version;                //!<Encoder version number
    int encoder_length;                 //!<Number of encoder bits
    int encoder_mask;                   //!<Bit mask for encoder bits
    int encoder_turns_mask;             //!<Bit mask for encoder multi-turn bits
    int encoder_multiturn;              //!<If encoder is multi-turn. value = 1 else 0
    int encoder_multiturn_bits;         //!<Number of encoder multi-turn bits
    int encoder_singleturn_bits;        //!<Number of encoder multi-turn bits
    int encoder_data_prev;              //!<Encoder single & multi-turn data (previous value)
    int encoder_speed_acc;              //!<Encoder reading accumulator for filtering
    int encoder_speed_ave;              //!<Encoder reading average
    int encoder_filter_length;          //!<Encoder reading filter length
    int encoder_turns;                  //!<Encoder multi-turn data
    int sensor_warning_bits;
    int sensor_error_bits;
} encoder_priv_struct;

/*!
 * @}
 */

/*!
 * @}
 */

#endif    /* ENCODER_PRIV_H_ */
