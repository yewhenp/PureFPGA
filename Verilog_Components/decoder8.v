module decoder8(
  input [2:0]data,
  output [7:0] eq7
);
  assign eq7[0] = ~data[2] & ~data[1] & ~data[0];
  assign eq7[1] = ~data[2] & ~data[1] & data[0];
  assign eq7[2] = ~data[2] & data[1] & ~data[0];
  assign eq7[3] = ~data[2] & data[1] & data[0];
  assign eq7[4] = data[2] & ~data[1] & ~data[0];
  assign eq7[5] = data[2] & ~data[1] & data[0];
  assign eq7[6] = data[2] & data[1] & ~data[0];
  assign eq7[7] = data[2] & data[1] & data[0];
  
endmodule