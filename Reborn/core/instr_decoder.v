module instr_decoder #(
    parameter
    WIDTH=32,
    OPCODE=4,
    REGS_CODING=3,
    FLAGS=4,
    CARRY=0,
    SIGN=1,
    OVERFLOW=2,
    ZERO=3,

    CORE_NUMBER=2,
    INT_NUM=3
)
(
    input 				     clk,
    input 				  	 en,
    input [WIDTH-1: 0] 		 long_instr,
    input                    instr_choose,
    input [FLAGS-1: 0]       flags,
    input [CORE_NUMBER-1:0]    core_index,
    //alu
    output reg                    alu_en = 1'b0,
    output reg [OPCODE-1 :0]      alu_opcode = 4'b0,
    //mem
    output reg                    mem_en = 1'b0,
    output reg                    wren = 0,
    //move
    output reg                    move_en = 1'b0,
    output reg [WIDTH/2-1: 0]     immediate = 16'b0,
    output reg [2:0]              mov_type = 3'b0,  //000 - mov reg reg, 001 - movl 010 - movh, 011 - movf, 100 - jump

    // alu + mem + move
    output reg [REGS_CODING-1: 0] op1 = 3'b0,
    output reg [REGS_CODING-1: 0] op2 = 3'b0,
    output reg                    suffix = 1'b0,

    output reg                      interrupt = 1'b0,
    output reg [INT_NUM-1:0]        int_num = 3'b0

);

reg [WIDTH/2-1: 0] short_instr = 16'b0;

always @(negedge clk) begin
    if (en) begin
        alu_en <=  0;
        mem_en <=  0;
        move_en <= 0;
		wren <= 0;
        interrupt <= 0;
        int_num <= 0;

        // long 32bit instruction - movl / movh
        if(long_instr[WIDTH-1] == 1) begin
            immediate = long_instr[WIDTH/2-1: 0];
            move_en <= 1;

            // register coding
            op1 <= long_instr[20:18];

            if (long_instr[25]) begin // movl
                mov_type <= 3'b001;
            end else begin            // movh
                mov_type <= 3'b010;
            end

            case (long_instr[24:21])
                4'b0000: suffix <= flags[ZERO] == 1;
                4'b0001: suffix <= flags[ZERO] == 0;
                4'b0010: suffix <= flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
                4'b0011: suffix <= flags[SIGN] != flags[OVERFLOW];
                4'b0100: suffix <= flags[SIGN] == flags[OVERFLOW];
                4'b0101: suffix <= flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
                4'b0110: suffix <= flags[CARRY] == 1;
                4'b0111: suffix <= flags[CARRY] == 0;
                4'b1000: suffix <= flags[SIGN] == 1;
                4'b1001: suffix <= flags[SIGN] == 0;
                4'b1010: suffix <= 1;    // AL
                4'b1011: suffix <= 0;    // NV
                4'b1100: suffix <= flags[OVERFLOW] == 1;
                4'b1101: suffix <= flags[OVERFLOW] == 0;
                4'b1110: suffix <= flags[CARRY] == 1 && flags[ZERO] == 0;
                4'b1111: suffix <= flags[CARRY] == 0 || flags[ZERO] == 0;
                default: suffix <= 1;
            endcase
        end else begin
            short_instr = instr_choose ? long_instr[WIDTH/2-1: 0] : long_instr[WIDTH-1: WIDTH/2];

            // suffix
            case(short_instr[9:6])
                4'b0000: suffix <= flags[ZERO] == 1;
                4'b0001: suffix <= flags[ZERO] == 0;
                4'b0010: suffix <= flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
                4'b0011: suffix <= flags[SIGN] != flags[OVERFLOW];
                4'b0100: suffix <= flags[SIGN] == flags[OVERFLOW];
                4'b0101: suffix <= flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
                4'b0110: suffix <= flags[CARRY] == 1;
                4'b0111: suffix <= flags[CARRY] == 0;
                4'b1000: suffix <= flags[SIGN] == 1;
                4'b1001: suffix <= flags[SIGN] == 0;
                4'b1010: suffix <= 1;    // AL
                4'b1011: suffix <= 0;    // NV
                4'b1100: suffix <= flags[OVERFLOW] == 1;
                4'b1101: suffix <= flags[OVERFLOW] == 0;
                4'b1110: suffix <= flags[CARRY] == 1 && flags[ZERO] == 0;
                4'b1111: suffix <= flags[CARRY] == 0 || flags[ZERO] == 0;
                default: suffix <= 1;
            endcase

            // ALU instruction
            if (short_instr[WIDTH/2-2] == 1) begin
                alu_en <=  1;

                alu_opcode <= short_instr[13:10];
                op1 <= short_instr[5:3];
                op2 <= short_instr[2:0];
            end else begin
                // load / store
                if (short_instr[13:11] == 3'b000) begin
                    mem_en <=  1;
                    //register with data
                    op1 <= short_instr[5:3];
                    // register with address
                    op2 <= short_instr[2:0];
                    wren <= short_instr[10];
                end else begin

						 // mov reg reg
						 if (short_instr[13:10] == 4'b0010) begin
							  move_en <= 1;
							  op1 <= short_instr[5:3];
							  op2 <= short_instr[2:0];
							  mov_type <= 3'b000; 
						 end else begin
						 

							 // others
							case (short_instr[13:9])
                                // movf
                                5'b01000: begin op1 <= short_instr[8:6]; mov_type <= 3'b011; move_en <= 1; end   // movf
								  
                                // jumps
								5'b01001: begin op1 <= short_instr[8:6]; suffix <= flags[ZERO] == 1; mov_type <= 3'b111; move_en <= 1; end
								5'b01010: begin op1 <= short_instr[8:6]; suffix <= flags[ZERO] == 0; mov_type <= 3'b111; move_en <= 1; end
								5'b01011: begin op1 <= short_instr[8:6]; suffix <= flags[ZERO] == 0 && (flags[OVERFLOW] == flags[SIGN]); mov_type <= 3'b111; move_en <= 1; end
								5'b01100: begin op1 <= short_instr[8:6]; suffix <= flags[OVERFLOW] == flags[SIGN]; mov_type <= 3'b111; move_en <= 1; end
								5'b01101: begin op1 <= short_instr[8:6]; suffix <= flags[OVERFLOW] != flags[SIGN]; mov_type <= 3'b111; move_en <= 1; end
								5'b01110: begin op1 <= short_instr[8:6]; suffix <= flags[ZERO] == 1 || (flags[OVERFLOW] != flags[SIGN]); mov_type <= 3'b111; move_en <= 1; end
                                5'b01111: begin op1 <= short_instr[8:6]; suffix <= 1; mov_type <= 3'b111; move_en <= 1; end

                                // coreidx
                                5'b10000: begin op1 <= short_instr[4:2]; mov_type <= 3'b001; move_en <= 1; immediate[15:2] <= 14'b0; immediate[1:0] <= core_index; end 

                                // int
                                5'b10001: begin op1 <= short_instr[4:2]; interrupt <= 1; int_num <= short_instr[4:2]; end

								default: op1 <= op1;
                            endcase
                            // op1 <= short_instr[5:3];
                            // op2 <= short_instr[2:0];
						 end
					 
					 end

            end

        end
    end
end

endmodule