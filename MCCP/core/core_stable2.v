module core #(
 parameter
 WIDTH=32,
 REGS_CODING=3,
 FLAGS=4,
 CARRY=0,
 SIGN=1,
 OVERFLOW=2,
 ZERO=3,
 OPCODE=4,
 MOV_CODE=3,
 STATE_WIDTH=2,
 CORE_NUM=2,
 INT_NUM=3
)(
input 				 	clk,
input			       	response,		// reponse from memory arbitr
input [WIDTH-1: 0] 		readdata,		// data bus with data to read from memory
input [WIDTH-1: 0] 		instruction,	// 32 bit instruction opcode bus
input [CORE_NUM-1:0]	core_index,		// index of this core
input 					interrupt_start,// interupt that starts core
output 				 	wren,			// wren for memory arbitr
output             		request,		// request to memory
output[WIDTH-1: 0] 		writedata,		// data to write into memory
output[WIDTH-1: 0] 		address,		// address of memory cell to write to / read from
output[WIDTH-1: 0] 		instr_addr,		// address of instruction
output[INT_NUM-1:0] 	int_num,		// core of interupt from core
output reg				interrupt_finish// interupr that signals that videocard finished job
);


// set core registers
reg [WIDTH-1:0] reg0=0, reg1=0, reg2=0, reg3=0, reg4=0, reg5=0, sp=0, ip=-1;

// stack-related registers
reg [WIDTH-1:0] stack_begin=0, my_stack_begin=0, my_stack_end=0, stack_exc_addr=0;
reg [FLAGS-1: 0] flags=0; // CF, SF, OF, ZF

// state of core
reg [STATE_WIDTH-1: 0] state=2'b11;
wire fetch, decode, execute, save;

// state of work (sleep / work)
reg perform=1'b0;

// operands
wire [REGS_CODING-1: 0] operand1_code, operand2_code, result_code;
reg [WIDTH-1: 0] operand1, operand2, result;

// using decoder, get this values
wire [WIDTH/2-1: 0] immediate;
wire [MOV_CODE-1: 0] move_type;
wire [OPCODE-1: 0] alu_opcode;

// stack handling
wire 					write_stack_params;
wire [1:0] 				stack_param_coding;
wire [REGS_CODING-1:0] 	stack_param_reg;

// which part of instruction (first 16 bit or second) use
reg instr_choose=1'b1;

// enables and suffix use
wire alu_en, move_en, mem_en;
wire suffix;

// help regs for memory
reg [WIDTH-1: 0] address_reg=0, writedata_reg=0;
reg wait_memory=0;
wire wren_instr;
reg wren_exception = 0;

// helping wires for alu
wire [WIDTH-1: 0] result_wire;
wire [FLAGS-1: 0] flags_wire;

// interupt
wire interrupt;

// assigns
assign fetch = (state == 0);
assign decode = (state == 1);
assign execute = (state == 2);
assign save = (state == 3);
assign address = address_reg;
assign writedata = writedata_reg;
assign instr_addr = ip;
assign request = wait_memory;

assign wren = wren_instr || wren_exception;

// dump core counter for moving registers to stack when exception happened
reg [3:0] dump_core_counter = 0;

instr_decoder instr_decoder_main (
	.clk(clk),
	.en(decode),
	.long_instr(instruction),
	.instr_choose(instr_choose),
	.flags(flags[FLAGS-1: 0]),
	.core_index(core_index),
	.alu_en(alu_en),
	.alu_opcode(alu_opcode),
	.mem_en(mem_en),
	.wren(wren_instr),
	.move_en(move_en),
	.immediate(immediate),
	.mov_type(move_type),  //000 - mov reg reg, 001 - movl 010 - movh, 011 - movf, 100 - jump
	.op1(operand1_code),
	.op2(operand2_code),
	.suffix(suffix),
	.interrupt(interrupt),
	.int_num(int_num),
	// .stack_exception(stack_exception),
	.write_stack_params(write_stack_params),
	.stack_param_coding(stack_param_coding),
	.stack_param_reg(stack_param_reg)
);


alu alu_main (
	.clk(clk),
	.en(alu_en && execute),
	.dest_in(operand1_code),
	.opcode(alu_opcode),
	.op1(operand1),
	.op2(operand2),
	.cin(flags[CARRY]),
	.flags(flags_wire),
	.dest_out(result_code),
	.result(result_wire)
);

always @ * begin
	// set operand 1
	case (operand1_code)
		3'b000 : operand1 <= reg0;
		3'b001 : operand1 <= reg1;
		3'b010 : operand1 <= reg2;
		3'b011 : operand1 <= reg3;
		3'b100 : operand1 <= reg4;
		3'b101 : operand1 <= reg5;
		3'b110 : operand1 <= sp;
		3'b111 : operand1 <= ip;
	endcase
	
	// set operand 2
	case (operand2_code)
		3'b000 : operand2 <= reg0;
		3'b001 : operand2 <= reg1;
		3'b010 : operand2 <= reg2;
		3'b011 : operand2 <= reg3;
		3'b100 : operand2 <= reg4;
		3'b101 : operand2 <= reg5;
		3'b110 : operand2 <= sp;
		3'b111 : operand2 <= ip;
	endcase
end


always @(posedge clk) begin

	if (interrupt_start) begin
		perform <= 1'b1;
	end else begin

		if (perform) begin

			if (wait_memory) begin
				// got response, read data and unlock core
				if (response) begin

					// continue loading registers to the stack
					if (dump_core_counter > 0) begin
						dump_core_counter = dump_core_counter - 1;
						sp = sp + 1;
						address_reg = sp;
						case (dump_core_counter) 
							3'b0000 : begin ip <= stack_exc_addr; state <= 0; instr_choose <= 0; end // load exception handling instruction address
							3'b0001 : writedata_reg <= reg0;
							3'b0010 : writedata_reg <= reg1;
							3'b0011 : writedata_reg <= reg2;
							3'b0100 : writedata_reg <= reg3;
							3'b0101 : writedata_reg <= reg4;
							3'b0110 : writedata_reg <= reg5;
							3'b0111 : writedata_reg <= sp;
							3'b1000 : writedata_reg <= ip;
						endcase
					end else begin
						wait_memory <= 0;

						if (wren==0) begin 
							case (operand1_code)
								3'b000 : reg0 <= readdata;
								3'b001 : reg1 <= readdata;
								3'b010 : reg2 <= readdata;
								3'b011 : reg3 <= readdata;
								3'b100 : reg4 <= readdata;
								3'b101 : reg5 <= readdata;
								3'b110 : sp <= readdata;
								3'b111 : ip = readdata;
							endcase
						end
					end

				end else begin
					// wait for data
					reg0 <= reg0;
				end
			
			end else begin
				
				if (fetch) begin
					// just wait, as instructuion address is just assigned
					reg0 <= reg0;
				end
				
				// on execute stage
				if (execute) begin
					if (alu_en) begin
						// flags[FLAGS-1: 0] <= flags_wire;
						result <= result_wire;
					end
				end
				
				// on save stage
				if (save) begin
					$display("Flags in core ", core_index ," : ", flags, " instruction: ", instruction, " ip: ", ip);


					// interrupt from instruction
					if (interrupt && suffix) begin
						interrupt_finish <= 1;
						perform <= 0;
						ip = -1;
						reg0 <= 0;
						reg1 <= 0;
						reg2 <= 0;
						reg3 <= 0;
						reg4 <= 0;
						reg5 <= 0;
						sp <= 0;
					end

					// work with alu
					if (alu_en && suffix) begin
						// set result reg
						case (result_code)
							3'b000 : reg0 <= result;
							3'b001 : reg1 <= result;
							3'b010 : reg2 <= result;
							3'b011 : reg3 <= result;
							3'b100 : reg4 <= result;
							3'b101 : reg5 <= result;
							3'b110 : sp <= result;
							3'b111 : ip = result;
						endcase
						flags[FLAGS-1: 0] <= flags_wire;
					end
					
					// work with movs
					if (move_en) begin
						
						if (suffix) begin
						
							case (move_type)
								//mov reg
								3'b000: 	case (operand1_code)
												3'b000 : reg0 <= operand2;
												3'b001 : reg1 <= operand2;
												3'b010 : reg2 <= operand2;
												3'b011 : reg3 <= operand2;
												3'b100 : reg4 <= operand2;
												3'b101 : reg5 <= operand2;
												3'b110 : sp <= operand2;
												3'b111 : ip = operand2;
											endcase
								// mov flags
								3'b011 : case (operand1_code)
												3'b000 : reg0 <= flags;
												3'b001 : reg1 <= flags;
												3'b010 : reg2 <= flags;
												3'b011 : reg3 <= flags;
												3'b100 : reg4 <= flags;
												3'b101 : reg5 <= flags;
												3'b110 : sp <= flags;
											endcase
								// jump
								3'b111 : begin
											case (operand1_code)
												3'b000 : ip = reg0-1;
												3'b001 : ip = reg1-1;
												3'b010 : ip = reg2-1;
												3'b011 : ip = reg3-1;
												3'b100 : ip = reg4-1;
												3'b101 : ip = reg5-1;
												3'b110 : ip = sp-1;
												3'b111 : ip = ip-1;
											endcase
											instr_choose = 1;
											end
								// mov high
								3'b010 : case (operand1_code)
												3'b000 : reg0[WIDTH-1: WIDTH/2] <= immediate;
												3'b001 : reg1[WIDTH-1: WIDTH/2] <= immediate;
												3'b010 : reg2[WIDTH-1: WIDTH/2] <= immediate;
												3'b011 : reg3[WIDTH-1: WIDTH/2] <= immediate;
												3'b100 : reg4[WIDTH-1: WIDTH/2] <= immediate;
												3'b101 : reg5[WIDTH-1: WIDTH/2] <= immediate;
												3'b110 : sp[WIDTH-1: WIDTH/2] <= immediate;
											endcase
								// mov lov
								3'b001 : case (operand1_code)
												3'b000 : reg0[WIDTH/2-1: 0] <= immediate;
												3'b001 : reg1[WIDTH/2-1: 0] <= immediate;
												3'b010 : reg2[WIDTH/2-1: 0] <= immediate;
												3'b011 : reg3[WIDTH/2-1: 0] <= immediate;
												3'b100 : reg4[WIDTH/2-1: 0] <= immediate;
												3'b101 : reg5[WIDTH/2-1: 0] <= immediate;
												3'b110 : sp[WIDTH/2-1: 0] 	<= immediate;
											endcase
							endcase

						end
					end
					
					// work with memory
					if (mem_en) begin
					
						// set address
						address_reg = operand2;

						// read from memory to reg
						// lock core
						wait_memory <= 1'b1;

						// check if you're writing in other's core stack
						if ((address_reg >= stack_begin) && 
							!(address_reg >= my_stack_begin && address_reg < my_stack_end)) begin
							// dump core
							dump_core_counter = 8; // 8 - number of registers
						end

						if (dump_core_counter > 0) begin
							address_reg = sp;
							wren_exception = 1;
							case (dump_core_counter)
								3'b0001 : writedata_reg <= reg0;
								3'b0010 : writedata_reg <= reg1;
								3'b0011 : writedata_reg <= reg2;
								3'b0100 : writedata_reg <= reg3;
								3'b0101 : writedata_reg <= reg4;
								3'b0110 : writedata_reg <= reg5;
								3'b0111 : writedata_reg <= sp;
								3'b1000 : writedata_reg <= ip;
							endcase
						end else begin
							// write to memory
							if (wren) begin
								writedata_reg <= operand1;
							end 
						end
						// else begin
						// 	// read from memory to reg
						// 	// lock core
						// 	wait_memory <= 1'b1;
						// end

					end

					// load stack parameters
					if (write_stack_params && suffix) begin
						case (stack_param_coding)
							2'b00: begin

								 	case (stack_param_reg) 
										3'b000 : begin my_stack_begin <= reg0; sp <= reg0; end
										3'b001 : begin my_stack_begin <= reg1; sp <= reg1; end
										3'b010 : begin my_stack_begin <= reg2; sp <= reg2; end
										3'b011 : begin my_stack_begin <= reg3; sp <= reg3; end
										3'b100 : begin my_stack_begin <= reg4; sp <= reg4; end
										3'b101 : begin my_stack_begin <= reg5; sp <= reg5; end
										3'b110 : begin my_stack_begin <= sp; sp <= sp; end
										3'b111 : begin my_stack_begin <= ip; sp <= ip; end
									endcase
									// sp <= my_stack_begin;
							end
							2'b01:  case (stack_param_reg) 
										3'b000 : my_stack_end <= reg0;
										3'b001 : my_stack_end <= reg1;
										3'b010 : my_stack_end <= reg2;
										3'b011 : my_stack_end <= reg3;
										3'b100 : my_stack_end <= reg4;
										3'b101 : my_stack_end <= reg5;
										3'b110 : my_stack_end <= sp;
										3'b111 : my_stack_end <= ip;
									endcase
							2'b10:  case (stack_param_reg) 
										3'b000 : stack_begin <= reg0;
										3'b001 : stack_begin <= reg1;
										3'b010 : stack_begin <= reg2;
										3'b011 : stack_begin <= reg3;
										3'b100 : stack_begin <= reg4;
										3'b101 : stack_begin <= reg5;
										3'b110 : stack_begin <= sp;
										3'b111 : stack_begin <= ip;
									endcase
							2'b11:  case (stack_param_reg) 
										3'b000 : stack_exc_addr <= reg0;
										3'b001 : stack_exc_addr <= reg1;
										3'b010 : stack_exc_addr <= reg2;
										3'b011 : stack_exc_addr <= reg3;
										3'b100 : stack_exc_addr <= reg4;
										3'b101 : stack_exc_addr <= reg5;
										3'b110 : stack_exc_addr <= sp;
										3'b111 : stack_exc_addr <= ip;
									endcase
						endcase
					end
					
				end
				
				// process state change
				if (state < 3) begin
					state = state + 2'b1;
				end else begin
					// reset machine cycle
					state = 0;

					if (instr_choose || (instruction[WIDTH-1] == 1)) begin
						ip = ip + 1;
						instr_choose = 0;
					end else begin
						// choose another instruction
						instr_choose = ~instr_choose;
					end
				end
			end
		end else begin
			interrupt_finish <= 0;
		end
	end
	
end

endmodule