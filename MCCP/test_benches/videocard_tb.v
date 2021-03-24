`timescale 1 ns/10 ps
module videocard_tb();

localparam WIDTH=32;


reg clk = 0;
reg clk_hps = 0;
reg [WIDTH/2-1: 0] address = 16'b0;
reg [WIDTH-1: 0] data_in = 16'b0;
wire [WIDTH-1: 0] data_out;
reg wren = 1'b0;

reg address_control = 1'b0;
reg [WIDTH-1: 0] data_in_control = 32'b0;
wire [WIDTH-1: 0] data_out_control;
reg wren_control = 1'b0;


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
	.clk_hps(clk_hps) ,	// input  clk_hps_sig
	.data_in(data_in) ,	// input [WIDTH-1:0] data_in_sig
	.data_out(data_out) ,	// output [WIDTH-1:0] data_out_sig
	.address(address) ,	// input [WIDTH/2-1:0] address_sig
	.byteenable(4'b1111) ,	// input [BYTES-1:0] byteenable_sig
	.write(wren) ,	// input  write_sig
	.read(1'b1) ,	// input  read_sig
	.reset_sink_reset(1'b0) ,	// input  reset_sink_reset_sig
	.data_out_control(data_out_control),
	.data_in_control(data_in_control),
	.read_control(~wren_control),
	.write_control(wren_control),
	.address_control(address_control)
);



initial begin
	#200
	
	address <= 0;
	data_in <= 1;
	wren <= 1;
	
	#40
	
	address <= 1;
	data_in <= 2;
	
	#40
	address <= 2;
	data_in <= 3;
	
	#40
	address <= 3;
	data_in <= 4;
	
	#40
	address <= 4;
	wren <= 0;
	
	#40
	wren_control <= 1;
	address_control <= 0;
	data_in_control <= 1;
	
	#20
	wren_control <= 0;
	address_control <= 1;
	data_in_control <= 0;
   
	#800
	address <= 0;
	
	#40
	address <= 1;
	
	#40
	address <= 2;
	
	#40
	address <= 3;
	
	#200
   $stop;

end

always #5 clk = ~clk;
always #1 clk_hps = ~clk_hps;

endmodule 