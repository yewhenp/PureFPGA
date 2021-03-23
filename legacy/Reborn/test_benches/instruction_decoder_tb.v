`timescale 1 ns/10 ps
module instruction_decoder_tb();

localparam WIDTH = 32;
localparam FLAGS = 4;
localparam OPCODE = 4;
localparam REGS_CODING = 3;

reg clk = 0;
reg en = 0;
reg [WIDTH-1: 0] instruction = 0;
reg instr_choose = 0;
reg [FLAGS-1: 0] flags = 4'b0000;

//alu
wire                    alu_en;
wire [OPCODE-1 :0]      alu_opcode;
//mem
wire                    mem_en;
wire                    wren;
//move
wire                    move_en;
wire [WIDTH/2-1: 0]     immediate;
wire [2:0]              mov_type;  //000 - mov reg reg, 001 - movl 010 - movh, 011 - movf, 100 - jump

// alu + mem + move
wire [REGS_CODING-1: 0] op1;
wire [REGS_CODING-1: 0] op2;
wire                    suffix;

instr_decoder decoder(
    .clk(clk),
    .en(en),
    .long_instr(instruction),
    .instr_choose(instr_choose),
    .flags(flags),

    .alu_en(alu_en),
    .alu_opcode(alu_opcode),
    .mem_en(mem_en),
    .wren(wren),
    .move_en(move_en),
    .immediate(immediate),
    .mov_type(mov_type),
    .op1(op1),
    .op2(op2),
    .suffix(suffix)
);

initial begin
    $display("Testing instruciton decoder...");

    $display("disabled");
    #10;
    #10;

    $display("ALU instructions");
    en = 1;
    instruction = 32'b01_0000_1010_000_010__01_0000_1010_010_011;   // add reg0 reg2; add reg2 reg3
    instr_choose = 0;
    #10;
    instr_choose = 1;
    #10;

    instr_choose = 0;
    instruction = 32'b01_0100_1010_000_010__01_1001_0001_010_011;   // mul reg0 reg2; lshne reg2 reg3
    #10;
    instr_choose = 1;
    #10;

    $display("Mov immediate");
    // movl
    instr_choose = 0;
    
    $stop();



end

always #5 clk = ~clk;

endmodule
