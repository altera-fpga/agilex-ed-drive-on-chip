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
 * The 16-bit counter resolution is sufficient to generate an 8-kHz PWM output. The
 * design generates high- and low-side drive signals for the insulated gate bipolar
 * transistor (IGBT) module by comparing the ramp counter value with the values you
 * set in the PWM threshold configuration registers. The design inserts a dead period
 * between the switching of the upper and lower drive signals according to the value set
 * in the PWM blocking time configuration register.
 *
 * The design sets carrier_latch output signal high for one clock cycle when the PWM
 * counter is at 0 or max. This signal triggers a position encoder to take a position
 * reading.
 *
 * ##########################################################################
 */

// 3.0 Added ability to switch each phase independently for trapezoidal commutation
// 4.0 Re-architected for higher PWM Fmax, targeting 333.333MHz

`default_nettype none

`timescale 1ns/1ns

//****************************************************************************//
module ssg_emb_pwm (
    // System clock domain
    // Must be same clock as ADC for synchronization of start strobe
    input wire          sys_clk,
    input wire          reset_n,

    // Avalon-MM in system clk domain
    input wire          avs_write_n,
    input wire          avs_read_n,
    input wire [3:0]    avs_address,
    input wire [31:0]   avs_writedata,
    output reg [31:0]   avs_readdata,

    input wire [2:0]    pwm_control,
    output reg          encoder_strobe_n,
    output reg          start_adc,

    // PWM clock domain
    // PWM carrier clock
    input wire          pwm_clk,
    input wire          pwm_reset_n,

    input wire          sync_in,

    input wire [15:0]   vu_pwm,
    input wire [15:0]   vv_pwm,
    input wire [15:0]   vw_pwm,

    output wire         u_h,
    output wire         u_l,
    output wire         v_h,
    output wire         v_l,
    output wire         w_h,
    output wire         w_l,
    output wire         sync_out
);
//****************************************************************************//

reg [2:0]   gate_h;
reg [2:0]   gate_l;
reg [2:0]   gate_h_x;
reg [2:0]   gate_l_x;
reg [2:0]   hall_reg;    // bits corresponds to phases: 0:U 1:V 2:W

reg carrier_latch;
reg pwm_encoder_strobe;
reg pwm_start_adc;
reg start_adc_stretch;

reg [0:0]   control_reg;
reg [14:0]  pwm_reg         [0:2];           // 0:U 1:V 2:W
reg [14:0]  pwm_reg_avs     [0:2];    // 0:U 1:V 2:W
(* maxfan = 1 *) reg        [14:0] max_reg;
reg [9:0]   block_reg;
reg [14:0]  trigger_up_reg;
reg [14:0]  trigger_down_reg;
(* maxfan = 1 *) reg [2:0] hall_enable_reg;
reg [0:0]   pwm_direct_reg;

reg [0:0]  control_reg_r;
reg [0:0]  control_reg_rr;
reg [9:0]  block_reg_r;
reg [9:0]  block_reg_rr;
reg [14:0] trigger_down_reg_r;
reg [14:0] trigger_down_reg_rr;
reg [14:0] trigger_down_reg_rrr;
reg [14:0] trigger_up_reg_r;
reg [14:0] trigger_up_reg_rr;
reg [14:0] trigger_up_reg_rrr;
reg [14:0] max_reg_r;
reg [14:0] max_reg_rr;
reg [14:0] max_reg_rrr;
reg [2:0]  pwm_control_r;
reg [2:0]  pwm_control_rr;

reg [9:0]   dead_count          [0:2];
reg         dead_count_flag_0   [0:2];
reg         dead_count_load     [0:2];
reg         compare             [0:2];
reg         compare_r           [0:2];
reg         up;
reg         sync;
reg [14:0]  counter;
reg [3:0]   multi_cycle_cnt;
// To achieve higher PWM Fmax, pipeline counter operation by generating single bit flags
reg flag_count_max, flag_count_min, flag_trigger_up, flag_trigger_down;
reg flag_count_max_u, flag_count_min_u, flag_trigger_up_u, flag_trigger_down_u;
reg flag_count_max_l, flag_count_min_l, flag_trigger_up_l, flag_trigger_down_l;
reg [2:0] hall_enable_reg_r;
reg [2:0] hall_enable_reg_rr;
reg [2:0] hall_enable_reg_rrr;
reg hall_stable;
reg [14:0] pwm          [0:2];
reg [14:0] pwm_reg_r    [0:2];
reg [14:0] pwm_reg_rr   [0:2];
reg [14:0] pwm_reg_rrr  [0:2];
reg pwm_stable          [0:2];
reg adc_strobe_s1;
reg adc_strobe_s2;
reg adc_strobe_s3;
reg encoder_strobe_s1;
reg encoder_strobe_s2;

// CDC handshaking signals
reg [0:0]  control_reg_src;
reg [9:0]  block_reg_src;
reg [14:0] trigger_down_reg_src;
reg [14:0] trigger_up_reg_src;
reg [14:0] max_reg_src;
reg [2:0]  pwm_control_src;
reg [2:0]  hall_enable_reg_src;
reg [14:0] pwm_reg_src [0:2];

reg req_toggle        = 1'b1;
reg ack_toggle_meta   = 1'b0;
reg ack_toggle_safe   = 1'b0;
reg ack_toggle_safe_d = 1'b0;
reg ack_pulse         = 1'b0;
wire in_data_en;

reg ack_toggle        = 1'b0;
reg req_toggle_meta   = 1'b1;
reg req_toggle_safe   = 1'b1;
reg req_toggle_safe_d = 1'b0;
wire out_data_en;

//----------------------------------------------------------------------------//
//
// Avalon register interface
//
//----------------------------------------------------------------------------//

always @(posedge sys_clk or negedge reset_n)
    if (~reset_n)
    begin
        control_reg <= 1'b0;
        pwm_reg_avs[0] <= 15'b0;
        pwm_reg_avs[1] <= 15'b0;
        pwm_reg_avs[2] <= 15'b0;
        max_reg <= 15'h6000;
        block_reg <= 10'b0;
        trigger_up_reg <= 15'b0;
        trigger_down_reg <= 15'b0;
        hall_enable_reg <= 3'b111;    // bits corresponds to phases: 0:U 1:V 2:W
        pwm_direct_reg <= 1'b0;
    end
    else if (~avs_write_n)
    begin
        case (avs_address)
            4'h0:   control_reg         <= avs_writedata[0];
            4'h1:   pwm_reg_avs[0]      <= avs_writedata[14:0];
            4'h2:   pwm_reg_avs[1]      <= avs_writedata[14:0];
            4'h3:   pwm_reg_avs[2]      <= avs_writedata[14:0];
            4'h4:   max_reg             <= avs_writedata[14:0];
            4'h5:   block_reg           <= avs_writedata[9:0];
            4'h6:   trigger_up_reg      <= avs_writedata[14:0];
            4'h7:   trigger_down_reg    <= avs_writedata[14:0];
            4'h8:   pwm_direct_reg      <= avs_writedata[0];
            4'hb:   hall_enable_reg     <= avs_writedata[2:0];
        endcase
    end
always @(posedge sys_clk or negedge reset_n)
    if (~reset_n)
    begin
        pwm_reg[0] <= 15'b0;
        pwm_reg[1] <= 15'b0;
        pwm_reg[2] <= 15'b0;
    end
    else
    begin
        if (pwm_direct_reg == 1)
        begin
            pwm_reg[0] <= vu_pwm[14:0];
            pwm_reg[1] <= vv_pwm[14:0];
            pwm_reg[2] <= vw_pwm[14:0];
        end
        else
        begin
            pwm_reg[0] <= pwm_reg_avs[0];
            pwm_reg[1] <= pwm_reg_avs[1];
            pwm_reg[2] <= pwm_reg_avs[2];
        end
    end

always @(*)
    case (avs_address)
        4'h0:   avs_readdata        <= {31'b0, control_reg};
        4'h1:   avs_readdata        <= {17'b0, pwm_reg[0]};
        4'h2:   avs_readdata        <= {17'b0, pwm_reg[1]};
        4'h3:   avs_readdata        <= {17'b0, pwm_reg[2]};
        4'h4:   avs_readdata        <= {17'b0, max_reg};
        4'h5:   avs_readdata        <= {22'b0, block_reg};
        4'h6:   avs_readdata        <= {17'b0, trigger_up_reg};
        4'h7:   avs_readdata        <= {17'b0, trigger_down_reg};
        4'h8:   avs_readdata        <= {31'b0, pwm_direct_reg};
        4'hb:   avs_readdata        <= {29'b0, hall_enable_reg};
        default:    avs_readdata    <= 32'h0;
    endcase

// Re-synch encoder strobe to system clock domain
always @(posedge sys_clk)
begin
    encoder_strobe_s1 <= pwm_encoder_strobe;
    encoder_strobe_s2 <= encoder_strobe_s1;
    encoder_strobe_n <= ~encoder_strobe_s2;
end

// Re-synch ADC start strobe to system clock domain and create a single clock strobe
// as required by existing ADC modules.
always @(posedge sys_clk)
begin
    adc_strobe_s1 <= start_adc_stretch;
    adc_strobe_s2 <= adc_strobe_s1;
    adc_strobe_s3 <= adc_strobe_s2;
    start_adc <= adc_strobe_s2 & ~adc_strobe_s3;
end

//----------------------------------------------------------------------------//
// Clock Domain Crossing
//----------------------------------------------------------------------------//
// sys_clk domain

assign in_data_en = ((ack_toggle_safe == ack_toggle_safe_d) && (ack_toggle_safe == req_toggle));

always @ (posedge sys_clk) begin
  // the "req_toggle_safe = req_toggle_safe_d" condition ensures that any glitches
  // do not perpetuate and the data is only latched when the toggle signals are stable
  if (in_data_en == 1'b1) begin
    control_reg_src      <= control_reg;
    block_reg_src        <= block_reg;
    trigger_down_reg_src <= trigger_down_reg;
    trigger_up_reg_src   <= trigger_up_reg;
    max_reg_src          <= max_reg;
    pwm_control_src      <= pwm_control;
    hall_enable_reg_src  <= hall_enable_reg;
    pwm_reg_src          <= pwm_reg;
  end //if
end // always

always @ (posedge sys_clk or negedge reset_n) begin
  // the "req_toggle_safe = req_toggle_safe_d" condition ensures that any glitches
  // do not perpetuate and the data is only latched when the toggle signals are stable
  if (reset_n == 1'b0) begin
    req_toggle <= 1'b1;
  end else if (in_data_en == 1'b1) begin
    req_toggle <= ~req_toggle;
  end //if
end // always

always @ (posedge sys_clk or negedge reset_n) begin
  if (reset_n == 1'b0) begin
    ack_toggle_meta   <= 1'b0;
    ack_toggle_safe   <= 1'b0;
    ack_toggle_safe_d <= 1'b0;
  end else begin
    ack_toggle_meta   <= ack_toggle;
    ack_toggle_safe   <= ack_toggle_meta;
    ack_toggle_safe_d <= ack_toggle_safe;
  end //if
end //always

// pwm_clk domain
always @ (posedge pwm_clk or negedge pwm_reset_n) begin
  if (pwm_reset_n == 1'b0) begin
    req_toggle_meta   <= 1'b1;
    req_toggle_safe   <= 1'b1;
    req_toggle_safe_d <= 1'b0;
  end else begin
    req_toggle_meta   <= req_toggle;
    req_toggle_safe   <= req_toggle_meta;
    req_toggle_safe_d <= req_toggle_safe;
  end //if
end //always

// the "req_toggle_safe = req_toggle_safe_d" condition ensures that any glitches
// do not perpetuate and the data is only latched when the toggle signals are stable
assign out_data_en = ((req_toggle_safe == req_toggle_safe_d) && (req_toggle_safe != ack_toggle));

always @ (posedge pwm_clk) begin
  if (out_data_en == 1'b1) begin
    control_reg_r      <= control_reg_src;
    block_reg_r        <= block_reg_src;
    trigger_down_reg_r <= trigger_down_reg_src;
    trigger_up_reg_r   <= trigger_up_reg_src;
    max_reg_r          <= max_reg_src;
    pwm_control_r      <= pwm_control_src;
    hall_enable_reg_r  <= hall_enable_reg_src;
    pwm_reg_r          <= pwm_reg_src;
  end //if
end //always

always @ (posedge pwm_clk or negedge pwm_reset_n) begin
  if (pwm_reset_n == 1'b0) begin
    ack_toggle <= 1'b0;
  end else if (out_data_en == 1'b1) begin
    ack_toggle <= ~ack_toggle;
  end //if
end //always


//----------------------------------------------------------------------------//
// PWM clock domain
//----------------------------------------------------------------------------//
always @(posedge pwm_clk /*or negedge pwm_reset_n*/)
    begin
        control_reg_rr <= control_reg_r;
        block_reg_rr <= block_reg_r;
        trigger_down_reg_rr <= trigger_down_reg_r;
        trigger_down_reg_rrr <= trigger_down_reg_rr + 2'b11;
        trigger_up_reg_rr <= trigger_up_reg_r;
        trigger_up_reg_rrr <= trigger_up_reg_rr - 2'b11;
        max_reg_rr <= max_reg_r;
        max_reg_rrr <= max_reg_rr - 2'b11;
        pwm_control_rr <= pwm_control_r;
    end

wire pwm_enable = control_reg_rr[0];
wire en_lower = pwm_control_rr[1];
wire en_upper = pwm_control_rr[2];

// Create local copies of control registers as they will be updated mid-cycle
// Only transfer new value if it has settled
generate
    genvar j;
    for (j = 0; j < 3; j = j + 1)
    begin : reg_gen_loop
        always @(posedge pwm_clk)
            begin
                pwm_reg_rr[j] <= pwm_reg_r[j];
                pwm_reg_rrr[j] <= pwm_reg_rr[j];
            end

        always @(posedge pwm_clk or negedge pwm_reset_n)
            if (~pwm_reset_n)
            begin
                pwm[j] <= 15'b0;
                pwm_stable[j] = 1'b0;
            end
            else
            begin
                pwm_stable[j] <= (pwm_reg_rrr[j] == pwm_reg_rr[j]);
                if (carrier_latch & pwm_stable[j])
                    pwm[j] <= pwm_reg_rrr[j];
            end

    end
endgenerate

always @(posedge pwm_clk)
    begin
        hall_enable_reg_rr  <= hall_enable_reg_r;
        hall_enable_reg_rrr <= hall_enable_reg_rr;
    end

always @(posedge pwm_clk or negedge pwm_reset_n)
    if (~pwm_reset_n)
    begin
        hall_reg <= 3'b001;
        hall_stable = 1'b0;
    end
    else
    begin
        hall_stable <= (hall_enable_reg_rrr == hall_enable_reg_rr);
        if (carrier_latch & hall_stable)
            hall_reg <= hall_enable_reg_rrr;
    end

always @(posedge pwm_clk or negedge pwm_reset_n)
begin
    if (~pwm_reset_n)
    begin
        flag_count_max_u    <= 1'b0;
        flag_count_max_l    <= 1'b0;
        flag_count_max      <= 1'b0;
        flag_count_min_u    <= 1'b0;
        flag_count_min_l    <= 1'b0;
        flag_count_min      <= 1'b0;
        flag_trigger_up_u   <= 1'b0;
        flag_trigger_up_l   <= 1'b0;
        flag_trigger_up     <= 1'b0;
        flag_trigger_down_u <= 1'b0;
        flag_trigger_down_l <= 1'b0;
        flag_trigger_down   <= 1'b0;
    end
    else
    begin
        if (sync_in)
        begin
            flag_count_max_u    <= 1'b0;
            flag_count_max_l    <= 1'b0;
            flag_count_max      <= 1'b0;
            flag_count_min_u    <= 1'b0;
            flag_count_min_l    <= 1'b0;
            flag_count_min      <= 1'b0;
            flag_trigger_up_u   <= 1'b0;
            flag_trigger_up_l   <= 1'b0;
            flag_trigger_up     <= 1'b0;
            flag_trigger_down_u <= 1'b0;
            flag_trigger_down_l <= 1'b0;
            flag_trigger_down   <= 1'b0;
        end
        else
        begin
            flag_count_max_u    <= counter[14:8] == max_reg_rrr[14:8];
            flag_count_max_l    <= counter[7:0] == max_reg_rrr[7:0];
            flag_count_max      <= flag_count_max_u & flag_count_max_l;

            flag_count_min_u    <= counter[14:8] == 7'h00;
            flag_count_min_l    <= counter[7:0] == 8'h03;
            flag_count_min      <= flag_count_min_u & flag_count_min_l;

            flag_trigger_up_u   <= counter[14:8] == trigger_up_reg_rrr[14:8];
            flag_trigger_up_l   <= counter[7:0] == trigger_up_reg_rrr[7:0];
            flag_trigger_up     <= flag_trigger_up_u & flag_trigger_up_l;

            flag_trigger_down_u <= counter[14:8] == trigger_down_reg_rrr[14:8];
            flag_trigger_down_l <= counter[7:0] == trigger_down_reg_rrr[7:0];
            flag_trigger_down   <= flag_trigger_down_u & flag_trigger_down_l;
        end
    end
end

// The counter counts alternately up and down between zero and max_reg value
// The count value is compared against the other registers to determine when
// to drive the various outputs
always @(posedge pwm_clk or negedge pwm_reset_n)
begin
    if (~pwm_reset_n)
    begin
        counter <= 15'b0;
        up <= 1'b1;
        pwm_start_adc <= 1'b0;
        carrier_latch <= 1'b0;
        sync <= 1'b0;
    end
    else
    begin
        if (~pwm_enable | sync_in)
        begin
            counter <= 15'b0;
            up <= 1'b1;
            pwm_start_adc <= 1'b0;
        end
        else
        begin
            if (up == 1'b1)
                counter <= counter + 15'b1;
            else
                counter <= counter - 15'b1;
            // Set pwm_start_adc pulse for ADC
            pwm_start_adc <= up & flag_trigger_up | ~up & flag_trigger_down;
        end

        if (up & flag_count_max | ~up & flag_count_min)
        begin
            // change direction and set latch enable
            up <= ~up;
            carrier_latch <= 1'b1;
        end
        else
        begin
            carrier_latch <= 1'b0;
        end

        // synchronize all PWM modules
        sync <= ~up & flag_count_min;

    end
end

assign sync_out = sync | sync_in;

reg [4:0] strobe_count;
// strobe_count is used to stretch the encoder strobe
always @(posedge pwm_clk or negedge pwm_reset_n)
    if (~pwm_reset_n)
        strobe_count <= 5'b00000;
    else if (carrier_latch)
        // Encoder strobe at end of each ramp in normal mode
        strobe_count <= strobe_count + 5'b00001;
    else if (|strobe_count)
        strobe_count <= strobe_count + 5'b00001;

always @(posedge pwm_clk or negedge pwm_reset_n)
    if (~pwm_reset_n)
        pwm_encoder_strobe <= 1'b0;
    else if (carrier_latch)
        pwm_encoder_strobe <= 1'b1;
    else if (|strobe_count)
        pwm_encoder_strobe <= 1'b1;
    else
        pwm_encoder_strobe <= 1'b0;

reg [4:0] start_count;
// start_count is used to stretch the ADC start strobe
always @(posedge pwm_clk or negedge pwm_reset_n)
    if (~pwm_reset_n)
        start_count <= 5'b00000;
    else if (pwm_start_adc)
        // Encoder strobe at end of each ramp in normal mode
        start_count <= start_count + 5'b00001;
    else if (|start_count)
        start_count <= start_count + 5'b00001;

always @(posedge pwm_clk or negedge pwm_reset_n)
    if (~pwm_reset_n)
        start_adc_stretch <= 1'b0;
    else if (pwm_start_adc)
        start_adc_stretch <= 1'b1;
    else if (|start_count)
        start_adc_stretch <= 1'b1;
    else
        start_adc_stretch <= 1'b0;

// Generate gate drives from counter state, inserting required dead time
// between H & L driver transitions
// generate index corresponds to phases: 0:U 1:V 2:W
generate
    genvar i;
        for (i = 0; i < 3; i = i + 1)
        begin : op_gen_loop
            always @(posedge pwm_clk or negedge pwm_reset_n)
                if (~pwm_reset_n)
                begin
                    dead_count[i]           <= 10'b0;
                    dead_count_load[i]      <= 1'b0;
                    dead_count_flag_0[i]    <= 1'b0;
                    compare[i]              <= 1'b0;
                    compare_r[i]            <= 1'b0;
                    gate_h_x[i]             <= 1'b0;
                    gate_l_x[i]             <= 1'b0;
                end
                else
                begin
                    compare_r[i] <= compare[i];
                    compare[i] <= pwm[i] > counter;
                    if (compare[i] != compare_r[i])
                        dead_count[i] <= block_reg_rr;
                    else if (~(dead_count[i] == 10'b0))
                        dead_count[i] <= dead_count[i] - 10'b1;
                    dead_count_load[i]      <= compare[i] != compare_r[i];
                    dead_count_flag_0[i]    <= dead_count[i] == 10'b0;

                    gate_h_x[i]  <= compare[i] & compare_r[i] & dead_count_flag_0[i] & ~dead_count_load[i];
                    gate_l_x[i]  <= ~compare[i] & ~compare_r[i] & dead_count_flag_0[i] & ~dead_count_load[i];
                end
        end
endgenerate

generate
    genvar k;
        for (k = 0; k < 3; k = k + 1)
        begin : op_en_loop
            always @(posedge pwm_clk or negedge pwm_reset_n)
                if (~pwm_reset_n)
                begin
                    gate_h[k] <= 1'b0;
                    gate_l[k] <= 1'b0;
                end
                else
                begin
                    gate_h[k] <= gate_h_x[k] & en_upper & hall_reg[k];
                    gate_l[k] <= gate_l_x[k] & en_lower & hall_reg[k];
                end
        end
endgenerate

assign u_h = gate_h[0];
assign v_h = gate_h[1];
assign w_h = gate_h[2];
assign u_l = gate_l[0];
assign v_l = gate_l[1];
assign w_l = gate_l[2];


//****************************************************************************//
endmodule   // ssg_emb_pwm
//****************************************************************************//
`default_nettype wire
