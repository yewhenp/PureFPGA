module four_way_rom #(
 parameter
 WIDTH=32
)(
input clk,
input [WIDTH-1: 0] address_core0,
input [WIDTH-1: 0] address_core1,
input [WIDTH-1: 0] address_core2,
input [WIDTH-1: 0] address_core3,
output reg [WIDTH-1: 0] data_core0,
output reg [WIDTH-1: 0] data_core1,
output reg [WIDTH-1: 0] data_core2,
output reg [WIDTH-1: 0] data_core3
);


reg [WIDTH-1: 0] data [511: 0];

always @ (posedge clk) begin
	 // mov lov imm = 7 to reg 0
	 data[0] <= 32'b10_01100_1010_00000_0000000000000111;
	 
	 // mov high imm = 0 to reg 0
	 data[1] <= 32'b10_00110_1010_00000_0000000000000000;
	 
	 // mov lov imm = 13 to reg 1
	 data[2] <= 32'b10_01101_1010_00000_0000000000001101;
	 
	 // mov high imm = 0 to reg 1
	 data[3] <= 32'b10_00111_1010_00000_0000000000000000;
	 
	 // add reg0 reg1; mul reg0 reg1
	 data[4] <= 32'b01_0000_1010_000_001__01_0100_1010_000_001;
	 
	 // mov lov imm = 1 to reg 2
	 data[5] <= 32'b10_01110_1010_00000_0000000000000001;
	 
	 // mov high imm = 0 to reg 2
	 data[6] <= 32'b10_01000_1010_00000_0000000000000000;
	 
	 // store reg0 to memory (address = reg2); mov reg0 reg1
	 data[7] <= 32'b00_0001_1010_000_010__00_0010_1010_000_001;
	 
	 // load reg3 (address = reg2); div reg3 reg1
	 data[8] <= 32'b00_0000_1010_011_010__01_0101_1010_011_001;

	 // sub reg0 reg0; add reg0 ip if eq
	 data[9] <= 32'b01_0010_1010_000_000__01_0000_0000_000_111;
	 
	 // sub reg0 reg0; je reg1
	 data[10] <= 32'b01_0010_1010_000_000__00_1100_0000_001_000;
	 
	 // nop; nop
	 data[11] <= 32'b01_0000_1011_000_000__01_0000_1011_000_000;

	 data_core0 = data[address_core0];
	 data_core1 = data[address_core1];
	 data_core2 = data[address_core2];
	 data_core3 = data[address_core3];
	
end

endmodule
