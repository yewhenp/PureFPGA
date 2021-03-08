`timescale 1 ns/10 ps
module videocard_tb();

localparam WIDTH=32;


reg clk = 0;
wire [WIDTH-1: 0] address;
wire [WIDTH-1: 0] data_in;
wire [WIDTH-1: 0] data_out;
wire wren;


RAM ram_inst
(
	.address(address),
	.clock(clk),
	.data(data_out),
	.wren(wren),
	.q(data_in)
);

videocard videocard_main
(
	.clk(clk),
	.data_in(data_in),
	.data_out(data_out),
	.address(address),
	.wren(wren)
);



initial begin
   
	#1000
   $stop;

end

always #5 clk = ~clk;

endmodule 