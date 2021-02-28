module alu #(
 parameter
 WIDTH=32,
 OPCODE=4,
 REGS_CODING=3,
 FLAGS=4,
 CARRY=0,
 SIGN=1,
 OVERFLOW=2,
 ZERO=3
)(
input 				  		 clk,
input 				  		 en,
input [REGS_CODING-1: 0] dest_in,
input	[OPCODE-1: 0] 		 opcode,
input [WIDTH-1: 0] op1,
input [WIDTH-1: 0] op2,
input cin,
output[WIDTH-1: 0] instr_addr,
output[FLAGS-1: 0] flags,
output[REGS_CODING-1: 0] dest_out,
output[WIDTH-1: 0] result
);

endmodule