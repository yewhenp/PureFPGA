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
);
	initial begin
    #200
    wren_control <= 0;
    address_control <= 1;

    #40
    wren <= 1;
address <= 0;
data_in <= 5;
#40
address <= 1;
data_in <= 45;
#40
address <= 2;
data_in <= 4;
#40
address <= 3;
data_in <= 10;
#40
address <= 4;
data_in <= 3;
#40
address <= 5;
data_in <= 1;
#40
address <= 6;
data_in <= 2;
#40
address <= 7;
data_in <= 3;
#40
address <= 8;
data_in <= 4;
#40
address <= 9;
data_in <= 5;
#40
address <= 10;
data_in <= 6;
#40
address <= 11;
data_in <= 7;
#40
address <= 12;
data_in <= 8;
#40
address <= 13;
data_in <= 9;
#40
address <= 14;
data_in <= 10;
#40
address <= 15;
data_in <= 11;
#40
address <= 16;
data_in <= 12;
#40
address <= 17;
data_in <= 13;
#40
address <= 18;
data_in <= 14;
#40
address <= 19;
data_in <= 15;
#40
address <= 20;
data_in <= 16;
#40
address <= 21;
data_in <= 17;
#40
address <= 22;
data_in <= 18;
#40
address <= 23;
data_in <= 19;
#40
address <= 24;
data_in <= 20;
#40
address <= 25;
data_in <= 21;
#40
address <= 26;
data_in <= 22;
#40
address <= 27;
data_in <= 23;
#40
address <= 28;
data_in <= 24;
#40
address <= 29;
data_in <= 25;
#40
address <= 30;
data_in <= 26;
#40
address <= 31;
data_in <= 27;
#40
address <= 32;
data_in <= 28;
#40
address <= 33;
data_in <= 29;
#40
address <= 34;
data_in <= 30;
#40
address <= 35;
data_in <= 31;
#40
address <= 36;
data_in <= 32;
#40
address <= 37;
data_in <= 33;
#40
address <= 38;
data_in <= 34;
#40
address <= 39;
data_in <= 35;
#40
address <= 40;
data_in <= 36;
#40
address <= 41;
data_in <= 37;
#40
address <= 42;
data_in <= 38;
#40
address <= 43;
data_in <= 39;
#40
address <= 44;
data_in <= 40;
#40
"""

FOOTER = """
// wait for the videocard to finish
    #150000
	#40
	address <= 0;
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
	#40
	address <= 15;
	#40
	address <= 16;
	#40
	address <= 17;
	#40
	address <= 18;
	#40
	address <= 19;
	#40
	address <= 20;
	#40
	address <= 21;
	#40
	address <= 22;
	#40
	address <= 23;
	#40
	address <= 24;
	#40
	address <= 25;
	#40
	address <= 26;
	#40
	address <= 27;
	#40
	address <= 28;
	#40
	address <= 29;
	#40
	address <= 30;
	#40
	address <= 31;
	#40
	address <= 32;
	#40
	address <= 33;
	#40
	address <= 34;
	#40
	address <= 35;
	#40
	address <= 36;
	#40
	address <= 37;
	#40
	address <= 38;
	#40
	address <= 39;
	#40
	address <= 40;
	#40
	address <= 41;
	#40
	address <= 42;
	#40
	address <= 43;
	#40
	address <= 44;
	#40
	address <= 45;
	#40
	address <= 46;
	#40
	address <= 47;
	#40
	address <= 48;
	#40
	address <= 49;
	#40
	address <= 50;
	#40
	address <= 51;
	#40
	address <= 52;
	#40
	address <= 53;
	#40
	address <= 54;
	#40
	address <= 55;
	#40
	address <= 56;
	#40
	address <= 57;
	#40
	address <= 58;
	#40
	address <= 59;
	#40
	address <= 60;
	#40
	address <= 61;
	#40
	address <= 62;
	#40
	address <= 63;
	#40
	address <= 64;
	#40
	address <= 65;
	#40
	address <= 66;
	#40
	address <= 67;
	#40
	address <= 68;
	#40
	address <= 69;
	#40
	address <= 70;
	#40
	address <= 71;
	#40
	address <= 72;
	#40
	address <= 73;
	#40
	address <= 74;
	#40
	address <= 75;
	#40
	address <= 76;
	#40
	address <= 77;
	#40
	address <= 78;
	#40
	address <= 79;
	#40
	address <= 80;
	#40
	address <= 81;
	#40
	address <= 82;
	#40
	address <= 83;
	#40
	address <= 84;
	#40
	address <= 85;
	#40
	address <= 86;
	#40
	address <= 87;
	#40
	address <= 88;
	#40
	address <= 89;
	#40
	address <= 90;
	#40
	address <= 91;
	#40
	address <= 92;
	#40
	address <= 93;
	#40
	address <= 94;
	#40
	address <= 95;
	#40
	address <= 96;
	#40
	address <= 97;
	#40
	address <= 98;
	#40
	address <= 99;
	#40
	address <= 100;
	#40
	address <= 101;
	
	
    // check finish interrupt
    #40
    wren_control <= 0;
    address_control <= 1;

    #40
    wren_control <= 1;
    address_control <= 1;
    data_in_control <= 0;

    #40
    wren_control <= 0;
    address_control <= 1;
	
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
	
	#20
	wren_control <= 0;
	address_control <= 1;
	data_in_control <= 0;
	
	// turning off/on cores
	#40
    wren_control <= 1;
    address_control <= 2;
    data_in_control <= 1;

    #40
    address_control <= 3;
    data_in_control <= 1;

    #40
    address_control <= 4;
    data_in_control <= 1;

    #40
    address_control <= 5;
    data_in_control <= 0;

    #40
	address_control <= 0;
	data_in_control <= 1;

    #40
    wren_control <= 0;
    address_control <= 1;


"""
    result += FOOTER

    with open(args.out, 'w') as out_file:
        out_file.write(result)

    # print(result)
