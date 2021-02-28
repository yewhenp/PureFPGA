module СMUX64 
#(parameter DATA_WIDTH=16,
            NUM_CORES=64,
            SEL_WIDTH=6)
	(
	input [DATA_WIDTH - 1: 0]inp64[NUM_CORES - 1 : 0],
	input [SEL_WIDTH - 1: 0] sel,
	output[DATA_WIDTH - 1: 0]out
	);
	assign out = inp64[sel][DATA_WIDTH - 1: 0]
endmodule 