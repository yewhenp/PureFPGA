module MMU 
#(parameter	DATA_WIDTH=16,
            ADDR_SPACE=16,
            NUM_CORES=64,
				COUNT_CORES=6
				)
				(	
	input [DATA_WIDTH - 1:0]wr_data[NUM_CORES - 1 : 0], 
	input [ADDR_SPACE - 1:0]address[NUM_CORES - 1 : 0],
	input en;
	output [DATA_WIDTH - 1:0]rd_data[NUM_CORES - 1 : 0],
	input wren,
	input sclk, // x64 speed clk
	input clk
	);
	reg [COUNT_CORES - 1: 0]curr_core;
	
	Count64 c (.clock(sclk),
				  .cnt_en(en),
				  .q(curr_core)
					);
	CMUX64 curr_address(.inp64(address),
	                    .sel(curr_core))