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

#ifndef MC_DSP_H_
#define MC_DSP_H_

/**
 * @file mc_dsp.h
 *
 * @brief Header file for DSP functions for motor control
 */

#include "sin_cos_q15.h"

#include "platform/platform_linker.h"


/*!
 * \addtogroup MC
 *
 * @{
 */

/*!
 * \addtogroup DSPFIXED Motor Control DSP Functions (Fixed Point)
 *
 * @{
 */

/**
 * PI Controller data structure
 */
typedef struct{
    int output;               //!< The output correction value A0 = Kp + Ki .
    int integrator;           //!< The integrator value.
    int kp;                   //!< The proportional gain coefficient, must be scaled by precision_bits.
    int ki;                   //!< The integral gain coefiicient, must be scaled by precision_bits.
    int precision_bits;       //!< Fractional bits held internally to improve precion
    int setpoint;             //!< Setpoint input
    int feedback;             //!< Feedback input
    int kp_ki_bits;          //!< Define how many bits for Kp and Ki max range.
    int error_limit;         //!< Saturation limit for error value
    int integrator_limit;    //!< Saturation limit for integrator
    int output_limit;        //!< Saturation limit for output
} pi_instance_q15;

// Assume a is a 16 bit fraction. Shift by one bit to force to positive q15 value.
#define SINE(a) (sin_q15((a)>>1))
#define COSINE(a) (cos_q15((a)>>1))

/**
 * Limits the input value (operand_a) to +/- the range limit (operand_b)
 *
 * Macro gives in-line code, avoiding parameter passing. More critical for Nios than HPS.
 *
 * @param a Input value
 * @param b Upper/lower range limit (saturation limit)
 * @return Input value after saturation
 */
#define ABS_MAX(a, b) (((a) > (b)) ? (b):((a) < -(b)) ? -(b):(a))

/**
 * Limits the input value (operand_a) to outside the range +/- the range limit (operand_b)
 *
 * Macro gives in-line code, avoiding parameter passing. More critical for Nios than HPS.
 *
 * @param a Input value
 * @param b Minimum range limit (range limit)
 * @return Input value after limiting
 */
#define ABS_MIN(a, b) (((a) > (b))?(a):((a) < -(b))?(a):((a) >= 0) ? (b) : -(b))

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

/**
 * Clarke Transform (alpha-beta transformation) is a space vector transformation of time-domain
 * signals (e.g. voltage, current, flux, etc) from a natural three-phase coordinate system (ABC/UVW) into a
 * stationary two-phase reference frame (alpha,beta).
 * The implementation of this transform is simplified due to the fact that U + V + W = 0 in a 3 phase motor,
 * so only U & W input vectors are used.
 *
 * @param i_u U input
 * @param i_w W input
 * @param[out] i_alpha alpha output
 * @param[out] i_beta beta output
 */
void clarke_transform(short i_u, short i_w, short I_scale, short I_parameter, int *i_alpha, int *i_beta) IRQ_SECTION;

/**
 * Park Transformation is a space vector transformation of three-phase time-domain signals from a
 * stationary phase coordinate system (alpha,beta) to a rotating coordinate system (dq0).
 *
 * @param Ialpha Alpha input
 * @param Ibeta Beta input
 * @param[out] Id D
 * @param[out] Iq Q
 * @param sinVal_q15 Sine value for angle (w)
 * @param cosVal_q15 Cosine value for angle (w)
 */
void park_transform(int Ialpha, int Ibeta, int *Id, int *Iq, int sinVal_q15, int cosVal_q15) IRQ_SECTION;

/**
 * Inverse Park Transformation ( rotor - stator ) 2 axis coordinate system ( d , q )
 * ( time invariant ) --> 2 axis coordinate system ( alpha , beta )
 *
 * @param Vd D input
 * @param Vq Q input
 * @param[out] pValpha Alpha output
 * @param[out] pVbeta Beta output
 * @param sinVal_q15 Sine value for angle (w)
 * @param cosVal_q15 Cosine value for angle (w)
 */
void inverse_park(int Vd, int Vq, int *Valpha, int *Vbeta, int sinVal_q15, int cosVal_q15) IRQ_SECTION;

/**
 * PI controller algorithm: Executes one time-step every execution
 * All coefficients, data inputs and outputs are contained in the S data structure
 *
 * @param S PI controller data structure
 * @param resetStateFlag
 */
void pi_control_q15(pi_instance_q15 *S, int reset) IRQ_SECTION;

/**
 * PI controller reset
 *
 * @param S PI controller structure to reset
 */
void pi_reset_q15(pi_instance_q15 *S);

/**
 * Space Vector Modulation
 *
 * Includes inverse Clark. Creates a switching sequence for the 3 voltage phases (UVW) of the motor that
 * are equivalent to the 2 phase a & b input vectors. Additional a third harmonic voltage waveform is added
 * to the SVM output to flatten the peaks and allows the maximum modulation index to be 1.15
 * The U,V,W outputs are limited to between 0 < voltage < pwm_max and are used directly by the PWM to indicate
 * which clock cycle the PWM switches high as the PWM counts up and then low again as the PWM counts down.
 *
 * @param v_alpha_q15 Input Alpha voltage vector
 * @param v_beta_q15 Input Beta voltage vector
 * @param [out] ru_out PWM switching threshold for U voltage phase
 * @param [out] rv_out PWM switching threshold for V voltage phase
 * @param [out] rw_out PWM switching threshold for W voltage phase
 */
void svm(int v_alpha_q15, int v_beta_q15, unsigned short *ru_out,
        unsigned short *rv_out, unsigned short *rw_out) IRQ_SECTION;

/*!
 * @}
 */

/*!
 * @}
 */

#endif /* MC_DSP_H_ */
