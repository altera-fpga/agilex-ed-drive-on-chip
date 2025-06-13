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

#ifndef MC_DEBUG_H_
#define MC_DEBUG_H_

#include "mc/mc_params.h"

/**
 * @file mc_debug.h
 *
 * @brief Header file for interface functions for system console debug GUI
 */

/*!
 * \addtogroup DEBUG
 *
 * @brief Support for debug information via system console GUI and console
 *
 * @{
 */

#define DEBUG_ADDR_SPACE_PER_AXIS       66        //!< Size (32 but words) of debug memory for each axis

/*!
 * \addtogroup DEBUG_MEM_ADDR Debug Memory Map
 *
 * Word (32-bit) addresses for debug memory
 *
 * @{
 */
// (WORD) ADDRESS MAP FOR DEBUG MEMORY
// Write-only registers will polled only by System Console
// Read-only registers (including button registers) will be polled in main loop

// General Drive Status (Write only)
#define DOC_DBG_DRIVE_STATE                 0
#define DOC_DBG_RUNTIME                     1
#define DOC_DBG_DSP_MODE                    2
#define DOC_DBG_APP_STATE                   3
#define DOC_DBG_LATENCY1                    4
#define DOC_DBG_DUMP_MODE                   5
#define DOC_DBG_TRIG_SEL                    6
#define DOC_DBG_TRIG_EDGE                   7
#define DOC_DBG_TRIG_VALUE                  8

// Drive Performance Status (Write only)
#define DOC_DBG_SPEED                       10        //<! Speed feedback (read)
#define DOC_DBG_POSITION                    12        //<! Position feedback (read)
#define DOC_DBG_BUTTON_DSP_MODE             13        //<! Mode  Software/DSP BA hardware
#define DOC_DBG_BUTTON_DRIVE_RESET          14
#define DOC_DBG_DEMO_MODE                   15        //<! Demo mode, i.e., commutation, control algorithm, etc.

#define DOC_DBG_I_PI_KP                     18        //<! Current control Kp
#define DOC_DBG_I_PI_KI                     19        //<! Current control Ki
#define DOC_DBG_SPEED_PI_KP                 20        //<! Speed control Kp
#define DOC_DBG_SPEED_PI_KI                 21        //<! Speed control Ki
#define DOC_DBG_SPEED_SETP0                 22        //<! Speed set point or command
#define DOC_DBG_AXIS_SELECT                 23        //<! Select to write on different axis

#define DOC_DBG_POS_SETP0                   25        //<! Position set point or command

#define DOC_DBG_WAVE_DEMO_MODE              29        //<! Speed/position waveform demo mode
#define DOC_DBG_POS_SPEED_LIMIT             30        //<! Speed limit for position mode demos
#define DOC_DBG_POS_PI_KP                   31        //<! Speed control Kp

#define DOC_DBG_WAVE_DEMO_PERIOD            33        //<! Speed/position demo waveform period
#define DOC_DBG_WAVE_DEMO_OFFSET            34        //<! Speed/position demo waveform time offset
#define DOC_DBG_WAVE_DEMO_WAVEFORM          35        //<! Speed/position demo waveform shape
#define DOC_DBG_WAVE_DEMO_AMP_F             36        //<! Speed/position demo waveform amplitude

#define DOC_DBG_DCDC_V_SETP0                44
#define DOC_DBG_DC_DC_V_LINK                54
#define DOC_DBG_ADC_TYPE                    55
#define DOC_DBG_LATENCY2                    56
#define DOC_DBG_LATENCY3                    57
#define DOC_DBG_TRACE_DEPTH                 58        //<! Waveform trace depth
#define DOC_DBG_TRIGGER_POS                 59        //<! Waveform trigger position
#define DOC_DBG_TRACE_SAMPLES               60        //<! Waveform trace sample skip
#define DOC_DBG_DEMO_UPDATE                 61        //<! Waveform demo update flag


/**
 * \addtogroup TRIGGER_SELECTS Debug Trigger Select Macros
 *
 * Trigger encodings for system console GUI waveform trigger selection. Encoding MUST match the list order used in
 * the creation of triggersigcombo in the tcl gui.
 *
 * @{
 */
#define TRIGGER_ALWAYS                    0

#define TRIGGER_VU_PWM                    1
#define TRIGGER_VV_PWM                    2
#define TRIGGER_VW_PWM                    3

#define TRIGGER_IU                        4
#define TRIGGER_IW                        5
#define TRIGGER_IV                        6

#define TRIGGER_SPD_CMD                   7
#define TRIGGER_SPD                       8
#define TRIGGER_SPD_EST                   9

#define TRIGGER_ID                        10
#define TRIGGER_IQ                        11
#define TRIGGER_IQ_CMD                    12

#define TRIGGER_POS                       13
#define TRIGGER_POS_CMD                   14

#define TRIGGER_ENABLE_DRIVE              15
#define TRIGGER_APP_STATE                 16

#define TRIGGER_VU                        18
#define TRIGGER_VV                        19
#define TRIGGER_VW                        20

#define TRIGGER_DCDC_V                    23
#define TRIGGER_BOOST0_I                  25
#define TRIGGER_BOOST1_I                  26

#define TRIGGER_IU_MEASURE                27

#define TRIGGER_EQUAL                     0
#define TRIGGER_RISING_EDGE               1
#define TRIGGER_FALLING_EDGE              2
#define TRIGGER_ANY_EDGE                  3
/*!
 * @}
 */

/*!
 * \addtogroup DEBUG_FUNCTIONS Debug Function Macros
 *
 * Macros for debug memory access functions
 *
 * @{
 */
#define debug_base_addr(dn, word_offset) (SYS_CONSOLE_DEBUG_RAM_BASE +\
                        (dn * DEBUG_ADDR_SPACE_PER_AXIS * 4) + (word_offset * 4))
#define debug_write_status(dn, reg_word_addr, value)\
            {IOWR_32DIRECT(debug_base_addr(dn, 0), reg_word_addr * 4, value); }
#define debug_write_status_float(dn, reg_word_addr, value)\
                        (IOWR_FLOATDIRECT(debug_base_addr(dn, 0), reg_word_addr * 4, value))
#define debug_read_command(dn, reg_word_addr) (IORD_32DIRECT(debug_base_addr(dn, 0), reg_word_addr * 4))
#define debug_read_command_float(dn, reg_word_addr) (IORD_FLOATDIRECT(debug_base_addr(dn, 0), reg_word_addr * 4))
/*!
 * @}
 */

/**
 * @brief Initialize drive parameters in the gui
 *
 */
void write_to_gui(void);

/**
 * @brief Put new values passed from system console GUI into drive parameters
 *
 * You should only call this if the app is in a suitable state to accept input from the GUI.
 *
 */
void read_from_gui(void);

/**
 * @brief Dump selected data to system console Tcl GUI
 *
 * @param dp            pointer to drive_params struct
 * @param sp            pointer to system_params struct
 */
void dump_data(const drive_params *dp, const system_params *sp) IRQ_SECTION;

/*!
 * \addtogroup DEBUG_MSG Debug Message Handling
 *
 * Mechanism to handle debug output to console
 *
 * @{
 */

#define MAX_DEBUG_MSG         256        //!< Maximum debug mesage length
#define MAX_DEBUG_QUEUE       256        //!< Debug mesage queue depth

/*!
 * \addtogroup DEBUG_FILTER Debug output levels
 *
 * Values used to filter console output
 *
 * @{
 */
#define DBG_NEVER               0       //!< No output
#define DBG_ALWAYS              1       //!< Always output
#define DBG_FATAL               10      //!< Fatal error
#define DBG_ERROR               20      //!< Non-fatal error
#define DBG_WARN                30      //!< Warning
#define DBG_INFO                40      //!< Information
#define DBG_PERF                50      //!< Performance data
#define DBG_DEBUG               60      //!< Debug
#define DBG_DEBUG_MORE          70      //!< More debug
#define DBG_ALL                 100     //!< Everything
/*!
 * @}
 */

/**
 * @brief Current debug level
 */
extern unsigned int dbg_level;

/**
 * @brief Initialise the debug system
 */
void init_debug_output(void);

/**
 * @brief Thread safe, non-blocking, printf() for debug output to console
 *
 * If the priority filter value is less than the current dbg_level value then the output is added
 * to the queue to be handled later by the debug_task.
 *
 * @param priority    Priority filter value
 * @param format    Format string
 * @return            0 = OK, otherwise output could not be added to queue (queue full)
 */
int debug_printf(unsigned int priority, char *format, ...);

/*!
 * @}
 */

/**
 * @brief Non-blocking wait for console input
 *
 * @param level    debug level for message
 * @param str    Prompt string
 *
 * @return        input char
 */
char debug_waitchar(int level, char *str, int en);

/**
 * @brief Check waveform input parameters have been updated
 *
 * @return    int
 * @retval  0 - params have not been updated
 * @retval  non-zero - params have been updated
 */
int debug_waveform_demo_update_check(void);

/**
 * @brief Clear update flag to signal input parameters have read
 *
 * @return    void
 */
void debug_waveform_demo_update_clear(void);

/**
 * @brief Retrieve new waveform input parameters
 *
 * @param drive_index - int - index of drive axis
 * @param waveform - waveform_input_params_t* - pointer to input parameters structure
 *
 * @return int
 * @retval  -1 - params have not been updated
 * @retval  0 - params have been updated
 */
int debug_waveform_demo_parameters(int drive_index, waveform_input_params_t *waveform);

/**
 * @brief Write Performance Measurement parameters to output i/f
 *
 * @param latency1 - int - first performance parameter
 * @param latency2 - int - second performance parameter
 *
 * @return None
 */
void debug_set_latency(int latency1, int latency2);

void debug_update_drive_params(int drive_index, unsigned short state, int speed, int pos);

void debug_update_sys_params(app_state_e app_state, calc_type_e dsp_mode, short dc_dc_v_fb);

/**
 * @brief Checks for external reset command triggered
 *
 * @return reset status - int
 * @retval zero - reset not triggered
 * @retval non-zero - reset triggered
 */
int debug_read_reset(void);

/**
 * @brief Reads current system demo mode from external interface
 *
 * @return demo_mode - demo_mode_e
 */
demo_mode_e debug_read_demo_mode(void);

/**
 * @brief Reads current system adc type from external interface
 *
 * @return adc_type - int
 */
int debug_read_adc_type(void);

/**
 * @brief Reads current system dsp mode from external interface
 *
 * @return adc_type - int
 */
calc_type_e debug_read_dsp_mode(void);

void debug_update_dc_dc_setp(short setp);

/**
 * @brief Updates external interface with current drive status
 *
 * @param new_status - int
 *
 * @return None
 */
void debug_update_drive_status(int drive_index, int new_status);

/**
 * Low level hardware float read
 *
 * @param[in] BASE Base Address
 * @param[in] OFFSET Byte offset
 * @return float Read data
 */
// Set address MSB to bypass cache
#define IORD_FLOATDIRECT(BASE, OFFSET)\
            (*((volatile float *)(__IO_CALC_ADDRESS_DYNAMIC((BASE), (OFFSET)) + 0x80000000)))

/**
 * Low level hardware float write
 *
 * @param[in] BASE Base Address
 * @param[in] OFFSET Byte offset
 * @param[in] DATA Data to write
 */
// Set address MSB to bypass cache
#define IOWR_FLOATDIRECT(BASE, OFFSET, DATA) (*((volatile float *)(__IO_CALC_ADDRESS_DYNAMIC((BASE),\
                        (OFFSET)) + 0x80000000)) = (DATA))
/*!
 * @}
 */

#endif /* MC_DEBUG_H_ */
