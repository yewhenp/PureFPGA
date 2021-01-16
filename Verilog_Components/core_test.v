`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

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

	assign data = (wren & cpen) ? data_in : 16'bZ;
	assign data_out = data;

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
	
	integer i = 0;

	initial begin
		$display("Testing writing into memory");
		 
		 address = 16'b0000000000000000;
		 data_in = 16'b0000000000000111;
		 #20;
//		 
//		 address = 16'b0000000000000001;
//		 data_in = 16'b0000000111000000;
//		 #10;
//		 
//		 $display("Testing reading into memory");
//		 
//		 address = 16'b0000000000000000;
//		 wren = 0;
//		 #10;
//		 
//		 address = 16'b0000000000000001;
//		 #10;
//		 

//		for(i = 0; i<10; i = i + 1) begin
//			address = i;
//			data_in = i + 5;
//			#10;
//		end
//		#20;
		
		wren = 0;
		#20;
		
		$display("Testing instruction execution");
		
//		
//		// mov 7 to reg 0
//		instruction = 15'b0_01010_00000111_0;
//		#20;
//		
//		instruction = 15'b0_00110_00000000_0;
//		#20;
//		
//		// mov 13 to reg 1
//		instruction = 15'b0_01011_00001101_0;
//		#20;
//		
//		instruction = 15'b0_00111_00000000_0;
//		#20;
//		
//		// add reg0+reg1, save to reg2
//		instruction = 15'b1_0100_1010_10_00_01;
//		#20;
//		
//		// mov 1 to reg3
//		instruction = 15'b0_01101_00000001_0;
//		#20;
//		
//		instruction = 15'b0_01001_00000000_0;
//		#20;
//		
//		// store reg2 to memory (addres = reg3)
//		instruction = 15'b0_00011_010_10_11_00;
//		#20;

		// movl reg0 0
		instruction = 15'b0_01010_000000000;
		#20;

		// load reg1 reg0
		instruction = 15'b0_00001_010010000;
		#20;

		// mov reg2 reg1
		instruction = 15'b0_00101_010_10_01_00;
		#20;

		// add reg1 reg2 reg1
		instruction = 15'b1_0000_1010_11_10_01;
		#20;

		// store reg1 reg0
		instruction = 15'b0_00011_010_11_00_00;
		#20;

		// nop
		instruction = 15'b1_0000_1011_00_00_00;
		address = 0;
		#40;
		
//		for(i = 0; i<10; i = i + 1) begin
//			address = i;
//			#10;
//		end

		
		 
	end

	always #5 clk = ~clk;

endmodule 