module memory_mapped_control #(
 parameter
 WIDTH=8
)(
input clk,
input clk_hps,
input interrupt,
input address,
input read,
input write,
input [WIDTH-1: 0] data_write,
output [WIDTH-1: 0] data_read,
output interrupt_internal
);

reg [WIDTH-1: 0] data_start = 8'b0;
reg [WIDTH-1: 0] data_finish = 8'b0;

reg [WIDTH-1: 0] steps_out = 8'b0;
reg [WIDTH-1: 0] steps_in = 8'b0;

assign data_read = data_finish;
assign interrupt_internal = (data_start == 1);

always @ (posedge clk) begin
	if (read) begin
		if (interrupt) begin
			if (address == 1'b1) begin
				if (steps_out == 0) begin
					data_finish = 1;
					steps_out = 3;
				end
			end
		end
	end
	if (steps_out > 0) begin
		steps_out <= steps_out - 2'b01;
	end else begin
		data_finish = 0;
	end
end

always @(posedge clk_hps) begin
	if (write) begin
		if (address == 1'b0) begin
			if (steps_in == 0) begin
				data_start = 1;
				steps_in = 20;
			end
		end
	end
	if (steps_in > 0) begin
		steps_in <= steps_in - 2'b01;
	end else begin
		data_start = 0;
	end
end

endmodule
