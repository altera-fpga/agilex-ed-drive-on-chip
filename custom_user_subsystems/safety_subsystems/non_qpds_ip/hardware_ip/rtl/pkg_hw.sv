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

//****************************************************************************//
package pkg_hw;
//****************************************************************************//

/*
    Adapt P_NO_TEMP_CHANNELS to be based off length of required sensors...
    [11 : 0] {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0}
    [11 : 0] {12, 12, 12, 12, 12, 12, 12, 4, 2, 12, 1, 0}

    [req_sensors[current_temperature_channel]]
*/

localparam int P_NO_CHANNELS      = 9;
localparam int P_NO_TEMP_CHANNELS = 5;
localparam int req_sensors [P_NO_TEMP_CHANNELS - 1 : 0] = {4, 3, 2, 1, 0};

localparam int P_MAX_TEMP_HW      = 60;
localparam int P_MIN_TEMP_HW      = 0;

typedef logic [P_NO_CH_VOLT - 1 : 0] t_voltage_array;

t_voltage_array t_voltage_data;

typedef struct {
    logic [3:0]  channel;
    logic [31:0] data;
} channelData;

//****************************************************************************//
endpackage: pkg_hw
//****************************************************************************//
