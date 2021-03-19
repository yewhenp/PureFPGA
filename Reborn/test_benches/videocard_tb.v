`timescale 1 ns/10 ps
module videocard_tb();

localparam WIDTH=32;


reg clk = 0;
reg [WIDTH/2-1: 0] address = 16'b0;
reg [WIDTH-1: 0] data_in = 16'b0;
wire [WIDTH-1: 0] data_out;
wire [WIDTH-1: 0] data_out_mm;
reg wren = 1'b0;
reg interrupt = 1'b0;


//RAM ram_inst
//(
//	.address(address),
//	.clock(clk),
//	.data(data_out),
//	.wren(wren),
//	.q(data_in)
//);
//
//videocard videocard_main
//(
//	.clk(clk),
//	.data_in(data_in),
//	.data_out(data_out),
//	.address(address),
//	.wren(wren),
//	.interrupt_start(intt)
//);

videocard_top videocard_top_inst
(
	.clk(clk) ,	// input  clk_sig
	.clk_hps(clk) ,	// input  clk_hps_sig
	.data_in(data_in) ,	// input [WIDTH-1:0] data_in_sig
	.data_out(data_out) ,	// output [WIDTH-1:0] data_out_sig
	.address(address) ,	// input [WIDTH/2-1:0] address_sig
	.byteenable(4'b1111) ,	// input [BYTES-1:0] byteenable_sig
	.write(wren) ,	// input  write_sig
	.read(~wren) ,	// input  read_sig
	.reset_sink_reset(1'b0) ,	// input  reset_sink_reset_sig
	.interrupt_start(interrupt) ,	// input  interrupt_start_sig
	.data_finish(data_out_mm), 	// output [WIDTH-1:0] data_finish_sig
	.read_finish(1'b1)
);



initial begin
	
	interrupt <= 1'b0;
	#200
	interrupt <= 1'b1;
	#10
	interrupt <= 1'b0;
   
	#2000
   $stop;

end

always #5 clk = ~clk;

endmodule 