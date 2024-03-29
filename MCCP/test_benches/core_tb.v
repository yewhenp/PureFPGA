`timescale 1 ns/10 ps
module core_tb();

localparam WIDTH=32;


reg                   clk = 1;
reg						 response = 0;
wire						 request;
wire						 wren;
reg [WIDTH-1: 0]      instruction;
reg [WIDTH-1: 0]      readdata = 0;
wire [WIDTH-1: 0]      address;
wire[WIDTH-1: 0]      writedata;
wire[WIDTH-1: 0]      instr_addr;


core core_inst
(
	.clk(clk) ,	// input  clk_sig
	.response(response) ,	// input  response_sig
	.instruction(instruction) ,	// input [WIDTH-1:0] instruction_sig
	.wren(wren) ,	// output  wren_sig
	.request(request) ,	// output  request_sig
	.readdata(readdata) ,	// input [WIDTH-1:0] readdata_sig
	.address(address) ,	// output [WIDTH-1:0] address_sig
	.writedata(writedata) ,	// output [WIDTH-1:0] writedata_sig
	.instr_addr(instr_addr) 	// output [WIDTH-1:0] instr_addr_sig
);


initial begin
    
	 #10
	 // mov lov imm = 7 to reg 0
	 instruction <= 32'b10_01100_1010_00000_0000000000000111;
	 
	 #40
	 // mov high imm = 0 to reg 0
	 instruction <= 32'b10_00110_1010_00000_0000000000000000;
	 
	 #40
	 // mov lov imm = 13 to reg 1
	 instruction <= 32'b10_01101_1010_00000_0000000000001101;
	 
	 #40
	 // mov high imm = 0 to reg 1
	 instruction <= 32'b10_00111_1010_00000_0000000000000000;
	 
	 #40
	 // add reg0 reg1; mul reg0 reg1
	 instruction <= 32'b01_0000_1010_000_001__01_0100_1010_000_001;
	 
	 #80
	 // mov lov imm = 1 to reg 2
	 instruction <= 32'b10_01110_1010_00000_0000000000000001;
	 
	 #40
	 // mov high imm = 0 to reg 2
	 instruction <= 32'b10_01000_1010_00000_0000000000000000;
	 
	 
	 #40
	 // store reg0 to memory (address = reg2); mov reg0 reg1
	 instruction <= 32'b00_0001_1010_000_010__00_0010_1010_000_001;
	 
	 
	 #80
	 // load reg3 (address = reg1); div reg1 reg3
	 instruction <= 32'b00_0000_1010_011_001__01_0101_1010_001_011;
	 
	 #150
	 readdata <= 32'b00000000000000000000000000000010;
	 response <= 1;
	 
	 #40
	 response <= 0;
	 
	 #20
	 // sub reg0 reg0; add reg0 ip if eq
	 instruction <= 32'b01_0010_1010_000_000__01_0000_0000_000_111;
	 
	 #80
	 // sub reg0 reg0; je reg1
	 instruction <= 32'b01_0010_1010_000_000__00_1100_0000_001_000;
	 
	 #80
	 // nop; nop
	 instruction <= 32'b01_0000_1011_000_000__01_0000_1011_000_000;
	 
	 #160
    $stop;

end

always #5 clk = ~clk;

endmodule 