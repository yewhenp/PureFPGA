module core #(
 parameter
 WIDTH=32,
 REGS_CODING=8,
 NOP=15'b1_0000_1011_00_00_00, // addnv reg0, reg0
 CARRY=0,
 SIGN=1,
 OVERFLOW=2,
 ZERO=3
)(
input 				 clk;
input					 response;
input	[WIDTH-1: 0] instruction;
output 				 wren;
output             request;
input	[WIDTH-1: 0] readdata;
output[WIDTH-1: 0] address;
output[WIDTH-1: 0] writedata;
output[WIDTH-1: 0] instr_addr;

);