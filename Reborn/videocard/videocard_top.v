module videocard_top #(
 parameter
 WIDTH=32,
 BYTES=4
)(
input 						clk,
input							clk_hps,
input [WIDTH-1: 0] 		data_in,
output [WIDTH-1: 0] 		data_out,
input [WIDTH/2-1: 0] 	address,
input [BYTES-1: 0]		byteenable,
input 						write,
input 						read,
input							reset_sink_reset,
input 						interrupt_start,
output [WIDTH-1: 0]		data_finish,
input 						read_finish
);

wire [WIDTH-1: 0] data_in_internal;
wire [WIDTH-1: 0] data_out_internal;
wire [WIDTH-1: 0] address_internal;
wire 					wren_internal;
wire					interrupt_finish;
wire [WIDTH-1: 0] data_finish_wire;

assign data_finish = data_finish_wire & read_finish;


videocard videocard_inst (
	.clk(clk),
	.data_in(data_in_internal),
	.data_out(data_out_internal),
	.address(address_internal),
	.wren(wren_internal),
	.interrupt_start(interrupt_start),
	.interrupt_finish(interrupt_finish)
);

RAM_dual ram_inst (
	.aclr_b(reset_sink_reset),
	.address_a(address_internal[WIDTH/2-1: 0]),
	.address_b(address),
	.byteena_b(byteenable),
	.clock_a(clk),
	.clock_b(clk_hps),
	.data_a(data_out_internal),
	.data_b(data_in),
	.rden_a(1'b1),
	.rden_b(read),
	.wren_a(wren_internal),
	.wren_b(write),
	.q_a(data_in_internal),
	.q_b(data_out)
);

memory_mapped_control mm_control (
	.clk(clk),
	.interrupt(interrupt_finish),
	.data(data_finish_wire)
);

endmodule