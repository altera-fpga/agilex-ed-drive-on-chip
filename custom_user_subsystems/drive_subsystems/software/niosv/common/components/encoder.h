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

#ifndef ENCODER_H_
#define ENCODER_H_

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
 * \addtogroup ENCODER Encoder data structure
 *
 * @brief Data structure to hold encoder parameters in an encoder independent way
 *
 * @{
 */
/*
 * @brief Data structure to hold encoder parameters in an encoder independent way
 */
typedef struct {
    int   speed_encoder;        //!<Actual measured Speed
    unsigned short mphase;      //!<Phase offset
    int   enc_data;             //!<Encoder single & multi-turn data (current value)
    int   raw;                  //!<Encoder raw reading
    int   turns_delta;          //!<Encoder position passed through 0
} encoder_struct;

/*!
 * @}
 */

/*!
 * @}
 */

#endif    /* ENCODER_H_ */
