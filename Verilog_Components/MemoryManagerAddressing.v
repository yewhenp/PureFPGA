`timescale 1 ns/10 ps 
module MemoryManagerAddressing;
   localparam DATA_WIDTH	=8;
	localparam ADDRESS_WIDTH=23;
	localparam CORE_WIDTH	=16;
	localparam NUM_REGS		=8;
	localparam NUM_CORES		=64;
	reg wren_in;
	 
	wire	[NUM_REGS-1:0] reg_en;
	wire	[NUM_CORES-1:0] core_en;
	
	wire	wren_out;
	reg	[ADDRESS_WIDTH-1:0] address;
	wire	[CORE_WIDTH-1:0] core_address;
	

	wire	[CORE_WIDTH-1:0] core_data;
//	wire 	[CORE_WIDTH-1:0] core_data_tx;
//	wire	[CORE_WIDTH-1:0] core_data_rx;
//	
	wire	[DATA_WIDTH-1:0] data;
//	reg 	[DATA_WIDTH-1:0] data_tx;
//	wire	[DATA_WIDTH-1:0] data_rx;
//	
//	assign data = wren_in ? data_tx : 8'bZ;
//	assign data_rx = data;
//	
//	assign core_data = ~wren_in ? core_data_tx : 16'bZ;
//	assign core_data_rx = core_data;
	
	integer i = 0;
	reg clk = 1;
	
	memory_manager mm
(
	.data(data) ,	// inout [DATA_WIDTH-1:0] data
	.address(address) ,	// input [ADDR_SPACE-1:0] address
	.wren_in(wren_in) ,	// input  wren_in
	.clk(clk) ,	// input  clk
	.core_data(core_data) ,	// inout [CORE_WIDTH-1:0] core_data
	.core_address(core_address) ,	// output [CORE_WIDTH-1:0] core_address
	.wren_out(wren_out) ,	// output  wren_out
	.reg_en(reg_en) ,	// output [NUM_REGS-1:0] reg_en
	.core_en(core_en) 	// output [NUM_CORES-1:0] core_en
);

//	 OnePortRAM ram(
//	  .address((address >> 1)),
//	  .clock(clk),
//	  .data(core_data_rx),
//	  .wren(wren_in),
//	  .q(core_data_tx));
	initial
	 
    begin 		
		// TEST: ADDRESSING
		wren_in = 1; // enable writing
		for(i = 0; i<256; i = i + 2) begin
			// [8-bit on odd][8-bit on even] = [16-bit memory cell]
			address = i;
		
			#10;
			
		end
		
		address = 23'b11111111111111111110000; // reg0
		#10;
		
		address = 23'b11111111111111111110010; // reg1
		#10;
		
		address = 23'b11111111111111111110100; // reg2
		#10;
		
		address = 23'b11111111111111111110110; // reg3
		#10;
		
		address = 23'b11111111111111111111000; // reg4
		#10;
		
		address = 23'b11111111111111111111010; // reg5
		#10;
		
		address = 23'b11111111111111111111100; // sp
		#10;
		
		address = 23'b11111111111111111111110; // ip
		#10;
		
		
		#40;
		$stop;

		
    end
	always #5 clk = ~clk;
endmodule 