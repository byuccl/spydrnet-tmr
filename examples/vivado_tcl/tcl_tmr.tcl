# TMR in TCL script
package require struct::set

set properties_excluded [list BEL IS_BEL_FIXED IS_LOC_FIXED LOC]
set properties_unique   [list SOFT_HLUTNM]

proc run {} {
    parse_nodes_to_replicate
    parse_nodes_to_vote_on
    determine_pins_to_replicate
    set dont_touch_cells [get_cells -hierarchical -filter DONT_TOUCH]
    set_property DONT_TOUCH 0 $dont_touch_cells
    replicate_cells
    replicate_ports
    replicate_nets
    set_property DONT_TOUCH 1 $dont_touch_cells
    connect_replicates
    insert_voters
}

proc parse_nodes_to_replicate {} {
    global nodes_to_replicate
    
    set fi [open nodes_to_replicate.txt]
    set nodes_to_replicate [get_cells [split [read $fi] "\n"] ]
    close $fi
}

proc parse_nodes_to_vote_on {} {
    global nodes_to_vote_on
    
    set fi [open nodes_to_vote_on.txt]
    set nodes_to_vote_on [get_cells [split [read $fi] "\n"] ]
    close $fi
}

proc determine_pins_to_replicate {} {
    global nodes_to_replicate
    global pins_to_replicate
    global instance_src_pins
    global instance_sink_pins
    set instance_pins [get_pins -of_objects $nodes_to_replicate]
    set instance_src_pins [filter $instance_pins DIRECTION==OUT]
    set instance_sink_pins [filter $instance_pins DIRECTION==IN]
    set drive_nets [get_nets -of_objects $instance_src_pins -segments]
    set driven_nets [get_nets -of_objects $instance_sink_pins -segments]
    set common_nets [struct::set intersect $drive_nets $driven_nets]
    set exclude_pins [get_pins -of_objects [get_cells -hierarchical -filter PRIMITIVE_LEVEL==MACRO||PRIMITIVE_LEVEL==LEAF||PRIMITIVE_LEVEL==INTERNAL]]
    set pins [get_pins -of_objects $common_nets -filter IS_LEAF==0]
    set pins_to_replicate [struct::set difference $pins $exclude_pins]
    set pins_to_replicate [get_pins $pins_to_replicate]
}


proc replicate_cells {} {
    global nodes_to_replicate
    global properties_excluded
    global properties_unique
    set_hierarchy_separator |
    array set pblocks [list]
    foreach cell $nodes_to_replicate {
        _get_properties $cell r_properties rw_properties
        for {set ii 1} {$ii < 3} {incr ii} {
            set new_cell [create_cell -reference $r_properties(REF_NAME) "${r_properties(NAME)}_TMR_${ii}"]
            foreach {key value} [array get rw_properties] {
                if {[struct::set contains $properties_excluded $key]==0} {
                    if [struct::set contains $properties_unique $key] {
                        set_property $key "${value}_TMR_${ii}" $new_cell
                    } else {
                        set_property $key $value $new_cell
                    }
                }
            }
            if [info exists r_properties(PBLOCK)] {
                set pblock $r_properties(PBLOCK)
                lappend pblocks($pblock) $new_cell
            }
        }
        #foreach property $properties_unique {
        #    if [info exists rw_properties($property)] {
        #        set value $rw_properties($property)
        #        set_property $property "${value}_TMR_0" $cell
        #    }
        #}
        #rename_cell $cell -to "${r_properties(NAME)}_TMR_0"
        unset r_properties rw_properties
    }
    foreach {key value} [array get pblocks] {
        add_cells_to_pblock $key $value
    }
    unset pblocks
    set_hierarchy_separator
}

proc replicate_ports {} {
    global pins_to_replicate
    set_hierarchy_separator |
    set replicated_ports [list]
    foreach pin $pins_to_replicate {
        _get_properties $pin r_properties rw_properties
        if [info exists r_properties(BUS_NAME)] {
            set match [regexp {(.*)\[\d+\]$} $pin group0 basename]
            if {[struct::set contains $replicated_ports $basename]==0} {
                struct::set add replicated_ports $basename
                for {set ii 1} {$ii < 3} {incr ii} {
                    set new_pins [create_pin "${r_properties(PARENT_CELL)}|${r_properties(BUS_NAME)}_TMR_${ii}" \
                        -direction $r_properties(BUS_DIRECTION) -from $r_properties(BUS_START) -to $r_properties(BUS_STOP)]
                }
                #rename_pin "${r_properties(PARENT_CELL)}|${r_properties(BUS_NAME)}" -to "${r_properties(BUS_NAME)}_TMR_0"
            }
        } else {
            for {set ii 1} {$ii < 3} {incr ii} {
                set new_pin [create_pin "${r_properties(NAME)}_TMR_${ii}" -direction $r_properties(DIRECTION)]
            }
            #rename_pin $pin -to "${r_properties(REF_PIN_NAME)}_TMR_0"
        }
        unset r_properties rw_properties
    }
    set_hierarchy_separator
}

proc replicate_nets {} {
    global pins_to_replicate
    global instance_src_pins
    global nets_to_replicate
    set instance_nets [get_nets -of_objects $instance_src_pins]
    set port_nets [get_nets -of_objects $pins_to_replicate -boundary_type both]
    set unique_nets [struct::set union $instance_nets $port_nets] 
    set nets_to_replicate [get_nets $unique_nets]
    
    set_hierarchy_separator |
    set replicated_nets [list]
    foreach net $nets_to_replicate {
        _get_properties $net r_properties rw_properties
        if [info exists r_properties(BUS_NAME)] {
            set match [regexp {(.*)\[\d+\]$} $net group0 basename]
            if {[struct::set contains $replicated_nets $basename]==0} {
                struct::set add replicated_nets $basename
                for {set ii 1} {$ii < 3} {incr ii} {
                    set new_nets [create_net "${r_properties(PARENT_CELL)}|${r_properties(BUS_NAME)}_TMR_${ii}" \
                        -from $r_properties(BUS_START) -to $r_properties(BUS_STOP)]
                }
                #rename_pin "${r_properties(PARENT_CELL)}|${r_properties(BUS_NAME)}" -to "${r_properties(BUS_NAME)}_TMR_0"
            }
        } else {
            for {set ii 1} {$ii < 3} {incr ii} {
                set new_net [create_net "${r_properties(NAME)}_TMR_${ii}"]
            }
            #rename_pin $pin -to "${r_properties(REF_PIN_NAME)}_TMR_0"
        }
        unset r_properties rw_properties
    }
    set_hierarchy_separator
}

proc _get_properties {object r_property_ref rw_property_ref} {
    upvar $r_property_ref r_property_array
    upvar $rw_property_ref rw_property_array
    set properties [report_property -all -return_string $object]
    set lines [split $properties \n]
    set num_lines [llength $lines]
    set r_property_list [list]
    set rw_property_list [list]
    for {set ii 1} {$ii < $num_lines} {incr ii} {
        set line [lindex $lines $ii]
        set values [regexp -inline -all -- {\S+} $line]
        if {[llength $values]==4} {
            if {[string equal [lindex $values 2] "false"]} {
                lappend rw_property_list [lindex $values 0] [lindex $values 3]
            } else {
                lappend r_property_list [lindex $values 0] [lindex $values 3]
            }
        }
    }
    array set rw_property_array $rw_property_list
    array set r_property_array $r_property_list
}

proc connect_replicates {} {
    _connect_replicated_elements
    _connect_split_drivers
}

proc _connect_replicated_elements {} {
    global instance_sink_pins
    global instance_src_pins
    global pins_to_replicate
    global nets_to_replicate
    set instance_pins [struct::set union $instance_sink_pins $instance_src_pins]
    set all_pins [struct::set union $instance_pins $pins_to_replicate]
    foreach net $nets_to_replicate {
        set replicated_pins [get_pins [struct::set intersect [get_pins -of_objects $net] $all_pins ] ]
        array set replicate_pin_names [list]
        foreach pin $replicated_pins {
            _get_properties $pin r_properties rw_properties
            if [struct::set contains $instance_pins [get_property NAME $pin]] {
                for {set ii 1} {$ii < 3} {incr ii} {
                    lappend replicate_pin_names($ii) "${r_properties(PARENT_CELL)}_TMR_${ii}/${r_properties(REF_PIN_NAME)}"
                }
            } else {
                if [info exists r_properties(BUS_NAME)] {
                    regexp {.*(\[\d+\])$} $r_properties(NAME) group0 suffix
                    for {set ii 1} {$ii < 3} {incr ii} {
                        lappend replicate_pin_names($ii) "${r_properties(PARENT_CELL)}/${r_properties(BUS_NAME)}_TMR_${ii}${suffix}"
                    }
                } else {
                    for {set ii 1} {$ii < 3} {incr ii} {
                        lappend replicate_pin_names($ii) "${r_properties(NAME)}_TMR_${ii}"
                    }
                }
            }
            unset r_properties rw_properties
        }
        _get_properties $net r_properties rw_properties
        if [info exists r_properties(BUS_NAME)] {
            regexp {.*(\[\d+\])$} $r_properties(NAME) group0 suffix
            for {set ii 1} {$ii < 3} {incr ii} {
                connect_net -net [get_nets "${r_properties(PARENT_CELL)}/${r_properties(BUS_NAME)}_TMR_${ii}${suffix}"] -objects [get_pins $replicate_pin_names($ii)]
            }
        } else {
            for {set ii 1} {$ii < 3} {incr ii} {
                connect_net -net [get_nets "${r_properties(NAME)}_TMR_${ii}"] -objects [get_pins $replicate_pin_names($ii)]
            }
        }
        unset r_properties rw_properties replicate_pin_names
    }
}

proc _connect_split_drivers {} {
    global nodes_to_replicate
    global nets_to_replicate
    global instance_sink_pins
    set driving_nets [get_nets -of_objects $instance_sink_pins]
    set non_replicated_wires [get_nets [struct::set difference $driving_nets $nets_to_replicate] ]
    set driven_pins [get_pins [struct::set intersect [get_pins -of_objects $non_replicated_wires] $instance_sink_pins ] ]
    foreach pin $driven_pins {
        _get_properties $pin r_properties rw_properties
        set net [get_nets -of_objects $pin]
        set replicate_pin_names [list]
        for {set ii 1} {$ii < 3} {incr ii} {
            lappend replicate_pin_names "${r_properties(PARENT_CELL)}_TMR_${ii}/${r_properties(REF_PIN_NAME)}"
        }
        connect_net -net $net -objects [get_pins $replicate_pin_names]
        unset r_properties rw_properties
    }
}

proc insert_voters {} {
    global nodes_to_vote_on
    foreach node $nodes_to_vote_on {
        set output_pins [get_pins -of_objects $node -filter DIRECTION==OUT]
        foreach output_pin $output_pins {
            set net [get_nets -of_objects $output_pin]
            if {[llength $net]==1} {
                _get_properties $output_pin r_properties rw_properties
                set voter_cells [list]
                set voter_nets [list]
                for {set ii 0} {$ii < 3} {incr ii} {
                    set new_cell [create_cell -reference LUT3 "${r_properties(PARENT_CELL)}_${r_properties(REF_PIN_NAME)}_TMR_VOTER_${ii}"]
                    set_property INIT 8'hE8 $new_cell
                    lappend voter_cells $new_cell
                    set new_net [create_net "${r_properties(PARENT_CELL)}_${r_properties(REF_PIN_NAME)}_TMR_VOTER_NET_${ii}"]
                    lappend voter_nets $new_net
                }
                disconnect_net -net $net -objects $output_pin
                set target_pins [list]
                foreach voter_cell $voter_cells {
                    lappend target_pins "${voter_cell}/I0"
                }
                connect_net -net [lindex $voter_nets 0] -objects [concat [get_pins $target_pins] $output_pin]
                connect_net -net $net -objects [get_pins [lindex $voter_cells 0]/O]
                for {set ii 1} {$ii < 3} {incr ii} {
                    set replicate_pin [get_pins "${r_properties(PARENT_CELL)}_TMR_${ii}/${r_properties(REF_PIN_NAME)}"]
                    set net [get_nets -of_objects $replicate_pin]
                    disconnect_net -net $net -objects $replicate_pin
                    set target_pins [list]
                    foreach voter_cell $voter_cells {
                        lappend target_pins "${voter_cell}/I${ii}"
                    }
                    connect_net -net [lindex $voter_nets $ii] -objects [concat [get_pins $target_pins] $replicate_pin]
                    connect_net -net $net -objects [get_pins [lindex $voter_cells $ii]/O]
                }
                unset r_properties rw_properties
            }
        }
    }
}

#run