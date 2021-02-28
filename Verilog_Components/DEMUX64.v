module DEMUX64 
#(parameter DATA_WIDTH=16,
            NUM_CORES=64,
            SEL_WIDTH=6)
	(
	input [DATA_WIDTH - 1: 0]data,
	input [SEL_WIDTH - 1: 0] sel,
	output reg [DATA_WIDTH - 1: 0]out64 [NUM_CORES - 1 : 0]
	);
	
	always @(sel, data) begin
		out64[sel][DATA_WIDTH - 1: 0] <= data;
	end

endmodule 