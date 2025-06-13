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
 * @file mc_dsp.c
 *
 * @brief DSP functions for motor control
 */

#include "mc_dsp.h"

#include <stdlib.h>

#include "platform/common/platform.h"

#include "demo_cfg.h"

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
 * @brief Clarke Transform from 3-phase u, v, w to 2 axis coordinate alpha, beta
 *
 * Clarke Transform (alpha-beta transformation) is a space vector transformation of time-domain
 * signals (e.g. voltage, current, flux, etc) from a natural three-phase coordinate system (ABC/UVW) into a
 * stationary two-phase reference frame (alpha, beta).
 *
 * General form of Clarke transform
 * | alpha(t) | = 2/3 * | 1      -1/2      -1/2] | * | u(t) |
 * |  beta(t) |         | 0 sqrt(3)/2 -sqrt(3)/2 |   | v(t) |
 *                                                   | w(t) |
 *
 * In a three-phase motor we know that
 * and u(t) + v(t) + w(t) = 0
 *
 * alpha(t) = 2/3*(u(t) - v(t)/2 - w(t)/2)
 *          = 2/3*(u(t) + u(t)/2 + w(t)/2 - w(t)/2)
 *          = 2/3*(3/2*u(t)
 *          = u(t)
 * beta(t) = 2/3 * (sqrt(3)/2*v(t) - sqrt(3)/2*w(t))
 *         = 2/3 * (-sqrt(3)/2*u(t) - sqrt(3)/2*w(t) - sqrt(3)/2*w(t))
 *         = 2/3 * (-sqrt(3)/2*u(t) - sqrt(3)*w(t))
 *         = -1/sqrt(3)*(u(t) - 2/sqrt(3)*w(t))
 *         = -1/sqrt(3)*((u(t) + 2*w(t))
 *
 * I_parameter = 1/sqrt(3) is approximated as 1/sqrt(3)*dp->motor->Iphase_ADC_scale_A
 * For example, if dp->motor->Iphase_ADC_scale_A=1024, this value is 591
 *
 * @param i_u u phase current in Q10 format
 * @param i_u w phase current in Q10 format
 * @param i_alpha alpha current in Q10 format
 * @param i_beta beta current in Q10 format
 */
void clarke_transform(short i_u, short i_w, short I_scale, short I_parameter, int *i_alpha, int *i_beta)
{
    *i_alpha = i_u;
    *i_beta = (-I_parameter * (i_u + (i_w << 1)))/I_scale;    // -1/sqrt(3)*(iu+2*iw)
}

 /**
  * @brief Park Transform 2 axis coordinate system alpha, beta to 2 axis time invariant coordinate system d, q
  *
  * Park Transformation is a space vector transformation of three-phase time-domain signals from a
  * stationary phase coordinate system (alpha, beta) to a rotating coordinate system (d, q).
  *
  * id = ialpha*cos(phi_elec) + ibeta*sin(phi_elec)
  * iq = -ialpha*sin(phi_elec) + ibeta*cos(phi_elec)
  *
  * The sin and cos values are used elsewhere so pre-calculated values are passed to this Fn.
  * @param i_alpha in q10 format
  * @param i_beta in q10 format
  * @param i_d in q10 format
  * @param i_q in q10 format
  * @param sin_val_q15   pre-calculated sin(phi_elec)
  * @param cos_val_q15   pre-calculated cos(phi_elec)
  */
void park_transform(int Ialpha, int Ibeta, int *Id, int *Iq, int sinVal_q15, int cosVal_q15)
{
    *Id = (Ialpha * cosVal_q15 + Ibeta * sinVal_q15) >> 15;
    *Iq = (-Ialpha * sinVal_q15 + Ibeta * cosVal_q15) >> 15;
}

/**
 * @brief Inverse Park Transform 2 axis time invariant coordinate system d , q to 2 axis coordinate system alpha, beta
 *
 * v_alpha = v_d*cos(phi) - v_q*sin(phi)
 * v_beta = v_d*sin(phi) + v_q*cos(phi)
 *
 * Output format will match the Vd, Vq input format, e.g. q15 in -> q15 out. Intermediate results are limited to int.
 *
 * @param Vd
 * @param Vq
 * @param Valpha
 * @param Vbeta
 * @param sinVal_q15
 * @param cosVal_q15
 */
void inverse_park(int Vd, int Vq, int *Valpha, int *Vbeta, int sinVal_q15, int cosVal_q15)
{
    *Valpha = (Vd * cosVal_q15 - Vq * sinVal_q15) >> 15;
    *Vbeta = (Vd * sinVal_q15 + Vq * cosVal_q15) >> 15;
}

/**
 * @brief PI controller
 *
 * Executes one time-step every execution. Limits are applied to the error value,
 * integrator and output.
 *
 * The additional calculation precision (number of extra fixed point fractional bits) is set by
 * precision bits member of the PI struct instance. The gains are treated as having the same
 * precision. The gains and limit values should be determined such that the final output is
 * a Q15 value representing the range +/-1
 *
 * error_limit is based on original error_limit value and the calculated error_limit from kp and ki range
 * (make sure no overflow on proportional and integral), choose the smaller value between the two.
 * postion:kp and ki range from 0 to 2^7 -1 (127)
 *
 * position_pi:kp_ki_bits = 10             kp and ki range from 0 to 2^10-1 (1023)
 * speed_pi:kp_ki_bits = 19                kp and ki range from 0 to 2^19-1 (524287)
 * current_pi(id and iq):kp_ki_bits = 19   kp and ki range from 0 to 2^19-1 (524287)
 *
 * in order to make sure proportional + integral will not overflow, No. of bits for error_limit + kp_ki_bits = 31 - 1
 * calculated position_pi.error_limit (no overflow)= (1<<20)-1;           //30 - 10
 * calculated speed_pi.error_limit    (no overflow)= (1<<11)-1;           //30 - 19
 * calculated iq_pi.error_limit       (no overflow)= (1<<11)-1;           //30 - 19
 * calculated id_pi.error_limit       (no overflow)= (1<<11)-1;           //30 - 15
 *
 * final position_pi.error_limit = 0xf ffff
 * final speed_pi.error_limit    = 2047
 * final iq_pi.error_limit       = 2047
 * final id_pi.error_limit       = 2047
 *
 * position_pi.precision_bits = 10 - SPEED_FRAC_BITS + 2 = 8
 * speed_pi.precision_bits = 12 + SPEED_FRAC_BITS = 16
 * iq_pi.precision_bits = 10
 * id_pi.precision_bits = 10
 *
 * position_pi.integrator_limit =
 *      old position_pi.integrator_limit << precision_bits = 0
 * speed_pi.integrator_limit =
 *      old speed_pi.integrator_limit    << precision_bits = 3000 * (2^16)
 * iq_pi.integrator_limit =
 *      old iq_pi.integrator_limit       << precision_bits = 31128 * (2^10)
 * id_pi.integrator_limit =
 *      old id_pi.integrator_limit       << precision_bits = 31128 * (2^10)
 *
 * position_pi.output_limit = read from GUI then * 16
 * speed_pi.output_limit    = 3000
 * iq_pi.output_limit       = 31128
 * id_pi.output_limit       = 31128
 *
 * @param S    pointer to PI struct instance
 * @param reset set to 1 to reset the controller
 */



void pi_control_q15(pi_instance_q15 *S, int reset)
{
    //In order to make sure that setpoint - feedback is not going to overflow,
    //This function is within ISR routine, originally setpoint and feedback is calculated as below
    //Limit both of them to 31 bits including sign bit.
    //int local_setpoint = ABS_MAX(S->setpoint, (1<<30)-1);  // (1<<30)-1)=3fff ffff
    //int local_feedback = ABS_MAX(S->feedback, (1<<30)-1);  // (1<<30)-1)=3fff ffff
    //Only setpoint and feedback in position control may overflow.
    //position control:                setpoint and feedback are integer range  (32 bits including sign bit)
    //Speed control in speed demo: setpoint and feedback +/- 48000          (17 bits including sign bit)
    //Speed control in position demo:  setpoint +/- 32767 (16 bits including sign bit)
    //                              and feedback +/- 48000(17 bits including sign bit)
    //iq current control:              setpoint and feedback +/- 3000           (13 bits including sign bit)
    //id current control:              setpoint and feedback +/- 3000           (13 bits including sign bit)
    //Due to Timing request, this calculate is moved to position_control() in motor_task.c

    // This function is within ISR routine, originally the error_limit is calculated as
    //S->error_limit = MIN((1<<(31-S->kp_ki_bits))-1, S->error_limit);
    //Due to Timing request, this calculate is moved to update_axis(drive_params * dp)
    //and init_axis(drive_params * dp, system_params * sp)

    //int error_input = ABS_MAX(local_setpoint - local_feedback, S->error_limit);
    int error_input = ABS_MAX(S->setpoint - S->feedback, S->error_limit);

    // Kp and Ki have an implied shift of precision_bits. When multiplied by the integer
    // error_input, the resulting proportional and integral terms also include precision_bits
    // fractional bits.
    // This function is within ISR routine, originally the kp and ki is calculated as
    // S->kp = ABS_MAX(abs(S->kp),((1<<S->kp_ki_bits)-1));
    // S->ki = ABS_MAX(abs(S->ki),((1<<S->kp_ki_bits)-1));
    // Due to Timing request, this calculate is moved to update_axis(drive_params * dp)

    // In order to make sure no overflow, error_input * kp and error_input * ki
    // are both limited to 30 bits plus 1 sign bit
    // Limit both of them to 31 bits including sign bit, this calculation is done
    // by limit No. of bits for error_input and kp_ki_bits.
    // No. of bits for error_limit + kp_ki_bits = 31 - 1.
    int proportional = error_input*S->kp; // (1<<30)-1)=3fff ffff
    int integral =     error_input*S->ki; // (1<<30)-1)=3fff ffff



    // Limit S->integrator to 31 bits including sign bit.
    // position_pi.integrator_limit = old position_pi.integrator_limit << precision_bits = 0
    // speed_pi.integrator_limit    = old speed_pi.integrator_limit    << precision_bits = 3000 * (2^16)
    // iq_pi.integrator_limit       = old iq_pi.integrator_limit       << precision_bits = 31128 * (2^10)
    // id_pi.integrator_limit       = old id_pi.integrator_limit       << precision_bits = 31128 * (2^10)
    // Based on above values, the following line is not nessary.
    // S->integrator = ABS_MAX(S->integrator + integral, (1<<30)-1); // (1<<30)-1)=3fff ffff
    // The integrator includes extra precision bits, integer integrator_limit value is shifted
    // accordingly before use.
    // In order to save ISR time, move S->integrator_limit<<S->precision_bits from this function to init_axis() in mc.c
    // S->integrator = ABS_MAX(S->integrator + integral, S->integrator_limit<<S->precision_bits);
    S->integrator = ABS_MAX(S->integrator + integral, S->integrator_limit);
    // The result of adding the proportional term to the integrator is shifted right to remove
    // the fractional bit before comparing against the output limit.
    S->output = ABS_MAX((S->integrator + proportional) >> S->precision_bits, S->output_limit);

    if (reset) {
        // Clear the output and integrator
        S->output = 0;
        S->integrator = 0;
    }
}

/**
 * @brief PI controller reset
 *
 * Reset the output and integrator of a PI controller struct
 *
 * @param S Pointer to PI struct to reset
 */
void pi_reset_q15(pi_instance_q15 *S)
{
    S->output = 0;
    S->integrator = 0;
}

/**
 * Space Vector Modulation
 *
 * Includes inverse Clark. Creates a switching sequence for the 3 voltage phases (UVW) of the motor that
 * are equivalent to the 2 phase a & b input vectors. Additional a third harmonic voltage waveform is added
 * to the SVM output to flatten the peaks and allows the maximum modulation index to be 1.15
 * The U,V,W outputs are limited to between 0 < voltage < pwm_max and are used directly by the PWM to indicate
 * which clock cycle the PWM switches high as the PWM counts up and then low again as the PWM counts down.
 *
 * @param pwm_max Sets the maximum value for ru, rv & rw output values.
 * @param v_alpha_q15 Input Alpha voltage vector
 * @param v_beta_q15 Input Beta voltage vector
 * @param [out] ru_out PWM switching threshold for U voltage phase
 * @param [out] rv_out PWM switching threshold for V voltage phase
 * @param [out] rw_out PWM switching threshold for W voltage phase
 */
void svm(int v_alpha_q15, int v_beta_q15, unsigned short *ru_out, unsigned short *rv_out, unsigned short *rw_out)
{
    const short     c0577 = 18919 ; // 32768 / sqrt(3)
    unsigned short  tmax = platform.pwm_count;
    int             ru, rv, rw;

    // Scale inputs to maximum PWM count
    int v_alpha = (v_alpha_q15*tmax);

    v_alpha = v_alpha>>15;
    int v_beta = (v_beta_q15*tmax);

    v_beta = v_beta>>15;

    v_beta = (v_beta * c0577) >> 15;    //Note: scale by 1/sqrt(3) for *u_b* only
    if (v_alpha >= 0) {
        if (v_beta >= 0) {
            if (v_alpha < v_beta)
                goto sector_2;
            //   SVM sector 1
            rv =  v_alpha - v_beta;                 //   t1 =   u_a - u_b ;
            rw =  v_beta + v_beta;                  //   t2 =   2 * u_b ;
            ru = (tmax + rv + rw) >> 1;
            rv = ru - rv;
            rw = rv - rw;
        } else {
            if (v_alpha < -v_beta)
                goto sector_5;
            //   SVM sector 6
            rv = -v_beta - v_beta;                 //   t1 =  -2 * u_b ;
            rw =   v_alpha + v_beta;                //   t2 =  u_a + u_b ;
            ru = (tmax + rw + rv) >> 1;
            rw = ru - rw;
            rv = rw - rv;
               }
    } else {
        if (v_beta >= 0) {
            if (-v_alpha >= v_beta) {
                //   SVM sector 3
                rw =   v_beta + v_beta;              //   t1 =   2 *u_b ;
                ru =  -v_alpha - v_beta;             //   t2 = - u_a - u_b ;
                rv = (tmax + ru + rw) >> 1;
                rw = rv - rw;
                ru = rw - ru;
            } else {
sector_2:   // SVM sector 2
                rw =    v_alpha + v_beta;            //   t1 =   u_a + u_b ;
                ru =   -v_alpha + v_beta;            //   t2 =  -u_a + u_b ;
                rv = (tmax + ru + rw) >> 1;
                ru = rv - ru;
                rw = ru - rw;
            }
        } else {
            if (v_alpha < v_beta) {
                // SVM sector 4
                ru =  -v_alpha + v_beta;              //   t1 = -u_a + u_b ;
                rv =  -v_beta - v_beta;               //   t2 =  -2 * u_b ;
                rw = (tmax + ru + rv) >> 1;
                rv = rw - rv;
                ru = rv - ru;
            } else {
sector_5:
                // SVM sector 5
                ru =  -v_alpha - v_beta;              //   t1 = -u_a - u_b ;
                rv =   v_alpha - v_beta;              //   t2 =  u_a - u_b ;
                rw = (tmax + ru + rv) >> 1;
                ru = rw - ru;
                rv = ru - rv;
            }
        }
    }

    if (ru < 0) {
        ru = 0;
    } else if (ru > tmax) {
        ru = tmax;
    }
    *ru_out = (unsigned short)ru;
    if (rv < 0) {
        rv = 0;
    } else if (rv > tmax) {
        rv = tmax;
    }
    *rv_out = (unsigned short)rv;
    if (rw < 0) {
        rw = 0;
    } else if (rw > tmax) {
        rw = tmax;
    }
    *rw_out = (unsigned short)rw;
}

/*!
 * @}
 */

/*!
 * @}
 */
