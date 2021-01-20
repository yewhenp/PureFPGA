module RAM1 #(
    parameter 
    WIDTH = 16
)
    (
    input [WIDTH-1: 0]  address,
    input               clock,
    input [WIDTH-1: 0]  data,
    input               wren,
    output [WIDTH-1: 0] q
);
    wire address, clk, data, wren;
    reg q;
    

endmodule