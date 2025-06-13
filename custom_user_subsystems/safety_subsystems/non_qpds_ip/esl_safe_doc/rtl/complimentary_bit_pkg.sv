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

package complimentary_bit;

//----------------------------------------------------------------------------//
typedef struct packed{
    logic p;
    logic n;
} compli;

function logic fcn_pn_fault (compli pn);
    if (pn.p == pn.n ) begin
        fcn_pn_fault = 1'b1;
    end else begin
        fcn_pn_fault = 1'b0;
    end //if
    return fcn_pn_fault;
endfunction

function logic pn_check(compli pn);
    if(pn.p != 1'b1 || pn.n != 1'b0)
        return 1'b0;
    return 1'b1;
endfunction

// end of package
//----------------------------------------------------------------------------//
endpackage
