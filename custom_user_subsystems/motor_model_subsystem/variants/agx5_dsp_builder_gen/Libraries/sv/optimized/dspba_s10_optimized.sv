// Copyright 2018 Intel Corporation. All rights reserved.
// Intel products are protected under numerous U.S. and foreign patents, 
// maskwork rights, copyrights and other intellectual property laws.  
//
// This reference design file, and your use thereof, is subject to and governed
// by the terms and conditions of the applicable Intel Reference Design 
// License Agreement (either as signed by you or found at www.intel.com).  By
// using this reference design file, you indicate your acceptance of such terms
// and conditions between you and Intel Corporation.  In the event that you do
// not agree with such terms and conditions, you may not use the reference 
// design file and please promptly destroy any copies you have made.
//
// This reference design file is being provided on an "as-is" basis and as an 
// accommodation and therefore all warranties, representations or guarantees of 
// any kind (whether express, implied or statutory) including, without 
// limitation, warranties of merchantability, non-infringement, or fitness for
// a particular purpose, are specifically disclaimed.  By making this reference
// design file available, Intel expressly does not recommend, suggest or 
// require that this reference design file be used in combination with any 
// other product not provided by Intel.
/////////////////////////////////////////////////////////////////////////////

// Sergey Gribok - 09-12-2018 - core functionality
// Bogdan Pasca  - 02-11-2021 - shift direction, flexible pipelining 


module s10_barrel_shifter_core #(
	parameter SIZE = 16,
	parameter SHIFT_SIZE = 4, 
	parameter LSB = 0, 
	parameter PIPELINE = 0,
	parameter REC_LEVEL = 0
)(	
	input clk,
	input [SIZE-1:0] din,
	input [SHIFT_SIZE-1:0] shift,

	output [SIZE-1:0] dout
);

function int get_pipeline_stages(int PIPELINE = PIPELINE, int REC_LEVEL = REC_LEVEL);
	int LP; 
	int delay;
    LP = (PIPELINE >> (REC_LEVEL+1));
	delay = 0;

	while (LP > 0) begin 
		delay = delay + (LP % 2);
		LP = (LP >> 1);
	end

    return delay;
endfunction


localparam DELAY = get_pipeline_stages(PIPELINE, REC_LEVEL);

localparam SIZE0 = (SIZE + 3) / 4;
localparam SIZE1 = (SIZE + 2) / 4;
localparam SIZE2 = (SIZE + 1) / 4;
localparam SIZE3 = SIZE / 4;

localparam START = (LSB == 0) ? 0 : LSB - 1;

localparam LSB0 = (LSB < 4) ? 0: LSB / 4;
localparam LSB1 = (LSB < 4) ? 0: (LSB - 1) / 4;
localparam LSB2 = (LSB < 4) ? 0: (LSB - 2) / 4;
localparam LSB3 = (LSB < 4) ? 0: (LSB - 3) / 4;

wire [SIZE-1:-2] w_din;

genvar i;
generate

if (SHIFT_SIZE > 2)
begin

	wire [SIZE0-1:0] din0;
	wire [SIZE1-1:0] din1;
	wire [SIZE2-1:0] din2;
	wire [SIZE3-1:0] din3;
	wire [SIZE0-1:0] dout0;
	wire [SIZE1-1:0] dout1;
	wire [SIZE2-1:0] dout2;
	wire [SIZE3-1:0] dout3;

	assign w_din[-1:-2] = 2'b0;

	for (i = 0; i < SIZE; i = i + 1)
	begin: loop1
		if (i[1:0] == 0) begin
			assign din0[i / 4] = din[i];
			assign w_din[i] = dout0[i / 4];
		end else if (i[1:0] == 1) begin
			assign din1[i / 4] = din[i];
			assign w_din[i] = dout1[i / 4];
		end else if (i[1:0] == 2) begin
			assign din2[i / 4] = din[i];
			assign w_din[i] = dout2[i / 4];
		end else if (i[1:0] == 3) begin
			assign din3[i / 4] = din[i];
			assign w_din[i] = dout3[i / 4];
		end
	end

	s10_barrel_shifter_core #(SIZE0, SHIFT_SIZE-2, LSB0, PIPELINE, REC_LEVEL+1) shifter0(
		.clk(clk), .din(din0), .shift(shift[SHIFT_SIZE-1:2]), .dout(dout0)
	);
	s10_barrel_shifter_core #(SIZE1, SHIFT_SIZE-2, LSB1, PIPELINE, REC_LEVEL+1) shifter1(
		.clk(clk), .din(din1), .shift(shift[SHIFT_SIZE-1:2]), .dout(dout1)
	);
	s10_barrel_shifter_core #(SIZE2, SHIFT_SIZE-2, LSB2, PIPELINE, REC_LEVEL+1) shifter2(
		.clk(clk), .din(din2), .shift(shift[SHIFT_SIZE-1:2]), .dout(dout2)
	);
	s10_barrel_shifter_core #(SIZE3, SHIFT_SIZE-2, LSB3, PIPELINE, REC_LEVEL+1) shifter3(
		.clk(clk), .din(din3), .shift(shift[SHIFT_SIZE-1:2]), .dout(dout3)
	);
end
else
begin
	assign w_din = {din, 2'b0};
end

wire [SIZE-1:0] sum_w;
wire [SIZE:0] cout_w;

assign cout_w[0] = 1'b0;

wire [1:0] shift_w;
// if the final shift stage is pipelined, then we don't need to delay 
// the shift value;
if ( (PIPELINE==0) || (PIPELINE==1) || (DELAY==0) || (SHIFT_SIZE <= 2) )
	assign shift_w = shift[1:0];
else
begin

	reg [DELAY-1:0][1:0] shift_r;
	
	always @(posedge clk) begin
		shift_r[0] <= shift[1:0];
	end
	for (i = 1; i < DELAY; i = i + 1)
	begin: sr
		always @(posedge clk) begin
			shift_r[i] <= shift_r[i-1];
		end

	end	

	assign shift_w = shift_r[DELAY-1];
end

for (i = 0; i < SIZE; i = i + 1)
begin: loop3
	if (i < START)
		assign sum_w[i] = 1'b0;
	else if ((i == START) && (START > 0))
	begin
		assign sum_w[i] = 1'b0;
		// p = !a & (!b & c | b & d)
		// g = a & (!b & c | b & d) 
		fourteennm_lcell_comb #(
			.lut_mask(64'h0000_0000_A820_5410)
		) c0 (
			.dataa(shift_w[0]), 
			.datab(shift_w[1]), 
			.datac(w_din[i]), 
			.datad(w_din[i-2]), 
			.cin(1'b0),
			.sumout(), 
			.cout(cout_w[i+1]),
			.datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
		);
	end
	else
		// p = !a & (!b & c | b & d)
		// g = a & (!b & c | b & d) 
		fourteennm_lcell_comb #(
			.lut_mask(64'h0000_0000_A820_5410)
		) c0 (
			.dataa(shift_w[0]), 
			.datab(shift_w[1]), 
			.datac(w_din[i]), 
			.datad(w_din[i-2]), 
			.cin(cout_w[i]),
			.sumout(sum_w[i]), 
			.cout(cout_w[i+1]),
			.datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
		);

	
end

if ( ((PIPELINE>>REC_LEVEL)%2) == 0)
	assign dout = sum_w;
else
begin
	reg [SIZE-1:0] sum_r;
	always @(posedge clk) begin
		sum_r <= sum_w;
	end
	assign dout = sum_r;
end

endgenerate

	
endmodule

(* altera_attribute = "-name FRACTAL_SYNTHESIS ON" *) 
module s10_barrel_shifter #(
	parameter SIZE = 32,
	parameter SHIFT_SIZE = 4, // Must be even number!
	parameter LSB = 0, // If several LSB outputs are not going to be used then you should specify it by using parameter LSB. That saves a lot of area.
	parameter PIPELINE = 1 // If 0 then there is no pipelines, if 1 then the design is fully pipelined (SHIFT_SIZE / 2 pipeline stages)
)(	
	input clk,
	input [SIZE-1:0] din,
	input [SHIFT_SIZE-1:0] shift,

	output [SIZE-1:LSB] dout
);

wire [SIZE-1:0] w_dout;

s10_barrel_shifter_core #(SIZE, SHIFT_SIZE, LSB, PIPELINE) shifter(.clk(clk), .din(din), .shift(shift), .dout(w_dout));

assign dout = w_dout[SIZE-1:LSB];

endmodule




module shift_left_stratix10 #(
	parameter SIZE = 32,
	parameter SHIFT_SIZE = 4, // Must be even number!
	parameter LSB = 0, // If several LSB outputs are not going to be used then you should specify it by using parameter LSB. That saves a lot of area.
	parameter PIPELINE = 1 // If 0 then there is no pipelines, if 1 then the design is fully pipelined (SHIFT_SIZE / 2 pipeline stages)
)(	
	input clk,
	input [SIZE-1:0] din,
	input [SHIFT_SIZE-1:0] shift,

	output [SIZE-1:LSB] dout
);

wire [SIZE-1:0] w_dout;
s10_barrel_shifter #(SIZE, SHIFT_SIZE, LSB, PIPELINE) shifter(.clk(clk), .din(din), .shift(shift), .dout(w_dout));
assign dout = w_dout[SIZE-1:LSB];

endmodule

module shift_right_stratix10 #(
	parameter SIZE = 32,
	parameter SHIFT_SIZE = 4, // Must be even number!
	parameter LSB = 0, // If several LSB outputs are not going to be used then you should specify it by using parameter LSB. That saves a lot of area.
	parameter PIPELINE = 1 // If 0 then there is no pipelines, if 1 then the design is fully pipelined (SHIFT_SIZE / 2 pipeline stages)
)(	
	input clk,
	input [SIZE-1:0] din,
	input [SHIFT_SIZE-1:0] shift,

	output [SIZE-1:LSB] dout
);

wire [SIZE-1:0] din_flipped;
wire [SIZE-1:0] w_dout_flipped;
wire [SIZE-1:0] w_dout;

assign din_flipped = {<<{din}};

s10_barrel_shifter #(SIZE, SHIFT_SIZE, LSB, PIPELINE) shifter(.clk(clk), .din(din_flipped), .shift(shift), .dout(w_dout_flipped));
assign w_dout = {<<{w_dout_flipped}};
assign dout = w_dout[SIZE-1:LSB];

endmodule

// Copyright 2020 Intel Corporation. 
//
// This reference design file is subject licensed to you by the terms and 
// conditions of the applicable License Terms and Conditions for Hardware 
// Reference Designs and/or Design Examples (either as signed by you or 
// found at https://www.altera.com/common/legal/leg-license_agreement.html ).  
//
// As stated in the license, you agree to only use this reference design 
// solely in conjunction with Intel FPGAs or Intel CPLDs.  
//
// THE REFERENCE DESIGN IS PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED
// WARRANTY OF ANY KIND INCLUDING WARRANTIES OF MERCHANTABILITY, 
// NONINFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE. Intel does not 
// warrant or assume responsibility for the accuracy or completeness of any
// information, links or other items within the Reference Design and any 
// accompanying materials.
//
// In the event that you do not agree with such terms and conditions, do not
// use the reference design file.
/////////////////////////////////////////////////////////////////////////////

module s10_leading_zero_counter #(
    parameter SIZE = 40,
    parameter OUT_SIZE = 6,
    parameter PIPELINE = 1
		
) (
    input clk,
    input [SIZE-1:0] din,
    output [OUT_SIZE-1:0] dout
);

wire [OUT_SIZE-1:0] dout_w;

genvar i, j;
generate

if (SIZE == 1) begin
    assign dout_w = din[0] ? 0 : 1;
end else if (SIZE == 2) begin
    assign dout_w = din[1] ? 0 : (din[0] ? 1 : 2);
end else if (SIZE == 3) begin
    assign dout_w = din[2] ? 0 : (din[1] ? 1 : (din[0] ? 2 : 3 ) );
end else if (SIZE == 4) begin
    assign dout_w = din[3] ? 0 : (din[2] ? 1 : (din[1] ? 2 : (din[0] ? 3 : 4) ) );
end else if (SIZE == 5) begin
    assign dout_w = din[4] ? 0 : (din[3] ? 1 : (din[2] ? 2 : (din[1] ? 3 : (din[0] ? 4 : 5) ) ) );
end else if (SIZE == 6) begin
    assign dout_w = din[5] ? 0 : (din[4] ? 1 : (din[3] ? 2 : (din[2] ? 3 : (din[1] ? 4 : (din[0] ? 5 : 6) ) ) ) );
end else begin

    localparam [SIZE:0] C[0:5] = {64'b1010101010101010101010101010101010101010101010101010101010101010,
                                  64'b1100110011001100110011001100110011001100110011001100110011001100,
                                  64'b1111000011110000111100001111000011110000111100001111000011110000,
                                  64'b1111111100000000111111110000000011111111000000001111111100000000,
                                  64'b1111111111111111000000000000000011111111111111110000000000000000,
                                  64'b1111111111111111111111111111111100000000000000000000000000000000};

    localparam LOOP_NUM = (SIZE - 6) / 6;

    for (j = 0; j < OUT_SIZE; j=j+1) begin : loop_j
        wire [2*LOOP_NUM+3:0] cout_w;

        fourteennm_lcell_comb #(
            .lut_mask({32'h0, {8{C[j][SIZE-4]}}, {4{C[j][SIZE-3]}}, {2{C[j][SIZE-2]}}, C[j][SIZE-1], C[j][SIZE], 16'h0})
        ) c0 (
            .dataa(din[0]), 
            .datab(din[1]), 
            .datac(din[2]), 
            .datad(din[3]), 
            .cin(1'b0),
            .sumout(), 
            .cout(cout_w[0]),
            .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
        );

        fourteennm_lcell_comb #(
            .lut_mask({32'h0, {8{C[j][SIZE-6]}}, {4{C[j][SIZE-5]}}, 4'h0, 16'h000F})
        ) c1 (
            .dataa(), 
            .datab(), 
            .datac(din[4]), 
            .datad(din[5]), 
            .cin(cout_w[0]),
            .sumout(), 
            .cout(cout_w[1]),
            .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
        );


        for (i = 0; i < LOOP_NUM; i = i + 1)
        begin: loop
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][SIZE-6*i-10]}}, {4{C[j][SIZE-6*i-9]}}, {2{C[j][SIZE-6*i-8]}}, C[j][SIZE-6*i-7], 1'b0, 16'h0001})
            ) c2 (
                .dataa(din[6*i+6]), 
                .datab(din[6*i+7]), 
                .datac(din[6*i+8]), 
                .datad(din[6*i+9]), 
                .cin(cout_w[2*i+1]),
                .sumout(), 
                .cout(cout_w[2*i+2]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
            
            // cout[2] = cout[13] & sum[4] & sum[5]
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][SIZE-6*i-12]}}, {4{C[j][SIZE-6*i-11]}}, 4'h0, 16'h000F})
            ) c3 (
                .dataa(), 
                .datab(), 
                .datac(din[6*i+10]), 
                .datad(din[6*i+11]), 
                .cin(cout_w[2*i+2]),
                .sumout(), 
                .cout(cout_w[2*i+3]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end

        if (SIZE % 6 == 0)
        begin
            // Last empty cell
            fourteennm_lcell_comb #(
                .lut_mask(64'h0000_0000_0000_0000)
            ) cN (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(), 
                .cin(cout_w[2*LOOP_NUM+1]),
                .sumout(dout_w[j]), 
                .cout(),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end
        else if (SIZE % 6 == 1)
        begin	
            // Second to last cell
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][0]}}, 8'h0, 16'h00FF})
            ) cN_minus_1 (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(din[SIZE-1]), 
                .cin(cout_w[2*LOOP_NUM+1]),
                .sumout(), 
                .cout(cout_w[2*LOOP_NUM+2]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );

            // Last empty cell
            fourteennm_lcell_comb #(
                .lut_mask(64'h0000_0000_0000_0000)
            ) cN (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(), 
                .cin(cout_w[2*LOOP_NUM+2]),
                .sumout(dout_w[j]), 
                .cout(),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end
        else if (SIZE % 6 == 2)
        begin	
            // Second to last cell
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][0]}}, {4{C[j][1]}}, 4'h0, 16'h000F})
            ) cN_minus_1 (
                .dataa(), 
                .datab(), 
                .datac(din[SIZE-2]), 
                .datad(din[SIZE-1]), 
                .cin(cout_w[2*LOOP_NUM+1]),
                .sumout(), 
                .cout(cout_w[2*LOOP_NUM+2]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );

            // Last empty cell
            fourteennm_lcell_comb #(
                .lut_mask(64'h0000_0000_0000_0000)
            ) cN (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(), 
                .cin(cout_w[2*LOOP_NUM+2]),
                .sumout(dout_w[j]), 
                .cout(),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end
        else if (SIZE % 6 == 3)
        begin	
            // Second to last cell
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][0]}}, {4{C[j][1]}}, {2{C[j][2]}}, 2'h0, 16'h0003})
            ) cN_minus_1 (
                .dataa(), 
                .datab(din[SIZE-3]), 
                .datac(din[SIZE-2]), 
                .datad(din[SIZE-1]), 
                .cin(cout_w[2*LOOP_NUM+1]),
                .sumout(), 
                .cout(cout_w[2*LOOP_NUM+2]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );

            // Last empty cell
            fourteennm_lcell_comb #(
                .lut_mask(64'h0000_0000_0000_0000)
            ) cN (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(), 
                .cin(cout_w[2*LOOP_NUM+2]),
                .sumout(dout_w[j]), 
                .cout(),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end
        else if (SIZE % 6 == 4)
        begin	
            // Second to last cell
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][0]}}, {4{C[j][1]}}, {2{C[j][2]}}, C[j][3], 1'h0, 16'h0001})
            ) cN_minus_1 (
                .dataa(din[SIZE-4]), 
                .datab(din[SIZE-3]), 
                .datac(din[SIZE-2]), 
                .datad(din[SIZE-1]), 
                .cin(cout_w[2*LOOP_NUM+1]),
                .sumout(), 
                .cout(cout_w[2*LOOP_NUM+2]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );

            // Last empty cell
            fourteennm_lcell_comb #(
                .lut_mask(64'h0000_0000_0000_0000)
            ) cN (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(), 
                .cin(cout_w[2*LOOP_NUM+2]),
                .sumout(dout_w[j]), 
                .cout(),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end
        else if (SIZE % 6 == 5)
        begin	
            // Third to last cell
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][1]}}, {4{C[j][2]}}, {2{C[j][3]}}, C[j][4], 1'h0, 16'h0001})
            ) cN_minus_2 (
                .dataa(din[SIZE-5]), 
                .datab(din[SIZE-4]), 
                .datac(din[SIZE-3]), 
                .datad(din[SIZE-2]), 
                .cin(cout_w[2*LOOP_NUM+1]),
                .sumout(), 
                .cout(cout_w[2*LOOP_NUM+2]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );

            // Second to last cell
            fourteennm_lcell_comb #(
                .lut_mask({32'h0, {8{C[j][0]}}, 8'h0, 16'h00FF})
            ) cN_minus_1 (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(din[SIZE-1]), 
                .cin(cout_w[2*LOOP_NUM+2]),
                .sumout(), 
                .cout(cout_w[2*LOOP_NUM+3]),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );

            // Last empty cell
            fourteennm_lcell_comb #(
                .lut_mask(64'h0000_0000_0000_0000)
            ) cN (
                .dataa(), 
                .datab(), 
                .datac(), 
                .datad(), 
                .cin(cout_w[2*LOOP_NUM+3]),
                .sumout(dout_w[j]), 
                .cout(),
                .datae(), .dataf(), .datag(), .datah(), .sharein(), .shareout(), .combout()
            );
        end
    end
end
endgenerate

if (PIPELINE==0)
	assign dout = dout_w;
else
begin
	reg [OUT_SIZE-1:0] dout_w_r;
	always @(posedge clk) begin
		dout_w_r <= dout_w;
	end
	assign dout = dout_w_r;
end
endmodule




