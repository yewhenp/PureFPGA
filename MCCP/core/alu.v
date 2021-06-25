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
input 				  		     		clk,
input 				  		     		en,
input [REGS_CODING-1: 0]     		dest_in,
input	[OPCODE-1: 0] 		     		opcode,
input [WIDTH-1: 0]           		op1,
input [WIDTH-1: 0]           		op2,
input                        		cin,
output reg [FLAGS-1: 0]   			flags,
output [REGS_CODING-1: 0]			dest_out,
output reg [WIDTH-1: 0]     		result = 4'b0
);

wire [WIDTH-1:0] tmp;
reg carry;
assign tmp = (opcode[1])? op1[WIDTH-2:0] - op2[WIDTH-2:0] :op1[WIDTH-2:0] + op2[WIDTH-2:0];




assign dest_out = dest_in;


wire [WIDTH-1: 0] div_result;
	
divider div_module (
	.denom(op2),
	.numer(op1),
	.quotient(div_result),
	.remain()
);


always @ (*) begin
		flags= 0;
		case(opcode)
			4'b0000: // Addition
				{flags[CARRY], result} = op1 + op2;
			4'b0001: // Addition with carry
				{flags[CARRY], result} = op1 + op2 + cin;
			4'b0010: // Subtraction
				{flags[CARRY], result} = op1 - op2;
			4'b0011: // Subtraction with carry
				{flags[CARRY], result} = op1 - op2 - cin;
			4'b0100: // Multiplication
				result = op1 * op2;
			4'b0101: // Multiplication with carry?????? - will be division
				result = div_result;
			4'b0110:  //  Logical and
				result = op1 & op2;
			4'b0111: //  Logical or
				result = op1 | op2;
			4'b1000: //  Logical xor
				result = op1 ^ op2;
			4'b1001: //  Left shift
				result = op1 << op2;
			4'b1010: //  Right shift
				result = op1 >> op2;
			4'b1011: //  Not A
				result = ~op1;
			4'b1100: // Compare
				{flags[CARRY], result} = op1 - op2;
			4'b1101: // Increment A
				{flags[CARRY], result} = op1 + 1'b1;
			4'b1110: // Decrement A
				{flags[CARRY], result} = op1 - 1'b1;
			default: result = op1;
		endcase
		flags[SIGN] = result[31];
		flags[OVERFLOW] = flags[CARRY] ^ tmp[WIDTH-1];
		flags[ZERO] = (0 == result);

end
endmodule
