// source: https://github.com/whitequark/bfcpu2/blob/master/verilog/Stack.v 
module stack (
	clk,
	reset,
	q,
	d,
	push,
	pop,
);

	parameter WIDTH = 32;
	parameter DEPTH = 3;

	input                    clk;
	input                    en;
	input      [WIDTH - 1:0] d;
	output reg [WIDTH - 1:0] q;
	input                    push;
	input                    pop;

	reg [DEPTH - 1:0] ptr=0;
	reg [WIDTH - 1:0] stack [0:(1 << DEPTH) - 1];

	always @(posedge clk) begin
        if (en)
    		if (push)
	    		ptr <= ptr + 1;
		    else if (pop)
			    ptr <= ptr - 1;
	end

endmodule