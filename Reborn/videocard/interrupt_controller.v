module interrupt_controller #(
 parameter
 CORE_NUM=4
)(
	input							clk,
	input [CORE_NUM-1: 0] 	core_interrupts,
	output reg 					interrupt = 0
);

reg [CORE_NUM-1: 0] internal_interrupt = 4'b0;

always @(negedge clk) begin

	if (interrupt) begin
		
		interrupt <= 1'b0;
		internal_interrupt <= 4'b0;
	
	end else begin
	
		internal_interrupt = internal_interrupt | core_interrupts;
		if (internal_interrupt == 4'b1111) begin
			interrupt <= 1'b1;
		end
	
	end

end

endmodule