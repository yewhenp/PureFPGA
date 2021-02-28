`timescale 1 ns/10 ps
module DEMUX64_tb();

reg [5: 0]sel;
reg [15: 0]data;
wire [15:0] out [63:0];
integer i;

DEMUX64 dd
(
.sel(sel),
.data(data),
.out64(out)
);

reg clk = 1'b0;
initial begin
	for(i = 0; i<64; i = i + 1) begin
			sel = i;
			data = i;
			#10;
			
		end
		$stop;
end

always #5 clk = ~clk;

endmodule 