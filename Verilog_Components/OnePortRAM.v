module OnePortRAM
#(parameter DATA_WIDTH=16,
            ADDR_SPACE=16)
	(
    output[DATA_WIDTH - 1:0] q,
    input [ADDR_SPACE - 1:0] address,
<<<<<<< HEAD
    input [DATA_WIDTH - 1:0] data, 
    input wren,
    input clock);

    reg [DATA_WIDTH - 1:0] memory [0:(1 << ADDR_SPACE) - 1];
=======
    input [DATA_WIDTH-1:0] data, 
    input wren,
    input clock);
		
    reg [DATA_WIDTH-1:0] memory [0:(1 << ADDR_SPACE) - 1];
>>>>>>> e355c8b426a777e913b516ea784c0cec91f5b9c9

    always @(posedge clock) begin
        if (wren) begin
            memory[address] <= data;
        end
	//	  q <= memory[address];

    end

    assign q = memory[address];

endmodule