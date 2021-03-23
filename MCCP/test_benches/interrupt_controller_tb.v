`timescale 1 ns/10 ps
module interrupt_controller_tb();

localparam CORE_NUM = 4;

reg clk = 1;
reg [CORE_NUM-1: 0] core_interrupts = 4'b0;
wire interrupt_finish;

interrupt_controller inter_controller
(
	.clk(clk),
	.core_interrupts(core_interrupts),
	.interrupt(interrupt_finish)
);


initial begin

	#50
	core_interrupts[0] = 1;
	
	#10
	core_interrupts[0] = 0;
	
	#70
	core_interrupts[1] = 1;
	core_interrupts[2] = 1;
	
	#10
	core_interrupts[1] = 0;
	core_interrupts[2] = 0;
	core_interrupts[3] = 1;
	
	#10
	core_interrupts[3] = 0;
	
	
	#100
	core_interrupts = 4'b1111;
	
	#10
	core_interrupts = 4'b0000;
	
	#30
   $stop;

end

always #5 clk = ~clk;

endmodule 