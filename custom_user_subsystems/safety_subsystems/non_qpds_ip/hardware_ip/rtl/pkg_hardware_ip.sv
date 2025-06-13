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

`default_nettype none

//****************************************************************************//
package pkg_hardware_ip;
//****************************************************************************//

typedef enum {CMD_VOLTAGE, CMD_TEMP} t_cmd_type;

typedef struct {
    logic [7 : 0]   cmd_next_addr;
    logic           sop;
    logic           eop;
    logic [3 : 0]   temp_index;
    logic [3 : 0]   id;
    logic [23 : 0]  cmd;
    t_cmd_type      cmd_type;
} t_cmd;

typedef struct {
    logic [31:0]    min;
    logic [31:0]    max;
} t_voltage_minmax;

//****************************************************************************//
endpackage: pkg_hardware_ip
//****************************************************************************//
