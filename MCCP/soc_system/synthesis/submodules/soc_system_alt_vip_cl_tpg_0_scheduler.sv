// (C) 2001-2020 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


module soc_system_alt_vip_cl_tpg_0_scheduler

   (  input    wire                                clock,
      input    wire                                reset,
      
      output   wire                                av_st_cmd_ac_valid,
      input    wire                                av_st_cmd_ac_ready,
      output   wire                                av_st_cmd_ac_startofpacket,
      output   wire                                av_st_cmd_ac_endofpacket,
      output   wire  [64 - 1 : 0]         av_st_cmd_ac_data,
      
      
      
      output   wire                                av_st_cmd_vob_valid,
      input    wire                                av_st_cmd_vob_ready,
      output   wire                                av_st_cmd_vob_startofpacket,
      output   wire                                av_st_cmd_vob_endofpacket,
      output   wire  [64 - 1 : 0]         av_st_cmd_vob_data
   );
   
   wire                                av_st_cmd_mux_valid;
   wire                                av_st_cmd_mux_ready;
   wire                                av_st_cmd_mux_startofpacket;
   wire                                av_st_cmd_mux_endofpacket;
   wire  [64 - 1 : 0]         av_st_cmd_mux_data;
   
   wire                                av_mm_control_write;
   wire                                av_mm_control_read;
   wire  [4 - 1 : 0]           av_mm_control_byteenable;
   wire  [4 - 1 : 0]         av_mm_control_address;
   wire  [32 - 1 : 0]      av_mm_control_writedata;
   wire                                av_mm_control_waitrequest;
   wire  [32 - 1 : 0]      av_mm_control_readdata;
   wire                                av_mm_control_readdatavalid;
   
   localparam  integer  CORE_TYPE   [0 : 15] =  '{ 0,  0,  0,  0,
                                                   0,  0,  0,  0, 
                                                   0,  0,  0, 0, 
                                                   0, 0, 0, 0 };

   localparam  integer  CORE_SUBS   [0 : 15] =  '{ 0,  0,  0,  0,
                                                   0,  0,  0,  0, 
                                                   0,  0,  0, 0, 
                                                   0, 0, 0, 0 };
   
   alt_vip_tpg_multi_scheduler # (
      .BITS_PER_SYMBOL                 (8),
      .MAX_WIDTH                       (1920),
      .MAX_HEIGHT                      (1080),
      .PIXELS_IN_PARALLEL              (1),
      .NUM_CORES                       (1),
      .RUNTIME_CONTROL                 (0),
      .LIMITED_READBACK                (0),
      .PIPELINE_READY                  (0),
      .DEFAULT_R_Y                     (16),
      .DEFAULT_G_CB                    (16),
      .DEFAULT_B_CR                    (16),
      .DEFAULT_INTERLACE               ("PROGRESSIVE"),
      .DEFAULT_BOARDER                 (1),
      .CORE_TYPE                       (CORE_TYPE),
      .CORE_SUBS                       (CORE_SUBS)
   ) tpg_multi_scheduler_inst (  
      .clock                           (clock),
      .reset                           (reset),
      .av_st_cmd_ac_valid              (av_st_cmd_ac_valid),
      .av_st_cmd_ac_ready              (av_st_cmd_ac_ready),
      .av_st_cmd_ac_startofpacket      (av_st_cmd_ac_startofpacket),
      .av_st_cmd_ac_endofpacket        (av_st_cmd_ac_endofpacket),
      .av_st_cmd_ac_data               (av_st_cmd_ac_data),
      
      .av_st_cmd_mux_valid             (av_st_cmd_mux_valid),
      .av_st_cmd_mux_ready             (av_st_cmd_mux_ready),
      .av_st_cmd_mux_startofpacket     (av_st_cmd_mux_startofpacket),
      .av_st_cmd_mux_endofpacket       (av_st_cmd_mux_endofpacket),
      .av_st_cmd_mux_data              (av_st_cmd_mux_data),
      
      .av_st_cmd_vob_valid             (av_st_cmd_vob_valid),
      .av_st_cmd_vob_ready             (av_st_cmd_vob_ready),
      .av_st_cmd_vob_startofpacket     (av_st_cmd_vob_startofpacket),
      .av_st_cmd_vob_endofpacket       (av_st_cmd_vob_endofpacket),
      .av_st_cmd_vob_data              (av_st_cmd_vob_data),
      
      .av_mm_control_write             (av_mm_control_write),
      .av_mm_control_read              (av_mm_control_read),
      .av_mm_control_byteenable        (av_mm_control_byteenable),
      .av_mm_control_address           (av_mm_control_address),
      .av_mm_control_writedata         (av_mm_control_writedata),
      .av_mm_control_waitrequest       (av_mm_control_waitrequest),
      .av_mm_control_readdata          (av_mm_control_readdata),
      .av_mm_control_readdatavalid     (av_mm_control_readdatavalid)
   );
   
endmodule
   
   
      
      
      
      

