// Copyright (C) 2019  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
// CREATED		"Sat Jan 16 21:53:50 2021"

module Components(
	wren,
	vga_reset,
	clk,
	adress,
	hsync,
	vsync,
	p_tick,
	blue,
	data,
	green,
	red
);


input wire	wren;
input wire	vga_reset;
input wire	clk;
input wire	[22:0] adress;
output wire	hsync;
output wire	vsync;
output wire	p_tick;
output wire	[4:0] blue;
inout wire	[7:0] data;
output wire	[4:0] green;
output wire	[5:0] red;

wire	[15:0] gdfx_temp0;
wire	SYNTHESIZED_WIRE_0;
wire	[15:0] SYNTHESIZED_WIRE_1;
wire	[9:0] SYNTHESIZED_WIRE_2;
wire	[9:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[15:0] SYNTHESIZED_WIRE_5;
wire	[18:0] SYNTHESIZED_WIRE_6;
wire	[63:0] SYNTHESIZED_WIRE_7;
wire	[14:0] SYNTHESIZED_WIRE_8;
wire	[7:0] SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_10;
wire	[15:0] SYNTHESIZED_WIRE_11;





memory_manager	b2v_inst(
	.wren_in(wren),
	.clk(clk),
	.address(adress),
	.core_data(gdfx_temp0),
	.data(data),
	.wren_out(SYNTHESIZED_WIRE_4),
	.core_address(SYNTHESIZED_WIRE_5),
	
	.core_en(SYNTHESIZED_WIRE_7),
	
	.reg_en(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst.ADDR_SPACE = 23;
	defparam	b2v_inst.CORE_CODIND = 6;
	defparam	b2v_inst.CORE_WIDTH = 16;
	defparam	b2v_inst.DATA_WIDTH = 8;
	defparam	b2v_inst.NUM_CORES = 64;
	defparam	b2v_inst.NUM_REGS = 8;
	defparam	b2v_inst.REGS_CODIND = 3;


buffer_manager	b2v_inst1(
	.on_air(SYNTHESIZED_WIRE_0),
	.clk(clk),
	.data(SYNTHESIZED_WIRE_1),
	.x(SYNTHESIZED_WIRE_2),
	.y(SYNTHESIZED_WIRE_3),
	.address(SYNTHESIZED_WIRE_6),
	.blue(blue),
	.green(green),
	.red(red));
	defparam	b2v_inst1.ADDRESS_WIDTH = 19;
	defparam	b2v_inst1.BLUE = 5;
	defparam	b2v_inst1.COORDINATES = 10;
	defparam	b2v_inst1.GREEN = 5;
	defparam	b2v_inst1.RED = 6;
	defparam	b2v_inst1.SCREEN_W = 800;
	defparam	b2v_inst1.WIDTH = 16;


SM	b2v_inst3(
	.wren(SYNTHESIZED_WIRE_4),
	.clk(clk),
	.clk_buffer(clk),
	.address(SYNTHESIZED_WIRE_5),
	.bufferAddress(SYNTHESIZED_WIRE_6),
	.coreEnable(SYNTHESIZED_WIRE_7),
	.data(gdfx_temp0),
	.instruction(SYNTHESIZED_WIRE_8),
	.bufferData(SYNTHESIZED_WIRE_1)
	);
	defparam	b2v_inst3.ADDRESS_WIDTH = 16;
	defparam	b2v_inst3.BUFFER_ADDRESS_WIDTH = 19;
	defparam	b2v_inst3.CORE_BUFFER_WIDTH = 13;
	defparam	b2v_inst3.CORE_NUM = 64;
	defparam	b2v_inst3.DATA_WIDTH = 16;
	defparam	b2v_inst3.INSTRUCTION_WIDTH = 15;


vga	b2v_inst5(
	.clk(clk),
	.reset(vga_reset),
	.hsync(hsync),
	.vsync(vsync),
	.video_on(SYNTHESIZED_WIRE_0),
	.p_tick(p_tick),
	.x(SYNTHESIZED_WIRE_2),
	.y(SYNTHESIZED_WIRE_3));


InstructionProcessor	b2v_inst8(
	.clock(clk),
	.regChoose(SYNTHESIZED_WIRE_9),
	.regData(gdfx_temp0),
	.ROMData(SYNTHESIZED_WIRE_10),
	.instructionOut(SYNTHESIZED_WIRE_8),
	.ROMAddress(SYNTHESIZED_WIRE_11));
	defparam	b2v_inst8.CARRY = 0;
	defparam	b2v_inst8.NOP = 15'b100001011000000;
	defparam	b2v_inst8.OVERFLOW = 2;
	defparam	b2v_inst8.REGS_CODING = 8;
	defparam	b2v_inst8.SIGN = 1;
	defparam	b2v_inst8.WIDTH = 16;
	defparam	b2v_inst8.ZERO = 3;


ROM	b2v_inst9(
	.clock(clk),
	.address(SYNTHESIZED_WIRE_11),
	.q(SYNTHESIZED_WIRE_10));


endmodule
