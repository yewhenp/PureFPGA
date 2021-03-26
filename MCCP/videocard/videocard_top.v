module videocard_top #(
 parameter
 WIDTH=32,
 WIDTH_CTRL=8,
 BYTES=4
)(
input 								clk,
input									clk_hps,
input [WIDTH-1: 0] 				data_in,
output [WIDTH-1: 0] 				data_out,
input [WIDTH/2: 0] 				address,
input [BYTES-1: 0]				byteenable,
input 								write,
input 								read,
input									reset_sink_reset,
output [WIDTH_CTRL-1: 0]		data_out_control,
input [WIDTH_CTRL-1: 0]			data_in_control,
input 								read_control,
input 								write_control,
input 								address_control
);

wire [WIDTH-1: 0] data_in_internal;
wire [WIDTH-1: 0] data_out_internal;
wire [WIDTH-1: 0] address_internal;
wire 					wren_internal;
wire					interrupt_finish;
wire [WIDTH-1: 0] data_finish_wire;
wire 					interrupt_start;


videocard videocard_inst (
	.clk(clk),
	.data_in(data_in_internal),
	.data_out(data_out_internal),
	.address(address_internal),
	.wren(wren_internal),
	.interrupt_start(interrupt_start),
	.interrupt_finish(interrupt_finish),
	.clk_rom(clk_hps),
	.address_rom(address[WIDTH/2-1: 0]),
	.data_in_rom(data_in),
	.wren_rom(write && address[WIDTH/2])
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
	.wren_b(write && ~address[WIDTH/2]),
	.q_a(data_in_internal),
	.q_b(data_out)
);

memory_mapped_control mm_control (
	.clk(clk),
	.clk_hps(clk_hps),
	.interrupt(interrupt_finish),
	.address(address_control),
	.read(read_control),
	.write(write_control),
	.data_write(data_in_control),
	.data_read(data_out_control),
	.interrupt_internal(interrupt_start)
);

endmodule