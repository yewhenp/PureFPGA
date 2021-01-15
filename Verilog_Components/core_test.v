`timescale 1 ns/10 ps 
module core_test;

localparam DATA_WIDTH=16;
localparam ADDRESS_WIDTH=16;
localparam INSTRUCTION_WIDTH=15;

reg	clk = 0;
reg [INSTRUCTION_WIDTH-1:0]	instruction = 15'b1_0000_1011_00_00_00;
wire [DATA_WIDTH-1:0]	data;
reg [DATA_WIDTH-1:0]	data_in;
wire [DATA_WIDTH-1:0]	data_out;
reg [ADDRESS_WIDTH-1:0]	address;
reg 	wren = 1;
reg 	cpen = 1;

assign data_out = data;
assign data = (wren & cpen) ? data_in : 16'bZ;


core cooree (
	.data(data), 
	.address(address),
	.instruction(instruction),
	.bufferAddress(0),
	.wren(wren),
	.cpen(cpen),
	.clk(clk),
	.clk_buffer(clk),
	.bufferData()
);

initial begin
    $display("Testing writing into memory");
    $display("Load 0 to address 0");
	 
	 address = 16'b0000000000000000;
	 data_in = 16'b0100000000000000;
	 #10;
	 
	 address = 16'b0000000000000001;
	 data_in = 16'b0000000111000000;
	 #10;
	 
	 $display("Testing reading into memory");
	 
	 address = 16'b0000000000000000;
	 wren = 0;
	 #10;
	 
	 address = 16'b0000000000000001;
	 #10;
	 
	 $display("Testing instruction execution");
	 
end

always #10 clk = ~clk;

endmodule 