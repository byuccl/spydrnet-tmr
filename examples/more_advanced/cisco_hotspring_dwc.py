"""
Cisco DWC Example
==================
    
    This file provides an example of applying DWC to a larger, more complex design
"""
import spydrnet_shrec as sdn_shrec
from spydrnet_shrec.analysis.adjacency_list import adjacency_list
import spydrnet as sdn
import networkx as nx

clock_pins = {'FDRE': ['C'], 'RAM32M16': ['WCLK'], 'FDPE': ['C'], 'RAM64M8': ['WCLK'], 'FDSE': ['C'], 'FDCE': ['C'],
              'RAMB36E2': ['CLKARDCLK', 'CLKBWRCLK'], 'RAMB18E2': ['CLKARDCLK', 'CLKBWRCLK'], 'SRL16E': ['CLK'],
              'DSP48E2': ['CLK']}

power_def = ['GND', 'VCC']

dont_replicate_def_name = {'VCC', 'GND', 'emac_rx_fifocompare_7_HD1217', 'RAMB36E2', 'emac_rx_fifocompare_7_HD1089',
                           'RAMB18E2', 'emac_rx_fifocompare_7_HD1153', 'emac_rx_fifocompare_7'}
dont_replicate_inst_name = {'handoff_top_inst/handoff_blocks/mdio_top/cylon0_mdio_rx_top/mdio_rx/mdio_clk_Q1_reg',
                            'handoff_top_inst/handoff_blocks/mdio_top/cylon0_mdio_rx_top/mdio_rx/mdio_clk_Q2_reg',
                            'handoff_top_inst/handoff_blocks/mdio_top/cylon1_mdio_rx_top/mdio_rx/mdio_clk_Q1_reg',
                            'handoff_top_inst/handoff_blocks/mdio_top/cylon1_mdio_rx_top/mdio_rx/mdio_clk_Q2_reg'}

netlist = None
connectivity_graph = None
feedback_hierarchy = None

selection = None


def run():
    global netlist
    parse_netlist()
    uniquify_netlist()
    # parse_feedback_hierarchy()
    create_connectivity_graph()
    search_pattern = 'handoff_top_inst/handoff_blocks/.*'
    handoff_blocks_hinsts = list(netlist.get_hinstances(search_pattern, recursive=True, is_re=True,
                                                        filter=lambda x: x.item.reference.is_leaf() is True))
    handoff_blocks_hinsts = set(x for x in handoff_blocks_hinsts if x.name not in dont_replicate_inst_name and
                                x.item.reference.name not in dont_replicate_def_name)

    driving_non_dwc_hinst = list(x for x in handoff_blocks_hinsts if
                                 any(y not in handoff_blocks_hinsts for y in connectivity_graph.successors(x)))

    driving_pins = list(sdn.get_hpins(driving_non_dwc_hinst, filter=lambda x: x.item.port.direction is sdn.OUT))
    outer_driving_pins = list(sdn.get_pins(driving_pins, selection="OUTSIDE"))

    replicaMap = sdn_shrec.apply_nmr(list(x.item for x in handoff_blocks_hinsts), 2, 'DWC')

    from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
    from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector

    detectorMap = insert_organs(replicaMap, outer_driving_pins, XilinxDWCDetector(), "detectorGaget")

    detectorGroup0 = list(dd[0] for dd in detectorMap.values())
    detectorGroup1 = list(dd[1] for dd in detectorMap.values())

    detectorGroup0OutaPins = sdn.get_pins(detectorGroup0, selection=sdn.OUTSIDE)
    detectorGroup0OutaPins = list(p for p in detectorGroup0OutaPins if p.inner_pin.port.direction is sdn.OUT)

    detectorGroup1OutaPins = sdn.get_pins(detectorGroup1, selection=sdn.OUTSIDE)
    detectorGroup1OutaPins = list(p for p in detectorGroup1OutaPins if p.inner_pin.port.direction is sdn.OUT)

    from spydrnet_tmr.transformation.surface_pins import surface_pins

    dwcWiremap0 = surface_pins(detectorGroup0OutaPins, "DRail_0")
    dwcWiremap1 = surface_pins(detectorGroup1OutaPins, "DRail_1")

    from spydrnet_shrec.transformation.reduction_network import create_reduction_network
    from spydrnet_shrec.transformation.reduction_network import define_reg
    from spydrnet_shrec.transformation.reduction_network import registerDWCWires, instance_JTAG_module

    regDef = define_reg(netlist)

    dwcWiremap0 = registerDWCWires(netlist, dwcWiremap0, regDef, "Reg_Q_0")
    dwcWiremap1 = registerDWCWires(netlist, dwcWiremap1, regDef, "Reg_Q_1")

    rail0Map = create_reduction_network(netlist, dwcWiremap0)
    rail1Map = create_reduction_network(netlist, dwcWiremap1)

    instance_JTAG_module(netlist, rail0Map, rail1Map)

    netlist.compose('hotspring_main_top_dwc_balanced.edf')

    user_clk_net = next(netlist.get_hwires('clk')).item
    clk_pins = sdn.get_pins(list(netlist.get_hpins("Reg_Reg_Q_.*/clk", is_re=True, recursive=True)),
                            selection="OUTSIDE")
    for clk_pin in clk_pins:
        user_clk_net.connect_pin(clk_pin)

    netlist.compose('hotspring_main_top_dwc_balanced_with_clock.edf')

    # finding places to insert detectors

    # clocked_items = list(handoff_blocks_hinst.get_hinstances(recursive=True, filter=lambda
    #     x: x.item.reference.is_leaf() and x.item.reference.name in clock_pins))
    # clock_hpins = sdn.get_hpins(clocked_items, filter=is_clock_pin)
    # clock_hwires = sdn.get_hwires(clock_hpins, selection=sdn.ALL)
    # clock_drivers = sdn.get_hpins(clock_hwires, filter=lambda x: x.item.port.definition.is_leaf() is True and
    #                               x.item.port.direction is sdn.OUT)
    #
    # handoff_blocks_nodes = list(x for x in connectivity_graph.nodes if
    #                             x.name.startswith('handoff_top_inst/handoff_blocks') is True)


def parse_netlist():
    global netlist
    netlist = sdn.parse('hotspring_main_top.edf')


def uniquify_netlist():
    from spydrnet.uniquify import uniquify
    uniquify(netlist)


def parse_feedback_hierarchy(filename):
    global feedback_hierarchy
    feedback_hierarchy = list()
    with open(filename) as fi:
        for line in fi:
            feedback_hierarchy.append(line.strip().split(' '))
    hinsts = list(netlist.get_hinstances((x[1] for x in feedback_hierarchy if x[1].startswith('Feedback') is False),
                                         recursive=True))
    index = 0
    for item in feedback_hierarchy:
        item[0] = int(item[0])
        name = hinsts[index].name
        if name == item[1]:
            item[1] = hinsts[index]
            index += 1
        for sub_index, sub_item in enumerate(item[2:], 2):
            item[sub_index] = int(sub_item)


def create_connectivity_graph():
    global connectivity_graph
    hports = netlist.get_hports()
    hinsts = netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True)
    from itertools import chain
    connectivity_graph = nx.DiGraph(adjacency_list(chain(hports, hinsts)))


def is_clock_pin(hpin):
    port = hpin.item.port
    definition = port.definition
    definition_name = definition.name
    if definition_name in clock_pins:
        port_name = port.name
        if port_name in clock_pins[definition_name]:
            return True
    return False


# hinst = next(netlist.get_hinstances('handoff_top_inst'))
# leaf_insts = list(hinst.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
# # 146624
# # 152568 <- That is what vivado is saying... They can see inside the king fisher... Black boxes. I say don't mess with
# # blackboxes
#
# count = dict()
# for leaf_cell in leaf_insts:
#     reference = leaf_cell.item.reference
#     if reference not in count:
#         count[reference] = 1
#     else:
#         count[reference] += 1
#
#
# for key in sorted(count, key= lambda x: x.name):
#     print(key.name, count[key])

run()

# BITSLICE_CONTROL 12 X
# BUFGCE 5 X
# BUFG_GT 16 X
# BUFG_GT_SYNC 8 X
# GND 2029 X
# GTYE4_CHANNEL 4 X
# HPIO_VREF 4 X
# IBUFDS 1 X
# IBUFDS_GTE4 1 X
# IOBUFDS 4 X
# IOBUFE3 36 X
# MMCME4_ADV 1 X
# OBUF 25 X
# OBUFDS 1 X
# PLLE4_ADV 2 X
# RIU_OR 6 X
# RXTX_BITSLICE 65 X
# TX_BITSLICE_TRI 12 X
# VCC 1877 X
# emac_rx_fifocompare_7 1 X
# emac_rx_fifocompare_7_HD1089 1 X
# emac_rx_fifocompare_7_HD1153 1 X
# emac_rx_fifocompare_7_HD1217 1 X
# tri_mode_eth_mac_vtri_mode_ethernet_mac_v9_0_8 1 X
# tri_mode_eth_mac_vtri_mode_ethernet_mac_v9_0_8_HD1011 1 X
# tri_mode_eth_mac_vtri_mode_ethernet_mac_v9_0_8_HD1044 1 X
# tri_mode_eth_mac_vtri_mode_ethernet_mac_v9_0_8_HD978 1 X

# Purely Combinational
# AND2B1L 1
# CARRY8 1218
# LUT1 1067
# LUT2 5287
# LUT3 7709
# LUT4 8901
# LUT5 7185
# LUT6 26158
# LUT6_2 31
# MUXF7 4807
# MUXF8 1483

# Hybrid
# CFGLUT5 812 (async read, sync write)
# DSP48E2 6
# FDCE 10649 (async reset, sync D)
# FDCPE 64 (async reset/preset, sync D)
# FDPE 1014 (async reset, sync D)
# RAM32M 113
# RAM32M16 156
# RAM64M8 2148
# RAM64X1D 4096 (async read, sync write)
# SRL16E 1569 (async read, sync write)
# SRLC16E 4 (async read, sync write)
# SRLC32E 106 (async read, sync write)

# Purely Sequential
# FDRE 55173
# FDSE 2482
# RAMB18E2 7 X?
# RAMB36E2 261 X?

# So, let's exclude those components, what is left? How many clusters do we have? Clock domains? Can we then rank items
# clusters, or compoenents by this information.