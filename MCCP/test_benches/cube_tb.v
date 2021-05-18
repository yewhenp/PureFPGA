`timescale 1 ns/10 ps
module cube_tb();

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


videocard_top videocard_top_inst
(
	.clk(clk) ,	// input  clk_sig
	.clk_rom(clk_rom) ,	// input  clk_hps_sig
    .clk_hps(clk_rom),
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

    #40
    address <= 65536;
    data_in <= 32'b00100001010011000110001010100100;

    #40
    address <= 65537;
    data_in <= 32'b10001111010100000000000000000000;

    #40
    address <= 65538;
    data_in <= 32'b01110010100111000100001011000000;

    #40
    address <= 65539;
    data_in <= 32'b10001110000101001111000001011111;

    #40
    address <= 65540;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65541;
    data_in <= 32'b00100100000101000000100000110101;

    #40
    address <= 65542;
    data_in <= 32'b10001110000101001111010001000111;

    #40
    address <= 65543;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65544;
    data_in <= 32'b00100110000101000010000101001100;

    #40
    address <= 65545;
    data_in <= 32'b01100010101001000100001011000000;

    #40
    address <= 65546;
    data_in <= 32'b10001111010100000000000000000001;

    #40
    address <= 65547;
    data_in <= 32'b01110010100111000100001011000000;

    #40
    address <= 65548;
    data_in <= 32'b10001110000101001111010001000111;

    #40
    address <= 65549;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65550;
    data_in <= 32'b00100100000101000000100000110101;

    #40
    address <= 65551;
    data_in <= 32'b10001110000101001111100000101111;

    #40
    address <= 65552;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65553;
    data_in <= 32'b00100110000101000010000101001100;

    #40
    address <= 65554;
    data_in <= 32'b01100010101001000100001011000000;

    #40
    address <= 65555;
    data_in <= 32'b10001111010100000000000000000010;

    #40
    address <= 65556;
    data_in <= 32'b01110010100111000100001011000000;

    #40
    address <= 65557;
    data_in <= 32'b10001110000101001111100000101111;

    #40
    address <= 65558;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65559;
    data_in <= 32'b00100100000101000000100000110101;

    #40
    address <= 65560;
    data_in <= 32'b10001110000101001111110000010111;

    #40
    address <= 65561;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65562;
    data_in <= 32'b00100110000101000010000101001100;

    #40
    address <= 65563;
    data_in <= 32'b01100010101001000100001011000000;

    #40
    address <= 65564;
    data_in <= 32'b10001111010100000000000000000011;

    #40
    address <= 65565;
    data_in <= 32'b01110010100111000100001011000000;

    #40
    address <= 65566;
    data_in <= 32'b10001110000101001111110000010111;

    #40
    address <= 65567;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65568;
    data_in <= 32'b00100100000101000000100000110101;

    #40
    address <= 65569;
    data_in <= 32'b10001110000101001111111111111111;

    #40
    address <= 65570;
    data_in <= 32'b10001100000101000000000000000000;

    #40
    address <= 65571;
    data_in <= 32'b00100110000101000100001011000000;

    #40
    address <= 65572;
    data_in <= 32'b10001111010101001111000001011111;

    #40
    address <= 65573;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65574;
    data_in <= 32'b00101001010101000100001011000000;

    #40
    address <= 65575;
    data_in <= 32'b10001111010101000000000000000001;

    #40
    address <= 65576;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65577;
    data_in <= 32'b00000010100011010010000101010100;

    #40
    address <= 65578;
    data_in <= 32'b01000010100011010100001011000000;

    #40
    address <= 65579;
    data_in <= 32'b10001111010101000000000000000000;

    #40
    address <= 65580;
    data_in <= 32'b00000010100111010100001011000000;

    #40
    address <= 65581;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65582;
    data_in <= 32'b01010110100111010100001011000000;

    #40
    address <= 65583;
    data_in <= 32'b00000010100100010100001011000000;

    #40
    address <= 65584;
    data_in <= 32'b10001111010110000000000000110101;

    #40
    address <= 65585;
    data_in <= 32'b10001101010110000000000000000000;

    #40
    address <= 65586;
    data_in <= 32'b10001111010101000000000000111010;

    #40
    address <= 65587;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65588;
    data_in <= 32'b01000010110000000001111101000000;

    #40
    address <= 65589;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65590;
    data_in <= 32'b01000010100011010111101010011000;

    #40
    address <= 65591;
    data_in <= 32'b10001111010101000000000000101110;

    #40
    address <= 65592;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65593;
    data_in <= 32'b01000010110000000001010101000000;

    #40
    address <= 65594;
    data_in <= 32'b00100011010001000100001011000000;

    #40
    address <= 65595;
    data_in <= 32'b00001010100000100101001010000010;

    #40
    address <= 65596;
    data_in <= 32'b01010010100000100000011010000001;

    #40
    address <= 65597;
    data_in <= 32'b01000010110000000001111110000000;

    #40
    address <= 0;
    data_in <= 4;

    #40
    address <= 1;
    data_in <= 2;

    #40
    address <= 2;
    data_in <= 3;

    #40
    address <= 3;
    data_in <= 4;

    #40
    address <= 4;
    data_in <= 5;

    #40
    address <= 5;
    data_in <= 6;

    #40
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