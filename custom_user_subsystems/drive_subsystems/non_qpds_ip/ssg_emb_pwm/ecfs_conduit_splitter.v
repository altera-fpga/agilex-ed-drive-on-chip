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

/* ##########################################################################
 * A simple output splitter as in PD one output cannot be connected to two places.
 *
 * ##########################################################################
 */

`timescale 1 ns / 1 ns

(* altera_attribute = "-name IP_TOOL_NAME conduit_splitter; -name IP_TOOL_VERSION 13.0" *)

module ecfs_conduit_splitter
#(
    parameter OUTPUT_NUM = 2
)
(
    input   conduit_input,
    output  conduit_output_0,
    output  conduit_output_1,
    output  conduit_output_2,
    output  conduit_output_3,
    output  conduit_output_4
);

generate
    assign conduit_output_0 = conduit_input;
    assign conduit_output_1 = conduit_input;
    assign conduit_output_2 = conduit_input;
    assign conduit_output_3 = conduit_input;
    assign conduit_output_4 = conduit_input;
endgenerate
endmodule
