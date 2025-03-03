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

#ifndef MOTOR_H_
#define MOTOR_H_

/*
 *Structure to describe motor model
 */
typedef struct {
    // CONSTANTS
    float    R_ohm;                    //!< Stator Phase resistance [Ohm]
    float    L_H;                    //!< Stator Phase Inductance [H]
    float    inv_L_H;                //!< Inverse Stator Phase Inductance [1/H]
    float    Ke_Vs_rad;                //!< Back-emf constant kE [Vs/rad]
    float    Kt_Nm_A;                //!< Motor torque constant kT [Nm/A]
    unsigned short PolePairs_int;     //!< Pole pairs (0.5*n poles) [integer]
    float    J_kgm2;                    //!< Rotor Mechanical Inertia [kgm^2]
    float    invJ_kgm2;                //!< Inverse Rotor Mechanical Inertia [1/(kgm^2)]
    short   Iphase_ADC_scale_A;     //!< Phase current ADC scale factor: number per Amp
    short   Vphase_ADC_scale_V;     //!< Phase voltage ADC scale factor: number per V
    short   V_DC_link_scale_V;      //!< DC link voltage ADC scale factor: number per V

    // INPUTS
    float load_T_Nm;                //!< Load torque
    float DC_link;                  //!< DC link voltage
    float Ts_s_20;                  //!< Integrator Sample time for 20MHz 1/(sample_time)
    float T_Nm;                        //!< Motor torque


} MotorStruct_f;

//functions are defined in motor_functio.h to avoid circular dependency

#endif //MOTOR_H_
