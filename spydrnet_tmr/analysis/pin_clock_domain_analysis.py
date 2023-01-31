import spydrnet as sdn
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr.support_files.vendor_names import XILINX


def pin_clock_domain_analysis(netlist, include_blackboxes=True, vendor=XILINX):
    '''
    Finds all of the pins in a design involving clocks. (e.g. clk, clr, enable)

    :param netlist: the current netlist
    :param include_blackboxes:
    :type include_blackboxes: bool
    :return: a dictionary of 'instance clk/clr/etc. pin' to 'that pin's driver' entries
    '''
    primitive_info = load_primitive_info(netlist, vendor)

    leaf_cells = set(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf()))
    _report_leaf_count(leaf_cells)

    known_clock_ports = set(sdn.get_hports(leaf_cells,
                                           filter=lambda x: x.item.definition in primitive_info['sequential_cells'] and
                                                            x.item in
                                                            primitive_info['sequential_cells'][x.item.definition][
                                                                'clk_ports']))

    known_clock_wires = set(sdn.get_hwires(known_clock_ports, selection="ALL"))

    known_clock_srcs = set(sdn.get_hpins(known_clock_wires, filter=lambda x: x.item.port.definition.is_leaf() and
                                                                             x.item.port.direction is sdn.OUT and x.item.port.definition not in
                                                                             primitive_info['power_ground_cells']))

    clock_endpoints = _find_clock_endpoints_from_clock_sources(known_clock_srcs)
    _report_clock_endpoints_count(clock_endpoints)

    pin_clock_domains = dict()
    _propagate_clocks(primitive_info, clock_endpoints, pin_clock_domains)
    if include_blackboxes:
        _propagate_blackbox_drivers(primitive_info, netlist, pin_clock_domains)
    #_propagate_power_ground(primitive_info, netlist, pin_clock_domains)

    return pin_clock_domains


def _find_clock_endpoints_from_clock_sources(clock_sources):
    clock_endpoints = dict()

    for clock_source in clock_sources:
        wires = clock_source.get_hwires(selection="ALL")
        endpoints = set(
            sdn.get_hpins(wires, filter=lambda x: x.item.port.definition.is_leaf() and x.item.port.direction is sdn.IN))
        clock_endpoints[clock_source] = endpoints

    return clock_endpoints


def _report_leaf_count(leaf_cells):
    leaf_count = dict()
    for leaf_cell in leaf_cells:
        ref_name = leaf_cell.item.reference.name
        if ref_name not in leaf_count:
            leaf_count[ref_name] = 0
        leaf_count[ref_name] += 1
    print("REPORT: Leaf Count")
    for ref_name, count in leaf_count.items():
        print("  {}: {}".format(ref_name, count))


def _report_clock_endpoints_count(clock_endpoints):
    print("REPORT: Clock endpoints count")
    for clock_src, endpoints in clock_endpoints.items():
        print("  {}: {}".format(clock_src.name, len(endpoints)))


def _propagate_clocks(primitive_info, clock_endpoints, pin_clock_domains):
    for clock_src, endpoints in clock_endpoints.items():
        sync_drivers = list()
        for endpoint in endpoints:
            definition = endpoint.item.port.definition
            if definition in primitive_info['sequential_cells']:
                seq_cell_info = primitive_info['sequential_cells'][definition]
                clk_port_info = seq_cell_info['clk_ports'][endpoint.item.port]
                instance = endpoint.parent.parent
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
        _propagate_clock_from_drivers(primitive_info, clock_src, sync_drivers, pin_clock_domains)


def _propagate_blackbox_drivers(primitive_info, netlist, pin_clock_domains):
    global blackbox_drivers

    known_cell_types = set()
    known_cell_types.update(primitive_info['power_ground_cells'])
    known_cell_types.update(primitive_info['combinational_cells'])
    known_cell_types.update(primitive_info['sequential_cells'])

    blackbox_drivers = set(netlist.get_hpins(recursive=True, filter=lambda x: x.item.port.definition.is_leaf() and
                                                       x.item.port.direction is sdn.OUT and
                                                       x.item.port.definition not in known_cell_types))

    for blackbox_driver in blackbox_drivers:
        _propagate_clock_from_drivers(primitive_info, blackbox_driver, [blackbox_driver], pin_clock_domains)


def _propagate_clock_from_drivers(primitive_info, clock_src, drivers, pin_clock_domains):
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


def _propagate_power_ground(primitive_info, netlist, pin_clock_domains):
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

