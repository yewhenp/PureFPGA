module decoder64(
  input [5:0]data,
  output [63:0] eq63
);
  assign eq63[0] = ~data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[1] = ~data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[2] = ~data[5] & ~data[4] & ~data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[3] = ~data[5] & ~data[4] & ~data[3] & ~data[2] & data[1] & data[0];
assign eq63[4] = ~data[5] & ~data[4] & ~data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[5] = ~data[5] & ~data[4] & ~data[3] & data[2] & ~data[1] & data[0];
assign eq63[6] = ~data[5] & ~data[4] & ~data[3] & data[2] & data[1] & ~data[0];
assign eq63[7] = ~data[5] & ~data[4] & ~data[3] & data[2] & data[1] & data[0];
assign eq63[8] = ~data[5] & ~data[4] & data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[9] = ~data[5] & ~data[4] & data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[10] = ~data[5] & ~data[4] & data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[11] = ~data[5] & ~data[4] & data[3] & ~data[2] & data[1] & data[0];
assign eq63[12] = ~data[5] & ~data[4] & data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[13] = ~data[5] & ~data[4] & data[3] & data[2] & ~data[1] & data[0];
assign eq63[14] = ~data[5] & ~data[4] & data[3] & data[2] & data[1] & ~data[0];
assign eq63[15] = ~data[5] & ~data[4] & data[3] & data[2] & data[1] & data[0];
assign eq63[16] = ~data[5] & data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[17] = ~data[5] & data[4] & ~data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[18] = ~data[5] & data[4] & ~data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[19] = ~data[5] & data[4] & ~data[3] & ~data[2] & data[1] & data[0];
assign eq63[20] = ~data[5] & data[4] & ~data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[21] = ~data[5] & data[4] & ~data[3] & data[2] & ~data[1] & data[0];
assign eq63[22] = ~data[5] & data[4] & ~data[3] & data[2] & data[1] & ~data[0];
assign eq63[23] = ~data[5] & data[4] & ~data[3] & data[2] & data[1] & data[0];
assign eq63[24] = ~data[5] & data[4] & data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[25] = ~data[5] & data[4] & data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[26] = ~data[5] & data[4] & data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[27] = ~data[5] & data[4] & data[3] & ~data[2] & data[1] & data[0];
assign eq63[28] = ~data[5] & data[4] & data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[29] = ~data[5] & data[4] & data[3] & data[2] & ~data[1] & data[0];
assign eq63[30] = ~data[5] & data[4] & data[3] & data[2] & data[1] & ~data[0];
assign eq63[31] = ~data[5] & data[4] & data[3] & data[2] & data[1] & data[0];
assign eq63[32] = data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[33] = data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[34] = data[5] & ~data[4] & ~data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[35] = data[5] & ~data[4] & ~data[3] & ~data[2] & data[1] & data[0];
assign eq63[36] = data[5] & ~data[4] & ~data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[37] = data[5] & ~data[4] & ~data[3] & data[2] & ~data[1] & data[0];
assign eq63[38] = data[5] & ~data[4] & ~data[3] & data[2] & data[1] & ~data[0];
assign eq63[39] = data[5] & ~data[4] & ~data[3] & data[2] & data[1] & data[0];
assign eq63[40] = data[5] & ~data[4] & data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[41] = data[5] & ~data[4] & data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[42] = data[5] & ~data[4] & data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[43] = data[5] & ~data[4] & data[3] & ~data[2] & data[1] & data[0];
assign eq63[44] = data[5] & ~data[4] & data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[45] = data[5] & ~data[4] & data[3] & data[2] & ~data[1] & data[0];
assign eq63[46] = data[5] & ~data[4] & data[3] & data[2] & data[1] & ~data[0];
assign eq63[47] = data[5] & ~data[4] & data[3] & data[2] & data[1] & data[0];
assign eq63[48] = data[5] & data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[49] = data[5] & data[4] & ~data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[50] = data[5] & data[4] & ~data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[51] = data[5] & data[4] & ~data[3] & ~data[2] & data[1] & data[0];
assign eq63[52] = data[5] & data[4] & ~data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[53] = data[5] & data[4] & ~data[3] & data[2] & ~data[1] & data[0];
assign eq63[54] = data[5] & data[4] & ~data[3] & data[2] & data[1] & ~data[0];
assign eq63[55] = data[5] & data[4] & ~data[3] & data[2] & data[1] & data[0];
assign eq63[56] = data[5] & data[4] & data[3] & ~data[2] & ~data[1] & ~data[0];
assign eq63[57] = data[5] & data[4] & data[3] & ~data[2] & ~data[1] & data[0];
assign eq63[58] = data[5] & data[4] & data[3] & ~data[2] & data[1] & ~data[0];
assign eq63[59] = data[5] & data[4] & data[3] & ~data[2] & data[1] & data[0];
assign eq63[60] = data[5] & data[4] & data[3] & data[2] & ~data[1] & ~data[0];
assign eq63[61] = data[5] & data[4] & data[3] & data[2] & ~data[1] & data[0];
assign eq63[62] = data[5] & data[4] & data[3] & data[2] & data[1] & ~data[0];
assign eq63[63] = data[5] & data[4] & data[3] & data[2] & data[1] & data[0];
endmodule