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
output reg [FLAGS-1: 0]      		flags,
output reg [REGS_CODING-1: 0]		dest_out,
output reg [WIDTH-1: 0]     		result
);

	// result
	wire [WIDTH:0] tmp;
	assign tmp = {1'b0, op1} + {1'b0, op2};

	// flags
//	wire [FLAGS-1: 0] flags_wire;
//	assign flags_wire[CARRY] = tmp[16];
//	assign flags_wire[SIGN] = result[15];
//	xor(flags_wire[OVERFLOW], flags_wire[CARRY], flags_wire[SIGN]);
//	assign flags_wire[ZERO] = (0 == result);
	
	

//always @ (en, clk, opcode, op1, op2, cin, dest_in, flags_wire)
always @ (negedge clk)

	//if (en && clk) begin
	if (en) begin
	
		case(opcode)
			4'b0000: // Addition
				result = op1 + op2;
			4'b0001: // Addition with carry
				result = op1 + op2 + cin;
			4'b0010: // Subtraction
				result = op1 - op2;
			4'b0011: // Subtraction with carry
				result = op1 - op2 - cin;
			4'b0100: // Multiplication
				result = op1 * op2;
			4'b0101: // Multiplication with carry?????? - will be division
				result = op1 / op2;
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
				result = op1 - op2;
			4'b1101: // Increment A
				result = op1 + 1'b1;
			4'b1110: // Decrement A
				result = op1 - 1'b1;
			default: result = op1;
		endcase
	
		dest_out <= dest_in;
		//flags <= flags_wire;
		flags[CARRY] = tmp[16];
		flags[SIGN] = result[15];
		flags[OVERFLOW] = tmp[16] ^ result[15];
		flags[ZERO] = (0 == result);
		
	end

endmodule