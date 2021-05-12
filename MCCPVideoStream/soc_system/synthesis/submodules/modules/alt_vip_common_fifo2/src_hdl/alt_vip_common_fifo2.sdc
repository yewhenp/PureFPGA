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


proc alt_vip_get_timequest_name {hier_name} {
	set sta_name ""
	for {set inst_start [string first ":" $hier_name]} {$inst_start != -1} {set inst_start [string first ":" $hier_name $inst_start]} {
		incr inst_start
		set inst_end [string first "|" $hier_name $inst_start]
		if {$inst_end == -1} {
			append sta_name [string range $hier_name $inst_start end]
		} else {
			append sta_name [string range $hier_name $inst_start $inst_end]
		}
	}
	return $sta_name
}

proc alt_vip_get_core_instance_list {corename} {
	set full_instance_list [alt_vip_get_core_full_instance_list $corename]
	set instance_list [list]

	foreach inst $full_instance_list {
		set sta_name [alt_vip_get_timequest_name $inst]
		if {[lsearch -exact $instance_list $sta_name] == -1} {
			lappend instance_list $sta_name
		}
	}
	return $instance_list
}

proc alt_vip_get_core_full_instance_list {corename} {
	set instance_list [list]

	# Look for a keeper (register) name
	# Try mem_clk[0] to determine core instances
	set search_list [list "*"]
	set found 0
	for {set i 0} {$found == 0 && $i != [llength $search_list]} {incr i} {
		set pattern [lindex $search_list $i]
		set instance_collection [get_keepers -nowarn "*|${corename}:*|$pattern"]
		if {[get_collection_size $instance_collection] == 0} {
			set instance_collection [get_keepers "${corename}:*|$pattern"]
		}
		if {[get_collection_size $instance_collection] > 0} {
			set found 1
		}
	}
	# regexp to extract the full hierarchy path of an instance name
	set inst_regexp {(^.*}
	append inst_regexp ${corename}
	append inst_regexp {:[A-Za-z0-9\.\\_\[\]\-\$()]+)\|}
	foreach_in_collection inst $instance_collection {
		set name [get_node_info -name $inst]
		if {[regexp -- $inst_regexp $name -> hier_name] == 1} {
			if {[lsearch -exact $instance_list $hier_name] == -1} {
				lappend instance_list $hier_name
			}
		}
	}
	return $instance_list
}

set corename "alt_vip_common_fifo2"
set instance_list [alt_vip_get_core_instance_list $corename]

foreach inst $instance_list {
    set hier_to_block ${inst}|*cfifo_component
    set fifo_name ${hier_to_block}|*


    # Having set hierarchy, need to ascertain whether dcfifo or scfifo is being used.
    # Constraints are only required for the dcfifo
    # hier_to_block should define hierarchy to common_fifo
    # by getting keepers this will return a collection of either scfifo or dcfifo keepers.
    # Can strip the returned value to test 
    set fifo_instance_list [get_keepers $fifo_name]
    foreach_in_collection fifo_instance $fifo_instance_list {
        set fifo_instance_name [get_node_info -name $fifo_instance]
        regexp {(.)cfifo_component} $fifo_instance_name -> fifo_type
    }
    
    #####################################################################################
    # Constrain the DCFIFOS if they are present
    #####################################################################################    
    if {[string compare $fifo_type "d"] == 0} {
        set fifo_name ${inst}|*
        # The following constraints are predicated on the embedded false_paths having been disabled.
        set_time_format -unit ns -decimal_places 3
        set_max_delay -from [get_keepers "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] 100
        set_min_delay -from [get_keepers "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] -100
        set_max_delay -from [get_keepers "${fifo_name}wrptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] 100
        set_min_delay -from [get_keepers "${fifo_name}wrptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] -100

        #set_net_delay -from [get_pins -compatibility_mode "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}ws_dgrp|dffpipe*"] -min 0
        set_net_delay -from [get_pins -compatibility_mode "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}ws_dgrp|dffpipe*"] -max 2
        #set_net_delay -from [get_pins -compatibility_mode "${fifo_name}delayed_wrptr_g[*]*"] -to [get_keepers "${fifo_name}rs_dgwp|dffpipe*"] -min 0
        set_net_delay -from [get_pins -compatibility_mode "${fifo_name}delayed_wrptr_g[*]*"] -to [get_keepers "${fifo_name}rs_dgwp|dffpipe*"] -max 2

        #6ns for 150MHz operation. 
        #The 'if' here means that the check is only used during timequest analysis, not during fitting.
        if { [string equal "quartus_sta" $::TimeQuestInfo(nameofexecutable)] } {
           set_max_skew -from [get_pins -compatibility_mode "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}ws_dgrp|dffpipe*"] 6
           set_max_skew -from [get_pins -compatibility_mode "${fifo_name}delayed_wrptr_g[*]*"] -to [get_keepers "${fifo_name}rs_dgwp|dffpipe*"] 6
        }
	#There is a reset resynchroniser which needs to have the asynchronous clear path false pathd
        set_false_path -through [get_pins -compatibility_mode "${fifo_name}|dffe*|clrn"]
        set_false_path -through [get_pins -compatibility_mode "${fifo_name}|dffe*|clrn"]         
    }
    unset hier_to_block
}
