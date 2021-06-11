module interrupt_controller #(
 parameter
 CORE_NUM=4
)(
	input							clk,
	input [CORE_NUM-1: 0] 	core_interrupts,
	// input clear_interrupt,
	// input [CORE_NUM-1: 0] core_en,
	output reg 					interrupt = 0
);

reg [CORE_NUM-1: 0] internal_interrupt = 4'b0000;

always @(negedge clk) begin

	if (interrupt) begin
		interrupt <= 1'b0;
		internal_interrupt = 4'b0000;
	end else begin
		
		if (core_interrupts[0]) begin
			internal_interrupt[0] = 1;
		end
		if (core_interrupts[1]) begin
			internal_interrupt[1] = 1;
		end
		if (core_interrupts[2]) begin
			internal_interrupt[2] = 1;
		end
		if (core_interrupts[3]) begin
			internal_interrupt[3] = 1;
		end
	
		if (internal_interrupt == 4'b1111) begin
			interrupt <= 1'b1;
		end
	
	end

end

endmodule