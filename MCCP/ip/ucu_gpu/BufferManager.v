module buffer_manager 
#(parameter WIDTH=16,
            COORDINATES=10,
				RED=6,
				GREEN=5,
				BLUE=5,
            SCREEN_W=800,
				ADDRESS_WIDTH=19)
   (	
	input [COORDINATES - 1:0]x, 
	input [COORDINATES - 1:0]y, 
	input on_air,
	input clk,
	input [WIDTH - 1: 0]data,
	output reg [ADDRESS_WIDTH - 1:0]address,
   output reg [RED - 1:0]red,
	output reg [GREEN - 1:0]green,
	output reg [BLUE - 1:0]blue
	);
	always @(posedge clk) begin
		address = y * SCREEN_W + x;
	end
	always @* begin
		red = (on_air) ? data[WIDTH - 1: WIDTH - RED] : 0;
		green = (on_air) ? data[WIDTH - RED - 1: WIDTH - RED - GREEN] : 0;
		blue = (on_air) ? data[BLUE - 1: 0] : 0;
	end
endmodule