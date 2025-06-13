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

#ifndef MOTOR_TASK_H_
#define MOTOR_TASK_H_

void *get_dp(void);
void *get_sp(void);

void adjust_speed(unsigned int drive_index, int delta);
void set_speed_limit(unsigned int drive_index, int limit);
void adjust_pos_setpoint(unsigned int drive_index, int delta);
void set_pos_setpoint(unsigned int drive_index, int pos_setpoint);

#endif /* MOTOR_TASK_H_ */
