###################################################################################
# Copyright (C) 2025 Altera Corporation
#
# This software and the related documents are Altera copyrighted materials, and
# your use of them is governed by the express license under which they were
# provided to you ("License"). Unless the License provides otherwise, you may
# not use, modify, copy, publish, distribute, disclose or transmit this software
# or the related documents without Altera's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.
###################################################################################

set inst [get_current_instance]

set o_powerdown_test [get_keepers -nowarn ${inst}|powerdown_p_meta[*]]

if {[get_collection_size $o_powerdown_test] > 0} {
  set_false_path -to [get_keepers ${inst}|powerdown_p_meta[*]]
  set_false_path -to [get_keepers ${inst}|powerdown_n_meta[*]]
}
