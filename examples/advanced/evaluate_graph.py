"""
Evaluate Graph
--------------
"""
import sys
import spydrnet as sdn
from plot_connectivity_graph import ConnectivityGraphGenerator
from itertools import chain
import networkx as nx
import glob
import os

def run():
    filenames = glob.glob("../**/*.edf")
    for filename in sorted(filenames):
        report(filename)

def report(filename):
    connectivity_graph = nx.DiGraph()
    instances = 0
    tmr_instances = 0
    reduction_voter = 0
    non_tmr_sinks = 0
    non_tmr_srcs = set()
    tmr_srcs = set()
    num_protected_edge = 0
    clk_rst_protected_edges = 0
    netlist = sdn.parse(filename)
    top_definition = netlist.top_instance.reference
    for instance in top_definition.children:
        instances += 1
        if get_name(instance.reference) in {"GND", "VCC"}:
            continue
        name = get_name(instance)
        if name.endswith("_TMR_2"):
            connectivity_graph.add_node(instance)
            tmr_instances += 1
            reference = instance.reference
            input_ports = list(x for x in reference.ports if x.direction == sdn.IN)
            input_pins = list(chain.from_iterable(x.pins for x in input_ports))
            outer_pins = list(instance.pins[x] for x in input_pins)
            for outer_pin in outer_pins:
                wire = outer_pin.wire
                if wire:
                    for pin in wire.pins:
                        if isinstance(pin, sdn.OuterPin):
                            if pin.inner_pin.port.direction == sdn.OUT:
                                if get_name(pin.instance.reference) in {"GND", "VCC"}:
                                    continue
                                if get_name(pin.instance).endswith("_TMR_2") is False:
                                    non_tmr_srcs.add(pin)
                                else:
                                    tmr_srcs.add(pin)
                                    connectivity_graph.add_edge(pin.instance, instance)
                                    num_protected_edge += 1
                        else:
                            if pin.port.direction == sdn.IN:
                                if get_name(pin.port).endswith("_TMR_2") is False:
                                    non_tmr_srcs.add(pin)
                                else:
                                    clk_rst_protected_edges += 1
        if name.endswith("_TMR_0_VOTER"):
            reference = instance.reference
            output_port = next(x for x in reference.ports if x["EDIF.identifier"] == "O")
            output_pin = output_port.pins[0]
            outer_pin = instance.pins[output_pin]
            wire = outer_pin.wire
            non_tmr_sinks += len(wire.pins) - 1
            reduction_voter += 1
    basename = os.path.splitext(os.path.basename(filename))[0]
    print("{},{},{},{},{},{},{},{},{},{}".format(basename, instances, tmr_instances, clk_rst_protected_edges, num_protected_edge, len(tmr_srcs), reduction_voter, len(non_tmr_srcs), non_tmr_sinks, nx.number_weakly_connected_components(connectivity_graph)))
    #print("Total Instances", instances)
    #print("Instances TMR'd", tmr_instances)
    #print("Number of clk reset protected", clk_rst_protected_edges)
    #print("Number of protected edges", num_protected_edge)
    #print("Number of protected routes", len(tmr_srcs))
    #print("Reduction Voters", reduction_voter)
    #print("Non-TMR sources", len(non_tmr_srcs))
    #print("Non-TMR sinks", non_tmr_sinks)
    #print("Number of weakly connected components", nx.number_weakly_connected_components(connectivity_graph))
    
def get_name(object):
    if "EDIF.original_identifier" in object:
        return object["EDIF.original_identifier"]
    return object["EDIF.identifier"]
    

run()