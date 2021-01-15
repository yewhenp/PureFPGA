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

    reg[14:0] coreInstr;
    reg[3:0] ALUSel = 4'b1111;
    reg[WIDTH-1:0] firstOperand=0, secondOperand=0, RAMAddress=0, RAMData=0;
    reg cinReg, saveRes, wren;

    assign instructionOut = coreInstr;
    assign cin = cinReg;
	 

    reg[WIDTH-1:0] reg0, reg1, reg2, reg3, reg4, reg5, sp, ip, flags; // CF, SF, OF, ZF
	 assign ROMAddress = ip;
    alu alu0 (
        .A(firstOperand),
        .B(secondOperand),
        .ALUSel(ALUSel),
        .CarryIn(cin),
        .clk(clock),
        .ALU_Out(ALURes),
        .CarryOut(ALUCF),
        .SignOut(ALUSF),
        .OverflowOut(ALUOF),
        .ZeroOut(ALUZF)
    );

    RAM_1 ram1(
        .address(RAMAddress),
        .clock(clock),
        .data(RAMData),
        .wren(wren),
        .q(RAMOutData)
    );

    always @ (posedge clock) begin
        // if it's time to write into registers
        if (regChoose) begin
            case(regChoose)
                8'b00000001: reg0 = regData;
                8'b00000010: reg1 = regData;
                8'b00000100: reg2 = regData;
                8'b00001000: reg3 = regData;
                8'b00010000: reg4 = regData;
                8'b00100000: reg5 = regData;
                8'b01000000: sp   = regData;
                8'b10000000: ip   = regData;
                default:     reg0 = reg0;
            endcase
        end else begin
            if (ROMData[0] == 1) begin
                coreInstr <= ROMData[WIDTH-2:0];
            end else begin
                coreInstr <= NOP;
                // suffix
                case(ROMData[9:6])    // TODO: fix magic numbers
                    4'b0000: saveRes = flags[ZERO] == 1;
                    4'b0001: saveRes = flags[ZERO] == 0;
                    4'b0010: saveRes = flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
                    4'b0011: saveRes = flags[SIGN] != flags[OVERFLOW];
                    4'b0100: saveRes = flags[SIGN] == flags[OVERFLOW];
                    4'b0101: saveRes = flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
                    4'b0110: saveRes = flags[CARRY] == 1;
                    4'b0111: saveRes = flags[CARRY] == 0;
                    4'b1000: saveRes = flags[SIGN] == 1;
                    4'b1001: saveRes = flags[SIGN] == 0;
                    4'b1010: saveRes = 1;    // AL
                    4'b1011: saveRes = 0;    // NV
                    4'b1100: saveRes = flags[OVERFLOW] == 1;
                    4'b1101: saveRes = flags[OVERFLOW] == 0;
                    4'b1110: saveRes = flags[CARRY] == 1 && flags[ZERO] == 0;
                    4'b1111: saveRes = flags[CARRY] == 0 || flags[ZERO] == 0;
                    default: saveRes = 0;
                endcase
                case(ROMData[5:3])    // TODO: fix magic numbers
                    3'b000: firstOperand = reg0;
                    3'b001: firstOperand = reg1;
                    3'b010: firstOperand = reg2;
                    3'b011: firstOperand = reg3;
                    3'b100: firstOperand = reg4;
                    3'b101: firstOperand = reg5;
                    3'b110: firstOperand = sp;
                    3'b111: firstOperand = ip;
                    default: firstOperand = 0;
                endcase
                case(ROMData[2:0])    // TODO: fix magic numbers
                    3'b000: secondOperand = reg0;
                    3'b001: secondOperand = reg1;
                    3'b010: secondOperand = reg2;
                    3'b011: secondOperand = reg3;
                    3'b100: secondOperand = reg4;
                    3'b101: secondOperand = reg5;
                    3'b110: secondOperand = sp;
                    3'b111: secondOperand = ip;
                    default: secondOperand = 0;
                endcase
                // alu command
                if (ROMData[1] == 1) begin
                    ALUSel <= ROMData[13:10];
                    // if suffix condition is true
                    if (saveRes) begin
                        case(ROMData[5:3])    // TODO: fix magic numbers
                            3'b000: reg0 = ALURes;
                            3'b001: reg1 = ALURes;
                            3'b010: reg2 = ALURes;
                            3'b011: reg3 = ALURes;
                            3'b100: reg4 = ALURes;
                            3'b101: reg5 = ALURes;
                            3'b110: sp   = ALURes;
                            3'b111: ip   = ALURes;
                            default: ;
                        endcase
                        // cin if addc subc or mulc
                        case(ROMData[13:10])
                            4'b0001, 4'b0011, 4'b0101: cinReg <= 1;
                            default: cinReg <= 0;
                        endcase
                        flags[CARRY]    <= ALUCF;
                        flags[SIGN]     <= ALUSF;
                        flags[OVERFLOW] <= ALUOF;
                        flags[ZERO]     <= ALUZF;
                    end
                end else begin
                    // loadi0 / loadi1
                    if (ROMData[13:10] == 4'b0000) begin
                        if (saveRes) begin
                            wren <= 0;
                            RAMAddress <= secondOperand;
                            case(ROMData[5:3])    // TODO: fix magic numbers
                                3'b000: reg0 = RAMOutData;
                                3'b001: reg1 = RAMOutData;
                                3'b010: reg2 = RAMOutData;
                                3'b011: reg3 = RAMOutData;
                                3'b100: reg4 = RAMOutData;
                                3'b101: reg5 = RAMOutData;
                                3'b110: sp   = RAMOutData;
                                3'b111: ip   = RAMOutData;
                                default:reg0 = reg0;
                            endcase
                        end
                    end else begin
                        // store
                        if (ROMData[13:10] == 4'b0001) begin
                            if (saveRes) begin
                                wren <= 1;
                                RAMAddress <= secondOperand;
                                case(ROMData[5:3])    // TODO: fix magic numbers
                                    3'b000: RAMData <= reg0;
                                    3'b001: RAMData <= reg1;
                                    3'b010: RAMData <= reg2;
                                    3'b011: RAMData <= reg3;
                                    3'b100: RAMData <= reg4;
                                    3'b101: RAMData <= reg5;
                                    3'b110: RAMData <= sp;
                                    3'b111: RAMData <= ip;
                                    default: RAMData <= 0;
                                endcase
                            end
                        // move
                        end else begin
                            if (ROMData[13:10] == 4'b0010) begin
                                if (saveRes) begin
                                    case(ROMData[5:3])    // TODO: fix magic numbers
                                        3'b000: reg0 = secondOperand;
                                        3'b001: reg1 = secondOperand;
                                        3'b010: reg2 = secondOperand;
                                        3'b011: reg3 = secondOperand;
                                        3'b100: reg4 = secondOperand;
                                        3'b101: reg5 = secondOperand;
                                        3'b110: sp   = secondOperand;
                                        3'b111: ip   = secondOperand;
                                        default:reg0 = reg0;
                                    endcase
                                end
                            end else begin
                                saveRes = 0;
                                // movl moh movf, jumps
                                case (ROMData[13:9])
                                    00110: reg0[WIDTH-1:8] = ROMData[8:1];
                                    00111: reg1[WIDTH-1:8] = ROMData[8:1];
                                    01000: reg2[WIDTH-1:8] = ROMData[8:1];
                                    01001: reg3[WIDTH-1:8] = ROMData[8:1];
                                    01010: reg4[WIDTH-1:8] = ROMData[8:1];
                                    01011: reg5[WIDTH-1:8] = ROMData[8:1];
                                    01100: reg0[7:0]       = ROMData[8:1];
                                    01101: reg1[7:0]       = ROMData[8:1];
                                    01110: reg2[7:0]       = ROMData[8:1];
                                    01111: reg3[7:0]       = ROMData[8:1];
                                    10000: reg4[7:0]       = ROMData[8:1];
                                    10001: reg5[7:0]       = ROMData[8:1];
                                    10010: reg0 = flags;
                                    10011: reg1 = flags;
                                    10100: reg2 = flags;
                                    10101: reg3 = flags;
                                    10110: reg4 = flags;
                                    10111: reg5 = flags;
                                    11000: saveRes = flags[ZERO] == 1;
                                    11001: saveRes = flags[ZERO] == 0;
                                    11010: saveRes = flags[ZERO] == 0 && (flags[OVERFLOW] == flags[SIGN]);
                                    11011: saveRes = flags[OVERFLOW] == flags[SIGN];
                                    11100: saveRes = flags[OVERFLOW] != flags[SIGN];
                                    11101: saveRes = flags[ZERO] == 1 && (flags[OVERFLOW] != flags[SIGN]);
                                    default: reg0 = reg0;
                                endcase
                                // jump if condition is True
                                if (saveRes) begin
                                    ip <= firstOperand;
                                end
                            end
                        end 
                    end

                end
            ip = ip + 1;
            end
        end
    end

endmodule

// task movelLowestEightBits;
//     input[WIDTH-1:0]  originalContent;
//     input[7:0]        bits;
//     output[WIDTH-1:0] res;



// endtask