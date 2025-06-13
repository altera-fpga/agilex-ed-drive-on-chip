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

#ifndef MC_PARAMS_H_
#define MC_PARAMS_H_

#include "system.h"
#include "system_shim.h"
#include "demo_cfg.h"
#include "math.h"

typedef struct system_params system_params;
typedef struct drive_params drive_params;

#include "components/encoder.h"
#include "mc/mc_dsp.h"
#include "platform/motors/motor_types.h"
#include "platform/platform_linker.h"
#include "sin_cos_q15.h"
#include "perf/altera_avalon_performance_counter.h"

#include "motorsim/motor_functions.h"        //motor mode

/**
 * @file mc.h
 *
 * @brief Header file for motor control demo
 */

/*!
 * \addtogroup MC
 *
 * @{
 */

//Macro to check saturation when casting from float to short
//APP_DRIVE_SIM
#define SHRT_MAX_F    ((float)32767)
#define SHRT_MIN_F    ((float)(-32768))

// Macros to help convert Q format to float
#define SHIFTR10FLOAT ((float)(1.0f / (1<<10)))
#define SHIFTR14FLOAT ((float)(1.0f / (1<<14)))
#define SHIFTR15FLOAT ((float)(1.0f / (1<<15)))
#define SHIFTR16FLOAT ((float)(1.0f / (1<<16)))
#define SHIFTR17FLOAT ((float)(1.0f / (1<<17)))

// Macros to help convert float to Q format
#define SHIFTL10FLOAT ((float)(1.0f * (1<<10)))
#define SHIFTL14FLOAT ((float)(1.0f * (1<<14)))    //used in motor model
#define SHIFTL15FLOAT ((float)(1.0f * (1<<15)))
#define SHIFTL16FLOAT ((float)(1.0f * (1<<16)))
#define SHIFTL17FLOAT ((float)(1.0f * (1<<17)))

// Sliding Mode Observer Macros
#define INTEGER_MAX         32768
#define ONE_BY_THREE        ((float)0.333333333333)
#define ONE_BY_SQRT_THREE   ((float)0.577350269189)

#define SIN_FN(a) (sin_q15((a)>>1))
#define COS_FN(a) (cos_q15((a)>>1))

#define TRACKER_ENABLE    1    // Enable/Disable angle tracking observer


/**
 * @brief Enumeration to reflect application state
 *
 * Values must be consistent with gui
 */
typedef enum {
    APP_IDLE                 = 0,    //!< Not started yet
    APP_INIT                 = 1,    //!< Initialization
    APP_DRIVE_INIT           = 2,    //!< Drive initialization
    APP_PWM_INIT             = 3,    //!< PWM initialization
    APP_WAIT_POWER           = 4,    //!< Wait for power board DC input valid
    APP_POWER_OK             = 5,    //!< Wait for power board DC input valid
    APP_ADC_CALIBRATION      = 6,    //!< ADC Calibration
    APP_ADC_CALIBRATED       = 7,    //!< ADC Calibration complete
    APP_ADC_FAIL             = 8,    //!< ADC calibration failed
    APP_INIT_DCDC            = 9,    //!< Initialize DCDC converter
    APP_ENCODER_SERVICE      = 10,   //!< Encoder calibration
    APP_LOOPBACK             = 11,   //!< Loopback mode
    APP_DCDC_OK              = 12,   //!< In dcdc_ok loop
    APP_ENCODER_CALIBRATION  = 13,   //!< Encoder calibration
    APP_ENCODER_RESET        = 14,   //!< Encoder reset
    APP_ENCODER_CALIBRATED   = 15,   //!< Encoder calibration complete
    APP_ENCODER_CAL_DONE     = 16,   //!< Encoder calibration complete
    APP_DRIVE_ENABLED        = 17,   //!< In inner loop enabling drives or running
    APP_DRIVE_RESTART        = 20    //!< Drive restarting due to error
} app_state_e;

/**
 * @brief Enumeration to control numeric processing
 *
 * Values must be consistent with gui
 */
typedef enum {
    SOFT_FIXP         = 0,    //!< Software fixed point
    DSPBA_FIXP        = 1,    //!< Hardware fixed point
} calc_type_e;

/**
 * @brief Enumeration to control demo selection
 *
 * Values must be consistent with gui
 */
typedef enum {
    DEMO_RESET                      = 0,    //!< Reset
    DEMO_OPEN_LOOP_SINE_16          = 1,    //!< Open loop Sinusoidal Volts/Hz  (keep)
    DEMO_OPEN_LOOP_SINE_32          = 2,    //!< Open loop Sinusoidal Volts/Hz   (keep)
    DEMO_FOC_SENSOR_16_2            = 5,    //!< FOC sensor 16kHz dual axis
    DEMO_FOC_SENSOR_32_2            = 6,    //!< FOC sensor 32kHz dual axis     (?)
    DEMO_FOC_SENSOR_DSP_FIXED_64_2  = 12    //!< FOC sensor 64kHz single axis  (keep)
} demo_mode_e;

/**
 * @brief Structure to encapsulate the per-axis ADC samples
 */
typedef struct {
    short iu_measure;        //!< Motor phase U current
    short iu;                //!< Motor phase U estimate current, calculated from iv and iw
    short iv;                //!< Motor phase V current
    short iw;                //!< Motor phase W current

    short vu;                //!< Motor phase U voltage
    short vv;                //!< Motor phase V voltage
    short vw;                //!< Motor phase W voltage

    short offset_u;          //!< Phase U current zero offset
    short offset_v;          //!< Phase V current zero offset
    short offset_w;          //!< Phase W current zero offset
    int offset_u_acc;        //!< Phase U current zero offset accumulator
    int offset_v_acc;        //!< Phase V current zero offset accumulator
    int offset_w_acc;        //!< Phase W current zero offset accumulator
} drive_adc_t;

/**
 * @brief Structure to encapsulate the platform ADC samples
 */
typedef struct {
    short dc_dc_v_fb;        //!< DC-DC output voltage (DC link voltage)
} platform_adc_t;

/**
 * @brief Structure to encapsulate the system parameters
 */
struct system_params {
    int             lvmc_adc_type;          //!< Select ADC source
    demo_mode_e     demo_mode;              //!< Demo mode
    calc_type_e     dsp_mode;               //!< DSP calculation mode
    app_state_e     app_state;              //!< Application state
    int             axis_select;            //!< Axis selection for debug trace
    int             interactive_start;      //!< Controls interactive startup mode

    int             latency1;               //!< Latency measurement data
    int             latency2;               //!< Latency measurement data
    int             latency3;               //!< Latency measurement data

    platform_adc_t  sd_platform_adc;        //!< Struct to hold platform sigma-delta ADC readings
    platform_adc_t  max10_platform_adc;     //!< Struct to hold platform MAX 10 ADC readings

    // DC Link (inc DC-DC boost converter) variables
    short           dc_dc_v_scaled;         //!< DC link voltage scaled to volts
    short           dc_dc_cmd_v;            //!< Requested DC link voltage
};
/**
 * PI Controller data structure (floating point)
 */
typedef struct{
    float output;           //!< The output correction value A0 = Kp + Ki .
    float integrator;       //!< The integrator value.
    float Kp;               //!< The proportional gain coefficient
    float Ki;               //!< The integral gain coefficient
    float setpoint;         //!< Setpoint input.
    float feedback;         //!< Feedback input.
    float error_limit;      //!< Saturation limit for error value
    float integrator_limit; //!< Saturation limit for integrator
    float output_limit;     //!< Saturation limit for output
} pi_instance_f;

/**
 * Motor and driver parameters data structure for SMO based sensorless FOC
 */
typedef struct{
    float voltage_scalar;    //!< Multiplier to scale ADC value to volts
} motor_driver_params;

/**
 * @brief Structure to encapsulate the parameters for a drive axis
 */
struct drive_params {
    unsigned short   drive;

    unsigned int     DOC_ADC_BASE_ADDR;
    unsigned int     DOC_ADC_POW_BASE_ADDR;
    unsigned int     DOC_QEP_BASE_ADDR;
    unsigned int     DOC_RSLVR_PIO_BASE_ADDR;
    unsigned int     DOC_RSLVR_SPI_CTRL_BASE_ADDR;
    unsigned int     DOC_RSLVR_SPI_POSN_BASE_ADDR;
    unsigned int     DOC_PWM_BASE_ADDR;
    unsigned int     DOC_SM_BASE_ADDR;
    unsigned int     DOC_FOC_BASE_ADDR;
    unsigned int     DOC_MOTORMODEL_BASE_ADDR;


    struct motor_t *motor;          //!<Pointer to motor parameters struct
    MotorStruct_f motor_mdl;        //!<motor model struct

    //################################################################################################
    //Variables of Iq and Id Controls
    //################################################################################################

    short i_sat_limit;                //!<Current saturation limit
    short v_sat_limit;                //!<Voltage saturation limit

    int     id;                       //!<Direct Current
    int     iq;                       //!<Quadrature Current

    int     sin_phi_q15;
    int     cos_phi_q15;

    int     v_alpha_q15;              //!<Alpha Voltage
    int     v_beta_q15;               //!<Beta Voltage
    int     v_alpha_ol_q15;           //!<Alpha Voltage during open loop comtrol
    int     v_beta_ol_q15;            //!<Beta Voltage during open loop control

    int     vd_q15;                   //!<Direct voltage
    int     vq_q15;                   //!<Quadrature voltage

    int     i_alpha;                  //!<Alpha Current
    int     i_beta;                   //!<Beta Current

    unsigned short     vu_pwm;        //!<Vu (U voltage setting for PWM)
    unsigned short     vw_pwm;        //!<Vw (W voltage setting for PWM)
    unsigned short     vv_pwm;        //!<Vv (V voltage setting for PWM)

    int     i_command_q;              //!<Quadrature Current Command

    //Define PI controller structures
    pi_instance_q15 id_pi;            //!<FOC Direct Current PI controller
    pi_instance_q15 iq_pi;            //!<FOC Quadrature Current PI controller
    pi_instance_q15 speed_pi;         //!<Speed PI controller
    pi_instance_q15 position_pi;      //!<Position PI controller

    //################################################################################################
    //Variables of SMO Position and Speed Feedback
    //################################################################################################

    // Added to support passing of parameters to initialization functions
    motor_driver_params mdp;          //!< motor and driver parameters for SMO calcs
    unsigned int switch_count;        //!< Counter to determine when to switch to sensorless during startup


    //################################################################################################
    //ADC readings
    //################################################################################################
    volatile int Offset_start_calc;

    drive_adc_t sd_drive_adc;        //!< Struct to hold per-axis sigma-delta ADC readings
    drive_adc_t max10_drive_adc;     //!< Struct to hold per-axis MAX 10 ADC readings

    //################################################################################################
    //Variables of Iq and Id Controls (For Floating Point)
    //################################################################################################
    float    sin_phi_f;
    float    cos_phi_f;

    float   id_f;                    //!<Direct Current
    float   iq_f;                    //!<Quadrature Current)

    float   i_alpha_f;               //!<Alpha Current
    float   i_beta_f;                //!<Beta Current

    float   iu_f;                    //!<Phase U feedback current input
    float   iw_f;                    //!<Phase W feedback current input

    float   v_alpha_f;               //!<Alpha Voltage
    float   v_beta_f;                //!<Beta Voltage

    float   vd_f;                    //!<Vd output
    float   vq_f;                    //!<Vq output

    //Define Floating Point PI controller structures
    pi_instance_f i_d_pi_f;          //!<FOC Direct Current PI Controller
    pi_instance_f i_q_pi_f;          //!<FOC Quadrature Current PI Controller

    //################################################################################################
    //Angle variables
    //################################################################################################
    unsigned short  phi_mech;        //!<Mechanical Angle
    unsigned short  phi_elec;        //!<Electrical Angle

    //################################################################################################
    //Encoder Variables
    //################################################################################################
    short   enable_drive;            //!<Enables the PWM output
    short   pos_speed_demo_mode;     //!<Enables speed or position control depending on demo selected

    //################################################################################################
    //Encoder variables
    //################################################################################################
    encoder_struct encoder;

    //################################################################################################
    //Variables of speed control
    //################################################################################################
    int             speed_limit;            //!<Speed is limited to this value, RPM, scaled by SPEED_FRAC_BITS
    int             min_speed;              //!<minimum speed for sensorless, RPM, scaled by SPEED_FRAC_BITS
    int             speed_request;          //!<Speed request from gui, scaled by SPEED_FRAC_BITS
    int             pos_request;            //!<Position request from gui
    int             pos_speed_limit;        //!<Position PI controller output limit, scaled by SPEED_FRAC_BITS
    unsigned short  open_loop_idx_q16;      //!<Rotor electrical angle, 0..2^16 = 0..360deg//angle increase in 62.5us
    int             v_req_volts_f;          //!<Calculated voltage to apply
    int             pwm_request_q15;        //!<PWM count required based on PWM max count and available DC link voltage

    //################################################################################################
    //Variables of position control
    //################################################################################################
    int    pos_turns;                    //!<Whole turn count
    int    pos_16q16;                    //!<Multiturn position scaled for PI
    int    pos_16q16_avg;                //!<Multiturn position scaled for PI average

    //################################################################################################
    //Control variables
    //################################################################################################

    unsigned short status_word;
    unsigned short state_act, state_act_old, state_next;

    int reset_control;                  //!<Resets the FOC control algorithm (PI control & Filter)

};
/**
 * @brief PI controller reset
 *
 * Reset the output and integrator of a PI controller struct
 *
 * @param S Pointer to PI struct to reset
 */
static inline void PI_reset_f(pi_instance_f *S)
{
    S->output = 0;
    S->integrator = 0;
}

/*!
 * @}
 */

#endif /* MC_PARAMS_H_ */
