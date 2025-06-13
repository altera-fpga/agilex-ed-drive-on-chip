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

#ifndef MOTOR_TYPES_H_
#define MOTOR_TYPES_H_

#include "mc/mc_params.h"

/**
 * @file motor_types.h
 *
 * @brief Header file to define motor types
 */

/*!
 * \addtogroup PLATFORM
 *
 * @{
 */

/*!
 * \addtogroup MOTORS Motors
 *
 * @{
 */

/*!
 * \addtogroup MOTOR_TYPE Motor Type Encoding
 *
 * @{
 */
#define TAMAGAWA_RESOLVER           3       //!< Tamagawa TS4747N3200E600 with resolver

#define MOTOR_TYPE_TAMAGAWA_RESOLVER (1<<TAMAGAWA_RESOLVER)
/*!
 * @}
 */

/*!
 * \addtogroup MOTOR_ENCODER_TYPE Encoder Type Encoding
 *
 * @{
 */
#define    ENCODER_TYPE_RESOLVER    2       //!< Resolver
#define    ENCODER_TYPE_QUADRATURE  3       //!< Quadrature encoder

#define SYSID_ENCODER_TEST          7
/*!
 * @}
 */

/*!
 * \addtogroup MOTOR_ENCODER_CALIBRATION Encoder Calibration method
 *
 * @{
 */
#define    NO_ENCODER_CALIBRATION       -1  //!< e.g. hall
#define    ENCODER_CALIBRATION_ALWAYS   0   //!< Always calibrate at startup, e.g., QEP, Resolver


/*!
 * @}
 */

typedef struct motor_t motor_t;

/**
 * @brief Structure to describe a motor
 */
struct motor_t {
    // Motor parameters
    char *motor_name;               //!<Pointer to descriptive motor name
    int motor_type;                    //!<motor type
    char pole_pairs;                //!<Number of pole pairs
    int speed_limit;                //!<Maximum speed in rpm

    int iq_kp;                      //!<Iq proportional gain constant
    int iq_ki;                      //!<Iq integral gain constant
    int id_kp;                      //!<Id proportional gain constant
    int id_ki;                      //!<Id integral gain constant

    int speed_kp;                   //!<speed proportional gain constant
    int speed_ki;                   //!<speed integral gain constant
    int speed_kp_sl;                //!<speed proportional gain constant for sensorless mode
    int speed_ki_sl;                //!<speed integral gain constant for sensorless mode
    int pos_kp;                     //!<position proportional gain constant
    int pos_ki;                     //!<position integral gain constant

    //const float calibration_v;    //!<Voltage used during calibration
    const long int calibration_v;   //!<Voltage used during calibration

    //float V_min_f;                //!< minimum voltage to apply during open loop operation
    int V_min_f;                    //!< minimum voltage to apply during open loop operation
    //float v_per_hz_gain_f;        //!< Derived from motor rated speed and voltage
    int v_per_hz_gain_f;            //!< Derived from motor rated speed and voltage

    float  rs;                      //!< Single phase stator resistance (ohm)
    float  ls;                      //!< Single phase stator inductance (H)
    float  Max_Frequency;           //!< Maximum motor electrical frequency (Hz)

    // Encoder parameters
    char *encoder_name;             //!<pointer to descriptive encoder name
    int encoder_type;               //!<Encoder type
    const short calibration_method;
                                    //!<Pointer to encoder initialisation function
    int (*encoder_init_fn)(drive_params *dp);
                                    //!<Pointer to encoder service function
    void (*encoder_service_fn)(drive_params *dp, system_params *sp);
                                    //!<Pointer to encoder position read function
    void (*encoder_read_position_fn)(drive_params *dp, system_params *sp);
                                    //!<Direction for quadrature encoders 1 = change direction for default CCW rotation
    int dir;

    //Intrinsic motor parameters that are needed to model motors
    // CONSTANTS
    float    R_ohm;                 //!< Stator Phase resistance [Ohm]
    float    L_H;                   //!< Stator Phase Inductance [H]
    float    inv_L_H;               //!< Inverse Stator Phase Inductance [1/H]
    float    Ke_Vs_rad;             //!< Back-emf constant kE [Vs/rad]
    float    Kt_Nm_A;               //!< Motor torque constant kT [Nm/A]
    unsigned short PolePairs_int;   //!< Pole pairs (0.5*n poles) [integer]
    float    J_kgm2;                //!< Rotor Mechanical Inertia [kgm^2]
    float    invJ_kgm2;             //!< Inverse Rotor Mechanical Inertia [1/(kgm^2)]
    short   Iphase_ADC_scale_A;     //!< Phase current ADC scale factor: number per Amp
    short   Vphase_ADC_scale_V;     //!< Phase voltage ADC scale factor: number per V
    short   V_DC_link_scale_V;      //!< DC link voltage ADC scale factor: number per V
    short   CurrentParameter;       //!< Used in clarke_transform, not for motor model,  1/sqrt(3)*Iphase_ADC_scale_A: for example, if Iphase_ADC_scale_A = 1024 CurrentParameter = 591

    // INPUTS
    float load_T_Nm;                //!< Load torque
    float DC_link;                  //!< DC link voltage
    float Ts_s_20;                  //!< Integrator Sample time for 20MHz 1/(sample_time)

    // OUTPUTS
    float T_Nm;                     //!< Motor torque

    //Drive data structures initialization required in mc.c init_axis
    short i_sat_limit;
    int position_pi_precision_bits;
    int position_pi_kp_ki_bits;
    int speed_pi_precision_bits;
    int speed_pi_kp_ki_bits;
    int id_pi_setpoint;
    int id_pi_precision_bits;
    int id_pi_kp_ki_bits;
    int id_pi_output_limit;
    int iq_pi_precision_bits;
    int iq_pi_kp_ki_bits;
    int iq_pi_output_limit;

};

extern motor_t tamagawa_resolver[2];

// Array to hold motor types for each axis.
extern motor_t *motors[4];

#endif /* MOTOR_TYPES_H_ */

/*!
 * @}
 */

/*!
 * @}
 */
