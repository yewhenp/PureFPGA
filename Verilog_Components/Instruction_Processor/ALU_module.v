module ALUModule #(
    parameter 
    WIDTH=16;
)

(
  input [WIDTH-1:0] A,B,  		// ALU 16-bit Inputs
  input [3:0] ALUSel,		// ALU Selection
  input CarryIn,   			//Carry in
  input clk,
  input on,
  output [WIDTH-1:0] ALU_Out, 	// ALU 16-bit Output
  output CarryOut, 			// Carry Out Flag
  output SignOut, 			// Carry Out Flag
  output OverflowOut, 		// Carry Out Flag
  output ZeroOut 			// Carry Out Flag
);
	// result
	reg [15:0] ALUOut;
	wire [16:0] tmp;
	assign ALU_Out = ALUOut; // ALU out
	assign tmp = {1'b0,A} + {1'b0,B};

	// flags
	assign CarryOut = tmp[16]; // Carryout flag
	assign SignOut = ALUOut[15];
	xor(OverflowOut, CarryOut, SignOut);
	assign ZeroOut = 0 == ALUOut;

always @(posedge clk, on)
	case(ALUSel)
		4'b0000: // Addition
			ALUOut = A + B;
		4'b0001: // Addition with carry
			ALUOut = A + B + CarryIn;
		4'b0010: // Subtraction
			ALUOut = A - B;
		4'b0011: // Subtraction with carry
			ALUOut = A - B - CarryIn;
		4'b0100: // Multiplication
			ALUOut = A * B;
		4'b0101: // Multiplication with carry??????
			ALUOut = A * B;
		4'b0110:  //  Logical and
			ALUOut = A & B;
		4'b0111: //  Logical or
			ALUOut = A | B;
		4'b1000: //  Logical xor
			ALUOut = A ^ B;
		4'b1001: //  Left shift
			ALUOut = A << B;
		4'b1010: //  Right shift
			ALUOut = A >> B;
		4'b1011: //  Not A
			ALUOut = ~A;
		4'b1100: // Compare
			ALUOut = A - B;
		4'b1101: // Increment A
			ALUOut = A + 1'b1;
		4'b1110: // Decrement A
			ALUOut = A - 1'b1;
		default: ALUOut = A;
	endcase

endmodule