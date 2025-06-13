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
module hw_agilex_5
//****************************************************************************//);
#(
  parameter string P_FAMILY                  = "Agilex 5",
  parameter string P_SPEED_GRADE             = "6",
  parameter string P_AG5_SERIES              = "E",
  parameter string P_AG5_DENSITY             = "065",
  parameter int    P_NO_CH_VOLT              = 9,
  parameter int    P_NO_CH_TEMP              = 5,
  parameter int    P_INDEX_CONVERT [12 : 0]  = {13, 13, 13, 13, 13, 13, 13, 13, 4, 3, 2, 1, 0},
  parameter int    P_REQ_TEMPSENS  [12 : 0]  = {13, 13, 13, 13, 13, 13, 13, 13, 4, 3, 2, 1, 0}
) (
  input  wire                                 clk,
  input  wire                                 reset,
  output logic                                voltage_good,
  output logic                                temperature_good,
  output logic [P_NO_CH_VOLT - 1 : 0][31:0]   voltage_info,
  output logic [P_NO_CH_TEMP - 1 : 0][31:0]   temperature_info
);

timeunit 1ns;
timeprecision 1ps;

import pkg_hardware_ip::*;

//****************************************************************************//

localparam C_ROM_ADDR_WIDTH = $clog2( 2 * (P_NO_CH_VOLT + P_NO_CH_TEMP) + 1);

localparam int C_MAX_TEMP = 80;
localparam int C_MIN_TEMP = 10;

// Note that addressing for the Mailbox is 32-bit word addresses
localparam C_CMD_FIFO_ADDR           = 0;
localparam C_CMD_FIFO_LASTWORD_ADDR  = 1;
localparam C_CMD_FIFO_SPACE_ADDR     = 2;
localparam C_RSP_FIFO_DATA_ADDR      = 5;
localparam C_RSP_FIFO_FILL_ADDR      = 6;

logic [3 : 0]   avmm_address;
logic           avmm_write;
logic           avmm_read;
logic [31 : 0]  avmm_writedata;
logic [31 : 0]  avmm_readdata;
logic           avmm_readdatavalid;
logic           avmm_waitrequest;

logic           do_read;
logic           do_write;
logic [3 : 0]   address;
logic [31 : 0]  data_wr;
logic           ready;
logic [31 : 0]  data_rd;

t_cmd_type      next_rsp_type;

logic [3 : 0]   next_rsp_voltage_channel;
logic [3 : 0] next_rsp_temperature_channel;


logic [C_ROM_ADDR_WIDTH - 1 : 0] rom_addr;
t_cmd command_storage [((P_NO_CH_VOLT + P_NO_CH_TEMP)*2) : 0];
t_cmd rom_comb;
t_cmd rom_reg;

typedef enum
{
        S_IDLE,
        S_START_CHECKING_CMD_FIFO,
        S_WAITING_CHECKING_CMD_FIFO,
        S_WAITING_WRITE_CMD,
        S_WRITING_CMD,
        S_CHECKING_RSP_FIFO,
        S_READING_RSP_HEAD,
        S_WAITING_RSP_HEAD,
        S_READING_RSP_DATA,
        S_WAITING_RSP_DATA
} t_mailbox_fsm;

t_mailbox_fsm mailbox_fsm;

logic [31 : 0] cmd_fifo_data;
logic [3 : 0]  rsp_id;

logic [P_NO_CH_TEMP - 1 : 0][7:0]    temperature_collection;
logic [P_NO_CH_VOLT - 1 : 0][31:0]   voltage_collection;
logic collection_en;

t_voltage_minmax voltage_ranges [P_NO_CH_VOLT - 1 : 0] = '{default : 'h0};
// Array to indicate whether each temp/voltage channel is within limits
logic [P_NO_CH_VOLT - 1 : 0]         voltage_good_sep   = 'b0;
logic [P_NO_CH_TEMP - 1 : 0]     temperature_good_sep   = 'b0;

logic [P_NO_CH_TEMP - 1 : 0][3 : 0]  only_req_temps;

//----------------------------------------------------------------------------//
initial begin
  voltage_ranges[0] = '{32'h00000000, 32'hFFFFFFFF};            // Channel 2 - VCC
  voltage_ranges[1] = '{32'h00000000, 32'hFFFFFFFF};            // Channel 3 - VCCIO_SDM
  if (P_FAMILY == "Agilex 7") begin
    // Add elements using key-value pairs
    voltage_ranges[2] = '{32'h0000A767, 32'h0000F4DB};          // Channel 2 - VCC
    voltage_ranges[3] = '{32'h0001A3C2, 32'h0001F3B6};          // Channel 3 - VCCIO_SDM
    voltage_ranges[4] = '{32'h0001A3C2, 32'h0001F3B6};          // Channel 4 - VCCPT
    voltage_ranges[5] = '{32'h000117D6, 32'h000149CF};          // Channel 5 - VCCRRCORE
    voltage_ranges[6] = '{32'h0000D6E0, 32'h0000F4DB};          // Channel 6 - VCCH_SDM
    voltage_ranges[7] = '{32'h0000BDE3, 32'h0000D95F};          // Channel 7 - VCCL_SDM
    voltage_ranges[8] = '{32'h0001A3C2, 32'h0001F3B6};          // Channel 8 - VCCADC
  end else if (P_FAMILY == "Agilex 5") begin
    if (P_AG5_SERIES == "E") begin

      if (P_SPEED_GRADE == "6") begin
        // Add elements using key-value pairs
        voltage_ranges[2] = '{32'h0000B165, 32'h0000CA62};      // Channel 2 - VCC
        voltage_ranges[3] = '{32'h0001A3C2, 32'h0001F3B6};      // Channel 3 - VCCIO_SDM
        voltage_ranges[4] = '{32'h0001ADC0, 32'h0001E9B7};      // Channel 4 - VCCPT
        voltage_ranges[5] = '{32'h000117D6, 32'h000149CF};      // Channel 5 - VCCRRCORE
        if (  (P_AG5_DENSITY == "005") || (P_AG5_DENSITY == "007") )begin
          // 005 and 007 devices do not have transceivers and run at a different VCCH_SDM
          voltage_ranges[6] = '{32'h0000B165, 32'h0000CA62};    // Channel 6 - VCCH_SDM
        end else begin
          voltage_ranges[6] = '{32'h0000EADD, 32'h00010DD8};    // Channel 6 - VCCH_SDM
        end //if
        voltage_ranges[7] = '{32'h0000B165, 32'h0000CA62};      // Channel 7 - VCCL_SDM
        voltage_ranges[8] = '{32'h0001A3C2, 32'h0001F3B6};      // Channel 8 - VCCADC
      end //if

    end else begin
      // D series TDB

    end //if
  end // if
end

//----------------------------------------------------------------------------//
initial begin
  static logic [3:0] tracker = 0;
  static logic [3:0] pos = 0;

    while (tracker < P_NO_CH_TEMP) begin
        if  (P_REQ_TEMPSENS[pos] != 13) begin
      only_req_temps[tracker]  = P_REQ_TEMPSENS[pos];
            tracker                  = tracker + 1'b1;
        end //if
        pos = pos + 1;
    end //while
end //initial

//----------------------------------------------------------------------------//
assign cmd_fifo_data = {4'b0000, rom_reg.id, rom_reg.cmd};

always_ff @(posedge clk) begin
  if (reset == 1'b1) begin
    mailbox_fsm   <= S_IDLE;
    do_read       <= 1'b0;
    do_write      <= 1'b0;
    rom_addr      <= 'd1;
    collection_en <= 1'b0;

  end else begin
    case (mailbox_fsm)
      //-------------------------------------------------------------//
      S_IDLE : begin
        collection_en <= 1'b0;
        if (ready == 1'b1) begin
          do_read      <= 1'b1;
          address      <= C_CMD_FIFO_SPACE_ADDR;
          mailbox_fsm  <= S_START_CHECKING_CMD_FIFO;
        end //if
      end //S_IDLE

      //-------------------------------------------------------------//
      S_START_CHECKING_CMD_FIFO : begin
        do_read      <= 1'b0;
        mailbox_fsm  <= S_WAITING_CHECKING_CMD_FIFO;

      end //S_WAITING_CHECKING_CMD_FIFO

      //-------------------------------------------------------------//
      S_WAITING_CHECKING_CMD_FIFO : begin
        if (ready == 1'b1) begin
          // if not enough space in the FIFO keep polling until there is
          if (data_rd < 'd2) begin
            do_read      <= 1'b1;
            address      <= C_CMD_FIFO_SPACE_ADDR;
            mailbox_fsm  <= S_START_CHECKING_CMD_FIFO;
          // if there is enough space in the FIFO then write the command
          end else begin
            if (rom_reg.eop == 1'b1) begin
              address <= C_CMD_FIFO_LASTWORD_ADDR;
            end else begin
              address <= C_CMD_FIFO_ADDR;
            end //if
            do_write                 <= 1'b1;
            data_wr                  <= cmd_fifo_data;
            rom_addr                 <= rom_reg.cmd_next_addr[$left(rom_addr) : 0];
            next_rsp_type            <= rom_reg.cmd_type;
            next_rsp_voltage_channel <= rom_reg.id;
            mailbox_fsm              <= S_WRITING_CMD;
          end //if
        end //if
      end //S_WAITING_CHECKING_CMD_FIFO

      //-------------------------------------------------------------//
      S_WAITING_WRITE_CMD : begin
        if (ready == 1'b1) begin
          if (rom_reg.eop == 1'b1) begin
            address     <= C_CMD_FIFO_LASTWORD_ADDR;
            do_write    <= 1'b1;
            data_wr     <= cmd_fifo_data;
            rom_addr    <= rom_reg.cmd_next_addr[$left(rom_addr) : 0];
            mailbox_fsm <= S_WRITING_CMD;
          end else if (rom_reg.sop == 1'b1) begin
            do_read     <= 1'b1;
            address     <= C_RSP_FIFO_FILL_ADDR;
            mailbox_fsm <= S_CHECKING_RSP_FIFO;
          end //if
        end //if
      end //S_WRITING_CMD

      //-------------------------------------------------------------//
      S_WRITING_CMD : begin
        if (rom_reg.eop == 1'b1 && rom_reg.cmd_type == CMD_TEMP) begin
          next_rsp_temperature_channel <= rom_reg.temp_index;
        end //id
        if (ready == 1'b1) begin
          do_write    <= 1'b0;
          mailbox_fsm <= S_WAITING_WRITE_CMD;
          // do_read     <= 1'b1;
          // address     <= C_RSP_FIFO_FILL_ADDR;
          // mailbox_fsm <= S_CHECKING_RSP_FIFO;
        end //if
      end //S_WRITING_CMD

      //-------------------------------------------------------------//
      S_CHECKING_RSP_FIFO : begin
        do_read <= 1'b0;
        if (ready == 1'b1) begin
          if (  (data_rd [31 : 2] >= 'd2) ) begin
            do_read     <= 1'b1;
            address     <= C_RSP_FIFO_DATA_ADDR;
            mailbox_fsm <= S_READING_RSP_HEAD;
          end else begin
            do_read     <= 1'b1;
            address     <= C_RSP_FIFO_FILL_ADDR;
            mailbox_fsm <= S_CHECKING_RSP_FIFO;
          end //if
        end //if
      end //S_CHECKING_RSP_FIFO

      //-------------------------------------------------------------//
      S_READING_RSP_HEAD : begin
        if (ready == 1'b1) begin
          do_read <= 1'b0;
          mailbox_fsm <= S_WAITING_RSP_HEAD;
        end //if
      end // S_READING_RSP_HEAD

      //-------------------------------------------------------------//
      S_WAITING_RSP_HEAD : begin
        do_read <= 1'b0;
        if (ready == 1'b1) begin
          rsp_id      <= data_rd [27 : 24];
          do_read     <= 1'b1;
          mailbox_fsm <= S_READING_RSP_DATA;
        end //if
      end // S_WAITING_RSP_HEAD

      //-------------------------------------------------------------//
      S_READING_RSP_DATA : begin
        if (ready == 1'b1) begin
          do_read      <= 1'b0;
          mailbox_fsm  <= S_WAITING_RSP_DATA;
        end //if
      end // S_READING_RSP_DATA
      S_WAITING_RSP_DATA : begin
        if (ready == 1'b1) begin
          collection_en  <= 1'b1;
          mailbox_fsm    <= S_IDLE;
        end //if
      end // S_WAITING_RSP_DATA

      //-------------------------------------------------------------//
      default : begin
      end //default
      //-------------------------------------------------------------//
    endcase
  end //if

end //always_ff

always_ff @(posedge clk) begin
  if (reset == 1'b1) begin
    voltage_collection <= 'h0;
  end else begin
    if (collection_en == 1'b1) begin
      if (next_rsp_type == CMD_VOLTAGE) begin
        voltage_collection[next_rsp_voltage_channel] <= data_rd;
      end
    end
  end //if
end //always_ff

always_ff @(posedge clk) begin
  if (reset) begin
    temperature_collection <= 'h0;
  end else begin
    if (collection_en == 1'b1) begin
      if (next_rsp_type == CMD_TEMP) begin
        // Grab Temperature 8000000h
        temperature_collection[P_INDEX_CONVERT[next_rsp_temperature_channel]] <= data_rd[15:8];
      end
    end
  end //if
end //always_ff

always_ff @(posedge clk) begin
  for (int i = 0; i < P_NO_CH_VOLT; i++) begin
    if (  (voltage_ranges [i].min <= voltage_collection [i]) && (voltage_collection [i] <= voltage_ranges [i].max) ) begin
      voltage_good_sep [i] <= 1'b1;
    end else begin
      voltage_good_sep [i] <= 1'b0;
    end //if
  end //for
end //always_ff

always_ff @(posedge clk) begin
  if (reset == 1'b1) begin
    voltage_good <= 1'b0;
  end else begin
    voltage_good <= &voltage_good_sep;
  end //if
end //always_ff

always_ff @(posedge clk) begin
  for (int i = 0; i < P_NO_CH_VOLT; i++) begin
    voltage_info [i]     <= voltage_collection [i];
    voltage_info [i][31] <= voltage_good_sep [i];
  end //for
end //always_ff

always_ff @(posedge clk) begin
  for(int i = 0; i < P_NO_CH_TEMP; i++) begin
    if (  (C_MIN_TEMP <= temperature_collection[i]) && (temperature_collection[i] <= C_MAX_TEMP)  ) begin
      temperature_good_sep[i] <= 1'b1;
    end else begin
      temperature_good_sep[i] <= 1'b0;
    end //if
  end //for
end //always_ff

always_ff @(posedge clk) begin
  if (reset == 1'b1) begin
    temperature_good <= 1'b0;
  end else begin
    temperature_good <= &temperature_good_sep;
  end //if
end //always_ff

always_ff @(posedge clk) begin
  for(int i = 0; i < P_NO_CH_TEMP; i++) begin
    temperature_info [i]         <= temperature_collection [i];
    temperature_info [i][31]     <= temperature_good_sep [i];
    temperature_info [i][27:24]  <= only_req_temps [i];
  end //for
end //always_ff

//command_gen command_rom
hw_command_gen #(
  .P_ADDR_WIDTH         (C_ROM_ADDR_WIDTH),
  .P_NO_CH_TEMP         (P_NO_CH_TEMP),
  .P_NO_CH_VOLT         (P_NO_CH_VOLT),
  .P_REQ_TEMPSENS       (P_REQ_TEMPSENS)
) command_rom(
  .addr_i               (rom_addr),
  .q_o                  (rom_comb),
  .command_storage      (command_storage)
);

always_ff @(posedge clk) begin
  rom_reg <= rom_comb;
end //always_ff

hw_avmm_fsm hw_avmm_fsm_inst (
  .clk                  (clk),
  .reset                (reset),

  .do_read              (do_read),
  .do_write             (do_write),
  .address              (address),
  .data_wr              (data_wr),
  .ready                (ready),
  .data_rd              (data_rd),

  .avmm_address         (avmm_address),
  .avmm_write           (avmm_write),
  .avmm_writedata       (avmm_writedata),
  .avmm_read            (avmm_read),
  .avmm_readdata        (avmm_readdata),
  .avmm_readdatavalid   (avmm_readdatavalid),
  .avmm_waitrequest     (avmm_waitrequest)
);

doc_hw_ag5_mailbox doc_hw_ag5_mailbox_inst(
  .in_clk_clk           (clk),
  .in_reset_reset       (reset),
  .avmm_address         (avmm_address),
  .avmm_write           (avmm_write),
  .avmm_writedata       (avmm_writedata),
  .avmm_read            (avmm_read),
  .avmm_readdata        (avmm_readdata),
  .avmm_readdatavalid   (avmm_readdatavalid),
  .avmm_waitrequest     (avmm_waitrequest),
  .irq_irq              ()
);

//****************************************************************************//
endmodule : hw_agilex_5
//****************************************************************************//

`default_nettype wire
