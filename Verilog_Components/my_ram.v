//============================================================================//
//                                                                            //
//      Syncronous dual-port BRAM                                             //
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

module my_ram #(
      //=============
      // Parameters
      //=============
      parameter RAM_DATA_WIDTH = 16,             // width of the data
      parameter RAM_ADDR_WIDTH = 16              // number of address bits
   ) (
      //================
      // General Ports
      //================
      input wire                       clk, 

      //=========
      // Port A
      //=========
      input  wire                      wren_a,       // pulse a 1 to write and 0 reads
      input  wire [RAM_ADDR_WIDTH-1:0] address_a, 
      input  wire [RAM_DATA_WIDTH-1:0] data_a,
      output reg  [RAM_DATA_WIDTH-1:0] q_a,
      
      //=========
      // Port B
      //=========
      input  wire                      wren_b,       // pulse a 1 to write and 0 reads
      input  wire [RAM_ADDR_WIDTH-1:0] address_b, 
      input  wire [RAM_DATA_WIDTH-1:0] data_b,
      output reg  [RAM_DATA_WIDTH-1:0] q_b
   );
   
   //===============
   // Local Params
   //===============
   localparam RAM_DATA_DEPTH = 2**RAM_ADDR_WIDTH;  // depth of the ram, this is tied to the number of address bits
   
   //================
   // Shared memory
   //================
   reg [RAM_DATA_WIDTH-1:0] mem [RAM_DATA_DEPTH-1:0];
   
   //=========
   // Port A
   //=========
   always @(clk) begin
		if (wren_a) begin
			mem[address_a] <= data_a;
		end else begin
			q_a  <= mem[address_a];
		end
   end
   
   //=========
   // Port B
   //=========
   always @(clk) begin
		if (wren_b) begin
			mem[address_b] <= data_b;
		end else begin
			q_b  <= mem[address_b];
		end
   end
endmodule
