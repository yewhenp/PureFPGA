//`include "ALU.v"
//`include "RAM.v"

module core 
#(parameter DATA_WIDTH=16,
				ADDRESS_WIDTH=16,
				BUFFER_ADDRESS_WIDTH=13,
				INSTRUCTION_WIDTH=15,
				NUM_REGS=4,
				NUM_FLAGS=4,
				CARRY=0,
				SIGN=1,
				OVERFLOW=2,
				ZERO=3)
   (	
	inout [DATA_WIDTH - 1:0]data, 
	input [ADDRESS_WIDTH - 1:0]address,
	input [INSTRUCTION_WIDTH - 1:0]instruction,
	input [BUFFER_ADDRESS_WIDTH - 1:0]bufferAddress,
	input wren,
	input cpen,
	input clk,
	output [DATA_WIDTH - 1:0]bufferData
	);
  
  wire [DATA_WIDTH - 1:0] out_data;
  assign data = (cpen) ? out_data: 16'bZ; 
  
  wire [DATA_WIDTH - 1:0] aluOut;
  wire [NUM_FLAGS - 1: 0] flagsOut;
  reg [DATA_WIDTH - 1:0] aluA;
  reg [DATA_WIDTH - 1:0] aluB;
  reg suffixUse;
  
  reg [DATA_WIDTH - 1:0]reg0;
  reg [DATA_WIDTH - 1:0]reg1;
  reg [DATA_WIDTH - 1:0]reg2;
  reg [DATA_WIDTH - 1:0]reg3;
  
  reg [DATA_WIDTH - 1:0]flags;
  reg buffer = 0;
  reg bufferWrite = 0;
  
  wire [7:0] numberForMovs;
  assign numberForMovs = instruction[13:6];
  
  reg [DATA_WIDTH - 1:0] core_input_data;
  wire [DATA_WIDTH - 1:0] core_output_data;
  reg [ADDRESS_WIDTH - 1:0] core_address;
  reg core_wren;
  
  wire [1:0] registerMovFirst;
  wire [1:0] registerMovLast;
  assign registerMovFirst = instruction[10:9];
  assign registerMovLast = instruction[12:11];

  RAM raam(
  .address_a(address),
  .address_b(core_address),
  .clock(clk),
  .data_a(data),
  .data_b(core_input_data),
  .wren_a(wren && cpen),
  .wren_b(core_wren),
  .q_a(out_data),
  .q_b(core_output_data)
);

  Buffer buffer1(
  .address_a({~buffer, bufferAddress}),
  .address_b({buffer, core_address[12:0]}),
  .clock(clk),
  .data_a(0),
  .data_b(core_output_data),
  .wren_a(0),
  .wren_b(bufferWrite),
  .q_a(),
  .q_b(bufferData)
);
  
  alu allu(
  .A(aluA),
  .B(aluB),
  .ALUSel(instruction[4:1]),
  .CarryIn(flags[0]),
  .clk(clk),
  .ALU_Out(aluOut),
  .CarryOut(flagsOut[CARRY]),
  .SignOut(flagsOut[SIGN]),
  .OverflowOut(flagsOut[OVERFLOW]),
  .ZeroOut(flagsOut[ZERO])
  );

  always @(posedge clk) begin
  
		case (instruction[9:6])
			4'b0000: suffixUse = flags[ZERO] == 1;
			4'b0001: suffixUse = flags[ZERO] == 0;
			4'b0010: suffixUse = flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
			4'b0011: suffixUse = flags[SIGN] != flags[OVERFLOW];
			4'b0100: suffixUse = flags[SIGN] == flags[OVERFLOW];
			4'b0101: suffixUse = flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
			4'b0110: suffixUse = flags[CARRY] == 1;
			4'b0111: suffixUse = flags[CARRY] == 0;
			4'b1000: suffixUse = flags[SIGN] == 1;
			4'b1001: suffixUse = flags[SIGN] == 0;
			4'b1010: suffixUse = 1;    // AL
			4'b1011: suffixUse = 0;    // NV
			4'b1100: suffixUse = flags[OVERFLOW] == 1;
			4'b1101: suffixUse = flags[OVERFLOW] == 0;
			4'b1110: suffixUse = flags[CARRY] == 1 && flags[ZERO] == 0;
			4'b1111: suffixUse = flags[CARRY] == 0 || flags[ZERO] == 0;
			default: suffixUse = 0;
		endcase
  
		if (instruction[0]) begin
			case(instruction[10:9])
				2'b00:
					aluA = reg0;
				2'b01:
					aluA = reg1;
				2'b10:
					aluA = reg2;
				2'b11:
					aluA = reg3;
				default: aluA = reg0;
			endcase
			
			case(instruction[12:11])
				2'b00:
					aluB = reg0;
				2'b01:
					aluB = reg1;
				2'b10:
					aluB = reg2;
				2'b11:
					aluB = reg3;
				default: aluB = reg0;
			endcase
			
			if (suffixUse) begin
				flags = flagsOut;
				case(instruction[14:13])
					2'b00:
						reg0 = aluOut;
					2'b01:
						reg1 = aluOut;
					2'b10:
						reg2 = aluOut;
					2'b11:
						reg3 = aluOut;
					default: reg0 = aluOut;
				endcase
			end
		
		end else begin
			case(instruction[5:1])
				5'b00000: begin
				if (suffixUse) begin
					core_wren = 0;
					case (registerMovFirst)
						2'b00:
							reg0 = core_output_data;
						2'b01:
							reg1 = core_output_data;
						2'b10:
							reg2 = core_output_data;
						2'b11:
							reg3 = core_output_data;
						default: reg0 = reg0;
					endcase
					
					case (registerMovLast)
						2'b00:
							core_address = reg0;
						2'b01:
							core_address = reg1;
						2'b10:
							core_address = reg2;
						2'b11:
							core_address = reg3;
						default: reg0 = reg0;
					endcase
				end
				end
					
				5'b00001: begin
				if (suffixUse) begin
					core_wren = 0;
				
					case (registerMovFirst)
						2'b00:
							reg0 = core_output_data;
						2'b01:
							reg1 = core_output_data;
						2'b10:
							reg2 = core_output_data;
						2'b11:
							reg3 = core_output_data;
						default: reg0 = reg0;
					endcase
					
					case (registerMovLast)
						2'b00:
							core_address = reg0;
						2'b01:
							core_address = reg1;
						2'b10:
							core_address = reg2;
						2'b11:
							core_address = reg3;
						default: reg0 = reg0;
					endcase
				end
				end
				5'b00010: begin
				if (suffixUse) begin
					core_wren = 1;
				
					case (registerMovFirst)
						2'b00:
							core_input_data = reg0;
						2'b01:
							core_input_data = reg1;
						2'b10:
							core_input_data = reg2;
						2'b11:
							core_input_data = reg3;
						default: reg0 = reg0;
					endcase
					
					case (registerMovLast)
						2'b00:
							core_address = reg0;
						2'b01:
							core_address = reg1;
						2'b10:
							core_address = reg2;
						2'b11:
							core_address = reg3;
						default: reg0 = reg0;
					endcase
				end
				end
				5'b00011: begin
					if (suffixUse) begin
						core_wren = 1;
						case (registerMovFirst)
							2'b00:
								core_input_data = reg0;
							2'b01:
								core_input_data = reg1;
							2'b10:
								core_input_data = reg2;
							2'b11:
								core_input_data = reg3;
							default: reg0 = reg0;
						endcase
						
						case (registerMovLast)
							2'b00:
								core_address = reg0;
							2'b01:
								core_address = reg1;
							2'b10:
								core_address = reg2;
							2'b11:
								core_address = reg3;
							default: reg0 = reg0;
						endcase
					end
				end
				5'b00100: begin
				if (suffixUse) begin
				
					case (registerMovFirst)
							2'b00:	
								case (registerMovLast)
									2'b00:
										reg0 = reg0;
									2'b01:
										reg0 = reg1;
									2'b10:
										reg0 = reg2;
									2'b11:
										reg0 = reg3;
									default: reg0 = reg0;
								endcase
							2'b01:
								case (registerMovLast)
									2'b00:
										reg1 = reg0;
									2'b01:
										reg1 = reg1;
									2'b10:
										reg1 = reg2;
									2'b11:
										reg1 = reg3;
									default: reg0 = reg0;
								endcase
							2'b10:
								case (registerMovLast)
									2'b00:
										reg2 = reg0;
									2'b01:
										reg2 = reg1;
									2'b10:
										reg2 = reg2;
									2'b11:
										reg2 = reg3;
									default: reg0 = reg0;
								endcase
							2'b11:
								case (registerMovLast)
									2'b00:
										reg3 = reg0;
									2'b01:
										reg3 = reg1;
									2'b10:
										reg3 = reg2;
									2'b11:
										reg3 = reg3;
									default: reg0 = reg0;
								endcase
							default: reg0 = reg0;
						endcase
					end
				end
				5'b00101: begin
					if (suffixUse) begin
					case (registerMovFirst)
							2'b00:	
								case (registerMovLast)
									2'b00:
										reg0 = reg0;
									2'b01:
										reg0 = reg1;
									2'b10:
										reg0 = reg2;
									2'b11:
										reg0 = reg3;
									default: reg0 = reg0;
								endcase
							2'b01:
								case (registerMovLast)
									2'b00:
										reg1 = reg0;
									2'b01:
										reg1 = reg1;
									2'b10:
										reg1 = reg2;
									2'b11:
										reg1 = reg3;
									default: reg0 = reg0;
								endcase
							2'b10:
								case (registerMovLast)
									2'b00:
										reg2 = reg0;
									2'b01:
										reg2 = reg1;
									2'b10:
										reg2 = reg2;
									2'b11:
										reg2 = reg3;
									default: reg0 = reg0;
								endcase
							2'b11:
								case (registerMovLast)
									2'b00:
										reg3 = reg0;
									2'b01:
										reg3 = reg1;
									2'b10:
										reg3 = reg2;
									2'b11:
										reg3 = reg3;
									default: reg0 = reg0;
								endcase
							default: reg0 = reg0;
						endcase
					end
				end
				5'b00110: reg0[15:8] = numberForMovs;
				5'b00111: reg1[15:8] = numberForMovs;
				5'b01000: reg2[15:8] = numberForMovs;
				5'b01001: reg3[15:8] = numberForMovs;
				5'b01010: reg0[7:0] = numberForMovs;
				5'b01011: reg1[7:0] = numberForMovs;
				5'b01100: reg2[7:0] = numberForMovs;
				5'b01101: reg3[7:0] = numberForMovs;
				5'b01110: reg0 = flags;
				5'b01111: reg1 = flags;
				5'b10000: reg2 = flags;
				5'b10001: reg3 = flags;
				5'b10010: bufferWrite = ~bufferWrite;
				5'b10011: buffer = ~buffer;
				default: buffer = buffer;
			endcase
		end
    end
endmodule