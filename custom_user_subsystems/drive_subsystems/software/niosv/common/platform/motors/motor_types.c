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

#include "mc/mc.h"
#include "motor_types.h"
#include "components/qep/qep.h"
#include "components/resolver/AU6805.h"

/**
 * @file motor_types.c
 *
 * @brief Source file to define motor types
 */

/*!
 * \addtogroup PLATFORM
 *
 * @{
 */

/*!
 * \addtogroup MOTORS
 *
 * @{
 */

/*
 * Initialize the motor types
 */

motor_t tamagawa_resolver[2] = {
    {
        "Tamagawa TS4747N3200E600 with resolver",
        MOTOR_TYPE_TAMAGAWA_RESOLVER,
        2,                      //!<Number of pole pairs
        3000,                   //!<Maximum speed in rpm

        /* Compromise settings that work for 32 kHz and do not cause excessive ringing at 16 kHz
         * Could be doubled for 32 kHz only operation
         */
        10000,                  //!<Iq proportional gain constant
        500,                    //!<Iq integral gain constant
        10000,                  //!<Id proportional gain constant
        500,                    //!<Id integral gain constant

        30000,                  //!<speed proportional gain constant
        10,                     //!<speed integral gain constant
        7000,                   //!<speed proportional gain constant for sensorless mode
        1,                      //!<speed integral gain constant for sensorless mode
        160,                    //!<position proportional gain constant
        0,                      //!<position integral gain constant

        //2.0,                  //!<Voltage used during calibration
        2,                      //!<Voltage used during calibration

        //The following two parameters have been multiplied by 2^15 reduce floating point operations in NIOSV, see open loop operation.
        //0.1,                  //!<An additional offset voltage for extra torque to compensate friction and cogging during open loop operation.
        3277,                   //!<An additional offset voltage for extra torque to compensate friction and cogging during open loop operation.
        //0.30*0.866,           //!< Derived from a measured volt_per_speed characteristic in FOC sensor control
        8513,                   //!< Derived from a measured volt_per_speed characteristic in FOC sensor control
                                //!< 0.866 is sqrt(3)/2 for compensatiion of svm() gain
                                //!< The original value is 0.564, it is derived from motor rated speed and voltage 5000 rpm at 48V,
                                //!< (Vrated - Vmin)/RPMrated*60, the new value 0.30*0.866 is used to reduce the power consumption in open loop

        0.227,                  //<! Single phase stator resistance (ohm) from data sheet Ra = 3xRph, Rph = 0.68/3
        0.001,                  //<! Single phase stator inductance (H) from data sheet La = 3xLph, Lph = 3.0/3mH
        167,                    //<! Maximum motor frequency (Hz) from data sheet RPM/60*2-poles

        "Encoder",
        ENCODER_TYPE_QUADRATURE,
        ENCODER_CALIBRATION_ALWAYS,
        qep_Init,
        qep_Service,
        qep_Read_Position,
        0,

        //Motor model parameters
        //Constants
        0.227f,                 //<! Stator Phase resistance [Ohm] from data sheet Ra = 3xRph, Rph = 0.68/3
        0.001f,                 //<! Stator Phase Inductance [H] from data sheet La = 3xLph, Lph = 3.0/3mH
        1000.0f,                //<! Inverse Stator Phase Inductance [1/H]
        0.033f,                 //<! Back-emf constant kE [Vs/rad] set equal to Motor Torque constant's peak phase value 0.07/3*sqrt(2)
        0.033f,                 //<! Motor torque constant kT's peak phase value 0.07/3*sqrt(2) [Nm/A]
        2,                      //<! Pole pairs (0.5*n poles) [integer]
        0.0000165f,             //<! Rotor Mechanical Inertia [kgm^2]
        60606.060606f,          //<! Inverse Rotor Mechanical Inertia [1/(kgm^2)]
        1024,                   //!<  Phase current ADC scale factor: number per Amp
                            /* Current is stored as short (16 bits signed value), so user need to make sure max current is large enough for their application,
                             *for example, 1024 means 2^15/1024: -32A to 32A. User also needs to check file ip\dspba\setup_motor_kit_sim_20MHz.m,
                             * there is a parameter called "constScaleCurrent" and it is 2^-n, n is the decimal bit in sfix16, so the user needs to make sure 2^n is equal or smaller than the value you put here.
                             * If the user has DSPBA license, then the user can also update ip\dspba\setup_motor_kit_sim_20MHz.m and regenerate VHDL for motor_kit_sim_20MHz.slx,
                             * be aware that the closer the value user put here to the 2^n, the better resolution user will get.
                             */
        545,                    //!< Phase voltage ADC scale factor: number per V
                            /* Voltage is stored as short (16 bits signed value), so users need to make sure the max voltage is large enough for their application,
                             * for example, 545 means 2^15/545: -60.1V to 60.1V. The user also needs to check file ip\dspba\setup_motor_kit_sim_20MHz.m,
                             *  there is a parameter called "constScaleVoltage" defined at demo_cfg.h  and it is 2^-n, n is the decimal bit in sfix16, so the user needs to make sure 2^n is equal or smaller than the value you put here.
                             *  If the user has DSPBA license, then the user can also update ip\dspba\setup_motor_kit_sim_20MHz.m and regenerate VHDL for motor_kit_sim_20MHz.slx,
                             *  be aware that the closer the value user put here to the 2^n, the better resolution user will get.
                             */

        545,                    //!< DC link voltage ADC scale factor: number per V
                            /* Voltage is stored as short (16 bits signed value), so users need to make sure the max voltage is large enough for their application,
                             * for example, 545 means 2^15/545: -60.1V to 60.1V. The user also needs to check file ip\dspba\setup_motor_kit_sim_20MHz.m,
                             * there is a parameter called "constScaleVoltage" defined at demo_cfg.h and it is 2^-n, n is the decimal bit in sfix16, so the user needs to make sure 2^n is equal or smaller than the value you put here.
                             * If the user has DSPBA license, then the user can also update ip\dspba\setup_motor_kit_sim_20MHz.m and regenerate VHDL for motor_kit_sim_20MHz.slx,
                             * be aware that the closer the value user put here to the 2^n, the better resolution user will get.
                             */
        591,                    //!< Used in clarke_transform, not for motor model,  1/sqrt(3)*Iphase_ADC_scale_A: for example, if Iphase_ADC_scale_A = 1024 CurrentParameter = 591


        //Inputs
        0.0f,                   //!< Load torque
        32.0f,                  //<! DC link voltage
        0.001f/(20000.0f),      //!< Integrator Sample time for 20MHz 1/(sample_time)
        //Outputs
        0.0f,                   //!< Motor torque

        //Drive data structures initialization required in mc.c init_axis
        3000,
        10 - SPEED_FRAC_BITS + 2,
        10,
        12 + SPEED_FRAC_BITS,
        19,
        0,
        10,
        19,
        ((((int)1<<15)-1)*95)/100,
        10,
        19,
        ((((int)1<<15)-1)*95)/100


    },
    {
        "Tamagawa TS4747N3200E600 with resolver",
        MOTOR_TYPE_TAMAGAWA_RESOLVER,
        2,                      //!<Number of pole pairs
        3000,                   //!<Maximum speed in rpm

        /* Compromise settings that work for 32 kHz and do not cause excessive ringing at 16 kHz
         * Could be doubled for 32 kHz only operation
         */
        10000,                  //!<Iq proportional gain constant
        500,                    //!<Iq integral gain constant
        10000,                  //!<Id proportional gain constant
        500,                    //!<Id integral gain constant

        30000,                  //!<speed proportional gain constant
        10,                     //!<speed integral gain constant
        7000,                   //!<speed proportional gain constant for sensorless mode
        1,                      //!<speed integral gain constant for sensorless mode
        160,                    //!<position proportional gain constant
        0,                      //!<position integral gain constant

        //2.0,                  //!<Voltage used during calibration
        2,                      //!<Voltage used during calibration

        //The following two parameters have been multiplied by 2^15 reduce floating point operations in NIOSV, see open loop operation.
        //0.1,                  //!<An additional offset voltage for extra torque to compensate friction and cogging during open loop operation.
        3277,                   //!<An additional offset voltage for extra torque to compensate friction and cogging during open loop operation.
        //0.30*0.866,           //!< Derived from a measured volt_per_speed characteristic in FOC sensor control
        8513,                   //!< Derived from a measured volt_per_speed characteristic in FOC sensor control
                                //!< 0.866 is sqrt(3)/2 for compensatiion of svm() gain
                                //!< The original value is 0.564, it is derived from motor rated speed and voltage 5000 rpm at 48V,
                                //!< (Vrated - Vmin)/RPMrated*60, the new value 0.30*0.866 is used to reduce the power consumption in open loop

        0.227,                  //<! Single phase stator resistance (ohm) from data sheet Ra = 3xRph, Rph = 0.68/3
        0.001,                  //<! Single phase stator inductance (H) from data sheet La = 3xLph, Lph = 3.0/3mH
        167,                    //<! Maximum motor frequency (Hz) from data sheet RPM/60*2-poles

        "Encoder",
        ENCODER_TYPE_QUADRATURE,
        ENCODER_CALIBRATION_ALWAYS,
        qep_Init,
        qep_Service,
        qep_Read_Position,
        0,

        //Motor model parameters
        //Constants
        0.227f,                 //<! Stator Phase resistance [Ohm] from data sheet Ra = 3xRph, Rph = 0.68/3
        0.001f,                 //<! Stator Phase Inductance [H] from data sheet La = 3xLph, Lph = 3.0/3mH
        1000.0f,                //<! Inverse Stator Phase Inductance [1/H]
        0.033f,                 //<! Back-emf constant kE [Vs/rad] set equal to Motor Torque constant's peak phase value 0.07/3*sqrt(2)
        0.033f,                 //<! Motor torque constant kT's peak phase value 0.07/3*sqrt(2) [Nm/A]
        2,                      //<! Pole pairs (0.5*n poles) [integer]
        0.0000165f,             //<! Rotor Mechanical Inertia [kgm^2]
        60606.060606f,          //<! Inverse Rotor Mechanical Inertia [1/(kgm^2)]
        1024,                   //!<  Phase current ADC scale factor: number per Amp
                            /*current is stored as short (16 bits signed value), so user need to make sure max current is large enough for their application,
                             * for example, 1024 means 2^15/1024: -32A to 32A. User also needs to check file ip\dspba\setup_motor_kit_sim_20MHz.m,
                             * there is a parameter called "constScaleCurrent" and it is 2^-n, n is the decimal bit in sfix16, so the user needs to make sure 2^n is equal or smaller than the value you put here.
                             * If the user has DSPBA license, then the user can also update ip\dspba\setup_motor_kit_sim_20MHz.m and regenerate VHDL for motor_kit_sim_20MHz.slx,
                             * be aware that the closer the value user put here to the 2^n, the better resolution user will get.
                             */
        545,                    //!< Phase voltage ADC scale factor: number per V
                            /* Voltage is stored as short (16 bits signed value), so users need to make sure the max voltage is large enough for their application,
                             *  for example, 545 means 2^15/545: -60.1V to 60.1V. The user also needs to check file ip\dspba\setup_motor_kit_sim_20MHz.m,
                             *  there is a parameter called "constScaleVoltage" defined at demo_cfg.h and it is 2^-n, n is the decimal bit in sfix16, so the user needs to make sure 2^n is equal or smaller than the value you put here.
                             *  If the user has DSPBA license, then the user can also update ip\dspba\setup_motor_kit_sim_20MHz.m and regenerate VHDL for motor_kit_sim_20MHz.slx,
                             *  be aware that the closer the value user put here to the 2^n, the better resolution user will get.
                             */

        545,                    //!< DC link voltage ADC scale factor: number per V
                            /* Voltage is stored as short (16 bits signed value), so users need to make sure the max voltage is large enough for their application,
                             * for example, 545 means 2^15/545: -60.1V to 60.1V. The user also needs to check file ip\dspba\setup_motor_kit_sim_20MHz.m,
                             * there is a parameter called "constScaleVoltage" defined at demo_cfg.h and it is 2^-n, n is the decimal bit in sfix16, so the user needs to make sure 2^n is equal or smaller than the value you put here.
                             * If the user has DSPBA license, then the user can also update ip\dspba\setup_motor_kit_sim_20MHz.m and regenerate VHDL for motor_kit_sim_20MHz.slx,
                             * be aware that the closer the value user put here to the 2^n, the better resolution user will get.
                             */
        591,                    //!< Used in clarke_transform, not for motor model,  1/sqrt(3)*Iphase_ADC_scale_A: for example, if Iphase_ADC_scale_A = 1024 CurrentParameter = 591

        //Inputs
        0.0f,                   //!< Load torque
        32.0f,                  //<! DC link voltage
        0.001f/(20000.0f),      //!< Integrator Sample time for 20MHz 1/(sample_time)
        //Outputs
        0.0f,                   //!< Motor torque

        //Drive data structures initialization required in mc.c init_axis
        3000,
        10 - SPEED_FRAC_BITS + 2,
        10,
        12 + SPEED_FRAC_BITS,
        19,
        0,
        10,
        19,
        ((((int)1<<15)-1)*95)/100,
        10,
        19,
        ((((int)1<<15)-1)*95)/100
        }
};


/*!
 * @}
 */

/*!
 * @}
 */
