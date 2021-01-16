`timescale 1 ns/10 ps
module Instruction_Processor_tb();

localparam WIDTH=16;
localparam REGS_CODING=8;
localparam NOP=15'b1_0000_1011_00_00_00;   // addnv reg0, reg0

reg                   clk = 0;
reg [REGS_CODING-1:0] regChoose = 0;
reg [WIDTH-1: 0]      ROMData = NOP, regData = 0;
wire[WIDTH-2: 0]      instructionOut;
wire[WIDTH-1: 0]      ROMAddress;

InstructionProcessor IP (
   .clock(clk), 
	.regData(regData), 
	.regChoose(regChoose), 
	.ROMData(ROMData), 
   .instructionOut(instructionOut), 
	.ROMAddress(ROMAddress)
);



initial begin
    $display("Testing writing into registers");
    $display("Load 0 to ip register");

    regChoose = 8'b10000000;
    regData = 0;
    #10;

    $display("load 10 to reg2 register");
    regChoose = 8'b00000100;
    regData = 10;
    #10;

    $display("load 65535 to sp");
    regChoose = 8'b01000000;
    regData = 65535;
    #10;

    $display("Core instruction execution");
    regChoose = 0;
    regData = 0;
    ROMData = 16'b11_0000_1010_00_00_01;  // addal reg0, reg0, reg1
    #10;
    
    ROMData = 16'b10_01010_111111110;     // movl reg0 255
    #10;

    $display("Instruction processor execution");
    $display("reg0 = 13");
    regChoose = 8'b00000001;
    regData = 13;
    #10;
    regChoose = 0;
    ROMData = 16'b01_0000_1010_000_010;  // add reg0, reg2
    #10;
 
    ROMData = 16'b01_0000_1010_000_010;  // add reg0, reg2
    #10;
    
    ROMData = 16'b01_0100_1010_000_010; // mul reg0, reg2
    #10;

    ROMData = 16'b00_01101_111111100;    // movli reg1 254
    #10;

    ROMData = 16'b00_00011_010_001_000;  // store reg1, reg0
    #10;

    ROMData = 16'b00_00001_010_011_000;  // load reg3, reg0
    #10

    $stop;

end

always #5 clk = ~clk;

endmodule 