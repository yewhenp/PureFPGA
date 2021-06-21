module memory_mapped_control #(
 parameter
 WIDTH=8,
 CORE_NUM=4
)(
input clk,
input clk_hps,
input interrupt,
input [2:0] address,
input read,
input write,
input [WIDTH-1: 0] data_write,
output [WIDTH-1: 0] data_read,
output interrupt_internal,
output reg [CORE_NUM-1:0] core_en=4'b1111
);

reg [WIDTH-1: 0] data_start = 8'b0;
reg [WIDTH-1: 0] data_finish = 8'b0;

reg [WIDTH-1: 0] steps_in = 8'b0;
reg interrupt_latch = 0;

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
	if (interrupt) begin
		interrupt_latch <= 1;
	end
	if (read) begin
		case (address) 
			3'b000: data_finish = data_start;
			3'b001: data_finish = interrupt_latch;
			3'b010: data_finish = core_en[0];
			3'b011: data_finish = core_en[1];
			3'b100: data_finish = core_en[2];
			3'b101: data_finish = core_en[3];
			default: data_finish = 0;
		endcase
	end
	
	if (write) begin
		case (address) 
			3'b000: begin  
				if (steps_in == 0) begin
					// $display("salam aleukum");
					data_finish = 0;
					data_start = 1;
					steps_in = 20;
				end 
			end
			3'b001: interrupt_latch <= data_write != 0; 
			3'b010: core_en[0] <= data_write == 1;
			3'b011: core_en[1] <= data_write == 1;
			3'b100: core_en[2] <= data_write == 1;
			3'b101: core_en[3] <= data_write == 1;
			default: data_finish = data_finish;
		endcase
	end
	// if (clear_hold > 0) begin
	// 	clear_hold = clear_hold - 1;
	// end else begin
	// 	clear_interrupt <= 0;
	// end
	if (steps_in > 0) begin
		steps_in = steps_in - 2'b01;
	end else begin
		data_start <= 0;
	end
end

endmodule
