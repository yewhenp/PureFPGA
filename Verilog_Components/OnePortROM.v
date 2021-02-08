//============================================================================//
//                                                                            //
//      Syncronous one-port ROM                                             //
//                                                                            //
//      Module name: bram_sync_dp                                             //
//      Desc: parameterized, syncronous, inferable, true dual-port,           //
//            dual clock block ram                                            //
//      Date: Dec 2011                                                        //
//      Developer: Wesley New                                                 //
//      Licence: GNU General Public License ver 3                             //
//      Notes: Developed from a combiniation of bram implmentations           //
//             This is a read-before-write implementation of a BRAM           //
//                                                                            //
//============================================================================//

module OnePortROM #(
      //=============
      // Parameters
      //=============
      parameter RAM_DATA_WIDTH = 16,             // width of the data
      parameter RAM_ADDR_WIDTH = 16              // number of address bits
   ) (
      //================
      // General Ports
      //================
      input wire                       clock, 

      //=========
      // Port A
      //=========
      input  wire [RAM_ADDR_WIDTH-1:0] address, 
      output reg  [RAM_DATA_WIDTH-1:0] q
      
   );
   
   //===============
   // Local Params
   //===============
   localparam RAM_DATA_DEPTH = 2**RAM_ADDR_WIDTH;  // depth of the ram, this is tied to the number of address bits
   
   //================
   // Shared memory
   //================
   reg [RAM_DATA_WIDTH-1:0] mem [RAM_DATA_DEPTH-1:0];
  
  initial begin
  
    mem[0] <= 16'b1100001011000000;
    mem[1] <= 16'b0001100000000000;
    mem[2] <= 16'b1100101010010101;
    mem[3] <= 16'b0011000000000000;
    mem[4] <= 16'b1001010000000000;
    mem[5] <= 16'b0001100000010100;
    mem[6] <= 16'b1111011010000000;
    mem[7] <= 16'b1000001010010000;
    mem[8] <= 16'b1000101010100100;
    mem[9] <= 16'b1100001010011001;
    mem[10] <= 16'b1000011010010000;
    mem[11] <= 16'b0111101010000000;
    mem[12] <= 16'b0001111000001100;
    mem[13] <= 16'b0011001000011000;
    mem[14] <= 16'b0001100000000000;
    mem[15] <= 16'b1100101010010101;
    mem[16] <= 16'b0011000000000000;

  end
   
   //=========
   // Port A
   //=========
   always @(address) begin
      q  <= mem[address];
   end
   
   
endmodule