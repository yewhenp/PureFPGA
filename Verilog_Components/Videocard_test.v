`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module Videocard_test;
   localparam DATA_WIDTH	=8;
	localparam ADDRESS_WIDTH=23;
	localparam CORE_WIDTH	=16;
	
	reg 	wren, clk;
	reg	[ADDRESS_WIDTH - 1:0] address;
	
	wire	[DATA_WIDTH-1:0] data;
	reg 	[DATA_WIDTH-1:0] data_tx;
	wire	[DATA_WIDTH-1:0] data_rx;
	
	assign data = wren ? data_tx : 8'bZ;
	assign data_rx = data;
	
	integer i = 0;
	 
	 Components videocard
(
	.wren(wren) ,	
	.clk(clk) ,	
	.adress(address) ,	
	.data(data)	
);

    initial
	 
    begin 
		clk = 1;
		
		wren = 1; // enable writing
		for(i = 0; i<1280; i = i + 1) begin
			// [8-bit on odd][8-bit on even] = [16-bit memory cell]
			address = i;
			data_tx = (i & 1) ? 0 : i % 128;
			#20;	
		end
		
		
		address = 23'b11111111111111111111110;
		
		data_tx = 4;
		#10;
		wren = 0;
		#1005;
		
		address = 0; // set read pointer at the beginning
		for(i = 0; i<1280; i = i + 2) begin
			address = i; // on even read LS byte, on odd read MS byte
			#20;	
		end
		#40;
		$stop;
		
    end
	 always #5 clk = ~clk;
endmodule


