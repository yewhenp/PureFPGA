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


set corename "cvo_core"

# For the transferral of mode registers from is_clk to vid_clk domain the handshake used to enable register updates in each clock domain
# guarantees that the is_clk registers are held stable for sufficiently long when the vid_clk enable allows the registers to sample their input
# These paths are register - register. There is no logic inbetween.
# The constraint approach here is keep the registers of each domain physically close to each other 
# By specifying a small max limit and the registers should not migrate far apart.
# The -ve min delay prevents them being pushed apart
# The path is then limited to a maximum of 0.8 of the destination clock to ensure that by the time 2 resync cycles have passed, the data has arrived.
    

    set_multicycle_path -setup -start -through [get_nets "*|${corename}*|mode_banks|u_calculate_mode_dynamic|*"] 2
    set_multicycle_path -hold -start -through [get_nets "*|${corename}*|mode_banks|u_calculate_mode_dynamic|*"] 1

    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|interlaced_field_reg[*]"]     -to [get_keepers "*|${corename}*|mode_banks|vid_interlaced_field[*]"]  100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|interlaced_reg"]              -to [get_keepers "*|${corename}*|mode_banks|vid_interlaced"]           100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_minus_one_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_minus_one[*]"] 100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|v_total_minus_one_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_v_total_minus_one[*]"] 100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_minus_two_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_minus_two[*]"] 100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_h_total[*]"]           100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|v_total_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_v_total[*]"]           100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_blank_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_h_blank[*]"]           100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_start_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_start[*]"]      100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_end_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_end[*]"]        100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_start_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_start[*]"]        100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_start_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_start[*]"]        100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_end_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_end[*]"]          100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_sync_start_reg[*]"]      -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_sync_start[*]"]   100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_sync_end_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_sync_end[*]"]     100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_sync_start_reg[*]"]      -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_sync_start[*]"]   100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_sync_end_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_sync_end[*]"]     100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f_rising_edge_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f_rising_edge[*]"]     100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f_falling_edge_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f_falling_edge[*]"]    100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_end_nxt_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_end_nxt[*]"]      100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f2_anc_v_start_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f2_anc_v_start[*]"]    100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|f1_anc_v_start_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f1_anc_v_start[*]"]    100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_polarity_reg"]         -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_polarity"]      100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|v_sync_polarity_reg"]         -to [get_keepers "*|${corename}*|mode_banks|vid_v_sync_polarity"]      100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_check_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_check[*]"]     100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|ap_start_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_ap_start[*]"]          100
    set_max_delay -from [get_keepers "*|${corename}*|mode_banks|h_frame_complete_point_reg[*]"]  -to [get_keepers "*|${corename}*|mode_banks|vid_h_frame_complete_point[*]"] 100

    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|interlaced_field_reg[*]"]     -to [get_keepers "*|${corename}*|mode_banks|vid_interlaced_field[*]"]  -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|interlaced_reg"]              -to [get_keepers "*|${corename}*|mode_banks|vid_interlaced"]           -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_minus_one_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_minus_one[*]"] -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|v_total_minus_one_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_v_total_minus_one[*]"] -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_minus_two_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_minus_two[*]"] -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_h_total[*]"]           -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|v_total_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_v_total[*]"]           -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_blank_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_h_blank[*]"]           -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_start_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_start[*]"]      -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_end_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_end[*]"]        -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_start_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_start[*]"]        -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_start_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_start[*]"]        -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_end_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_end[*]"]          -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_sync_start_reg[*]"]      -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_sync_start[*]"]   -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_sync_end_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_sync_end[*]"]     -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_sync_start_reg[*]"]      -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_sync_start[*]"]   -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_sync_end_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_sync_end[*]"]     -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f_rising_edge_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f_rising_edge[*]"]     -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f_falling_edge_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f_falling_edge[*]"]    -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_end_nxt_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_end_nxt[*]"]      -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f2_anc_v_start_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f2_anc_v_start[*]"]    -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|f1_anc_v_start_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f1_anc_v_start[*]"]    -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_polarity_reg"]         -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_polarity"]      -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|v_sync_polarity_reg"]         -to [get_keepers "*|${corename}*|mode_banks|vid_v_sync_polarity"]      -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_check_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_check[*]"]     -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|ap_start_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_ap_start[*]"]          -100
    set_min_delay -from [get_keepers "*|${corename}*|mode_banks|h_frame_complete_point_reg[*]"] -to [get_keepers "*|${corename}*|mode_banks|vid_h_frame_complete_point[*]"] -100


    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|interlaced_field_reg[*]"]     -to [get_keepers "*|${corename}*|mode_banks|vid_interlaced_field[*]"]  -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|interlaced_reg"]              -to [get_keepers "*|${corename}*|mode_banks|vid_interlaced"]           -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_minus_one_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_minus_one[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|v_total_minus_one_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_v_total_minus_one[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_minus_two_reg[*]"]    -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_minus_two[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_h_total[*]"]           -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|v_total_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_v_total[*]"]           -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_blank_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_h_blank[*]"]           -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_start_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_start[*]"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_end_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_end[*]"]        -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_start_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_start[*]"]        -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_start_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_start[*]"]        -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_end_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_end[*]"]          -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_sync_start_reg[*]"]      -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_sync_start[*]"]   -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f2_v_sync_end_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f2_v_sync_end[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_sync_start_reg[*]"]      -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_sync_start[*]"]   -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_sync_end_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_sync_end[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f_rising_edge_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_f_rising_edge[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f_falling_edge_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f_falling_edge[*]"]    -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f1_v_end_nxt_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_f1_v_end_nxt[*]"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f2_anc_v_start_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f2_anc_v_start[*]"]    -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|f1_anc_v_start_reg[*]"]       -to [get_keepers "*|${corename}*|mode_banks|vid_f1_anc_v_start[*]"]    -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_sync_polarity_reg"]         -to [get_keepers "*|${corename}*|mode_banks|vid_h_sync_polarity"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|v_sync_polarity_reg"]         -to [get_keepers "*|${corename}*|mode_banks|vid_v_sync_polarity"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_total_check_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_h_total_check[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|ap_start_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_ap_start[*]"]          -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "*|${corename}*|mode_banks|h_frame_complete_point_reg[*]"] -to [get_keepers "*|${corename}*|mode_banks|vid_h_frame_complete_point[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8

        #set_max_delay -from [get_keepers "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] 100
        #set_min_delay -from [get_keepers "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] -100
        #set_net_delay -from [get_pins -compatibility_mode "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}ws_dgrp|dffpipe*"] -max 2
        #set_net_delay -from $from_node_list -to $to_node_list -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
        
    # The following may not exist to be applied to
    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_standard[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|standard_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_standard[*]"]                   100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|standard_reg[*]"]          -to [get_keepers "*|${corename}*|mode_banks|vid_standard[*]"]                 -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|standard_reg[*]"]          -to [get_keepers "*|${corename}*|mode_banks|vid_standard[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_serial_output[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|serial_output_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_serial_output[*]"]          100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|serial_output_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_serial_output[*]"]        -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|serial_output_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_serial_output[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_ap_line[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|ap_line_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_ap_line[*]"]                100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|ap_line_reg[*]"]               -to [get_keepers "*|${corename}*|mode_banks|vid_ap_line[*]"]              -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|ap_line_reg[*]"]               -to [get_keepers "*|${corename}*|mode_banks|vid_ap_line[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_ap_line_end[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|ap_line_end_reg[*]"]          -to [get_keepers "*|${corename}*|mode_banks|vid_ap_line_end[*]"]            100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|ap_line_end_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_ap_line_end[*]"]          -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|ap_line_end_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_ap_line_end[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_sav[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|sav_reg[*]"]                  -to [get_keepers "*|${corename}*|mode_banks|vid_sav[*]"]                    100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|sav_reg[*]"]                   -to [get_keepers "*|${corename}*|mode_banks|vid_sav[*]"]                  -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|sav_reg[*]"]                   -to [get_keepers "*|${corename}*|mode_banks|vid_sav[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_sof_sample[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|sof_sample_reg[*]"]           -to [get_keepers "*|${corename}*|mode_banks|vid_sof_sample[*]"]             100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|sof_sample_reg[*]"]            -to [get_keepers "*|${corename}*|mode_banks|vid_sof_sample[*]"]           -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|sof_sample_reg[*]"]            -to [get_keepers "*|${corename}*|mode_banks|vid_sof_sample[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_sof_line[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|sof_line_reg[*]"]             -to [get_keepers "*|${corename}*|mode_banks|vid_sof_line[*]"]               100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|sof_line_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_sof_line[*]"]             -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|sof_line_reg[*]"]              -to [get_keepers "*|${corename}*|mode_banks|vid_sof_line[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_sof_subsample[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|sof_subsample_reg[*]"]        -to [get_keepers "*|${corename}*|mode_banks|vid_sof_subsample[*]"]          100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|sof_subsample_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_sof_subsample[*]"]        -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|sof_subsample_reg[*]"]         -to [get_keepers "*|${corename}*|mode_banks|vid_sof_subsample[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "*|${corename}*|mode_banks|vid_vcoclk_divider_value[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "*|${corename}*|mode_banks|vcoclk_divider_value_reg[*]"] -to [get_keepers "*|${corename}*|mode_banks|vid_vcoclk_divider_value[*]"]   100
        set_min_delay -from [get_keepers "*|${corename}*|mode_banks|vcoclk_divider_value_reg[*]"]  -to [get_keepers "*|${corename}*|mode_banks|vid_vcoclk_divider_value[*]"] -100
        set_net_delay -from [get_keepers "*|${corename}*|mode_banks|vcoclk_divider_value_reg[*]"]  -to [get_keepers "*|${corename}*|mode_banks|vid_vcoclk_divider_value[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }
    
set instance_collection [get_keepers -nowarn "*|${corename}*|rst_vid_clk_reg*"]
    foreach_in_collection inst $instance_collection {
        set name [get_node_info -name $inst]
                puts $name
                set clear_pin [get_pins ${name}|clrn]
                puts "Setting false path through [get_pin_info -name $clear_pin]"
                set_false_path -through $clear_pin
        }
