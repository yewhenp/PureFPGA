// istruction processor module
`include "ALU.v"
module InstructionProcessor #(
    parameter
    WIDTH=16,
    REGS_CODING=3,
    NOP=15'b1_0000_1011_00_00_00,
    CARRY=0,
    SIGN=1,
    OVERFLOW=2,
    ZERO=3
)
    (
    input clock,
    input [WIDTH-1:0]regData,
    input [REGS_CODING-1:0]regChoose,
    input [WIDTH-1:0]ROMData,
    // inout RAMData[WIDTH-1:0],
    output RAMWriteRead,
    output [WIDTH-2:0]instructionOut
);
    wire[3:0] ALUSel;
    wire[15:0] firstOperand, secondOperand, ALURes;
    wire cin, ALUCF, ALUSF, ALUOF, ALUZF, saveALURes;

    reg[14:0] coreInstr;
    reg[3:0] ALUSelReg = 4'b1111;
    reg[15:0] firstOperandReg=0, secondOperandReg=0, ALUResReg=0;
    reg cinReg, saveALUResReg;
    assign instructionOut = coreInstr;
    assign firstOperand = firstOperandReg;
    assign secondOperand = secondOperandReg;
    assign ALURes = ALUResReg;
    assign cin = cinReg;
    assign saveALURes = saveALUResReg;

    reg[15:0] reg0, reg1, reg2, reg3, reg4, reg5, sp, ip;
    reg[3:0] flags; // CF, SF, OF, ZF
    initial begin
        reg0 <= 0;
        reg1 <= 0;
        reg2 <= 0;
        reg3 <= 0;
        reg4 <= 0;
        reg5 <= 0;
        sp <= 0;
        ip <= 0;
        // cin <= 0;
        // saveALURes <= 0;
    end

    alu alu0 (
        .A(firstOperand),
        .B(secondOperand),
        .ALUSel(ALUSel),
        .CarryIn(cin),
        .clk(clock),
        .ALUOut(ALURes),
        .CarryOut(ALUCF),
        .SignOut(ALUSF),
        .OverflowOut(ALUOF),
        .ZeroOut(ALUZF)
    );

    always @ (posedge clock) begin
        // if it's time to write into registers
        if (regChoose) begin
            case(regChoose)
                3'b000: reg0 = regData;
                3'b001: reg1 = regData;
                3'b010: reg2 = regData;
                3'b011: reg3 = regData;
                3'b100: reg4 = regData;
                3'b101: reg5 = regData;
                3'b110: sp =   regData;
                3'b111: ip =   regData;
                default: ;
            endcase
        end else begin
            if (ROMData[0] == 1) begin
                coreInstr <= ROMData[WIDTH-1:1];
            end else begin
                coreInstr <= NOP;
                // alu command
                if (ROMData[1] == 1) begin
                    ALUSelReg <= ROMData[5:2];
                    case(ROMData[12:10])    // TODO: fix magic numbers
                        3'b000: firstOperandReg = reg0;
                        3'b001: firstOperandReg = reg1;
                        3'b010: firstOperandReg = reg2;
                        3'b011: firstOperandReg = reg3;
                        3'b100: firstOperandReg = reg4;
                        3'b101: firstOperandReg = reg5;
                        3'b110: firstOperandReg = sp;
                        3'b111: firstOperandReg = ip;
                        default: firstOperandReg = 0;
                    endcase
                    case(ROMData[15:13])    // TODO: fix magic numbers
                        3'b000: secondOperandReg = reg0;
                        3'b001: secondOperandReg = reg1;
                        3'b010: secondOperandReg = reg2;
                        3'b011: secondOperandReg = reg3;
                        3'b100: secondOperandReg = reg4;
                        3'b101: secondOperandReg = reg5;
                        3'b110: secondOperandReg = sp;
                        3'b111: secondOperandReg = ip;
                        default: secondOperandReg = 0;
                    endcase
                    // suffix
                    case(ROMData[9:6])    // TODO: fix magic numbers
                        4'b0000: saveALUResReg = flags[ZERO] == 1;
                        4'b0001: saveALUResReg = flags[ZERO] == 0;
                        4'b0010: saveALUResReg = flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
                        4'b0011: saveALUResReg = flags[SIGN] != flags[OVERFLOW];
                        4'b0100: saveALUResReg = flags[SIGN] == flags[OVERFLOW];
                        4'b0101: saveALUResReg = flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
                        4'b0110: saveALUResReg = flags[CARRY] == 1;
                        4'b0111: saveALUResReg = flags[CARRY] == 0;
                        4'b1000: saveALUResReg = flags[SIGN] == 1;
                        4'b1001: saveALUResReg = flags[SIGN] == 0;
                        4'b1010: saveALUResReg = 1;    // AL
                        4'b1011: saveALUResReg = 0;    // NV
                        4'b1100: saveALUResReg = flags[OVERFLOW] == 1;
                        4'b1101: saveALUResReg = flags[OVERFLOW] == 0;
                        4'b1110: saveALUResReg = flags[CARRY] == 1 && flags[ZERO] == 0;
                        4'b1111: saveALUResReg = flags[CARRY] == 0 || flags[ZERO] == 0;
                        default: saveALUResReg = 0;
                    endcase
                    // if suffix condition is true
                    if (saveALURes) begin
                        case(ROMData[12:10])    // TODO: fix magic numbers
                            3'b000: reg0 = ALURes;
                            3'b001: reg1 = ALURes;
                            3'b010: reg2 = ALURes;
                            3'b011: reg3 = ALURes;
                            3'b100: reg4 = ALURes;
                            3'b101: reg5 = ALURes;
                            3'b110: sp = ALURes;
                            3'b111: ip = ALURes;
                            default: reg0 = reg0;
                        endcase
                    end
                end
                ip = ip + 1;
            end

        end
    end

endmodule