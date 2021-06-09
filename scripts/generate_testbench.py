from argparse import ArgumentParser

HEADER = """`timescale 1 ns/10 ps
module XXX_XXX();

localparam WIDTH=32;


reg clk = 0;
reg clk_rom = 0;
reg [WIDTH/2: 0] address = 16'b0;
reg [WIDTH-1: 0] data_in = 16'b0;
wire [WIDTH-1: 0] data_out;
reg wren = 1'b0;

reg [2:0] address_control = 3'b000;
reg [WIDTH-1: 0] data_in_control = 32'b0;
wire [WIDTH-1: 0] data_out_control;
reg wren_control = 1'b0;


videocard_top videocard_top_inst
(
	.clk(clk) ,	// input  clk_sig
	.clk_rom(clk_rom) ,	// input  clk_hps_sig
    .clk_hps(clk_rom),
	.data_in(data_in) ,	// input [WIDTH-1:0] data_in_sig
	.data_out(data_out) ,	// output [WIDTH-1:0] data_out_sig
	.address(address) ,	// input [WIDTH/2-1:0] address_sig
	.byteenable(4'b1111) ,	// input [BYTES-1:0] byteenable_sig
	.write(wren) ,	// input  write_sig
	.read(1'b1) ,	// input  read_sig
	.reset_sink_reset(1'b0) ,	// input  reset_sink_reset_sig
	.data_out_control(data_out_control),
	.data_in_control(data_in_control),
	.read_control(~wren_control),
	.write_control(wren_control),
	.address_control(address_control)
);"""

FOOTER = """
// wait for the videocard to finish
    #15000
	address <= 0;
// read RAM
	#40
	address <= 1;
	
	#40
	address <= 2;
	
	#40
	address <= 3;

	#40
	address <= 4;

	#40
	address <= 5;
	
	#40
	address <= 6;
	
	#40
	address <= 7;
	
	#40
	address <= 8;
	
	#40
	address <= 9;
	
	#40
	address <= 10;

	#40
	address <= 11;
	
	#40
	address <= 12;
	
	#40
	address <= 13;
	
	#40
	address <= 14;
	
	#200
   $stop;

end

always #5 clk = ~clk;
always #1 clk_rom = ~clk_rom;

endmodule"""

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--binary', help="Program to load to meemory", type=str, required=True)
    parser.add_argument('--out', help="path to output file", type=str, required=True)

    args = parser.parse_args()
    module_name = args.out.split(".")[0]
    HEADER = HEADER.replace("XXX_XXX", module_name)

    result = HEADER
    result += "\n//Fill the ROM\ninitial begin\n" \
              "    #200\n" \
              "    wren <= 1;\n"

    address = 65536
    for line in open(args.binary, 'r'):
        line = line.strip()
        result += "\n"
        result += "    #40\n"
        result += "    address <= {};\n".format(address)
        result += "    data_in <= 32'b{};\n".format(line)
        address += 1
        line = line.strip()

    result += """
    #40
    wren <= 0;
    
	#40
	wren_control <= 1;
	address_control <= 0;
	data_in_control <= 1;
	
	#20
	wren_control <= 0;
	address_control <= 1;
	data_in_control <= 0;
"""
    result += FOOTER

    with open(args.out, 'w') as out_file:
        out_file.write(result)

    # print(result)
