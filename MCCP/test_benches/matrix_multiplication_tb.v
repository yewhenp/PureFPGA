`timescale 1 ns/10 ps
module matrix_multiplication_tb();

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
	address <= 0;
    data_in <= 5;
  
    #40
    address <= 1;
    data_in <= 21;

    #40
    address <= 2;
    data_in <= 2;

    #40
    address <= 3;
    data_in <= 37;

    #40
    address <= 4;
    data_in <= 5;

    #40
	address <= 5;
	data_in <= 1;

	#40
	address <= 6;
	data_in <= 2;

	#40
	address <= 7;
	data_in <= 3;

	#40
	address <= 8;
	data_in <= 4;

	#40
	address <= 9;
	data_in <= 5;

	#40
	address <= 10;
	data_in <= 6;

	#40
	address <= 11;
	data_in <= 7;

	#40
	address <= 12;
	data_in <= 8;

	#40
	address <= 13;
	data_in <= 9;

	#40
	address <= 14;
	data_in <= 10;

	#40
	address <= 15;
	data_in <= 11;

	#40
	address <= 16;
	data_in <= 12;

	#40
	address <= 17;
	data_in <= 13;

	#40
	address <= 18;
	data_in <= 14;

	#40
	address <= 19;
	data_in <= 15;

	#40
	address <= 20;
	data_in <= 16;

	#40
	address <= 21;
	data_in <= 1;

	#40
	address <= 22;
	data_in <= 9;

	#40
	address <= 23;
	data_in <= 2;

	#40
	address <= 24;
	data_in <= 10;

	#40
	address <= 25;
	data_in <= 3;

	#40
	address <= 26;
	data_in <= 11;

	#40
	address <= 27;
	data_in <= 4;

	#40
	address <= 28;
	data_in <= 12;

	#40
	address <= 29;
	data_in <= 5;

	#40
	address <= 30;
	data_in <= 13;

	#40
	address <= 31;
	data_in <= 6;

	#40
	address <= 32;
	data_in <= 14;

	#40
	address <= 33;
	data_in <= 7;

	#40
	address <= 34;
	data_in <= 15;

	#40
	address <= 35;
	data_in <= 8;

	#40
	address <= 36;
	data_in <= 16;

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
    data_in <= 32'b10001111010000000000000000000100;

    #40
    address <= 65576;
    data_in <= 32'b10001101010000000000000000000000;

    #40
    address <= 65577;
    data_in <= 32'b00000010100010000000011010001110;

    #40
    address <= 65578;
    data_in <= 32'b01110110101100000111101010000000;

    #40
    address <= 65579;
    data_in <= 32'b00000010100010000000011010001110;

    #40
    address <= 65580;
    data_in <= 32'b01110110101100000111101010000000;

    #40
    address <= 65581;
    data_in <= 32'b00000010100010000000011010001110;

    #40
    address <= 65582;
    data_in <= 32'b01110110101100000111101010000000;

    #40
    address <= 65583;
    data_in <= 32'b00000010100010000000011010001110;

    #40
    address <= 65584;
    data_in <= 32'b01110110101100000111101010000000;

    #40
    address <= 65585;
    data_in <= 32'b00000010100010000000011010001110;

    #40
    address <= 65586;
    data_in <= 32'b01110110101100000100001011000000;

    #40
    address <= 65587;
    data_in <= 32'b10001111010101000000000000111001;

    #40
    address <= 65588;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65589;
    data_in <= 32'b00000110101011100111011010110000;

    #40
    address <= 65590;
    data_in <= 32'b10001111010101000000000000111010;

    #40
    address <= 65591;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65592;
    data_in <= 32'b00011111010000000100001011000000;

    #40
    address <= 65593;
    data_in <= 32'b00100011010001000100001011000000;

    #40
    address <= 65594;
    data_in <= 32'b00000110101001100111011010110000;

    #40
    address <= 65595;
    data_in <= 32'b00001010101001100100001011000000;

    #40
    address <= 65596;
    data_in <= 32'b10001111010101000000000000000101;

    #40
    address <= 65597;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65598;
    data_in <= 32'b01000010101101010100001011000000;

    #40
    address <= 65599;
    data_in <= 32'b10001111010101000000000000000101;

    #40
    address <= 65600;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65601;
    data_in <= 32'b00001010100001000100101010000101;

    #40
    address <= 65602;
    data_in <= 32'b00000010100000000100001011000000;

    #40
    address <= 65603;
    data_in <= 32'b10001111010101000000000000000111;

    #40
    address <= 65604;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65605;
    data_in <= 32'b00001010100011000100101010001101;

    #40
    address <= 65606;
    data_in <= 32'b00000010100010010100001011000000;

    #40
    address <= 65607;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65608;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65609;
    data_in <= 32'b00001010100101000100101010010101;

    #40
    address <= 65610;
    data_in <= 32'b00000010100100100000011010000110;

    #40
    address <= 65611;
    data_in <= 32'b01110110101100000100001011000000;

    #40
    address <= 65612;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65613;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65614;
    data_in <= 32'b01000010101011000000011010001101;

    #40
    address <= 65615;
    data_in <= 32'b00100001010101000100101010001101;

    #40
    address <= 65616;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65617;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65618;
    data_in <= 32'b01001010100011010100001011000000;

    #40
    address <= 65619;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65620;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65621;
    data_in <= 32'b01000010101011000000011010001101;

    #40
    address <= 65622;
    data_in <= 32'b10001111010011000000000000000100;

    #40
    address <= 65623;
    data_in <= 32'b10001101010011000000000000000000;

    #40
    address <= 65624;
    data_in <= 32'b01010010100110000100001011000000;

    #40
    address <= 65625;
    data_in <= 32'b10001111010101000000000000000000;

    #40
    address <= 65626;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65627;
    data_in <= 32'b01000010101011000000011010011101;

    #40
    address <= 65628;
    data_in <= 32'b10001111010101000000000000000111;

    #40
    address <= 65629;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65630;
    data_in <= 32'b00001010100011000100101010001101;

    #40
    address <= 65631;
    data_in <= 32'b00000010100010010100001011000000;

    #40
    address <= 65632;
    data_in <= 32'b10001111010011000000000000000100;

    #40
    address <= 65633;
    data_in <= 32'b10001101010011000000000000000000;

    #40
    address <= 65634;
    data_in <= 32'b01111010100110000101001010011001;

    #40
    address <= 65635;
    data_in <= 32'b10001111010101000000000000000001;

    #40
    address <= 65636;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65637;
    data_in <= 32'b01000010101011000000011010011101;

    #40
    address <= 65638;
    data_in <= 32'b10001111010101000000000000000110;

    #40
    address <= 65639;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65640;
    data_in <= 32'b00001010100011000100101010001101;

    #40
    address <= 65641;
    data_in <= 32'b00000010100010010010000101010100;

    #40
    address <= 65642;
    data_in <= 32'b01010010100001010100001010010000;

    #40
    address <= 65643;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65644;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65645;
    data_in <= 32'b00001010100111000100001010011101;

    #40
    address <= 65646;
    data_in <= 32'b00000010100110110010000101010100;

    #40
    address <= 65647;
    data_in <= 32'b01010010101010110100001010001101;

    #40
    address <= 65648;
    data_in <= 32'b10001111010101000000000000000010;

    #40
    address <= 65649;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65650;
    data_in <= 32'b01000010101011000000011010001101;

    #40
    address <= 65651;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65652;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65653;
    data_in <= 32'b00001010100001000100101010000101;

    #40
    address <= 65654;
    data_in <= 32'b00000010100000000000011010000110;

    #40
    address <= 65655;
    data_in <= 32'b01110110101100000000011010010110;

    #40
    address <= 65656;
    data_in <= 32'b01110110101100000100001011000000;

    #40
    address <= 65657;
    data_in <= 32'b10001111010101000000000001111111;

    #40
    address <= 65658;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65659;
    data_in <= 32'b00000110101011100111011010110000;

    #40
    address <= 65660;
    data_in <= 32'b10001111010101000000000011011001;

    #40
    address <= 65661;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65662;
    data_in <= 32'b00011111010000000100001011000000;

    #40
    address <= 65663;
    data_in <= 32'b10001111010101000000000000000010;

    #40
    address <= 65664;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65665;
    data_in <= 32'b00001010100101000100001010010101;

    #40
    address <= 65666;
    data_in <= 32'b00000010100100100000011010000010;

    #40
    address <= 65667;
    data_in <= 32'b01110110100100000100001011000000;

    #40
    address <= 65668;
    data_in <= 32'b10001111010101000000000000000010;

    #40
    address <= 65669;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65670;
    data_in <= 32'b01000010101011000000011010010101;

    #40
    address <= 65671;
    data_in <= 32'b10001111010101000000000000000101;

    #40
    address <= 65672;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65673;
    data_in <= 32'b00001010100011000100101010001101;

    #40
    address <= 65674;
    data_in <= 32'b00000010100010010100001011000000;

    #40
    address <= 65675;
    data_in <= 32'b10001111010101000000000000000110;

    #40
    address <= 65676;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65677;
    data_in <= 32'b00001010100101000100001010010101;

    #40
    address <= 65678;
    data_in <= 32'b00000010100100100100001010010001;

    #40
    address <= 65679;
    data_in <= 32'b10001111010101000000000000000110;

    #40
    address <= 65680;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65681;
    data_in <= 32'b01000010101011000000011010010101;

    #40
    address <= 65682;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65683;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65684;
    data_in <= 32'b00001010100001000100001010000101;

    #40
    address <= 65685;
    data_in <= 32'b00000010100000000111101010000000;

    #40
    address <= 65686;
    data_in <= 32'b10001111010101000000000010011111;

    #40
    address <= 65687;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65688;
    data_in <= 32'b00010011010000000100001011000000;

    #40
    address <= 65689;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65690;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65691;
    data_in <= 32'b01000010101011000000011010000101;

    #40
    address <= 65692;
    data_in <= 32'b10001111010101000000000001111001;

    #40
    address <= 65693;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65694;
    data_in <= 32'b00011111010000000100001011000000;

    #40
    address <= 65695;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65696;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65697;
    data_in <= 32'b00001010100001000100001010000101;

    #40
    address <= 65698;
    data_in <= 32'b00000010100000000110001010001001;

    #40
    address <= 65699;
    data_in <= 32'b01110010100000010100001011000000;

    #40
    address <= 65700;
    data_in <= 32'b10001111010101000000000011010100;

    #40
    address <= 65701;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65702;
    data_in <= 32'b00011101010000000100001011000000;

    #40
    address <= 65703;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65704;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65705;
    data_in <= 32'b01001010100001010100001011000000;

    #40
    address <= 65706;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65707;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65708;
    data_in <= 32'b01000010101011000000011010000101;

    #40
    address <= 65709;
    data_in <= 32'b10001111010101000000000000000111;

    #40
    address <= 65710;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65711;
    data_in <= 32'b00001010100011000100001010001101;

    #40
    address <= 65712;
    data_in <= 32'b00000010100010010100001011000000;

    #40
    address <= 65713;
    data_in <= 32'b10001111010101000000000000000000;

    #40
    address <= 65714;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65715;
    data_in <= 32'b00001010100101000100001010010101;

    #40
    address <= 65716;
    data_in <= 32'b00000010100100100100001010001010;

    #40
    address <= 65717;
    data_in <= 32'b10001111010101000000000000000111;

    #40
    address <= 65718;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65719;
    data_in <= 32'b01000010101011000000011010001101;

    #40
    address <= 65720;
    data_in <= 32'b10001111010101000000000000000010;

    #40
    address <= 65721;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65722;
    data_in <= 32'b00001010100011000100001010001101;

    #40
    address <= 65723;
    data_in <= 32'b00000010100010010100001011000000;

    #40
    address <= 65724;
    data_in <= 32'b10001111010101000000000000000001;

    #40
    address <= 65725;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65726;
    data_in <= 32'b00001010100101000100001010010101;

    #40
    address <= 65727;
    data_in <= 32'b00000010100100100100001010001010;

    #40
    address <= 65728;
    data_in <= 32'b10001111010101000000000000000010;

    #40
    address <= 65729;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65730;
    data_in <= 32'b01000010101011000000011010001101;

    #40
    address <= 65731;
    data_in <= 32'b10001111010101000000000000000111;

    #40
    address <= 65732;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65733;
    data_in <= 32'b00001010100101000100101010010101;

    #40
    address <= 65734;
    data_in <= 32'b00000010100100100100001011000000;

    #40
    address <= 65735;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65736;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65737;
    data_in <= 32'b01000010101011000000011010010101;

    #40
    address <= 65738;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65739;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65740;
    data_in <= 32'b00001010100111000100101010011101;

    #40
    address <= 65741;
    data_in <= 32'b00000010100110110100001011000000;

    #40
    address <= 65742;
    data_in <= 32'b10001111010101000000000000000110;

    #40
    address <= 65743;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65744;
    data_in <= 32'b01000010101011000000011010011101;

    #40
    address <= 65745;
    data_in <= 32'b10001111010101000000000001111001;

    #40
    address <= 65746;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65747;
    data_in <= 32'b00011111010000000100001011000000;

    #40
    address <= 65748;
    data_in <= 32'b10001111010101000000000000001000;

    #40
    address <= 65749;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65750;
    data_in <= 32'b01001010101101010111101010110000;

    #40
    address <= 65751;
    data_in <= 32'b00000010101001100111101010110000;

    #40
    address <= 65752;
    data_in <= 32'b00000010101011100001111101000000;

    #40
    address <= 65753;
    data_in <= 32'b00000110101001100111011010110000;

    #40
    address <= 65754;
    data_in <= 32'b00001010101001100100001011000000;

    #40
    address <= 65755;
    data_in <= 32'b10001111010101000000000000000011;

    #40
    address <= 65756;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65757;
    data_in <= 32'b00001010100001000100101010000101;

    #40
    address <= 65758;
    data_in <= 32'b00000010100000000100001011000000;

    #40
    address <= 65759;
    data_in <= 32'b10001111010101000000000000000100;

    #40
    address <= 65760;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65761;
    data_in <= 32'b00001010100011000100101010001101;

    #40
    address <= 65762;
    data_in <= 32'b00000010100010010100001011000000;

    #40
    address <= 65763;
    data_in <= 32'b10001111010101000000000000000101;

    #40
    address <= 65764;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65765;
    data_in <= 32'b00001010100101000100101010010101;

    #40
    address <= 65766;
    data_in <= 32'b00000010100100100100001011000000;

    #40
    address <= 65767;
    data_in <= 32'b10001111010100000000000000000000;

    #40
    address <= 65768;
    data_in <= 32'b10001101010100000000000000000000;

    #40
    address <= 65769;
    data_in <= 32'b00000010100110000000001010101001;

    #40
    address <= 65770;
    data_in <= 32'b01010010100111010100001010100011;

    #40
    address <= 65771;
    data_in <= 32'b01110110100000000111011010001000;

    #40
    address <= 65772;
    data_in <= 32'b01111010100100000100001011000000;

    #40
    address <= 65773;
    data_in <= 32'b10001111010101000000000011101001;

    #40
    address <= 65774;
    data_in <= 32'b10001101010101000000000000000000;

    #40
    address <= 65775;
    data_in <= 32'b00010101010000000000101010000100;

    #40
    address <= 65776;
    data_in <= 32'b01111010101100000000001010100110;

    #40
    address <= 65777;
    data_in <= 32'b01111010101100000000001010101110;

    #40
    address <= 65778;
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
    #150000
	#40
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
	#40
	address <= 15;
	#40
	address <= 16;
	#40
	address <= 17;
	#40
	address <= 18;
	#40
	address <= 19;
	#40
	address <= 20;
	#40
	address <= 21;
	#40
	address <= 22;
	#40
	address <= 23;
	#40
	address <= 24;
	#40
	address <= 25;
	#40
	address <= 26;
	#40
	address <= 27;
	#40
	address <= 28;
	#40
	address <= 29;
	#40
	address <= 30;
	#40
	address <= 31;
	#40
	address <= 32;
	#40
	address <= 33;
	#40
	address <= 34;
	#40
	address <= 35;
	#40
	address <= 36;
	#40
	address <= 37;
	#40
	address <= 38;
	#40
	address <= 39;
	#40
	address <= 40;
	#40
	address <= 41;
	#40
	address <= 42;
	#40
	address <= 43;
	#40
	address <= 44;
	#40
	address <= 45;
	#40
	address <= 46;
	#40
	address <= 47;
	#40
	address <= 48;
	#40
	address <= 49;
	#40
	address <= 50;
	#40
	address <= 51;
	#40
	address <= 52;
	#40
	address <= 53;
	#40
	address <= 54;
	#40
	address <= 55;
	#40
	address <= 56;
	#40
	address <= 57;
	#40
	address <= 58;
	#40
	address <= 59;
	#40
	address <= 60;
	#40
	address <= 61;
	#40
	address <= 62;
	#40
	address <= 63;
	#40
	address <= 64;
	#40
	address <= 65;
	#40
	address <= 66;
	#40
	address <= 67;
	#40
	address <= 68;
	#40
	address <= 69;
	#40
	address <= 70;
	#40
	address <= 71;
	#40
	address <= 72;
	#40
	address <= 73;
	#40
	address <= 74;
	#40
	address <= 75;
	#40
	address <= 76;
	#40
	address <= 77;
	#40
	address <= 78;
	#40
	address <= 79;
	#40
	address <= 80;
	#40
	address <= 81;
	#40
	address <= 82;
	#40
	address <= 83;
	#40
	address <= 84;
	#40
	address <= 85;
	#40
	address <= 86;
	#40
	address <= 87;
	#40
	address <= 88;
	#40
	address <= 89;
	#40
	address <= 90;
	#40
	address <= 91;
	#40
	address <= 92;
	#40
	address <= 93;
	#40
	address <= 94;
	#40
	address <= 95;
	#40
	address <= 96;
	#40
	address <= 97;
	#40
	address <= 98;
	#40
	address <= 99;
	#40
	address <= 100;
	#40
	address <= 101;
	
	#200
   $stop;

end

always #5 clk = ~clk;
always #1 clk_rom = ~clk_rom;

endmodule