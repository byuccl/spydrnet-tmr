'''
Clock Domain Analysis
=====================
'''
import spydrnet as sdn
import spydrnet_shrec as sdn_shrec

netlist_filename = r"reference_switch-baseline-pblock-20180511.edf"
primitive_info_filename = r"primitive_info_db.json"

# netlist = None
primitive_info = None
leaf_cells = None
known_clock_ports = None
clock_srcs = None
clock_endpoints = None

def run():
    parse_netlist()
    parse_primitive_info()

    find_all_leaf_cells()
    report_leaf_count()

    identify_known_clock_ports()

    identify_clock_srcs()

    identify_clock_endpoints()
    report_clock_endpoints_count()

    propagate_clocks()

    #propagate_power_ground()

    propagate_blackbox_drivers()

    find_synchronizers()

    find_immediate_registers()

    find_selection()

    save_selection('aggressive_nmr_selection_rev3.txt')

    print("party_time")


def parse_netlist():
    global netlist
    if 'netlist' not in globals() or netlist is None:
        netlist = sdn.parse(netlist_filename)


def parse_primitive_info():
    global primitive_info
    primitive_info = sdn_shrec.load_primitive_info(netlist)


def find_all_leaf_cells():
    global leaf_cells
    leaf_cells = sdn_shrec.find_all_leaf_cells(netlist)


def report_leaf_count():
    leaf_count = dict()
    for leaf_cell in leaf_cells:
        ref_name = leaf_cell.item.reference.name
        if ref_name not in leaf_count:
            leaf_count[ref_name] = 0
        leaf_count[ref_name] += 1
    print("REPORT: Leaf Count")
    for ref_name, count in leaf_count.items():
        print("  {}: {}".format(ref_name, count))


def identify_known_clock_ports():
    global known_clock_ports
    known_clock_ports = set()

    for leaf_cell in leaf_cells:
        ref = leaf_cell.item.reference
        if ref in primitive_info['sequential_cells']:
            ref_info = primitive_info['sequential_cells'][ref]
            clk_pins = list(leaf_cell.get_hports(filter=lambda x: x.item in ref_info['clk_ports']))
            known_clock_ports.update(clk_pins)


def identify_clock_srcs():
    global clock_srcs

    clock_wires = list(sdn.get_hwires(known_clock_ports, selection="ALL"))
    clock_pins = set(sdn.get_hpins(clock_wires, filter=lambda x: x.item.port.direction is sdn.OUT and
                                                                 x.item.port.definition.is_leaf() and
                                                                 x.item.port.definition.name not in {"GND", "VCC"}))
    clock_srcs = clock_pins


def identify_clock_endpoints():
    global clock_endpoints
    clock_endpoints = dict()

    for clock_src in clock_srcs:
        clock_nets = list(clock_src.get_hwires(selection="ALL"))
        endpoints = set(sdn.get_hports(clock_nets, filter=lambda x: x.item.direction is sdn.IN and
                                                                    x.item.definition.is_leaf()))
        clock_endpoints[clock_src] = endpoints


def report_clock_endpoints_count():
    print("REPORT: Clock endpoints count")
    for clock_src, endpoints in clock_endpoints.items():
        print("  {}: {}".format(clock_src.name, len(endpoints)))


def propagate_clocks():
    global pin_clock_domains
    pin_clock_domains = dict()

    for clock_src, endpoints in clock_endpoints.items():
        sync_drivers = list()
        for endpoint in endpoints:
            definition = endpoint.item.definition
            if definition in primitive_info['sequential_cells']:
                seq_cell_info = primitive_info['sequential_cells'][definition]
                clk_port_info = seq_cell_info['clk_ports'][endpoint.item]
                instance = endpoint.parent
                sink_ports = list(instance.get_hports(filter=lambda x:x.item in clk_port_info['sync_ports'] and
                                                                  x.item.direction is sdn.IN))
                sink_pins = list(sdn.get_hpins(sink_ports))
                for sink_pin in sink_pins:
                    if sink_pin not in pin_clock_domains:
                        pin_clock_domains[sink_pin] = [clock_src]
                    elif clock_src not in pin_clock_domains[sink_pin]:
                        pin_clock_domains[sink_pin].append(clock_src)
                driver_ports = list(instance.get_hports(filter=lambda x:x.item in clk_port_info['sync_ports'] and
                                                                  x.item.direction is sdn.OUT))
                if len(driver_ports) > 0:
                    sync_drivers += sdn.get_hpins(driver_ports)
        propagate_clock_from_drivers(clock_src, sync_drivers)


def propagate_power_ground():
    global pin_clock_domains
    global power_ground_drivers

    pwr_gnd_prims = primitive_info['power_ground_cells']
    power_ground_cells = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference in pwr_gnd_prims))
    power_ground_drivers = set(sdn.get_hpins(power_ground_cells))

    for power_ground_driver in power_ground_drivers:
        power_ground_wires = list(sdn.get_hwires(power_ground_driver, selection="ALL"))
        power_ground_sinks = list(sdn.get_hpins(power_ground_wires,
                                                filter=lambda x: x.item.port.definition.is_leaf() and
                                                                 x.item.port.direction is sdn.IN))
        for sink_pin in power_ground_sinks:
            if sink_pin not in pin_clock_domains:
                pin_clock_domains[sink_pin] = [power_ground_driver]
            elif power_ground_driver not in pin_clock_domains[sink_pin]:
                pin_clock_domains[sink_pin].append(power_ground_driver)


def propagate_blackbox_drivers():
    global blackbox_drivers

    known_cell_types = set()
    known_cell_types.update(primitive_info['power_ground_cells'])
    known_cell_types.update(primitive_info['combinational_cells'])
    known_cell_types.update(primitive_info['sequential_cells'])

    blackbox_drivers = set(netlist.get_hpins(recursive=True, filter=lambda x: x.item.port.definition.is_leaf() and
                                                       x.item.port.direction is sdn.OUT and
                                                       x.item.port.definition not in known_cell_types))

    for blackbox_driver in blackbox_drivers:
        propagate_clock_from_drivers(blackbox_driver, [blackbox_driver])


def propagate_clock_from_drivers(clock_src, drivers):
    global pin_clock_domains

    hop_count = 0
    while len(drivers) > 0:
        hop_count += 1
        filtered_drivers = list()
        for driver in drivers:
            if driver not in pin_clock_domains:
                pin_clock_domains[driver] = [clock_src]
            elif clock_src not in pin_clock_domains[driver]:
                pin_clock_domains[driver].append(clock_src)
            else:
                continue
            filtered_drivers.append(driver)

        drivers = set()

        if len(filtered_drivers) > 0:
            connected_wires = list(sdn.get_hwires(filtered_drivers, selection="ALL"))
            sink_pins = list(sdn.get_hpins(connected_wires, filter=lambda x: x.item.port.definition.is_leaf() and
                                                                         x.item.port.direction is sdn.IN))
            filtered_sync_pins = list()
            for sink_pin in sink_pins:
                if sink_pin not in pin_clock_domains:
                    pin_clock_domains[sink_pin] = [clock_src]
                elif clock_src not in pin_clock_domains[sink_pin]:
                    pin_clock_domains[sink_pin].append(clock_src)
                else:
                    continue
                filtered_sync_pins.append(sink_pin)

            for filtered_sync_pin in filtered_sync_pins:
                definition = filtered_sync_pin.item.port.definition
                if definition in primitive_info['combinational_cells']:
                    port = filtered_sync_pin.parent
                    instance = port.parent
                    drivers.update(instance.get_hpins(filter=lambda x: x.item.port.direction is sdn.OUT))
                elif definition in primitive_info['sequential_cells']:
                    seq_cell_info = primitive_info['sequential_cells'][definition]
                    if 'async_ports' in seq_cell_info:
                        async_ports = seq_cell_info['async_ports']
                        if filtered_sync_pin.item.port in async_ports:
                            port = filtered_sync_pin.parent
                            instance = port.parent
                            drivers.update(instance.get_hpins(filter=lambda x: x.item.port.direction is sdn.OUT and
                                                                               x.item.port in async_ports))


def find_synchronizers():
    global synchronizer_chains
    multiple_clocks = list(x for x in pin_clock_domains if len(pin_clock_domains[x]) > 1)
    multiple_clocks_seq = set(x.parent.parent for x in multiple_clocks if x.item.port.definition in
                              primitive_info['sequential_cells'])
    flip_flop_search = list(x for x in multiple_clocks_seq if x.item.reference.name.startswith('FD'))
    synchronizer_head = dict()
    synchronizer_tail = dict()
    found = set()
    while flip_flop_search:
        flip_flop = flip_flop_search.pop()
        if flip_flop in found:
            continue
        found.add(flip_flop)
        output_pins = list(flip_flop.get_hpins(filter=lambda x: x.item.port.direction is sdn.OUT))
        driven_wires = list(sdn.get_hwires(output_pins, selection="ALL"))
        input_pins = list(sdn.get_hpins(driven_wires, filter=lambda x: x.item.port.definition.is_leaf() and
                                        x.item.port.direction is sdn.IN))
        sync_nodes = list(sdn.get_hinstances(input_pins))
        if len(sync_nodes) == 1 and all(x.item.reference.name.startswith('FD') for x in sync_nodes):
            sync_node = sync_nodes[0]

            flip_flop_clock_pin = next(flip_flop.get_hpins("C"))
            sync_node_clock_pin = next(sync_node.get_hpins("C"))
            flip_flop_clocks = pin_clock_domains[flip_flop_clock_pin]
            sync_node_clocks = pin_clock_domains[sync_node_clock_pin]
            if frozenset(flip_flop_clocks) != frozenset(sync_node_clocks):
                continue

            if sync_node in synchronizer_head:
                chain = synchronizer_head.pop(sync_node)
                chain.insert(0,flip_flop)
                synchronizer_head[flip_flop] = chain
            elif flip_flop in synchronizer_tail:
                chain = synchronizer_tail.pop(flip_flop)
                chain.append(sync_node)
                synchronizer_tail[sync_node] = chain
                flip_flop_search.append(sync_node)
            else:
                chain = [flip_flop, sync_node]
                synchronizer_head[flip_flop] = chain
                synchronizer_tail[sync_node] = chain
                flip_flop_search.append(sync_node)
    synchronizer_chains = list(synchronizer_head.values())


def find_immediate_registers():
    global immediate_registers
    currently_excluded = set()
    for chain in synchronizer_chains:
        currently_excluded.update(chain)

    for leaf_cell in leaf_cells:
        reference = leaf_cell.item.reference
        if reference not in primitive_info['combinational_cells'] and \
            reference not in primitive_info['sequential_cells']:
            currently_excluded.add(leaf_cell)

    ports = list(sdn.get_hports(currently_excluded))
    nets = list(sdn.get_hwires(ports, selection="ALL"))
    drivers = list(sdn.get_hpins(nets, filter=lambda x: x.item.port.definition.is_leaf() and
                                   x.item.port.direction is sdn.OUT))
    driver_instances = set(sdn.get_hinstances(drivers, filter=lambda x: x not in currently_excluded and
                                                                            x.item.reference.name.startswith('FD')))
    immediate_registers = driver_instances


def find_selection():
    global selection
    selection = set()

    multiple_clock_domain_leaf_cells = set(x.parent.parent for x, y in pin_clock_domains.items() if len(y) > 1)
    print("Multiple clock domain cells: ", len(multiple_clock_domain_leaf_cells))
    synchronizers = set()
    for chain in synchronizer_chains:
        synchronizers.update(chain)
    print("Synchronizers: ", len(synchronizers))

    for leaf_cell in leaf_cells:
        if leaf_cell not in synchronizers and leaf_cell not in multiple_clock_domain_leaf_cells:
            reference = leaf_cell.item.reference
            if reference in primitive_info['combinational_cells'] or reference in primitive_info['sequential_cells']:
                selection.add(leaf_cell)

    print("Leaf Cells in Selection: ", len(selection))



def find_selection_rev2():
    global selection
    selection = set()

    synchronizers = set()
    for chain in synchronizer_chains:
        synchronizers.update(chain)

    for leaf_cell in leaf_cells:
        if leaf_cell not in synchronizers and leaf_cell not in immediate_registers:
            reference = leaf_cell.item.reference
            if reference in primitive_info['combinational_cells'] or reference in primitive_info['sequential_cells']:
                selection.add(leaf_cell)


def save_selection(filename):
    with open(filename, 'w') as fi:
        for cell in selection:
            fi.write(cell.name + '\n')


run()
