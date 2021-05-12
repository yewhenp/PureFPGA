# (C) 2001-2020 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


# ==================================================================
# Write proc

# Clock crossing register



#JMH replaced the following line with DCFIFO-eque constraints :
#set_false_path -from [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|din_reg*}] -to [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|delay_line[0]*}]
set_max_delay -from [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|din_reg*}] -to [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|din_reg*}] -to [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|delay_line[*]*}] -100

set_net_delay -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|*mem_ctr_crosser|din_reg*}] -to [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|delay_line[*]*}] -max 2
 

#The 'if' here means that the check is only used during timequest analysis, not during fitting.
if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|*mem_ctr_crosser|din_reg*}] -to [get_keepers {*packet_transfer*write_proc_instance|*mem_ctr_crosser|delay_line[*]*}] 6
}



#JMH replaced the following line with DCFIFO-eque constraints :
#set_false_path -from [get_keepers {*packet_transfer*write_proc_instance|unload_ack*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_ack_crosser|delay_line[0]*}]
set_max_delay -from [get_keepers {*packet_transfer*write_proc_instance|unload_ack*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_ack_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*write_proc_instance|unload_ack*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_ack_crosser|delay_line[*]*}] -100

set_net_delay -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|unload_ack*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_ack_crosser|delay_line[*]*}] -max 2
 

#The 'if' here means that the check is only used during timequest analysis, not during fitting.
if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|unload_ack*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_ack_crosser|delay_line[*]*}] 6
}




#JMH replaced the following line with DCFIFO-eque constraints :
#set_false_path -from [get_keepers {*packet_transfer*write_proc_instance|unload_req*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_req_crosser|delay_line[0]*}]
set_max_delay -from [get_keepers {*packet_transfer*write_proc_instance|unload_req*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_req_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*write_proc_instance|unload_req*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_req_crosser|delay_line[*]*}] -100

set_net_delay -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|unload_req*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_req_crosser|delay_line[*]*}] -max 2
 

#The 'if' here means that the check is only used during timequest analysis, not during fitting.
if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|unload_req*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_req_crosser|delay_line[*]*}] 6
}




#JMH replaced the following line with DCFIFO-eque constraints :
#set_false_path -from [get_keepers {*packet_transfer*write_proc_instance|unload_done*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_done_crosser|delay_line[0]*}]
set_max_delay -from [get_keepers {*packet_transfer*write_proc_instance|unload_done*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_done_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*write_proc_instance|unload_done*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_done_crosser|delay_line[*]*}] -100

set_net_delay -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|unload_done*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_done_crosser|delay_line[*]*}] -max 2
 

#The 'if' here means that the check is only used during timequest analysis, not during fitting.
if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|unload_done*}] -to [get_keepers {*packet_transfer*write_proc_instance|*unload_done_crosser|delay_line[*]*}] 6
}





# Ack-syn path
#set_false_path -from [get_keepers {*packet_transfer*write_proc_instance|*unload_buffered*}] -to [get_keepers {*packet_transfer*write_proc_instance|*_mm_output*}]
set_max_delay -from [get_keepers {*packet_transfer*write_proc_instance|*unload_buffered*}] -to [get_keepers {*packet_transfer*write_proc_instance|*_mm_output*}] 100
set_min_delay -from [get_keepers {*packet_transfer*write_proc_instance|*unload_buffered*}] -to [get_keepers {*packet_transfer*write_proc_instance|*_mm_output*}] -100

set_net_delay -max -from [get_keepers {*packet_transfer*write_proc_instance|*unload_buffered*}] -to [get_keepers {*packet_transfer*write_proc_instance|*_mm_output*}] 2

if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*write_proc_instance|*unload_buffered*}] -to [get_keepers {*packet_transfer*write_proc_instance|*_mm_output*}] 5
}



# ==================================================================
# Read proc

# Clock crossing register

#JMH replaced the following line with DCFIFO-eque constraints :
#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[0]*}]
set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[*]*}] -100

set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[*]*}] -100

set_net_delay -from [get_pins -compatibility_mode {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[*]*}] -max 2

 

#The 'if' here means that the check is only used during timequest analysis, not during fitting.
if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*read_proc_instance|read_syn_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_syn_crosser|delay_line[*]*}] 6
}




#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[0]*}]
set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[*]*}] -100

set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[*]*}] 100
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[*]*}] -100

set_net_delay -from [get_pins -compatibility_mode {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[*]*}] -max 2

 

#The 'if' here means that the check is only used during timequest analysis, not during fitting.
if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*read_proc_instance|read_ack_buf*}] -to [get_keepers {*packet_transfer*read_proc_instance|*read_ack_crosser|delay_line[*]*}] 6
}





# Ack-syn path
#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*}] -to [get_keepers *packet_transfer*read_proc_instance\|*mm_msg_queue*scfifo*]
#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*}] -to [get_keepers *packet_transfer*read_proc_instance\|*mm_msg_queue*scfifo*]


set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
                                   *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
                                  }] -to [get_keepers *packet_transfer*read_proc_instance\|*mm_msg_queue*scfifo*]  100
                                  
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
                                   *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
                                  }] -to [get_keepers *packet_transfer*read_proc_instance\|*mm_msg_queue*scfifo*]  -100
                                  
set_net_delay -max -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
                                       *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
                                      }] -to [get_keepers *packet_transfer*read_proc_instance\|*mm_msg_queue*scfifo*]  2
                                  





#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
#                                   *packet_transfer*read_proc_instance|*current_ctxt_id*
#                                   *packet_transfer*read_proc_instance|*period_expecting_valid_ptr*
#                                   *packet_transfer*read_proc_instance|*context_expecting_valid_ptr*
#                                   *packet_transfer*read_proc_instance|*csel_expecting_valid_ptr*
#                                   *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
#                                  }] -to [get_keepers {*packet_transfer*read_proc_instance|*mm_msg_din*
#                                    *packet_transfer*read_proc_instance|*mm_msg_bypass_reg*
#                                    *packet_transfer*read_proc_instance|*mm_msg_queue*scfifo*
#                                  }]


                                  
set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
                                   *packet_transfer*read_proc_instance|*current_ctxt_id*
                                   *packet_transfer*read_proc_instance|*period_expecting_valid_ptr*
                                   *packet_transfer*read_proc_instance|*context_expecting_valid_ptr*
                                   *packet_transfer*read_proc_instance|*csel_expecting_valid_ptr*
                                   *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
                                  }] -to [get_keepers {*packet_transfer*read_proc_instance|*mm_msg_din*
                                    *packet_transfer*read_proc_instance|*mm_msg_bypass_reg*
                                    *packet_transfer*read_proc_instance|*mm_msg_queue*scfifo*
                                  }]    100

                                  
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
                                   *packet_transfer*read_proc_instance|*current_ctxt_id*
                                   *packet_transfer*read_proc_instance|*period_expecting_valid_ptr*
                                   *packet_transfer*read_proc_instance|*context_expecting_valid_ptr*
                                   *packet_transfer*read_proc_instance|*csel_expecting_valid_ptr*
                                   *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
                                  }] -to [get_keepers {*packet_transfer*read_proc_instance|*mm_msg_din*
                                    *packet_transfer*read_proc_instance|*mm_msg_bypass_reg*
                                    *packet_transfer*read_proc_instance|*mm_msg_queue*scfifo*
                                  }]    -100
                                  
set_net_delay -max -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*
                                       *packet_transfer*read_proc_instance|*current_ctxt_id*
                                       *packet_transfer*read_proc_instance|*period_expecting_valid_ptr*
                                       *packet_transfer*read_proc_instance|*context_expecting_valid_ptr*
                                       *packet_transfer*read_proc_instance|*csel_expecting_valid_ptr*
                                       *packet_transfer*read_proc_instance|*ctxt_expecting_valid_ptr*
                                      }] -to [get_keepers {*packet_transfer*read_proc_instance|*mm_msg_din*
                                        *packet_transfer*read_proc_instance|*mm_msg_bypass_reg*
                                        *packet_transfer*read_proc_instance|*mm_msg_queue*scfifo*
                                      }]    2

                                  
    

#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|*csel_target_addr*
#                                   *packet_transfer*read_proc_instance|*context_target_addr*
#                                   *packet_transfer*read_proc_instance|*ctxt_target_addr*
#                                   *packet_transfer*read_proc_instance|*period_targer_addr_start*
#                                  }] -to [get_keepers {*read_proc_instance|*mm_target_addr*}]


                                 
set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|*csel_target_addr*
                                   *packet_transfer*read_proc_instance|*context_target_addr*
                                   *packet_transfer*read_proc_instance|*ctxt_target_addr*
                                   *packet_transfer*read_proc_instance|*period_targer_addr_start*
                                   *packet_transfer*read_proc_instance|*current_ctxt_id*
                                  }] -to [get_keepers {*read_proc_instance|*mm_target_addr*}]   100
                                  
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|*csel_target_addr*
                                   *packet_transfer*read_proc_instance|*context_target_addr*
                                   *packet_transfer*read_proc_instance|*ctxt_target_addr*
                                   *packet_transfer*read_proc_instance|*period_targer_addr_start*
                                   *packet_transfer*read_proc_instance|*current_ctxt_id*
                                  }] -to [get_keepers {*read_proc_instance|*mm_target_addr*}]    -100
                                  
set_net_delay -max -from [get_keepers {*packet_transfer*read_proc_instance|*csel_target_addr*
                                       *packet_transfer*read_proc_instance|*context_target_addr*
                                       *packet_transfer*read_proc_instance|*ctxt_target_addr*
                                       *packet_transfer*read_proc_instance|*period_targer_addr_start*
                                       *packet_transfer*read_proc_instance|*current_ctxt_id*
                                      }] -to [get_keepers {*read_proc_instance|*mm_target_addr*}]   2
                                  
                                     
                                  
#set_false_path -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*}] -to [get_keepers {*read_proc_instance|*mm_burst_size*}]

set_max_delay -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*}] -to [get_keepers {*read_proc_instance|*mm_burst_size*}]   100
set_min_delay -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*}] -to [get_keepers {*read_proc_instance|*mm_burst_size*}]   -100

set_net_delay -max -from [get_keepers {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*}] -to [get_keepers {*read_proc_instance|*mm_burst_size*}]   2

if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
   set_max_skew -from [get_pins -compatibility_mode {*packet_transfer*read_proc_instance|*current_ctxt_burst_size*}] -to [get_keepers {*read_proc_instance|*mm_burst_size*}] 5
}


