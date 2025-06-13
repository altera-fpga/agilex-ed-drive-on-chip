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

/* ##########################################################################
 * The Drive-On-Chip Reference Design drive system monitor is an interlock between the
 * state of the system and the requested operation.
 *
 * Application software writes to the drive system monitor to request a change of state.
 * The hardware may accept or decline the change of state request, depending on the
 * system status (for example, overvoltage status, undervoltage status, and current
 * measurements alter the system status). A subsequent read from the Status register
 * verifies if the design accepts the change of state.
 *
 * The drive system monitor latches status signals from the system so the signals are
 * available as status register bits and direct outputs.
 * ##########################################################################
 */

// 1.2 extra IDLE state to DSM which can be used to disable the PWM
//     under software control
//     Correct operation of state machine so that (e1 | e3) term does not mask
//     remainder of state machine and prevent pwm being disable under fault condition.
// 1.3 [04/02/16] Keep PWM enabled so that counter and triggers operate and result in IRQ from ADC
//     New preinit state to ignore errors while system is brought up
//     Reset to preinit state when status bits are cleared
// 1.4 Set unused chopper error status bit to 0 rather than 1

`timescale 1ns/1ns

module ssg_emb_dsm (
    input               clk,
    input               reset_n,

    // Avalon-MM in system clk domain
    input               avs_write_n,
    input               avs_read_n,
    input               avs_address,
    input [31:0]        avs_writedata,
    output reg [31:0]   avs_readdata,

    input               overcurrent,
    input               overvoltage,
    input               undervoltage,
    input               chopper,
    input               dc_link_clk_err,
    input               mosfet_err,

    output wire         error_out,
    output wire         overcurrent_latch,
    output wire         overvoltage_latch,
    output wire         undervoltage_latch,
    output wire         dc_link_clk_err_latch,
    output wire         mosfet_err_latch,
    output reg          chopper_latch,
    output reg [2:0]    pwm_control
);

reg [2:0] state;
parameter   idle        = 3'b000,
            prech       = 3'b001,
            prer        = 3'b010,
            run         = 3'b011,
            error       = 3'b100,
            init        = 3'b101,
            preinit     = 3'b110;

parameter   pwm_disable = 3'b000,
            pwm_enable  = 3'b001,
            pwm_lower   = 3'b011,
            pwm_both    = 3'b111;

// Avalon register interface
reg [2:0] control_reg;
reg clear_status;
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        control_reg <= 3'b0;
        clear_status <= 1'b0;
    end
    else if (~avs_write_n)
    begin
        case (avs_address)
            4'h0:   control_reg <= avs_writedata[2:0];
            4'h1:
            begin
                clear_status <= 1'b1;
                if ((avs_writedata[31:28] == 4'hf))
                    control_reg <= idle;
            end
        endcase
    end
    else
        clear_status <= 1'b0;

reg [4:0] status_bits;
always @(*)
    case (avs_address)
        4'h0:   avs_readdata <= {29'b0, control_reg};
        4'h1:   avs_readdata <= {20'b0, state, pwm_control, 1'b0, status_bits};
        default:    avs_readdata <= 32'h0;
    endcase

// Status bits are sticky and cleared by write 1 to the bit(s) in status reg
reg [31:0] avs_writedata_r;
reg e1, e2;
always @(posedge clk or negedge reset_n)
    if (~reset_n)
        avs_writedata_r <= 5'b0;
    else
        avs_writedata_r <= avs_writedata;

always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        status_bits[3:0] <= 4'b0;
        chopper_latch <= 1'b0;
        e1 <= 1'b0;
        e2 <= 1'b0;
    end
    // Ignore errors in idle and preinit states
    else if ((state == idle) | (state == preinit))
    begin
        status_bits[3:0] <= 4'b0;
        chopper_latch <= 1'b0;
        e1 <= 1'b0;
        e2 <= 1'b0;
    end
    else if (clear_status)
        status_bits[3:0] <= status_bits[3:0] & ~avs_writedata_r[3:0];
    else
    begin
        chopper_latch <= chopper;
        e1 <= overvoltage_latch | mosfet_err_latch | undervoltage_latch;
        e2 <= overcurrent_latch | dc_link_clk_err_latch ;

        status_bits[2:1] <= status_bits[2:1] | {undervoltage, overvoltage};
        if ((state == prer) || (state == run))
        begin
            status_bits[0] <= status_bits[0] | overcurrent;
            status_bits[3] <= status_bits[3] | dc_link_clk_err;
        end
    end

assign overcurrent_latch     = status_bits[0];
assign overvoltage_latch     = status_bits[1];
assign undervoltage_latch    = status_bits[2];
assign dc_link_clk_err_latch = status_bits[3];
assign mosfet_err_latch      = status_bits[4];
assign error_out             = e1 | e2;

// Accumulate MOSFET errors
reg [7:0] mosfet_cnt;
reg mosfet_err_r;
always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        mosfet_cnt <= 8'b0;
        mosfet_err_r <= 1'b0;
        status_bits[4] <= 1'b0;
    end
    // Ignore errors in idle and preinit states
    else if ((state == idle) | (state == preinit))
    begin
        mosfet_cnt <= 8'b0;
        mosfet_err_r <= 1'b0;
        status_bits[4] <= 1'b0;
    end
    else if (clear_status)
        status_bits[4] <= status_bits[4] & ~avs_writedata_r[4];
    else
    begin
        mosfet_err_r <= mosfet_err;
        if (mosfet_err & ~mosfet_err_r)
        begin
            mosfet_cnt <= 8'b0;
        end
        if (mosfet_err_r)
            mosfet_cnt <= mosfet_cnt + 8'b1;
        if (mosfet_cnt == 8'd75)
            status_bits[4] <=  status_bits[4] | mosfet_err ;
    end

always @(posedge clk or negedge reset_n)
    if (~reset_n)
    begin
        state <= idle;
        pwm_control <= pwm_disable;
    end
    else if (clear_status & (avs_writedata_r[31:28] == 4'hf))
        state <= preinit;
    else
    begin
        case (state)
            idle:
                begin
                    // Can only go to preinit from here
                    pwm_control <= pwm_disable;
                    state <= preinit;
                end

            preinit:
                begin
                    // PWM outputs off but counter running allows ADCs and this IRQ to be triggered
                    // Errors ignored
                    pwm_control <= pwm_enable;
                    if (control_reg == init)
                        state <= init;
                end

            init:
                // PWM outputs off but counter running allows ADCs and this IRQ to be triggered
                if (e1)
                    state <= error;
                else
                begin
                    pwm_control <= pwm_enable;
                    if (control_reg == prech)
                        state <= prech;
                    else if (control_reg == preinit)
                        state <= preinit;
                end

            prech:
                // Pre-Charge State (Bootstrap) - enable Drive-PWM and lower Bridges(EN_Lower)
                // consider voltage and mosfet errors
                if (e1)
                    state <= error;
                else
                begin
                    pwm_control <= pwm_lower;
                    if (control_reg == prer)
                        state <= prer;
                    else if (control_reg == init)
                        state <= init;
                end

            prer:
                begin
                    // Pre-Run State (same as Pre-Charge but also consider over current error)
                    if (e1 | e2)
                        state <= error;
                    else
                    begin
                        if (control_reg == run)
                            state <= run;
                        else if (control_reg == prech)
                            state <= prech;
                        else if (control_reg == init)
                            state <= init;
                    end
                end

            run:
                begin
                    // Run State - enable Drive-PWM and both Bridges (EN_Upper and EN_Lower)
                    if (e1 | e2)
                        state <= error;
                    else
                    begin
                        pwm_control <= pwm_both;
                        if (control_reg == init)
                            state <= init;
                    end
                end

            error:
                begin
                    // Error State - PWM counter still running
                    pwm_control <= pwm_enable;
                    if (control_reg == preinit)
                        state <= preinit;
                end

            default:
                begin
                    // Fault - change to state Error
                    pwm_control <= pwm_enable;
                    state <= error;
                end
        endcase
    end

endmodule   // ssg_emb_dsm
