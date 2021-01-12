`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module Videocard_test;
   localparam DATA_WIDTH	=8;
	localparam ADDRESS_WIDTH=23;
	localparam CORE_WIDTH	=16;
	reg wren_sig, clock_reference_sig, clock_reset_sig, vga_reset_sig;
	wire hsync_sig, vsync_sig, p_tick_sig; 
	wire	[4:0]	blue_sig;
	wire	[4:0]	green_sig;
	wire	[5:0]	red_sig;
	reg	[ADDRESS_WIDTH - 1:0] adress_sig;
	reg	[DATA_WIDTH - 1:0] input_value;
	wire	[DATA_WIDTH - 1:0] bidir_signal;
	wire	[DATA_WIDTH - 1:0] output_value;
	
	assign bidir_signal = wren_sig ? input_value : 8'bZ;
	assign output_value = bidir_signal;
	
//	assign bidir_signal = wren_sig ? input_value : 8'bZ;
//	assign output_value = ~wren_sig ? bidir_signal : 8'bZ;
	integer i = 0;
	 
	 Components videocard
(
	.wren(wren_sig) ,	// input  wren_sig
	.clock_reference(clock_reference_sig) ,	// input  clock_reference_sig
	.clock_reset(clock_reset_sig) ,	// input  clock_reset_sig
	.vga_reset(vga_reset_sig) ,	// input  vga_reset_sig
	.adress(adress_sig) ,	// input [22:0] adress_sig
	.hsync(hsync_sig) ,	// output  hsync_sig
	.vsync(vsync_sig) ,	// output  vsync_sig
	.p_tick(p_tick_sig) ,	// output  p_tick_sig
	.blue(blue_sig) ,	// output [4:0] blue_sig
	.data(bidir_signal) ,	// inout [7:0] data_sig
	.green(green_sig) ,	// output [4:0] green_sig
	.red(red_sig) 	// output [5:0] red_sig
);

    initial
	 
    begin 
		clock_reference_sig = 0;
		wren_sig = 1;
		for(i = 0; i<20; i = i + 1) begin
			adress_sig = i;
			input_value = (i & 1) ? 0: i;
			#10;
		end
		#10;
		adress_sig = ((1 << ADDRESS_WIDTH - 1) - 1) << 1;
		
		input_value = 4;
		#200;
		wren_sig = 0;
		
		
		for(i = 0; i<20; i = i + 1) begin
			adress_sig = i;
			if (~(i & 1))
				$display ("Current value: %d\n", output_value);
			#10;
		end
		
    end
	 always #5 clock_reference_sig = ~clock_reference_sig;
endmodule

//module adapter (
//	input  data_tri,
//	input  [CORE_WIDTH - 1:0]data_in,
//	input  address,
//	output reg [CORE_WIDTH - 1:0]data_out,
//	inout  [DATA_WIDTH - 1:0]data_io
//	);
//
//  
//	reg 	[DATA_WIDTH - 1:0] data_tx;
//	wire	[DATA_WIDTH - 1:0] data_rx;
//
////	reg 	[CORE_WIDTH - 1:0] core_data_tx;
////	wire   [CORE_WIDTH - 1:0] core_data_rx;
//  
//	assign data_io = data_tri ? data_tx : 8'bZ;
//	assign data_rx = data_io;
//
////	assign core_data = data_tri ? core_data_tx : 16'bZ;
////	assign core_data_rx = core_data;
//	
//	
//
//	always @ begin
//			if (address) begin
//				data_out[CORE_WIDTH - 1: DATA_WIDTH] = data_rx;
//				data_tx = data_in[CORE_WIDTH - 1: DATA_WIDTH];
//			end
//			else begin
//				data_out[DATA_WIDTH - 1: 0] = data_rx;
//				data_tx = data_in[DATA_WIDTH - 1: 0];
//			end
//		end
//
//endmodule

