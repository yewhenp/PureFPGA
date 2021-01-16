`timescale 1 ns/10 ps 
module MM_and_SM_tb;
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
	reg clk = 0;
	reg [14:0]instruction = 15'b1_0000_1011_00_00_00;
	
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

SM SM_inst
(
	.data(core_data) ,	// inout [DATA_WIDTH-1:0] data_sig
	.address(core_address) ,	// input [ADDRESS_WIDTH-1:0] address_sig
	.instruction(instruction) ,	// input [INSTRUCTION_WIDTH-1:0] instruction_sig	// input [BUFFER_ADDRESS_WIDTH-1:0] bufferAddress_sig
	.wren(wren_out) ,	// input  wren_sig
	.coreEnable(core_en) ,	// input [CORE_NUM-1:0] coreEnable_sig
	.clk(clk)	// input  clk_sig
);

//	 OnePortRAM ram(
//	  .address((address >> 1)),
//	  .clock(clk),
//	  .data(core_data_rx),
//	  .wren(wren_in),
//	  .q(core_data_tx));
	initial
	 
    begin 		
		// TEST: DATA WRITING & READING
		
		wren_in = 1; // enable writing
		for(i = 0; i<128; i = i + 1) begin
			// [8-bit on odd][8-bit on even] = [16-bit memory cell]
			address = i;
			data_tx = (i & 1) ? 0 : i;
			#20;
			
		end
//		#5;
		// mov 2 to low reg 1
//		15'b001010000000000
//		15'b000001010010000
//		15'b000101010100100
//		15'b100001010011001
//		15'b000011010010000
//		15'b100001011000000
		// movl reg0 0
		wren_in = 0;
		instruction = 15'b0_01010_000000000;
		#20;

		// load reg1 reg0
		instruction = 15'b0_00001_010010000;
		#20;

		// mov reg2 reg1
		instruction = 15'b0_00101_010_10_01_00;
		#20;

		// add reg1 reg2 reg1
		instruction = 15'b1_0000_1010_11_10_01;
		#20;

		// store reg1 reg0
		instruction = 15'b0_00011_010_11_00_00;
		#20;

		// nop
		instruction = 15'b1_0000_1011_00_00_00;
		address = 0;
		#45;
		
		address = 0; // set read pointer at the beginning
//		wren_in = 0; // enable reading
		for(i = 0; i<128; i = i + 2) begin
			address = i; // on even read LS byte, on odd read MS byte
			#20;	
		end
		#40;
		$stop;

		
    end
	always #5 clk = ~clk;
endmodule 