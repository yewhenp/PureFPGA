module instr_decode #(
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
input 				  		 clk;
input 				  		 en;
input [WIDTH-1: 0] 		 long_instr;
input                    instr_choose;
input [FLAGS-1: 0]       flags;
//alu
output                   alu_en;
output[OPCODE-1 :0]      opcode;
//mem
output                   mem_en;
output                   wren;
//move
output                   move_en;
output[WIDTH/2-1: 0]     immediate;
output[1:0]              mode;

// alu + mem + move
output[REGS_CODING-1: 0] op1;
output[REGS_CODING-1: 0] op2;
output                   suffix;

);