module memory_mapped_control #(
 parameter
 WIDTH=8,
 CORE_NUM=4
)(
input clk,
input clk_hps,
input interrupt,
input address,
input read,
input write,
input [WIDTH-1: 0] data_write,
output [WIDTH-1: 0] data_read,
output interrupt_internal,
output reg [CORE_NUM-1:0] core_en
);

reg [WIDTH-1: 0] data_start = 8'b0;
reg [WIDTH-1: 0] data_finish = 8'b0;

reg [WIDTH-1: 0] steps_in = 8'b0;

assign data_read = data_finish;
assign interrupt_internal = (data_start == 1);

// always @ (posedge clk) begin
// 	if (read) begin
// 		if (interrupt) begin
// 			if (address == 1'b1) begin
// 				data_finish <= 1;
// 			end
// 		end
// 	end
// end

always @(posedge clk_hps) begin
	if (read) begin
		if (interrupt) begin
			if (address == 1'b1) begin
				data_finish <= 1;
			end
		end
	end
	
	if (write) begin
		case (address) 
			4'b0000: begin  
				if (steps_in == 0) begin
					data_finish <= 0;
					data_start <= 1;
					steps_in <= 20;
				end 
			end
			3'b010: core_en[0] <= data_write == 1;
			3'b011: core_en[1] <= data_write == 1;
			3'b100: core_en[2] <= data_write == 1;
			3'b101: core_en[3] <= data_write == 1;
		endcase
	end
	if (steps_in > 0) begin
		steps_in <= steps_in - 2'b01;
	end else begin
		data_start <= 0;
	end
end

endmodule
