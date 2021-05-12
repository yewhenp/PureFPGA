`timescale 1 ns / 1 ns

module tb;


reg clk, reset;
//Master Avalon interface simulation
reg 		 ctrl_cs;
reg  [16:0] ctl_address;
reg        ctl_read = 0;
wire [31:0] ctl_readdata;
wire        ctl_write;
reg [31:0] ctl_writedata;

initial // Clock generator
  begin
    clk = 0;
    forever
      #5 clk = !clk;
  end

initial	// Reset generator
begin
        reset = 1;
    #20 reset = 0;
        ctrl_cs = 1;
end

assign ctl_write = (ctl_address < 8)?1:0;

always @(posedge clk)
    begin
    if(reset) begin
        ctl_address <= 0;
        ctl_writedata <= 0;
        end
    else begin
        if(ctl_write)
            ctl_writedata <= ctl_writedata + 1;
        else
            ctl_writedata <= 0;
        if (ctl_address < 8)
            ctl_address <= ctl_address + 1;
        else
            ctl_address <= 0;
        end
    end
 mac  mac_dut(

	// global clock & reset
	.clk(clk),
	.reset(reset),
	
	// mm slave
	.avs_chipselect	(ctrl_cs),
	.avs_read		(ctl_read),
	.avs_write		(ctl_write),
	.avs_readdata 	(ctl_readdata),
	.avs_writedata (ctl_writedata),
	.avs_address	(ctl_address)

	);

endmodule 