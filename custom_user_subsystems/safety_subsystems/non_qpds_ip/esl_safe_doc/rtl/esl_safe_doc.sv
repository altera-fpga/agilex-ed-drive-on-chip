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

// F = FPGA
// H = HPS

import complimentary_bit::*;

module esl_safe_doc #(
    parameter P_MAX_TEMP            = 60,
    parameter P_MIN_TEMP            = 0,
    parameter P_TEMP_WIDTH          = 8,
    parameter P_DATA_WIDTH          = 9,
    parameter P_WAIT_COUNTER_WIDTH  = 34,
    parameter P_WAIT_LIMIT_MS       = 1,
    parameter P_ESL_CLK_FREQ_HZ     = 20_000_000,
    parameter P_CLK_HPS_FREQ_HZ     = 100_000_000,
    parameter P_CLK_FPGA_FREQ_HZ    = 100_000_000,
    parameter P_WINDOW_PERIOD       = 1000,         // In MicroSeconds, default = 1000us
    parameter P_WINDOW_TOLERANCE    = 300           // In Microseconds, default = 300us
) (
    // Base Inputs
    input wire esl_clk,
    input wire esl_reset,

    input wire clk_hps,
    input wire clk_fpga,

    //Timers
    input wire heartbeat_timer,                 // heartbeat_timer
    input wire heartbeat_fusa,                  // heartbeat_fusa

    //Quad Error
    input wire quad_error_p,
    input wire quad_error_n,

    //Comparison Bits
    input wire fpga_is_safe_p,
    input wire fpga_is_safe_n,
    input wire fpga_compare_good_p,
    input wire fpga_compare_good_n,
    input wire hps_is_safe_p,
    input wire hps_is_safe_n,
    input wire hps_compare_good_p,
    input wire hps_compare_good_n,
    input wire memory_fault_p,
    input wire memory_fault_n,
    input wire compare_timeout,
    input wire reset_safety_n,

    //Hardware Inputs
    input wire cram_good_p,
    input wire cram_good_n,
    input wire pwr_good_p,
    input wire pwr_good_n,
    input wire temp_good_p,
    input wire temp_good_n,

    //Output
    (* preserve *) output logic motor_powerdown_p,
    (* preserve *) output logic motor_powerdown_n,
    (* preserve *) output logic motor_powerdown_dup_p,
    (* preserve *) output logic motor_powerdown_dup_n
);

//-----------------------------//
//----- Initial Variables -----//
//-----------------------------//

    localparam P_WAIT_LIMIT = P_ESL_CLK_FREQ_HZ / 1000 * P_WAIT_LIMIT_MS;
    localparam SR_DEPTH = 3;

    logic   [P_DATA_WIDTH - 1 : 0]  inputs_p;
    logic   [P_DATA_WIDTH - 1 : 0]  inputs_n;
    logic   [P_DATA_WIDTH - 1 : 0]  values;    //Out
    logic                           fault;     //Out

    // Received -> Meta -> Safe -> Delayed Signal
    logic heartbeat_timer_meta;
    logic heartbeat_timer_safe;
    logic heartbeat_timer_d;

    logic heartbeat_fusa_meta;
    logic heartbeat_fusa_safe;
    logic heartbeat_fusa_d;

    logic compare_timeout_meta;
    logic compare_timeout_safe;

    // Variables to store correct hb and window error bits
    logic fusa_pulse;
    logic timer_pulse;
    logic fusa_window_error;
    logic timer_window_error;

    // Wait Variables - Make Parameters
    logic [P_WAIT_COUNTER_WIDTH - 1:0] delay_count_timer;
    logic isWaitTimer       = 1'b1;
    logic delay_fault_timer = 1'b0;

    logic [P_WAIT_COUNTER_WIDTH - 1:0] delay_count_fusa;
    logic isWaitFusa        = 1'b1;
    logic delay_fault_fusa  = 1'b0;

    // HPS
    logic hps_error;
    logic hps_error_n;
    logic hps_freq_too_high;
    logic hps_check_running;
    logic hps_check_done;
    logic hps_int_error;

    // FPGA
    logic fpga_error;
    logic fpga_error_n;
    logic fpga_freq_too_high;
    logic fpga_check_running;
    logic fpga_check_done;
    logic fpga_int_error;

    //Power-down Enables
    logic enable_pd_fpga;
    logic enable_pd_hps;

    logic motor_powerdown;

    logic                   areset_n;
    logic [SR_DEPTH-1 : 0]  areset_n_sr;

    // Reset For HPS Clk
    logic [SR_DEPTH-1 : 0]  esl_aresetn_sr;
    logic                   esl_aresetn;

    logic [SR_DEPTH-1 : 0]  safety_aresetn_sr;
    logic                   safety_aresetn;
    logic                   safety_esl_aresetn;


    always_ff @ (posedge esl_clk, negedge esl_reset)
    begin
        if (esl_reset == 1'b0) begin
            esl_aresetn_sr <= 'd0;
        end else begin
            esl_aresetn_sr <= {1'b1, esl_aresetn_sr [$left(esl_aresetn_sr) : 1]};
        end //if
    end //always_ff
    assign esl_aresetn = esl_aresetn_sr [0];

    always_ff @ (posedge clk_fpga, negedge reset_safety_n)
    begin
        if (reset_safety_n == 1'b0) begin
            safety_aresetn_sr <= 'd0;
        end else begin
            safety_aresetn_sr <= {1'b1, safety_aresetn_sr [$left(safety_aresetn_sr) : 1]};
        end //if
    end //always_ff
    assign safety_aresetn = safety_aresetn_sr [0];

    assign safety_esl_aresetn = safety_aresetn & esl_aresetn;

    always_ff @ (posedge esl_clk, negedge safety_esl_aresetn)
    begin
        if (safety_esl_aresetn == 1'b0) begin
            areset_n_sr <= 'd0;
        end else begin
            areset_n_sr <= {1'b1, areset_n_sr [$left(areset_n_sr) : 1]};
        end //if
    end //always_ff
    assign areset_n = areset_n_sr [0];


//-----------------------------//
//--- Initial Wait Counter ----//
//-----------------------------//
    always_ff @(posedge esl_clk or negedge areset_n)
    begin
        if(~areset_n) begin
            delay_count_timer <= 0;
            isWaitTimer <= 1'b1;
            delay_fault_timer <= 1'b0;
        end
        else if(!delay_fault_timer & isWaitTimer) begin
            delay_count_timer <= delay_count_timer + 1'b1;

            if((timer_pulse == 1'b1)) begin
                isWaitTimer <= 1'b0;
                delay_fault_timer <= 1'b0;
            end

            else if((delay_count_timer >= P_WAIT_LIMIT + 3)) begin
                isWaitTimer <= 1'b0;
                delay_fault_timer <= 1'b1;
            end
        end
    end

    always_ff @(posedge esl_clk or negedge areset_n)
    begin
        if(~areset_n) begin
            delay_count_fusa <= 0;
            isWaitFusa <= 1'b1;
            delay_fault_fusa <= 1'b0;
        end
        else if(!delay_fault_fusa & isWaitFusa) begin
            delay_count_fusa <= delay_count_fusa + 1'b1;

            if((fusa_pulse == 1'b1)) begin
                isWaitFusa <= 1'b0;
                delay_fault_fusa <= 1'b0;
            end

            else if((delay_count_fusa >= P_WAIT_LIMIT + 3)) begin
                isWaitFusa <= 1'b0;
                delay_fault_fusa <= 1'b1;
            end
        end
    end

    always_ff @(posedge esl_clk or negedge areset_n)
    begin
        if(~areset_n) begin
            enable_pd_fpga <= 1'b0;
            enable_pd_hps <= 1'b0;
        end
        else begin
            if(!isWaitFusa & fusa_pulse) begin
                enable_pd_fpga <= 1'b1;
            end

            if(!isWaitTimer & timer_pulse) begin
                enable_pd_hps <= 1'b1;
            end
        end
    end

//-----------------------------//
//------ Compli Control -------//
//-----------------------------//
    assign inputs_p = {memory_fault_n, fpga_is_safe_p, fpga_compare_good_p, hps_is_safe_p,
                        hps_compare_good_p, quad_error_n, cram_good_p, pwr_good_p, temp_good_p};
    assign inputs_n = {memory_fault_p, fpga_is_safe_n, fpga_compare_good_n, hps_is_safe_n,
                        hps_compare_good_n, quad_error_p, cram_good_n, pwr_good_n, temp_good_n};

    esl_comp_inputs #(
      .P_DATA_WIDTH     (P_DATA_WIDTH)
    ) comp_calculation(
        .clk            (esl_clk),
        .reset          (areset_n),
        .inputs_p       (inputs_p),
        .inputs_n       (inputs_n),
        .values         (values),
        .fault          (fault)
    );

//-----------------------------//
//------ Safe Control ---------//
//-----------------------------//
    always_ff @(posedge esl_clk or negedge areset_n) begin
        if(~areset_n) begin
            motor_powerdown <= 1'b0; // areset_n Safe State
        end
        else begin
            motor_powerdown <= fault | delay_fault_timer | delay_fault_fusa | fusa_window_error
                        | timer_window_error | hps_error | fpga_error | compare_timeout_safe;
        end
    end

    always_ff @(posedge esl_clk or negedge areset_n) begin
        if(~areset_n) begin
            motor_powerdown_p <= 1'b0; // areset_n Safe State
            motor_powerdown_n <= 1'b1; // areset_n Safe State
        end
        else begin
            if(enable_pd_fpga & enable_pd_hps & motor_powerdown) begin
                motor_powerdown_p <= 1'b1;
                motor_powerdown_n <= 1'b0;
            end
        end
    end

    assign motor_powerdown_dup_p = motor_powerdown_p;
    assign motor_powerdown_dup_n = motor_powerdown_n;

//-----------------------------//
//---- Channel Operation  -----//
//-----------------------------//
    // To Avoid Metastability...
    always_ff @(posedge esl_clk)
    begin
        heartbeat_timer_meta <= heartbeat_timer;
        heartbeat_timer_safe <= heartbeat_timer_meta;

        heartbeat_fusa_meta <= heartbeat_fusa;
        heartbeat_fusa_safe <= heartbeat_fusa_meta;
    end

    // Delayed Signals
    always_ff @(posedge esl_clk)
    begin
        heartbeat_timer_d <= heartbeat_timer_safe;
        heartbeat_fusa_d <= heartbeat_fusa_safe;
    end

    //Compare Timeout Metastability
    always_ff @(posedge esl_clk)
    begin
        compare_timeout_meta <= compare_timeout;
        compare_timeout_safe <= compare_timeout_meta;
    end
//-----------------------------//
//----    Window Checks   -----//
//-----------------------------//
    localparam tol_count    = (P_WINDOW_TOLERANCE*1000)/50 + 3;
    localparam window_upper = (P_ESL_CLK_FREQ_HZ/P_WINDOW_PERIOD + tol_count);
    localparam window_lower = (P_ESL_CLK_FREQ_HZ/P_WINDOW_PERIOD - tol_count);

    always_ff @(posedge esl_clk)
    begin
        fusa_pulse  <= (heartbeat_fusa_d ^ heartbeat_fusa_safe);
        timer_pulse <= (heartbeat_timer_d ^ heartbeat_timer_safe);
    end

    window_check #
    (
    .delay_count_lim    (window_upper),
    .delay_count_low_lim(window_lower)
    ) w1 (
    .clk                (esl_clk),
    .reset              (~isWaitTimer),
    .pulse              (timer_pulse),
    .window_error       (timer_window_error)
    );

    window_check #
    (
    .delay_count_lim    (window_upper),
    .delay_count_low_lim(window_lower)
    ) w2 (
    .clk                (esl_clk),
    .reset              (~isWaitFusa),
    .pulse              (fusa_pulse),
    .window_error       (fusa_window_error)
    );


//-----------------------------//
//----    Clock Checks    -----//
//-----------------------------//

    // Reset For HPS Clk
    logic [2 : 0]                      hps_aresetn_sr;
    logic                              hps_aresetn;

    logic [2 : 0]                      fpga_aresetn_sr;
    logic                              fpga_aresetn;

    localparam clk_count                = P_ESL_CLK_FREQ_HZ/1000;

    localparam hps_local_clk_count      = P_CLK_HPS_FREQ_HZ/1000;
    localparam hps_local_up_count       = hps_local_clk_count + 250;
    localparam hps_local_low_count      = hps_local_clk_count - 250;

    localparam fpga_local_clk_count     = P_CLK_FPGA_FREQ_HZ/1000;
    localparam fpga_local_up_count      = fpga_local_clk_count + 250;
    localparam fpga_local_low_count     = fpga_local_clk_count - 250;

    always_ff @ (posedge clk_hps, negedge areset_n)
    begin
        if (areset_n == 1'b0) begin
            hps_aresetn_sr <= 'd0;
        end else begin
            hps_aresetn_sr <= {1'b1, hps_aresetn_sr [$left(hps_aresetn_sr) : 1]};
        end //if
    end //always_ff
    assign hps_aresetn = hps_aresetn_sr [0];

    always_ff @ (posedge clk_fpga, negedge areset_n)
    begin
        if (areset_n == 1'b0) begin
            fpga_aresetn_sr <= 'd0;
        end else begin
            fpga_aresetn_sr <= {1'b1, fpga_aresetn_sr [$left(fpga_aresetn_sr) : 1]};
        end //if
    end //always_ff
    assign fpga_aresetn = fpga_aresetn_sr [0];

    esl_clk_check #
    (
        .LO_COUNT_THR   (hps_local_low_count),
        .HI_COUNT_THR   (hps_local_up_count),
        .REF_CLK_TC     (clk_count)
    ) clk_hps_check
    (
        .ref_clk        (esl_clk),
        .ref_rst_n      (areset_n),
        .cut_clk        (clk_hps),
        .cut_rst_n      (hps_aresetn),
        .error          (hps_error),
        .error_n        (hps_error_n),
        .freq_too_high  (hps_freq_too_high),
        .check_running  (hps_check_running),
        .check_done     (hps_check_done),
        .int_error      (hps_int_error)
    );

    esl_clk_check #
    (
        .LO_COUNT_THR   (fpga_local_low_count),
        .HI_COUNT_THR   (fpga_local_up_count),
        .REF_CLK_TC     (clk_count)
    ) clk_fpga_check
    (
        .ref_clk        (esl_clk),
        .ref_rst_n      (areset_n),
        .cut_clk        (clk_fpga),
        .cut_rst_n      (fpga_aresetn),
        .error          (fpga_error),
        .error_n        (fpga_error_n),
        .freq_too_high  (fpga_freq_too_high),
        .check_running  (fpga_check_running),
        .check_done     (fpga_check_done),
        .int_error      (fpga_int_error)
    );

endmodule

`default_nettype wire
