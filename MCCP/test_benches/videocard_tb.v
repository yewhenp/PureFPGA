`timescale 1 ns/10 ps
module videocard_tb();

localparam WIDTH=32;


reg clk = 0;
reg clk_rom = 0;
reg [WIDTH/2-1: 0] address = 16'b0;
reg [WIDTH-1: 0] data_in = 16'b0;
wire [WIDTH-1: 0] data_out;
reg wren = 1'b0;

reg address_control = 1'b0;
reg [WIDTH-1: 0] data_in_control = 32'b0;
wire [WIDTH-1: 0] data_out_control;
reg wren_control = 1'b0;


//RAM ram_inst
//(
//	.address(address),
//	.clock(clk),
//	.data(data_out),
//	.wren(wren),
//	.q(data_in)
//);
//
//videocard videocard_main
//(
//	.clk(clk),
//	.data_in(data_in),
//	.data_out(data_out),
//	.address(address),
//	.wren(wren),
//	.interrupt_start(intt)
//);

videocard_top videocard_top_inst
(
	.clk(clk) ,	// input  clk_sig
	.clk_hps(clk) ,	// input  clk_hps_sig
	.clk_rom(clk_rom),
	.data_in(data_in) ,	// input [WIDTH-1:0] data_in_sig
	.data_out(data_out) ,	// output [WIDTH-1:0] data_out_sig
	.address(address) ,	// input [WIDTH/2-1:0] address_sig
	.byteenable(4'b1111) ,	// input [BYTES-1:0] byteenable_sig
	.write(wren) ,	// input  write_sig
	.read(1'b1) ,	// input  read_sig
	.reset_sink_reset(1'b0) ,	// input  reset_sink_reset_sig
	.data_out_control(data_out_control),
	.data_in_control(data_in_control),
	.read_control(~wren_control),
	.write_control(wren_control),
	.address_control(address_control)
);



initial begin
	#200
	// RAM[0] = veector_size = 4
	address <= 0;
	data_in <= 8;
	wren <= 1;
	
	#40
	// RAM[1] = address = 2
	address <= 1;
	data_in <= 2;
	
	#40
	// RAN[2]=3
	address <= 2;
	data_in <= 3;
	
	#40
	// RAN[3]=4
	address <= 3;
	data_in <= 4;

	#40
	// RAN[4]=5
	address <= 4;
	data_in <= 5;

	#40
	// RAN[5]=6
	address <= 5;
	data_in <= 6;
	
	#40
	// RAN[6]=7
	address <= 6;
	data_in <= 7;
	
	#40
	// RAN[7]=8
	address <= 7;
	data_in <= 8;
	
	#40
	// RAN[8]=9
	address <= 8;
	data_in <= 9;
	
	#40
	// RAN[9]=10
	address <= 9;
	data_in <= 10;
	
	#40
	address <= 10;
	wren <= 0;
	
	#40
	wren_control <= 1;
	address_control <= 0;
	data_in_control <= 1;
	
	#20
	wren_control <= 0;
	address_control <= 1;
	data_in_control <= 0;
   
	#15000
	address <= 0;
	
	#40
	address <= 1;
	
	#40
	address <= 2;
	
	#40
	address <= 3;

	#40
	address <= 4;

	#40
	address <= 5;
	
	#40
	address <= 6;
	
	#40
	address <= 7;
	
	#40
	address <= 8;
	
	#40
	address <= 9;
	
	#40
	address <= 10;
	
	
	#200
   $stop;

end

always #5 clk = ~clk;
always #1 clk_rom = ~clk_rom;

endmodule 