module OnePortRAM
#(parameter DATA_WIDTH=16,
            ADDR_SPACE=16)
	(
    output reg[DATA_WIDTH - 1:0] q,
    input [ADDR_SPACE - 1:0] address,
    input [DATA_WIDTH-1:0] data, 
    input wren,
    input clock);
		
    reg [DATA_WIDTH-1:0] memory [0:(1 << ADDR_SPACE) - 1];

    always @(posedge clock) begin
        if (wren) begin
            memory[address] <= data;
        end
		  q <= memory[address];

    end

    //assign q = memory[address];

endmodule