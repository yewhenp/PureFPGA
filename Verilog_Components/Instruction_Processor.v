// istruction processor module
`include "ALU.v"
module InstructionProcessor #(
    parameter
    WIDTH=16,
    REGS_CODING=3,
    NOP=15'b1_0000_1011_00_00_00,   // addnv reg0, reg0
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
    wire[15:0] ALURes;
    wire ALUCF, ALUSF, ALUOF, ALUZF;

    reg[14:0] coreInstr;
    reg[3:0] ALUSel = 4'b1111;
    reg[15:0] firstOperand=0, secondOperand=0, ALUResReg=0;
    reg cinReg, saveALURes;

    assign instructionOut = coreInstr;
    assign ALURes = ALUResReg;

    reg[15:0] reg0, reg1, reg2, reg3, reg4, reg5, sp, ip, flags; // CF, SF, OF, ZF

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
                3'b110: sp   = regData;
                3'b111: ip   = regData;
                default:reg0 = reg0;
            endcase
        end else begin
            if (ROMData[0] == 1) begin
                coreInstr <= ROMData[WIDTH-1:1];
            end else begin
                coreInstr <= NOP;
                // alu command
                if (ROMData[1] == 1) begin
                    ALUSel <= ROMData[5:2];
                    case(ROMData[12:10])    // TODO: fix magic numbers
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
                    case(ROMData[15:13])    // TODO: fix magic numbers
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
                    // suffix
                    case(ROMData[9:6])    // TODO: fix magic numbers
                        4'b0000: saveALURes = flags[ZERO] == 1;
                        4'b0001: saveALURes = flags[ZERO] == 0;
                        4'b0010: saveALURes = flags[ZERO] == 0 && flags[SIGN] == flags[OVERFLOW];
                        4'b0011: saveALURes = flags[SIGN] != flags[OVERFLOW];
                        4'b0100: saveALURes = flags[SIGN] == flags[OVERFLOW];
                        4'b0101: saveALURes = flags[ZERO] == 1 || flags[SIGN] != OVERFLOW;
                        4'b0110: saveALURes = flags[CARRY] == 1;
                        4'b0111: saveALURes = flags[CARRY] == 0;
                        4'b1000: saveALURes = flags[SIGN] == 1;
                        4'b1001: saveALURes = flags[SIGN] == 0;
                        4'b1010: saveALURes = 1;    // AL
                        4'b1011: saveALURes = 0;    // NV
                        4'b1100: saveALURes = flags[OVERFLOW] == 1;
                        4'b1101: saveALURes = flags[OVERFLOW] == 0;
                        4'b1110: saveALURes = flags[CARRY] == 1 && flags[ZERO] == 0;
                        4'b1111: saveALURes = flags[CARRY] == 0 || flags[ZERO] == 0;
                        default: saveALURes = 0;
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
                            default: ;
                        endcase
                        // cin if addc subc or mulc
                        case(ROMData[5:2])
                            4'b0001, 4'b0011, 4'b0101: cinReg <= 1;
                            default: cinReg <= 0;
                        endcase
                        flags[CARRY]    <= ALUCF;
                        flags[SIGN]     <= ALUSF;
                        flags[OVERFLOW] <= ALUOF;
                        flags[ZERO]     <= ALUZF;
                    end
                end
            end
            ip = ip + 1;
        end
    end

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

endmodule