module videocard #(
 parameter
 WIDTH=32,
 CORE_NUM=4,
 INT_NUM=3
)(
input 					clk,
input [WIDTH-1: 0] 	data_in,
output [WIDTH-1: 0] 	data_out,
output [WIDTH-1: 0] 	address,
output 					wren,
input 					interrupt_start,
output 					interrupt_finish,
input						clk_hps
);


// internal wires
wire [WIDTH-1: 0] data_in_core0;
wire [WIDTH-1: 0] data_in_core1;
wire [WIDTH-1: 0] data_in_core2;
wire [WIDTH-1: 0] data_in_core3;

wire [WIDTH-1: 0] data_out_core0;
wire [WIDTH-1: 0] data_out_core1;
wire [WIDTH-1: 0] data_out_core2;
wire [WIDTH-1: 0] data_out_core3;

wire [WIDTH-1: 0] address_core0;
wire [WIDTH-1: 0] address_core1;
wire [WIDTH-1: 0] address_core2;
wire [WIDTH-1: 0] address_core3;

wire [WIDTH-1: 0] instruction_core0;
wire [WIDTH-1: 0] instruction_core1;
wire [WIDTH-1: 0] instruction_core2;
wire [WIDTH-1: 0] instruction_core3;

wire [WIDTH-1: 0] address_instr_core0;
wire [WIDTH-1: 0] address_instr_core1;
wire [WIDTH-1: 0] address_instr_core2;
wire [WIDTH-1: 0] address_instr_core3;

wire [CORE_NUM-1: 0] request;
wire [CORE_NUM-1: 0] response;
wire [CORE_NUM-1: 0] wren_core;
wire [CORE_NUM-1: 0] core_interrupts;

wire [INT_NUM-1:0]   int_num0; 
wire [INT_NUM-1:0]   int_num1;
wire [INT_NUM-1:0]   int_num2;
wire [INT_NUM-1:0]   int_num3;



four_way_rom rom
(
	.clk(clk_hps),
	.address_core0(address_instr_core0),
	.address_core1(address_instr_core1),
	.address_core2(address_instr_core2),
	.address_core3(address_instr_core3),
	.data_core0(instruction_core0),
	.data_core1(instruction_core1),
	.data_core2(instruction_core2),
	.data_core3(instruction_core3)
);


arbiter arbiter_inst
(
	.data_in_core0(data_in_core0) ,	// input [WIDTH-1:0] data_in_core0_sig
	.data_in_core1(data_in_core1) ,	// input [WIDTH-1:0] data_in_core1_sig
	.data_in_core2(data_in_core2) ,	// input [WIDTH-1:0] data_in_core2_sig
	.data_in_core3(data_in_core3) ,	// input [WIDTH-1:0] data_in_core3_sig
	.data_out_core0(data_out_core0) ,	// output [WIDTH-1:0] data_out_core0_sig
	.data_out_core1(data_out_core1) ,	// output [WIDTH-1:0] data_out_core1_sig
	.data_out_core2(data_out_core2) ,	// output [WIDTH-1:0] data_out_core2_sig
	.data_out_core3(data_out_core3) ,	// output [WIDTH-1:0] data_out_core3_sig
	.address_in_core0(address_core0) ,	// input [WIDTH-1:0] address_in_core0_sig
	.address_in_core1(address_core1) ,	// input [WIDTH-1:0] address_in_core1_sig
	.address_in_core2(address_core2) ,	// input [WIDTH-1:0] address_in_core2_sig
	.address_in_core3(address_core3) ,	// input [WIDTH-1:0] address_in_core3_sig
	.data_write(data_out) ,	// output [WIDTH-1:0] data_write_sig
	.data_read(data_in) ,	// input [WIDTH-1:0] data_read_sig
	.address(address) ,	// output [WIDTH-1:0] address_sig
	.request(request) ,	// input [CORE_NUM-1:0] request_sig
	.response(response) ,	// output [CORE_NUM-1:0] response_sig
	.wren_core(wren_core) ,	// input [CORE_NUM-1:0] wren_core_sig
	.wren(wren) ,	// output  wren_sig
	.clk(clk) 	// input  clk_sig
);

interrupt_controller inter_controller
(
	.clk(clk),
	.core_interrupts(core_interrupts),
	.interrupt(interrupt_finish)
);


core core0
(
	.clk(clk) ,	// input  clk_sig
	.response(response[0]) ,	// input  response_sig
	.instruction(instruction_core0) ,	// input [WIDTH-1:0] instruction_sig
	.wren(wren_core[0]) ,	// output  wren_sig
	.core_index(2'b00),
	.request(request[0]) ,	// output  request_sig
	.readdata(data_out_core0) ,	// input [WIDTH-1:0] readdata_sig
	.address(address_core0) ,	// output [WIDTH-1:0] address_sig
	.writedata(data_in_core0) ,	// output [WIDTH-1:0] writedata_sig
	.instr_addr(address_instr_core0), 	// output [WIDTH-1:0] instr_addr_sig
	.interrupt_start(interrupt_start),
	.interrupt_finish(core_interrupts[0]),
	.int_num(int_num0)
);

core core1
(
	.clk(clk) ,	// input  clk_sig
	.response(response[1]) ,	// input  response_sig
	.instruction(instruction_core1) ,	// input [WIDTH-1:0] instruction_sig
	.wren(wren_core[1]) ,	// output  wren_sig
	.core_index(2'b01),
	.request(request[1]) ,	// output  request_sig
	.readdata(data_out_core1) ,	// input [WIDTH-1:0] readdata_sig
	.address(address_core1) ,	// output [WIDTH-1:0] address_sig
	.writedata(data_in_core1) ,	// output [WIDTH-1:0] writedata_sig
	.instr_addr(address_instr_core1), 	// output [WIDTH-1:0] instr_addr_sig
	.interrupt_start(interrupt_start),
	.interrupt_finish(core_interrupts[1]),
	.int_num(int_num1)
);

core core2
(
	.clk(clk) ,	// input  clk_sig
	.response(response[2]) ,	// input  response_sig
	.instruction(instruction_core2) ,	// input [WIDTH-1:0] instruction_sig
	.wren(wren_core[2]) ,	// output  wren_sig
	.core_index(2'b10),
	.request(request[2]) ,	// output  request_sig
	.readdata(data_out_core2) ,	// input [WIDTH-1:0] readdata_sig
	.address(address_core2) ,	// output [WIDTH-1:0] address_sig
	.writedata(data_in_core2) ,	// output [WIDTH-1:0] writedata_sig
	.instr_addr(address_instr_core2), 	// output [WIDTH-1:0] instr_addr_sig
	.interrupt_start(interrupt_start),
	.interrupt_finish(core_interrupts[2]),
	.int_num(int_num2)
);

core core3
(
	.clk(clk) ,	// input  clk_sig
	.response(response[3]) ,	// input  response_sig
	.instruction(instruction_core3) ,	// input [WIDTH-1:0] instruction_sig
	.wren(wren_core[3]) ,	// output  wren_sig
	.core_index(2'b11),
	.request(request[3]) ,	// output  request_sig
	.readdata(data_out_core3) ,	// input [WIDTH-1:0] readdata_sig
	.address(address_core3) ,	// output [WIDTH-1:0] address_sig
	.writedata(data_in_core3) ,	// output [WIDTH-1:0] writedata_sig
	.instr_addr(address_instr_core3), 	// output [WIDTH-1:0] instr_addr_sig
	.interrupt_start(interrupt_start),
	.interrupt_finish(core_interrupts[3]),
	.int_num(int_num3)
);




endmodule