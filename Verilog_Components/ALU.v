/* ALU Arithmetic and Logic Operations
----------------------------------------------------------------------
|ALU_Sel|   ALU Operation
----------------------------------------------------------------------
| 0000  |   ALU_Out = A + B;
----------------------------------------------------------------------
| 0001  |   ALU_Out = A + B + Carry;
----------------------------------------------------------------------
| 0010  |   ALU_Out = A - B;
----------------------------------------------------------------------
| 0011  |   ALU_Out = A - B - Carry;
----------------------------------------------------------------------
| 0100  |   ALU_Out = A * B;
----------------------------------------------------------------------
| 0101  |   ALU_Out = A * B * Carry ???!!!??;
----------------------------------------------------------------------
| 0110  |   ALU_Out = A AND B;
----------------------------------------------------------------------
| 0111  |   ALU_Out = A OR B;
----------------------------------------------------------------------
| 1000  |   ALU_Out = A XOR B;
----------------------------------------------------------------------
| 1001  |   ALU_Out = A << B;
----------------------------------------------------------------------
| 1010  |   ALU_Out = A >> B;
----------------------------------------------------------------------
| 1011  |   ALU_Out = not A;
----------------------------------------------------------------------
| 1100  |   ALU_Out = A cmp B;
----------------------------------------------------------------------
| 1101  |   ALU_Out = A + 1;
----------------------------------------------------------------------
| 1110  |   ALU_Out = A - 1;
----------------------------------------------------------------------*/
module alu(
  input [15:0] A,B,  // ALU 16-bit Inputs                 
  input [3:0] ALU_Sel,// ALU Selection
  input CarryIn,   //Carry in
  input clk,
  output [15:0] ALU_Out, // ALU 16-bit Output
  output CarryOut, // Carry Out Flag
  output SignOut, // Carry Out Flag
  output OverflowOut, // Carry Out Flag
  output ZeroOut // Carry Out Flag
    );
	reg [15:0] ALU_Result;
	wire [16:0] tmp;
	assign ALU_Out = ALU_Result; // ALU out
	assign tmp = {1'b0,A} + {1'b0,B};
	assign CarryOut = tmp[16]; // Carryout flag
	assign SignOut = 0 > ALU_Result;
	assign OverflowOut = 0;
	assign ZeroOut = 0 == ALU_Result;
	always @(posedge clk)
	begin
	  case(ALU_Sel)
		4'b0000: // Addition
		  ALU_Result = A + B ; 
		4'b0001: // Addition with carry
		  ALU_Result = A + B + CarryIn;
		4'b0010: // Subtraction
		  ALU_Result = A - B;
		4'b0011: // Subtraction with carry
		  ALU_Result = A - B - CarryIn;
		4'b0100: // Multiplication
		  ALU_Result = A * B;
		4'b0101: // Multiplication with carry??????
		  ALU_Result = A * B;
		4'b0110:  //  Logical and 
		  ALU_Result = A & B;
		4'b0111: //  Logical or
		  ALU_Result = A | B;
		 4'b1000: //  Logical xor 
		  ALU_Result = A ^ B;
		 4'b1001: //  Left shift
		  ALU_Result = A << B;
		 4'b1010: //  Right shift
		  ALU_Result = A >> B;
		 4'b1011: //  Not A
		  ALU_Result = ~A;
		 4'b1100: // Compare
			ALU_Result = A - B;
		 4'b1101: // Increment A
			ALU_Result = A + 1;
		 4'b1110: // Decrement A
			ALU_Result = A - 1;
		 default: ALU_Result = A; 
	  endcase
	end

endmodule