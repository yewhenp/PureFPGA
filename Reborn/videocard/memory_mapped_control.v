module memory_mapped_control #(
 parameter
 WIDTH=32
)(
input clk,
input interrupt,
output reg [WIDTH-1: 0] data = 32'b0
);

reg [1:0] steps = 0;

always @ (posedge clk) begin
	if (steps > 0) begin
		steps <= steps - 2'b01;
	end else begin
		data = 0;
		if (interrupt) begin
			data = 1;
			steps = 3;
		end
	end
end

endmodule
