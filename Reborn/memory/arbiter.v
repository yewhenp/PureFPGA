module arbiter #(
 parameter
 WIDTH=32,
 CORE_NUM=4
)(

input [WIDTH-1: 0] 			data_in_core0,
input [WIDTH-1: 0] 			data_in_core1,
input [WIDTH-1: 0] 			data_in_core2,
input [WIDTH-1: 0] 			data_in_core3,

output reg [WIDTH-1: 0] 	data_out_core0 = 0,
output reg [WIDTH-1: 0] 	data_out_core1 = 0,
output reg [WIDTH-1: 0] 	data_out_core2 = 0,
output reg [WIDTH-1: 0] 	data_out_core3 = 0,

input [WIDTH-1: 0] 			address_in_core0,
input [WIDTH-1: 0] 			address_in_core1,
input [WIDTH-1: 0] 			address_in_core2,
input [WIDTH-1: 0] 			address_in_core3,

output reg [WIDTH-1: 0] 	data_write = 0,
input [WIDTH-1: 0] 			data_read,
output reg [WIDTH-1: 0] 	address = 0,

input [CORE_NUM-1: 0]	 	request,
output reg [CORE_NUM-1: 0] response = 0,

input [CORE_NUM-1: 0] 		wren_core,
output reg 						wren = 0,

input 							clk
);

// remember current reading core,
// state that we are waiting for read memory,
// last result of read to compare and
// how much cycles we are waiting
reg [1: 0] current_state = 2'b11;
reg wait_memory = 0;
reg [WIDTH-1: 0] last_res = 32'b1;
reg [WIDTH-1: 0] time_spent = 0;


always @(posedge clk) begin

	// watch on a=next core
	if (!wait_memory) begin
		current_state = current_state + 1'b1;
	end
	
	// reset outputs
	wren <= 0;
	response <= 0;
	
	// if current core wants to write
	if (wren_core[current_state]) begin
	
		case (current_state)
			2'b00: address <= address_in_core0;
			2'b01: address <= address_in_core1;
			2'b10: address <= address_in_core2;
			2'b11: address <= address_in_core3;
		endcase
		
		case (current_state)
			2'b00: data_write <= data_in_core0;
			2'b01: data_write <= data_in_core1;
			2'b10: data_write <= data_in_core2;
			2'b11: data_write <= data_in_core3;
		endcase
		wren <= 1;
		
	end else begin
	
		// if request was received from current core
		if (request[current_state] || wait_memory) begin
		
			if (!wait_memory) begin
		
				// lock moving to the next core
				wait_memory <= 1;
				
				// load what currently is on bus to compare
				last_res = data_read;
			end
			
			// update time spent
			time_spent = time_spent + 1;
			
			// put address wanted by core to address bus of RAM
			case (current_state)
				2'b00: address <= address_in_core0;
				2'b01: address <= address_in_core1;
				2'b10: address <= address_in_core2;
				2'b11: address <= address_in_core3;
			endcase
			
			// if we have updated data or if time limit was reached
			if ((data_read != last_res) || time_spent > 8) begin
			
				// give core data
				case (current_state)
					2'b00: data_out_core0 <= data_read;
					2'b01: data_out_core1 <= data_read;
					2'b10: data_out_core2 <= data_read;
					2'b11: data_out_core3 <= data_read;
				endcase
				response [current_state] <= 1'b1;
				
				// release lock and move on
				time_spent <= 0;
				wait_memory <= 0;
			
			end
			
		end
	
	end
	
end


endmodule