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

//****************************************************************************//
package doc_hw_pkg_hw;
//****************************************************************************//

localparam int P_NO_CHANNELS      = 9;
localparam int P_NO_TEMP_CHANNELS = 5;
localparam int P_MAX_TEMP_HW      = 60;
localparam int P_MIN_TEMP_HW      = 0;

typedef logic [P_NO_CHANNELS - 1 : 0] t_voltage_array;

t_voltage_array t_voltage_data;

typedef struct {
    logic [3:0]  channel;
    logic [31:0] data;
} channelData;


endpackage: doc_hw_pkg_hw
