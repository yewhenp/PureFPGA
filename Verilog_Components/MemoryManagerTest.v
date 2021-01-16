`timescale 1 ns/10 ps 
module MemoryManagerTest;
   localparam DATA_WIDTH	=8;
	localparam ADDRESS_WIDTH=23;
	localparam CORE_WIDTH	=16;
	localparam NUM_REGS		=8;
	localparam NUM_CORES		=64;
	reg wren_in, clk, ram_clk;
	 
	wire	[NUM_REGS-1:0] reg_en;
	wire	[NUM_CORES-1:0] core_en;
	
	wire	wren_out;
	reg	[ADDRESS_WIDTH-1:0] address;
	wire	[CORE_WIDTH-1:0] core_address;
	

	wire	[CORE_WIDTH-1:0] core_data;
	wire 	[CORE_WIDTH-1:0] core_data_tx;
	wire	[CORE_WIDTH-1:0] core_data_rx;
	
	wire	[DATA_WIDTH-1:0] data;
	reg 	[DATA_WIDTH-1:0] data_tx;
	wire	[DATA_WIDTH-1:0] data_rx;
	
	assign data = wren_in ? data_tx : 8'bZ;
	assign data_rx = data;
	
	assign core_data = ~wren_in ? core_data_tx : 16'bZ;
	assign core_data_rx = core_data;
	
	integer i = 0;
	memory_manager memory_manager_inst
(
	.data(data) ,	// inout [DATA_WIDTH-1:0] data_sig
	.address(address) ,	// input [ADDR_SPACE-1:0] address_sig
	.wren_in(wren_in) ,	// input  wren_in_sig
	.clk(clk) ,	// input  clk_sig
	.core_data(core_data) ,	// inout [CORE_WIDTH-1:0] core_data_sig
	.core_address(core_address) ,	// output [CORE_WIDTH-1:0] core_address_sig
	.wren_out(wren_out) ,	// output  wren_out_sig
	.reg_en(reg_en) ,	// output [NUM_REGS-1:0] reg_en_sig
	.core_en(core_en) 	// output [NUM_CORES-1:0] core_en_sig
);

	 OnePortRAM raam(
	  .address((address >> 1)),
	  .clock(clk),
	  .data(core_data_rx),
	  .wren(wren_in),
	  .q(core_data_tx));
	initial
	 
    begin 
		clk = 0;	
		
		
		// writing loop
		wren_in = 1;
		for(i = 0; i<20; i = i + 1) begin
			address = i;
			data_tx = i;
			#20;
			
		end
		#5;
		// reading loop
		address = 0;
		wren_in = 0;
		for(i = 0; i<20; i = i + 1) begin
			address = i;
			#20;	
		end
		#40;
		$stop;

		
    end
	always #5 clk = ~clk;
endmodule 