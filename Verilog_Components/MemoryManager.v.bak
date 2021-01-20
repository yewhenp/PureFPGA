module memory_manager 
#(parameter WIDTH=16,
            ADDR_SPACE=22,
            NUM_CORES=64,
            NUM_REGS=8,
            REGS_CODIND=3,
            CORE_CODIND=6)
   (	
	input [WIDTH - 1:0]data, 
	input [ADDR_SPACE - 1:0]address,
	input wren_in,
	input clk,
	output [WIDTH - 1:0]core_data,
	output [WIDTH - 1:0]core_address,
	output wren_out,
    output reg [NUM_REGS - 1:0]reg_en,
	output reg [NUM_CORES - 1:0]core_en
	);
  wire [NUM_CORES - 1:0]cores;
  wire [NUM_REGS - 1:0]regs;
  assign core_data = data;
  assign core_address = address[ADDR_SPACE - 1:CORE_CODIND];
  assign wren_out = wren_in;
  decoder64 d1(.data(address[CORE_CODIND - 1:0]), .eq63(cores));
  decoder8 d2(.data(address[REGS_CODIND - 1:0]), .eq7(regs));
  always @(posedge clk) begin
    if(address > (2 << 22 - 8)) begin
        core_en = 0;
        reg_en = regs;
      end 
      else begin
        reg_en = 0;
        core_en = cores;
      end
    end
  	

endmodule