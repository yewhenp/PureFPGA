module memory_manager
#(parameter CORE_WIDTH=16,
				DATA_WIDTH=8,
            ADDR_SPACE=23,
            NUM_CORES=64,
            NUM_REGS=8,
            REGS_CODIND=3,
            CORE_CODIND=6)
   (	
	inout [DATA_WIDTH - 1:0]data, 
	input [ADDR_SPACE - 1:0]address,
	input wren_in,
	input clk,
	inout [CORE_WIDTH - 1:0]core_data,
	output [CORE_WIDTH - 1:0]core_address,
	output wren_out,
   output reg [NUM_REGS - 1:0]reg_en,
	output reg [NUM_CORES - 1:0]core_en
	);
	
  wire [NUM_CORES - 1:0]cores;
  wire [NUM_REGS - 1:0]regs;
  
  
  reg 	[DATA_WIDTH - 1:0] data_tx;
  wire	[DATA_WIDTH - 1:0] data_rx;
  
  reg 	[CORE_WIDTH - 1:0] core_data_tx;
  wire   [CORE_WIDTH - 1:0] core_data_rx;
  
  assign data = ~wren_in ? data_tx : 8'bZ;
  assign data_rx = data;
  
  assign core_data = wren_in ? core_data_tx : 16'bZ;
  assign core_data_rx = core_data;
  
  assign core_address = address[ADDR_SPACE - 1:CORE_CODIND + 1];
  assign wren_out = wren_in;
  
  decoder64 d1(.data(address[CORE_CODIND:1]), .eq63(cores));
  decoder8 d2(.data(address[REGS_CODIND:1]), .eq7(regs));
  /// removed posedge
  always @(posedge clk) begin
		if(address[ADDR_SPACE - 1: 1] >= (1 << (ADDR_SPACE - 1) - NUM_REGS)) begin
		  core_en <= 0;
		  reg_en <= regs;
		end 
		else begin
		  reg_en <= 0;
		  core_en <= cores;
		end
	end
	/// removed posedge
	always @(posedge clk) begin
		if (address[0]) begin
			core_data_tx[DATA_WIDTH * 2 - 1: DATA_WIDTH] <= data_rx;
			data_tx <= core_data_rx[DATA_WIDTH * 2 - 1: DATA_WIDTH];
		end
		else begin
			core_data_tx[DATA_WIDTH - 1: 0] <= data_rx;
			data_tx <= core_data_rx[DATA_WIDTH - 1: 0];
		end
	end


endmodule