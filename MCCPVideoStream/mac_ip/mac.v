module mac(
    clk,
    reset,
    // mm slave
    avs_chipselect,
    avs_read,
    avs_write,
    avs_readdata,
    avs_writedata,
    avs_address
);


// global clock & reset
input    clk;
input    reset;
// mm slave
input              avs_chipselect;
input              avs_read;
input              avs_write;
output reg [31:0]  avs_readdata;
input  [31:0]      avs_writedata;
input  [16:0]      avs_address;

////////////////////////////////////////////////////////////////////////
// registers
reg [31:0] vector_a[3:0];
reg [31:0] vector_b[3:0];
reg [31:0] dot_product;
reg [31:0] ctrl_reg;
////////////////////////////////////////////////////////////////////////
// mm mater read
always @ (posedge clk)
begin
   if (reset) 
       avs_readdata <= {16'b0,1'b1,15'b0};
    else if (avs_chipselect & avs_read)
    begin
        case(avs_address) 
            0: avs_readdata <= ctrl_reg;
            1: avs_readdata <= dot_product;
            default:$display("Error"); 
        endcase
    end
end
  
/////////////////////////////////////////////////////////////////////////
// mm mater write
always @ (posedge clk)
begin
   if(avs_chipselect & avs_write) begin
       if      (avs_address < 4)  vector_a[avs_address    ] <= avs_writedata[31:0];
       else if (avs_address < 8)  vector_b[avs_address - 4] <= avs_writedata[31:0];
       end
end

always @ (posedge clk)
begin
   if (reset) 
      dot_product <= 0;
   else
      dot_product <= vector_a[0] * vector_b[0] 
                   + vector_a[1] * vector_b[1] 
                   + vector_a[2] * vector_b[2] 
                   + vector_a[3] * vector_b[3]; 
end

endmodule