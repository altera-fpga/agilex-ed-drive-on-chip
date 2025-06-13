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

#ifndef PLATFORM_H_
#define PLATFORM_H_

/**
 * @file platform.h
 *
 * @brief Header file for platform abstraction layer
 */

/*!
 * \addtogroup PLATFORM Hardware Platform Layer
 *
 * @brief Support the various hardware and RTOS platforms
 *
 * This module defines the underlying hardware platform for the Drive On Chip demo,
 * e.g., FPGA device family and powerboard.
 *
 * @{
 */

/*!
 * \addtogroup PLATFORM_SYSID_FIELDS SYSID Fields
 *
 * Bit field encoding for the QSYS SYSID
 *
 * @{
 */
#define SYSID_VERSION_MAJOR(s) ((s & 0x01F00000)>>20)      //!< DOC hardware Major version from QSYS SYSID
#define SYSID_VERSION_MINOR(s) ((s & 0x000F0000)>>16)      //!< DOC hardware Minor version from QSYS SYSID
#define SYSID_POWERBOARD_ID(s) ((s & 0x0000F000)>>12)      //!< DOC power board identifier from QSYS SYSID
#define SYSID_DEVICE_FAMILY(s) ((s & 0x00000F00)>>8)       //!< DOC device family identifier from QSYS SYSID
#define SYSID_DESIGN_ID(s)     ((s & 0x000000FF))          //!< DOC identifier from QSYS SYSID
/*!
 * @}
 */

/**
 * \cond SKIP
 */
#define SYSID_UNKNOWN    -1
/**
 * \endcond
 */

/*!
 * \addtogroup PLATFORM_SYSID_DEV SYSID Device Family Encoding
 *
 * Device family encoding for the QSYS SYSID SYSID_DEVICE_FAMILY field
 *
 * @{
 */
#define    SYSID_CIV_DE2115        0    //!< Cyclone IV On DE2-115 INK
#define    SYSID_CVE               1    //!< Cyclone VE dev kit
#define    SYSID_CVSX              2    //!< Cyclone V SX Altera dev kit
#define    SYSID_MAX10M50          3    //!< MAX 10M50 dev kit
#define    SYSID_CVSX_SOCKIT       4    //!< Cyclone VSX SoCKit
#define     SYSID_CVSX_XIP         5    //!< Cyclone VSX executing from QSPI (eXecute In Place)
#define     SYSID_CVSX_NIOS        6    //!< Cyclone VSX using NIOS
#define     SYSID_MOTOR_MODEL      7    //! Motor Model
#define    SYSID_CIV_MC            8    //!< Cyclone IV MercuryCode
#define    SYSID_SAFE_MOTOR_MODEL  9    //!< Safe Motor Model
/*!
 * @}
 */

/*!
 * \addtogroup PLATFORM_SYSID_PB SYSID Power Board Encoding
 *
 * Power board type encoding for the QSYS SYSID SYSID_POWERBOARD_ID field
 *
 * @{
 */
#define SYSID_PB_ALT12_MULTIAXIS        3       //!< Intel ALT12 multi axis power board
#define SYSID_PB_LOW_VOLTAGE            4       //!< Intel Tandem Motion Power board

#define HSMC_PRSNTN_MASK                0x80
#define HSMC_PRSNTN_SHFT                7
/*!
 * @}
 */

/*!
 * \addtogroup ADC_TYPE ADC Type Encoding
 *
 * @{
 */
#define    ADC_TYPE_SIGMA_DELTA         0       //!< Sigma-delta ADCs
#define    ADC_TYPE_MAX10               1       //!< MAX10 ADCs
/*!
 * @}
 */

/*!
 * \addtogroup COMMUTATION_TYPE Commutation Type Encoding
 *
 * @{
 */
#define    FOC_SENSOR                   0       //!< Encoder, e.g., EnDat, QEP
/*!
 * @}
 */

/**
 * @brief Structure to describe the FPGA device family
 */
typedef struct {
    int    sysid;                   //!< Identifier from Qsys SYSID
    char  *name;                    //!< Descriptive name
} device_family_t;

/**
 * @brief Structure to describe the power board
 */
typedef struct {
    int          sysid;                     //!< Identifier from Qsys SYSID
    char        *name;                      //!< Descriptive name
    unsigned int axes;                      //!< Number of axes supported
    unsigned int first_axis;                //!< Lowest operational axis
    unsigned int last_axis;                 //!< Highest operational axis
    unsigned int motors;                    //!< Bit vector of supported motor types
    unsigned int req_family;                //!< Bit vector of required device family
    unsigned int undervoltage;              //!< DC link undervoltage limit (V)
    unsigned int overvoltage;               //!< DC link overvoltage limit (V)
    unsigned int overcurrent;               //!< DC link overcurrent limit (V)
    unsigned int dc_in_undervoltage;        //!< DC input undervoltage limit (V)
    unsigned int dc_in_overvoltage;         //!< DC input overvoltage limit (V)
    unsigned int dc_in_overcurrent;         //!< DC input overcurrent limit (V)
    unsigned int pwm_max_freq;              //!< Maximum PWM frequency for this power board
} powerboard_t;

/**
 * @brief Structure to describe the hardware platform the code is running on
 */
typedef struct {
    device_family_t  *device_family;        //!< Device family decoded from Qsys SYSID
    powerboard_t     *powerboard;           //!< Power board decoded from Qsys SYSID
//    encoder_t       *encoder;                //!< Encoder type decoded from Qsys SYSID

    unsigned int      version_major;        //!< Qsys project major version number
    unsigned int      version_minor;        //!< Qsys project minor version number

    unsigned int      design_id;            //!< Magic number from Qsys SYSID
    unsigned int      first_drive;          //!< First active axis <= last_drive <= max_channel
    unsigned int      last_drive;           //!< Last active axis <= max_channel
    unsigned int      powerboard_present;   //!< Set if power board is present

    short             isr_sample_rate;      //!<Desired isr sample rate (kHz)
    short             adc_sample_rate;      //!<Desired adc sample rate (kHz)
    unsigned short    pwm_count;            //!<Maximum PWM count derived from desired sample rate
    short             commutation;          //!<Commutation mode
} platform_t;

/**
 * Instance of platform struct
 */
extern platform_t platform;

/**
 * Determine what hardware we are running on based on the FPGA SYSID component.
 *
 * For SoC hardware the FPGA must have been configured and the AXI bridges released
 * from reset.
 *
 * @param[in] sysid_base_addr The base address of the SYSID component
 * @return 0 = OK, anything else = error
 */
int decode_sysid(unsigned int sysid_base_addr);

/*!
 * @}
 */

#endif /* PLATFORM_H_ */
