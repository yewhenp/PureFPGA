`timescale 1 ns/10 ps
module videocard_tb();

localparam WIDTH=32;


reg clk = 0;
reg clk_rom = 0;
reg [WIDTH/2: 0] address = 16'b0;
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
	.clk_hps(clk_rom) ,	// input  clk_hps_sig
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
	wren <= 1;
	address <= 65536;
	data_in <= 32'b10001111010101000000000000000001; //1
	
	#40
	address <= 65537;
	data_in <= 32'b00000010100011010010000101010100; //2
	
	
	#40
	address <= 65538;
	data_in <= 32'b01000010100011010100001011000000; //3
	
	
	#40
	address <= 65539;
	data_in <= 32'b10001111010101000000000000000000; //4
	
	#40
	address <= 65540;
	data_in <= 32'b00000010100111010100001011000000; //5
	
	#40
	address <= 65541;
	data_in <= 32'b10001111010101000000000000000100; //6
	
	#40
	address <= 65542;
	data_in <= 32'b01010110100111010100001011000000; //7
	
	#40
	address <= 65543;
	data_in <= 32'b00000010100100010100001011000000; //8
	
	#40
	address <= 65544;
	data_in <= 32'b10001111010110000000000000001101; //9
	
	#40
	address <= 65545;
	data_in <= 32'b10001101010110000000000000000000; //10
	
	#40
	address <= 65546;
	data_in <= 32'b10001111010101000000000000010011; //11
	
	#40
	address <= 65547;
	data_in <= 32'b10001101010101000000000000000000; //12
	
	#40
	address <= 65548;
	data_in <= 32'b00011111010000000100001011000000; //13
	
	#40
	address <= 65549;
	data_in <= 32'b10001111010101000000000000000100; //14
	
	#40
	address <= 65550;
	data_in <= 32'b01000010100011010111101010011000; //15
	
	#40
	address <= 65551;
	data_in <= 32'b10001111010101000000000000000111; //16
	
	#40
	address <= 65552;
	data_in <= 32'b10001101010101000000000000000000; //17
	
	#40
	address <= 65553;
	data_in <= 32'b00010101010000000100001011000000; //18
	
	#40
	address <= 65554;
	data_in <= 32'b00100011010001000100001011000000; //19
	
	#40
	address <= 65555;
	data_in <= 32'b00001010100000100101001010000010; //20
	
	#40
	address <= 65556;
	data_in <= 32'b01010010100000100000011010000001; //21
	
	#40
	address <= 65557;
	data_in <= 32'b00011111100000000100001011000000; //22

	
	
	// RAM[0] = veector_size = 4
	#40
	address <= 0;
	data_in <= 12;
	
	
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
	// RAN[9]=10
	address <= 10;
	data_in <= 11;
	
	#40
	// RAN[9]=10
	address <= 11;
	data_in <= 12;
	
	#40
	// RAN[9]=10
	address <= 12;
	data_in <= 13;
	
	#40
	// RAN[9]=10
	address <= 13;
	data_in <= 14;
	
	#40
	address <= 14;
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

	#40
	address <= 11;
	
	#40
	address <= 12;
	
	#40
	address <= 13;
	
	#40
	address <= 14;
	
	#200
   $stop;

end

always #5 clk = ~clk;
always #1 clk_rom = ~clk_rom;

endmodule 