import os


def load_primitive_info(netlist, vendor):
    from spydrnet_tmr import base_dir

    primitive_info = dict()

    import json
    if "xilinx" in vendor:
        primitive_info_db = json.load(
            open(
                os.path.join(
                    base_dir,
                    "support_files",
                    "primitive_databases",
                    "xilinx_primitive_info_db.json",
                )
            )
        )
    if "lattice" in vendor:
        primitive_info_db = json.load(
            open(
                os.path.join(
                    base_dir,
                    "support_files",
                    "primitive_databases",
                    "lattice_primitive_info_db.json",
                )
            )
        )

    primitive_library = next(
        netlist.get_libraries(primitive_info_db["primitive_library_name"]),None
    )
    if primitive_library is None:
        primitive_library = next(netlist.get_libraries())
    primitive_info["primitive_library"] = primitive_library

    if "power_ground_cells" in primitive_info_db:
        power_ground_cells = set()
        primitive_info["power_ground_cells"] = power_ground_cells
        for power_ground_cell_info in primitive_info_db["power_ground_cells"]:
            # print(power_ground_cell_info["name"])
            power_ground_cell = next(
                primitive_library.get_definitions(power_ground_cell_info["name"]),
                None,
            )
            if power_ground_cell is None:
                continue
            power_ground_cells.add(power_ground_cell)

    if "clock_buffers" in primitive_info_db:
        clock_buffers = set()
        primitive_info["clock_buffers"] = clock_buffers
        for clock_buffer_info in primitive_info_db["clock_buffers"]:
            # print(clock_buffer_info["name"])
            clock_buffer = next(
                primitive_library.get_definitions(clock_buffer_info["name"]),
                None,
            )
            if clock_buffer is None:
                continue
            clock_buffers.add(clock_buffer)

    if "combinational_cells" in primitive_info_db:
        combinational_cells = set()
        primitive_info["combinational_cells"] = combinational_cells
        for combinational_cell_info in primitive_info_db["combinational_cells"]:
            # print(combinational_cell_info["name"])
            combinational_cell = next(
                primitive_library.get_definitions(combinational_cell_info["name"]),
                None,
            )
            if combinational_cell is None:
                continue
            combinational_cells.add(combinational_cell)

    if "complex_sequential_cells" in primitive_info_db:
        sequential_cells = dict()
        primitive_info["complex_sequential_cells"] = sequential_cells
        for seq_cell_info in primitive_info_db["complex_sequential_cells"]:
            sequential_cell = next(
                primitive_library.get_definitions(seq_cell_info["name"]), None
            )
            if sequential_cell is None:
                continue
            sequential_cell_dict = dict()
            sequential_cells[sequential_cell] = sequential_cell_dict

            if "description" in seq_cell_info:
                sequential_cell_dict["description"] = seq_cell_info["description"]

            if "clk_ports" in seq_cell_info:
                clock_pins = dict()
                sequential_cell_dict["clk_ports"] = clock_pins
                for clock_pin_info in seq_cell_info["clk_ports"]:
                    clock_pin = next(sequential_cell.get_ports(clock_pin_info["name"]))
                    clock_pin_dict = dict()
                    clock_pins[clock_pin] = clock_pin_dict

                    if "sync_ports" in clock_pin_info:
                        sync_ports = set()
                        clock_pin_dict["sync_ports"] = sync_ports
                        for sync_port_name in clock_pin_info["sync_ports"]:
                            sync_port = next(
                                sequential_cell.get_ports(
                                    sync_port_name + r"(?:\[[^\]]+\])?$",
                                    is_re=True,
                                )
                            )
                            sync_ports.add(sync_port)

            if "async_ports" in seq_cell_info:
                async_ports = set()
                sequential_cell_dict["async_ports"] = async_ports
                for async_port_name in seq_cell_info["async_ports"]:
                    async_port = next(
                        sequential_cell.get_ports(
                            async_port_name + r"(?:\[[^\]]+\])?$", is_re=True
                        )
                    )
                    async_ports.add(async_port)

    if "ff_cells" in primitive_info_db:
        ff_cells = dict()
        primitive_info["ff_cells"] = ff_cells
        for seq_cell_info in primitive_info_db["ff_cells"]:
            ff_cell = next(
                primitive_library.get_definitions(seq_cell_info["name"]), None
            )
            if ff_cell is None:
                continue
            ff_cell_dict = dict()
            ff_cells[ff_cell] = ff_cell_dict

            if "name" in seq_cell_info:
                ff_cell_dict["name"] = seq_cell_info["name"]

            if "description" in seq_cell_info:
                ff_cell_dict["description"] = seq_cell_info["description"]

            if "clk_ports" in seq_cell_info:
                clock_pins = dict()
                ff_cell_dict["clk_ports"] = clock_pins
                for clock_pin_info in seq_cell_info["clk_ports"]:
                    clock_pin = next(ff_cell.get_ports(clock_pin_info["name"]))
                    clock_pin_dict = dict()
                    clock_pins[clock_pin] = clock_pin_dict

                    if "sync_ports" in clock_pin_info:
                        sync_ports = set()
                        clock_pin_dict["sync_ports"] = sync_ports
                        for sync_port_name in clock_pin_info["sync_ports"]:
                            sync_port = next(
                                ff_cell.get_ports(
                                    sync_port_name + r"(?:\[[^\]]+\])?$",
                                    is_re=True,
                                )
                            )
                            sync_ports.add(sync_port)

            if "async_ports" in seq_cell_info:
                async_ports = set()
                ff_cell_dict["async_ports"] = async_ports
                for async_port_name in seq_cell_info["async_ports"]:
                    async_port = next(
                        ff_cell.get_ports(
                            async_port_name + r"(?:\[[^\]]+\])?$", is_re=True
                        )
                    )
                    async_ports.add(async_port)

    if "lut_cells" in primitive_info_db:
        lut_cells = set()
        primitive_info["lut_cells"] = lut_cells
        for lut_cell_info in primitive_info_db["lut_cells"]:
            # print(combinational_cell_info["name"])
            lut_cell = next(
                primitive_library.get_definitions(lut_cell_info["name"]),
                None,
            )
            if lut_cell is None:
                continue
            lut_cells.add(lut_cell)

    if 'carry_chain' in primitive_info_db:
        carry_chain_cells = dict()
        primitive_info["carry_chain"] = carry_chain_cells
        for carry_cell_info in primitive_info_db["carry_chain"]:
            carry_cell = next(primitive_library.get_definitions(carry_cell_info["name"]), None)
            if carry_cell is None:
                continue

            carry_cell_dict = dict()
            carry_chain_cells[carry_cell] = carry_cell_dict

            if "ports" in carry_cell_info:
                if "carry_in" in carry_cell_info["ports"]:
                    port_name_list = carry_cell_info["ports"]["carry_in"]
                    # carry_in_port = next(carry_cell.get_ports(port_name), None)
                    # if carry_in_port:
                    carry_cell_dict["carry_in"] = port_name_list
                if "carry_out" in carry_cell_info["ports"]:
                    port_name_list = carry_cell_info["ports"]["carry_out"]
                    # carry_out_port = next(carry_cell.get_ports(port_name), None)
                    # if carry_out_port:
                    carry_cell_dict["carry_out"] = port_name_list

    # combine ff_cells and complex_sequential_cells into a single sequential_cells section
    if 'ff_cells' in primitive_info.keys():
        primitive_info["sequential_cells"] = primitive_info['ff_cells'].copy()
    else:
        primitive_info["sequential_cells"] = dict()
    if "complex_sequential_cells" in primitive_info.keys():
        primitive_info["sequential_cells"].update(primitive_info["complex_sequential_cells"])

    return primitive_info
