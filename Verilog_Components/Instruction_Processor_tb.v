module InstructionProcessorTB();

localparam WIDTH=16;
localparam REGS_CODING=8;
localparam NOP=15'b1_0000_1011_00_00_00;   // addnv reg0, reg0

reg                   clk = 0;
reg [REGS_CODING-1:0] regChoose = 0;
reg [WIDTH-1: 0]      ROMData = NOP, regData = 0;
wire[WIDTH-2: 0]      instructionOut;
wire[WIDTH-1: 0]      ROMAddress;

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

    $stop;


end

InstructionProcessor IP (
    .clock(clk), 
	 .regData(regData), 
	 .regChoose(regChoose), 
	 .ROMData(ROMData), 
    .instructionOut(instructionOut), 
	 .ROMAddress(ROMAddress)
);

always begin
    #5 clk = ~clk;
end

endmodule 