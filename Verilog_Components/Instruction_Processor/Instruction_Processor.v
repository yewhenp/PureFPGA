// istruction processor module
// `include "ALU.v"
// `include "RAM1.v"
module InstructionProcessor #(
    parameter
    WIDTH=16,
    REGS_CODING=8,
    NOP=15'b1_0000_1011_00_00_00,   // addnv reg0, reg0
    CARRY=0,
    SIGN=1,
    OVERFLOW=2,
    ZERO=3
)
    (
    input                   clock,
    input [WIDTH-1:0]       regData,
    input [REGS_CODING-1:0] regChoose,
    input [WIDTH-1:0]       ROMData,
    output [WIDTH-2:0]      instructionOut,
	output [WIDTH-1:0]      ROMAddress
);
    wire[WIDTH-1:0] ALURes, RAMOutData;
    wire ALUCF, ALUSF, ALUOF, ALUZF, cin;

    reg[14:0] coreInstr = NOP;
    reg[3:0] ALUSel = 4'b1111;
    reg[WIDTH-1:0] firstOperand=0, secondOperand=0, RAMAddress=0, RAMData=0;
    reg cinReg=0, saveRes=1, wren=0, makeJump=0;

    assign instructionOut = coreInstr;
    //assign cin = cinReg;
	 

    reg[WIDTH-1:0] reg0=0, reg1=0, reg2=0, reg3=0, reg4=0, reg5=0, sp=0, ip=-1, flags=0; // CF, SF, OF, ZF
	assign ROMAddress = ip;
    alu alu0 (
        .A(firstOperand),
        .B(secondOperand),
        .ALUSel(ALUSel),
        .CarryIn(cinReg),
        .clk(clock),
        .ALU_Out(ALURes),
        .CarryOut(ALUCF),
        .SignOut(ALUSF),
        .OverflowOut(ALUOF),
        .ZeroOut(ALUZF)
    );

    OnePortRAM ram1(
        .address(RAMAddress),
        .clock(clock),
        .data(RAMData),
        .wren(wren),
        .q(RAMOutData)
    );

    always @(negedge clock) begin
        wren <= 0;
        // suffix
        case(ROMData[9:6])    // TODO: fix magic numbers
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
        
        // alu command
        if (ROMData[WIDTH-2] == 1) begin
            ALUSel <= ROMData[13:10];
            case(ROMData[5:3])    // TODO: fix magic numbers
                3'b000: firstOperand <= reg0;
                3'b001: firstOperand <= reg1;
                3'b010: firstOperand <= reg2;
                3'b011: firstOperand <= reg3;
                3'b100: firstOperand <= reg4;
                3'b101: firstOperand <= reg5;
                3'b110: firstOperand <= sp;
                3'b111: firstOperand <= ip;
                default:firstOperand <= 0;
            endcase
            case(ROMData[2:0])    // TODO: fix magic numbers
                3'b000: secondOperand <= reg0;
                3'b001: secondOperand <= reg1;
                3'b010: secondOperand <= reg2;
                3'b011: secondOperand <= reg3;
                3'b100: secondOperand <= reg4;
                3'b101: secondOperand <= reg5;
                3'b110: secondOperand <= sp;
                3'b111: secondOperand <= ip;
                default:secondOperand <= 0;
            endcase
            case(ROMData[13:10])
                4'b0001, 4'b0011, 4'b0101: cinReg <= flags[CARRY];
                default: cinReg <= 0;
            endcase
        end else begin
            // load
            if (ROMData[13:10] == 4'b0000 && saveRes) begin
                // address is always second operand
                case(ROMData[2:0])    // TODO: fix magic numbers
                    3'b000: RAMAddress <= reg0;
                    3'b001: RAMAddress <= reg1;
                    3'b010: RAMAddress <= reg2;
                    3'b011: RAMAddress <= reg3;
                    3'b100: RAMAddress <= reg4;
                    3'b101: RAMAddress <= reg5;
                    3'b110: RAMAddress <= sp;
                    3'b111: RAMAddress <= ip;
                    default:RAMAddress <= 0;
                endcase
                wren <= 0;
                
            end else begin
                // store
                if (ROMData[13:10] == 4'b0001 && saveRes) begin
                    wren <= 1;
                    // address is always second operand
                    case(ROMData[2:0])    // TODO: fix magic numbers
                        3'b000: RAMAddress <= reg0;
                        3'b001: RAMAddress <= reg1;
                        3'b010: RAMAddress <= reg2;
                        3'b011: RAMAddress <= reg3;
                        3'b100: RAMAddress <= reg4;
                        3'b101: RAMAddress <= reg5;
                        3'b110: RAMAddress <= sp;
                        3'b111: RAMAddress <= ip;
                        default:RAMAddress <= 0;
                    endcase

                    case(ROMData[5:3])    // TODO: fix magic numbers
                        3'b000: RAMData <= reg0;
                        3'b001: RAMData <= reg1;
                        3'b010: RAMData <= reg2;
                        3'b011: RAMData <= reg3;
                        3'b100: RAMData <= reg4;
                        3'b101: RAMData <= reg5;
                        3'b110: RAMData <= sp;
                        3'b111: RAMData <= ip;
                        default:RAMData <= 0;
                    endcase
                end
            end
        end
    end

    always @ (posedge clock) begin
        // if it's time to write into registers
        if (regChoose) begin
            case(regChoose)
                8'b00000001: reg0 <= regData;
                8'b00000010: reg1 <= regData;
                8'b00000100: reg2 <= regData;
                8'b00001000: reg3 <= regData;
                8'b00010000: reg4 <= regData;
                8'b00100000: reg5 <= regData;
                8'b01000000: sp   <= regData;
                8'b10000000: ip   <= regData;
                default:     reg0 <= reg0;
            endcase
        end else begin
            // ALUSel <= ROMData[13:10];
            if (ROMData[WIDTH-1] == 1) begin
                coreInstr <= ROMData[WIDTH-2:0];
            end else begin
                coreInstr <= NOP;
                
                // alu command
                if (ROMData[WIDTH-2] == 1) begin
                    
                    // if suffix condition is true
                    if (saveRes) begin
                        case(ROMData[5:3])    // TODO: fix magic numbers
                            3'b000: reg0 <= ALURes;
                            3'b001: reg1 <= ALURes;
                            3'b010: reg2 <= ALURes;
                            3'b011: reg3 <= ALURes;
                            3'b100: reg4 <= ALURes;
                            3'b101: reg5 <= ALURes;
                            3'b110: sp   <= ALURes;
                            3'b111: ip   <= ALURes;
                            default:reg0 <= reg0;
                        endcase
                        
                        flags[CARRY]    <= ALUCF;
                        flags[SIGN]     <= ALUSF;
                        flags[OVERFLOW] <= ALUOF;
                        flags[ZERO]     <= ALUZF;

                    end else begin
                        reg0 <= reg0;       // default case
                    end
                end else begin
                    
                    // load
                    if (ROMData[13:10] == 4'b0000) begin
                        if (saveRes) begin
                            case(ROMData[5:3])    // TODO: fix magic numbers
                                3'b000: reg0 <= RAMOutData;
                                3'b001: reg1 <= RAMOutData;
                                3'b010: reg2 <= RAMOutData;
                                3'b011: reg3 <= RAMOutData;
                                3'b100: reg4 <= RAMOutData;
                                3'b101: reg5 <= RAMOutData;
                                3'b110: sp   <= RAMOutData;
                                3'b111: ip   <= RAMOutData;
                                default:reg0 <= reg0;
                            endcase
                        end
                    end else begin
                        // mov
                        if (ROMData[13:10] == 4'b0010) begin
                            if (saveRes) begin
                                case(ROMData[5:3])    // TODO: fix magic numbers
                                    3'b000: reg0 <= secondOperand;
                                    3'b001: reg1 <= secondOperand;
                                    3'b010: reg2 <= secondOperand;
                                    3'b011: reg3 <= secondOperand;
                                    3'b100: reg4 <= secondOperand;
                                    3'b101: reg5 <= secondOperand;
                                    3'b110: sp   <= secondOperand;
                                    3'b111: ip   <= secondOperand;
                                    default:reg0 <= reg0;
                                endcase
                            end
                        end else begin
                            // makeJump <= 0;    // probably needed blocking
                            // movl moh movf, jumps
                            case (ROMData[13:9])
                                5'b00110: reg0[WIDTH-1:8] <= ROMData[8:1];
                                5'b00111: reg1[WIDTH-1:8] <= ROMData[8:1];
                                5'b01000: reg2[WIDTH-1:8] <= ROMData[8:1];
                                5'b01001: reg3[WIDTH-1:8] <= ROMData[8:1];
                                5'b01010: reg4[WIDTH-1:8] <= ROMData[8:1];
                                5'b01011: reg5[WIDTH-1:8] <= ROMData[8:1];
                                5'b01100: reg0[7:0]       <= ROMData[8:1];
                                5'b01101: reg1[7:0]       <= ROMData[8:1];
                                5'b01110: reg2[7:0]       <= ROMData[8:1];
                                5'b01111: reg3[7:0]       <= ROMData[8:1];
                                5'b10000: reg4[7:0]       <= ROMData[8:1];
                                5'b10001: reg5[7:0]       <= ROMData[8:1];
                                5'b10010: reg0 <= flags;
                                5'b10011: reg1 <= flags;
                                5'b10100: reg2 <= flags;
                                5'b10101: reg3 <= flags;
                                5'b10110: reg4 <= flags;
                                5'b10111: reg5 <= flags;
                                5'b11000: makeJump = flags[ZERO] == 1;
                                5'b11001: makeJump = flags[ZERO] == 0;
                                5'b11010: makeJump = flags[ZERO] == 0 && (flags[OVERFLOW] == flags[SIGN]);
                                5'b11011: makeJump = flags[OVERFLOW] == flags[SIGN];
                                5'b11100: makeJump = flags[OVERFLOW] != flags[SIGN];
                                5'b11101: makeJump = flags[ZERO] == 1 && (flags[OVERFLOW] != flags[SIGN]);
                                default: reg0 <= reg0;
                            endcase   
                        end
                    end
                end
            end
            // jump if condition is True
            if (makeJump) begin
                case(ROMData[5:3])    // TODO: fix magic numbers
                    3'b000: ip <= reg0;
                    3'b001: ip <= reg1;
                    3'b010: ip <= reg2;
                    3'b011: ip <= reg3;
                    3'b100: ip <= reg4;
                    3'b101: ip <= reg5;
                    3'b110: ip <= sp;
                    3'b111: ip <= ip;
                    default:ip <= ip;
                endcase
                makeJump = 0;
            end else begin
                ip <= ip + 1; 
            end
        end
    end

endmodule
