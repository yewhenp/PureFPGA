module core 
#(parameter DATA_WIDTH=16,
				ADDRESS_WIDTH=16,
				INSTRUCTION_WIDTH=15,
				NUM_REGS=4,
				NUM_FLAGS=4)
   (	
	inout [DATA_WIDTH - 1:0]data, 
	input [ADDRESS_WIDTH - 1:0]address,
	input [INSTRUCTION_WIDTH - 1:0]instruction,
	input wren,
	input cpen,
	input clk,
	output busy
	);
  assign core_data = data;
  assign core_address = address;
  assign core_instruction = instruction;
  assign core_wren = wren;
  assign core_cpen = cpen;
  assign alu_selection = instruction[4:1];
  
  assign ALUNonALU = instruction[0];
  
  wire [DATA_WIDTH - 1:0] aluOut;
  wire [NUM_FLAGS - 1: 0] flagsOut;
  reg aluA;
  reg aluB;
  
  reg [DATA_WIDTH - 1:0]reg0;
  reg [DATA_WIDTH - 1:0]reg1;
  reg [DATA_WIDTH - 1:0]reg2;
  reg [DATA_WIDTH - 1:0]reg3;
  
  reg [NUM_FLAGS - 1:0]flags;
  
  assign suffixUse = ((instruction[5] && flags[0]) || ~instruction[5]) &&
  ((instruction[6] && flags[1]) || ~instruction[6]) &&
  ((instruction[7] && flags[2]) || ~instruction[7]) &&
  ((instruction[8] && flags[3]) || ~instruction[8]);

  
//  RAM ram(
//  .data(core_data),
//  .address(core_address),
//  .wren(core_wren),
//  .cpen(core_cpen),
//  .clk(clk)
//  );
  
  alu allu(
  .A(aluA),
  .B(aluB),
  .ALUSel(alu_selection),
  .CarryIn(flags[0]),
  .clk(clk),
  .ALU_Out(aluOut),
  .CarryOut(flagsOut[0]),
  .SignOut(flagsOut[1]),
  .OverflowOut(flagsOut[2]),
  .ZeroOut(flagsOut[3])
  );

  always @(posedge clk) begin
  
		if (ALUNonALU) begin
		
			case(instruction[10:9])
				4'b00:
					aluA = reg0;
				4'b01:
					aluA = reg1;
				4'b10:
					aluA = reg2;
				4'b11:
					aluA = reg3;
				default: aluA = reg0;
			endcase
			
			case(instruction[12:11])
				4'b00:
					aluB = reg0;
				4'b01:
					aluB = reg1;
				4'b10:
					aluB = reg2;
				4'b11:
					aluB = reg3;
				default: aluB = reg0;
			endcase
			
			if (suffixUse) begin
				flags = flagsOut;
				case(instruction[14:13])
					4'b00:
						reg0 = aluOut;
					4'b01:
						reg1 = aluOut;
					4'b10:
						reg2 = aluOut;
					4'b11:
						reg3 = aluOut;
					default: reg0 = aluOut;
				endcase
			end
		
		end
	
    end
  	

endmodule