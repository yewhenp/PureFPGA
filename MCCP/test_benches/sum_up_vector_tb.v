`timescale 1 ns/10 ps
module sum_up_vector_tb();

localparam WIDTH=32;


reg clk = 0;
reg clk_rom = 0;
reg [WIDTH/2: 0] address = 16'b0;
reg [WIDTH-1: 0] data_in = 16'b0;
wire [WIDTH-1: 0] data_out;
reg wren = 1'b0;

reg [2:0] address_control = 3'b000;
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
    // fill RAM
    #40
	address <= 0;
    data_in <= 2;
    
    #40
	address <= 1;
    data_in <= 12;
	
	#40
	address <= 2;
    data_in <= 3;
	
	#40
	address <= 3;
    data_in <= 1;

	#40
	address <= 4;
    data_in <= 2;
	#40
	address <= 5;
	data_in <= 3;
	#40
	address <= 6;
	data_in <= 4;
	#40
	address <= 7;
	data_in <= 5;
	#40
	address <= 8;
	data_in <= 6;
	#40
	address <= 9;
	data_in <= 7;
	#40
	address <= 10;
    data_in <= 8;
	#40
	address <= 11;
	data_in <= 9;
	#40
	address <= 12;
    data_in <= 10;
    #40
	address <= 13;
    data_in <= 11;
    #40
	address <= 14;
    data_in <= 12;
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
    data_in <= 32'b10001111010101000000000000000000;

    #40
    address <= 65576;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65577;
    data_in <= 32'b00000010100001010100001011000000;

    #40
    address <= 65578;
    data_in <= 32'b10001111010101000000000000000001;

    #40
    address <= 65579;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65580;
    data_in <= 32'b00000010100011010101011010001000;

    #40
    address <= 65581;
    data_in <= 32'b00100001010010000101001010010001;

    #40
    address <= 65582;
    data_in <= 32'b10001111010101000000000000000010;

    #40
    address <= 65583;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65584;
    data_in <= 32'b00000010101011010100001010010101;

    #40
    address <= 65585;
    data_in <= 32'b10001111010101000000000000110111;

    #40
    address <= 65586;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65587;
    data_in <= 32'b00000110101011100111011010110000;

    #40
    address <= 65588;
    data_in <= 32'b10001111010101000000000001001001;

    #40
    address <= 65589;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65590;
    data_in <= 32'b00011111010000000100001011000000;

    #40
    address <= 65591;
    data_in <= 32'b10001111010001000000000000000011;

    #40
    address <= 65592;
    data_in <= 32'b10001101010001000000000000000000;

    #40
    address <= 65593;
    data_in <= 32'b00100001010010000100001010001010;

    #40
    address <= 65594;
    data_in <= 32'b00000110100000010110001010100100;

    #40
    address <= 65595;
    data_in <= 32'b01110010101000100100001011000000;

    #40
    address <= 65596;
    data_in <= 32'b10001111010101000000000001001000;

    #40
    address <= 65597;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65598;
    data_in <= 32'b00010101010000000100001011000000;

    #40
    address <= 65599;
    data_in <= 32'b10001111010010000000000000000100;

    #40
    address <= 65600;
    data_in <= 32'b10001101010010000000000000000000;

    #40
    address <= 65601;
    data_in <= 32'b00000010100010100100001010000001;

    #40
    address <= 65602;
    data_in <= 32'b01110110100100000000001010001010;

    #40
    address <= 65603;
    data_in <= 32'b01000010100000010111011010010000;

    #40
    address <= 65604;
    data_in <= 32'b00000010100010100100001010000001;

    #40
    address <= 65605;
    data_in <= 32'b10001111010010000000000000000011;

    #40
    address <= 65606;
    data_in <= 32'b10001101010010000000000000000000;

    #40
    address <= 65607;
    data_in <= 32'b00000110100000100100001011000000;

    #40
    address <= 65608;
    data_in <= 32'b00100011010001000100001011000000;

    #40
    address <= 65609;
    data_in <= 32'b00001010101000100100001010100001;

    #40
    address <= 65610;
    data_in <= 32'b01100010100110110100001011000000;

    #40
    address <= 65611;
    data_in <= 32'b00000010101010100100001010011101;

    #40
    address <= 65612;
    data_in <= 32'b01110110100100000111001010010100;

    #40
    address <= 65613;
    data_in <= 32'b10001111010101000000000001001011;

    #40
    address <= 65614;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65615;
    data_in <= 32'b00010101010000000000101010000011;

    #40
    address <= 65616;
    data_in <= 32'b01111010101100000000001010101110;

    #40
    address <= 65617;
    data_in <= 32'b00011111010000000100001011000000;

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

// wait for the videocard to finish
    #15000
	address <= 0;
// read RAM
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

	#40
	address <= 15;
	
	#40
	address <= 16;
	
	#200
   $stop;

end

always #5 clk = ~clk;
always #1 clk_rom = ~clk_rom;

endmodule