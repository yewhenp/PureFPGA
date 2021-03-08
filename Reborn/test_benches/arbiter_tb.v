`timescale 1 ns/10 ps
module arbiter_tb();

localparam WIDTH=32;
localparam CORE_NUM=4;

reg clk = 1;
reg [WIDTH-1: 0] data_in_core0;
wire [WIDTH-1: 0] data_out_core0;
reg [WIDTH-1: 0] address_in_core0;
reg [WIDTH-1: 0] data_in_core1;
wire [WIDTH-1: 0] data_out_core1;
reg [WIDTH-1: 0] address_in_core1;
wire [WIDTH-1: 0] data_write;
wire [WIDTH-1: 0] data_read;
wire [WIDTH-1: 0] address;
reg [CORE_NUM-1: 0] request = 0;
wire [CORE_NUM-1: 0] response;
reg [CORE_NUM-1: 0] wren_core = 0;
wire wren;

integer i = 0;


arbiter arbiter_inst
(
	.data_in_core0(data_in_core0) ,	// input [WIDTH-1:0] data_in_core0_sig
	.data_in_core1(data_in_core1) ,	// input [WIDTH-1:0] data_in_core1_sig
	.data_in_core2(0) ,	// input [WIDTH-1:0] data_in_core2_sig
	.data_in_core3(0) ,	// input [WIDTH-1:0] data_in_core3_sig
	.data_out_core0(data_out_core0) ,	// output [WIDTH-1:0] data_out_core0_sig
	.data_out_core1(data_out_core1) ,	// output [WIDTH-1:0] data_out_core1_sig
	.data_out_core2() ,	// output [WIDTH-1:0] data_out_core2_sig
	.data_out_core3() ,	// output [WIDTH-1:0] data_out_core3_sig
	.address_in_core0(address_in_core0) ,	// input [WIDTH-1:0] address_in_core0_sig
	.address_in_core1(address_in_core1) ,	// input [WIDTH-1:0] address_in_core1_sig
	.address_in_core2(0) ,	// input [WIDTH-1:0] address_in_core2_sig
	.address_in_core3(0) ,	// input [WIDTH-1:0] address_in_core3_sig
	.data_write(data_write) ,	// output [WIDTH-1:0] data_write_sig
	.data_read(data_read) ,	// input [WIDTH-1:0] data_read_sig
	.address(address) ,	// output [WIDTH-1:0] address_sig
	.request(request) ,	// input [CORE_NUM-1:0] request_sig
	.response(response) ,	// output [CORE_NUM-1:0] response_sig
	.wren_core(wren_core) ,	// input [CORE_NUM-1:0] wren_core_sig
	.wren(wren) ,	// output  wren_sig
	.clk(clk) 	// input  clk_sig
);


RAM RAM_inst
(
	.address(address),
	.clock(clk),
	.data(data_write),
	.wren(wren),
	.q(data_read)
);


initial begin

	#20
	
	wren_core[0] <= 1;
	request[0] <= 1;
	for(i = 0; i< 5; i = i + 1) begin
		address_in_core0 <= i;
		data_in_core0 <= 3*i;
		#80;
	end
	
	request[0] <= 0;
	wren_core[0] <= 0;
	wren_core[1] <= 1;
	request[1] <= 1;
	for(i = 5; i< 10; i = i + 1) begin
		address_in_core1 <= i;
		data_in_core1 <= 4*i;
		#80;
	end
	request[1] <= 0;
	wren_core[1] <= 0;
	#40
	
	address_in_core0 <= 3;
	request[0] <= 1;
	
	#80
	
	address_in_core1 <= 7;
	request[0] <= 0;
	request[1] <= 1;
	
	#100


   $stop;

end

always #5 clk = ~clk;

endmodule
