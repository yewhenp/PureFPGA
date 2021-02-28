module instr_decoder #(
    parameter
    WIDTH=32,
    OPCODE=4,
    REGS_CODING=3,
    FLAGS=4,
    CARRY=0,
    SIGN=1,
    OVERFLOW=2,
    ZERO=3
)
(
    input 				     clk,
    input 				  	 en,
    input [WIDTH-1: 0] 		 long_instr,
    input                    instr_choose,
    input [FLAGS-1: 0]       flags,
    //alu
    output                   alu_en,
    output[OPCODE-1 :0]      opcode,
    //mem
    output                   mem_en,
    output                   wren,
    //move
    output                   move_en,
    output reg [WIDTH/2-1: 0]immediate,
    output[2:0]              mov_type,  //000 - mov reg reg, 001 - movl 010 - movh, 011 - movf, 100 - jump

    // alu + mem + move
    output[REGS_CODING-1: 0] op1,
    output[REGS_CODING-1: 0] op2,
    output                   suffix

);

reg [WIDTH/2-1: 0] short_instr;


always @(posedge clk) begin
    if (en) begin
        // long instruction - movl / movh
        if(long_instr[WIDTH-1] == 1) begin
            immediate = long_instr[WIDTH-1: WIDTH/2];
            move_en = 1;
            alu_en =  0;
            mem_en =  0;
            suffix =  1;
            
            case(long_instr[13:9]) 
                5'b00110: begin op1 <= 3'b000; mov_type <= 3'b010; end   // movh
                5'b00111: begin op1 <= 3'b001; mov_type <= 3'b010; end
                5'b01000: begin op1 <= 3'b010; mov_type <= 3'b010; end
                5'b01001: begin op1 <= 3'b011; mov_type <= 3'b010; end
                5'b01010: begin op1 <= 3'b100; mov_type <= 3'b010; end
                5'b01011: begin op1 <= 3'b101; mov_type <= 3'b010; end

                5'b01100: begin op1 <= 3'b000; mov_type <= 3'b001; end   // movl
                5'b01101: begin op1 <= 3'b001; mov_type <= 3'b001; end
                5'b01110: begin op1 <= 3'b010; mov_type <= 3'b001; end
                5'b01111: begin op1 <= 3'b011; mov_type <= 3'b001; end
                5'b10000: begin op1 <= 3'b100; mov_type <= 3'b001; end
                5'b10001: begin op1 <= 3'b101; mov_type <= 3'b001; end
            endcase
        end else begin
            short_instr = instr_choose ? long_instr[WIDTH/2-1: 0] : long_instr[WIDTH-1: WIDTH/2];
        end
    end
end

endmodule