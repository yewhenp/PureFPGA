module MemoryManagerTest;
   localparam DATA_WIDTH	=8;
	localparam ADDRESS_WIDTH=23;
	localparam CORE_WIDTH	=16;
	localparam NUM_REGS		=8;
	localparam NUM_CORES		=64;
	reg wren_in, clk;
	 
	wire	[NUM_REGS-1:0] reg_en;
	wire	[NUM_CORES-1:0] core_en;
	
	wire	wren_out;
	reg	[ADDRESS_WIDTH-1:0] address;
	wire	[CORE_WIDTH-1:0] core_address;
	
	wire	[CORE_WIDTH-1:0] core_data;
	reg 	[CORE_WIDTH-1:0] core_data_tx;
	wire	[CORE_WIDTH-1:0] core_data_rx;
	
	wire	[DATA_WIDTH-1:0] data;
	reg 	[DATA_WIDTH-1:0] data_tx;
	wire	[DATA_WIDTH-1:0] data_rx;
	
	assign data = wren_in ? data_tx : 8'bZ;
	assign data_rx = data;
	
	
//	assign core_data = ~wren_in ? core_data_tx : 16'bZ;
	assign core_data_rx = core_data;
	
//	assign bidir_signal = wren_sig ? input_value : 8'bZ;
//	assign output_value = ~wren_sig ? bidir_signal : 8'bZ;
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
	initial
	 
    begin 
		clk = 0;
		wren_in = 1;
		address = 0;
		data_tx = 5;
		
		#10;
		
		address = 1;
		data_tx = 0;
		#10;
		wren_in = 0;
		#20;
		
		
		
//		for(i = 0; i<20; i = i + 1) begin
//			wren_in = 1;
//			address = i;
//			data_tx = (i & 1) ? 0: i;
//			#10;
//			wren_in = (i & 1) ? 0: 1;
//			
//			#10;
//			
//		end
//		#10;

		
    end
	always #5 clk = ~clk;
endmodule 