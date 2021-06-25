// source: https://github.com/whitequark/bfcpu2/blob/master/verilog/Stack.v 
module mini_storage (
	clk,
	q,
	d,
	addr,
);

	parameter WIDTH = 32;
	parameter DEPTH = 3;

	input                    clk;
	input                    en;
	input  [DEPTH-1:0]		 addr;
	input 					 wren;
	input 					 get_addr,
	input      [WIDTH - 1:0] d;
	output reg [WIDTH - 1:0] q;

	reg [WIDTH - 1:0] storage [0:(1 << DEPTH) - 1];

	always @(posedge clk) begin
		if (en)
			if (get_addr) begin
				for (i = 0; i < 8; i = i + 1) begin
					if (d == storage[i])
						q  <= i;
				end				
			end else begin
				if (wren)
					storage[addr] <= d;
				else
					q <= storage[addr];
			end
	end
endmodule