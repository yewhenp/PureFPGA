// instructionType = 0 - instruction for cores, 1 - alu, 2 - load/store, 3- movi, 4 - movli, 5 - movhi, 6 - movf, 7 - jump
// sel - size 4 + last digit=0 if ALU, size 5 if memory
// firstRegChoose - a) first operand if ALU 
//                  b) register with data if load/store, 
//                  c) codes register that will have number moved (movli/movhi/movf)
//                  d) register with new IP if jump
// secondRegChoose - a) second operand if ALU
//                   b) register with address if load/store
//                   c) 

module InstructionDecoder #(
    parameter
    WIDTH=16,
    INSTR_SEL_WIDTH=5,
    INSTR_TYPE_CODING=3,
    REG_CODING=3,
    FLAG_NUMBER=4,

    CARRY=0,
    SIGN=1,
    OVERFLOW=2,
    ZERO=3
) 
    (
        input                           clock,
        input                           on,
        input  [WIDTH-1:0]              instructionIn,
        input  [FLAG_NUMBER-1:0]        flags,
        output reg                         saveRes,
        output reg [INSTR_TYPE_CODING-1:0]  instructionType,
        output reg [INSTR_SEL_WIDTH-1:0]    sel,
        output reg [REG_CODING-1:0]         firstRegChoose,
        output reg [REG_CODING-1:0]         secondRegChoose
);
    always @(posedge clock, on) begin
        // instruction for cores, do nothing
        if (instructionIn[WIDTH-1] == 1) begin
            instructionType <= 0;
        end else begin
            // suffix
            case(instructionIn[9:6])    // TODO: fix magic numbers
                4'b0000: saveRes <= flags[ZERO] == 1;
                4'b0001: saveRes <= flags[ZERO] == 0;
                4'b0010: saveRes <= flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
                4'b0011: saveRes <= flags[SIGN] != flags[OVERFLOW];
                4'b0100: saveRes <= flags[SIGN] == flags[OVERFLOW];
                4'b0101: saveRes <= flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
                4'b0110: saveRes <= flags[CARRY] == 1;
                4'b0111: saveRes <= flags[CARRY] == 0;
                4'b1000: saveRes <= flags[SIGN] == 1;
                4'b1001: saveRes <= flags[SIGN] == 0;
                4'b1010: saveRes <= 1;    // AL
                4'b1011: saveRes <= 0;    // NV
                4'b1100: saveRes <= flags[OVERFLOW] == 1;
                4'b1101: saveRes <= flags[OVERFLOW] == 0;
                4'b1110: saveRes <= flags[CARRY] == 1 && flags[ZERO] == 0;
                4'b1111: saveRes <= flags[CARRY] == 0 || flags[ZERO] == 0;
                default: saveRes <= 0;
            endcase
            // ALU instruction
            if (instructionIn[WIDTH-2] == 1) begin
                sel[INSTR_SEL_WIDTH-1:1] <= instructionIn[13:10];
                sel[0] <= 0;
                firstRegChoose <= instructionIn[5:3];
                secondRegChoose <= instructionIn[2:0];
            end

            if (instructionIn[WIDTH-2] == 0) begin
                // load / store
                if (instructionIn[13:11] == 3'b000) begin
                    //register with data
                    firstRegChoose <= instructionIn[5:3];
                    // register with address
                    secondRegChoose <= instructionIn[2:0];

                    instructionType <= 2; 
                end 

                // movi
                if (instructionIn[13:10] == 4'b0010) begin
                    firstRegChoose <= instructionIn[5:3];
                    secondRegChoose <= instructionIn[2:0];
                    instructionType <= 3; 
                end

                // movli/movhi/movf
                case (instructionIn[13:9])
                    5'b00110: begin firstRegChoose <= 3'b000; instructionType <= 5; end   // movhi
                    5'b00111: begin firstRegChoose <= 3'b001; instructionType <= 5; end
                    5'b01000: begin firstRegChoose <= 3'b010; instructionType <= 5; end
                    5'b01001: begin firstRegChoose <= 3'b011; instructionType <= 5; end
                    5'b01010: begin firstRegChoose <= 3'b100; instructionType <= 5; end
                    5'b01011: begin firstRegChoose <= 3'b101; instructionType <= 5; end

                    5'b01100: begin firstRegChoose <= 3'b000; instructionType <= 4; end   // movli
                    5'b01101: begin firstRegChoose <= 3'b001; instructionType <= 4; end
                    5'b01110: begin firstRegChoose <= 3'b010; instructionType <= 4; end
                    5'b01111: begin firstRegChoose <= 3'b011; instructionType <= 4; end
                    5'b10000: begin firstRegChoose <= 3'b100; instructionType <= 4; end
                    5'b10001: begin firstRegChoose <= 3'b101; instructionType <= 4; end

                    5'b10010: begin firstRegChoose <= 3'b000; instructionType <= 6; end   // movf
                    5'b10011: begin firstRegChoose <= 3'b001; instructionType <= 6; end
                    5'b10100: begin firstRegChoose <= 3'b010; instructionType <= 6; end
                    5'b10101: begin firstRegChoose <= 3'b011; instructionType <= 6; end
                    5'b10110: begin firstRegChoose <= 3'b100; instructionType <= 6; end
                    5'b10111: begin firstRegChoose <= 3'b101; instructionType <= 6; end

                    5'b11000: begin saveRes <= flags[ZERO] == 1; instructionType <= 7; end // jumps
                    5'b11001: begin saveRes <= flags[ZERO] == 0; instructionType <= 7; end
                    5'b11010: begin saveRes <= flags[ZERO] == 0 && (flags[OVERFLOW] == flags[SIGN]); instructionType <= 7; end
                    5'b11011: begin saveRes <= flags[OVERFLOW] == flags[SIGN]; instructionType <= 7; end
                    5'b11100: begin saveRes <= flags[OVERFLOW] != flags[SIGN]; instructionType <= 7; end
                    5'b11101: begin saveRes <= flags[ZERO] == 1 && (flags[OVERFLOW] != flags[SIGN]); instructionType <= 7; end

                    default: firstRegChoose <= firstRegChoose;

                endcase


    
            end

            
        end
    end

endmodule