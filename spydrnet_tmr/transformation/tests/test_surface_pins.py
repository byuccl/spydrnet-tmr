import os
import unittest
import spydrnet as sdn
import spydrnet_tmr as sdn_sh
from spydrnet_tmr.transformation.surface_pins import surface_pins
from spydrnet_tmr.utils.design_rule_check.drc_surface_pins import check_surfaced_pins


class TestSurfacePins(unittest.TestCase):

    def test_surface_pins(self):
        # get example netlist
        netlist = sdn_sh.load_example_netlist_by_name("registered_inverter")

        # list of instances we will replicate
        instancesToReplicate = ["PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]", "COMBINATIONAL_LOGIC/O_INST_0"]

        # get H instances of instances to replicate
        hLeafsR = netlist.get_hinstances(instancesToReplicate, recursive=True)

        # get the objects of the H instances
        leafsR = list(l.item for l in hLeafsR)

        from spydrnet_tmr.transformation.replication.nmr import apply_nmr

        replicaMap = apply_nmr(leafsR, 2, "dwc", False)

        outaPins = sdn.get_pins(leafsR, selection=sdn.OUTSIDE)

        # filter
        outaPins = list(p for p in outaPins if p.inner_pin.port.direction is sdn.OUT)

        from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
        from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector

        detectorMap = insert_organs(replicaMap, outaPins, XilinxDWCDetector(), "detectorGaget")

        # seperate first and second detectors
        detectorGroup0 = list(dd[0] for dd in detectorMap.values())
        detectorGroup1 = list(dd[1] for dd in detectorMap.values())
        # gets pins for group0
        detectorGroup0OutaPins = sdn.get_pins(detectorGroup0, selection=sdn.OUTSIDE)
        # filter
        detectorGroup0OutaPins = list(p for p in detectorGroup0OutaPins if p.inner_pin.port.direction is sdn.OUT)

        # get pins for group1
        detectorGroup1OutaPins = sdn.get_pins(detectorGroup1, selection=sdn.OUTSIDE)
        # filter
        detectorGroup1OutaPins = list(p for p in detectorGroup1OutaPins if p.inner_pin.port.direction is sdn.OUT)

        surface_pins(detectorGroup0OutaPins, "DRail_0")
        surface_pins(detectorGroup1OutaPins, "DRail_1")

        self.assertTrue(check_surfaced_pins(detectorGroup0OutaPins,"DRail_0"))
        self.assertTrue(check_surfaced_pins(detectorGroup1OutaPins,"DRail_1"))

        netlist.compose('registered_detector_dwc2.edf')
        os.remove('registered_detector_dwc2.edf')


    def test_surface_pins_and_wire_to_black_box(self):
        # get example netlist
        netlist = sdn_sh.load_example_netlist_by_name("registered_inverter")

        # list of instances we will replicate
        instancesToReplicate = ["PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]", "COMBINATIONAL_LOGIC/O_INST_0"]

        # get H instances of instances to replicate
        hLeafsR = netlist.get_hinstances(instancesToReplicate, recursive=True)

        # get the objects of the H instances
        leafsR = list(l.item for l in hLeafsR)

        from spydrnet_tmr.transformation.replication.nmr import apply_nmr

        replicaMap = apply_nmr(leafsR, 2, "dwc", False)

        outaPins = sdn.get_pins(leafsR, selection=sdn.OUTSIDE)

        # filter
        outaPins = list(p for p in outaPins if p.inner_pin.port.direction is sdn.OUT)

        from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
        from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector

        detectorMap = insert_organs(replicaMap, outaPins, XilinxDWCDetector(), "detectorGaget")

        # seperate first and second detectors
        detectorGroup0 = list(dd[0] for dd in detectorMap.values())
        detectorGroup1 = list(dd[1] for dd in detectorMap.values())
        # gets pins for group0
        detectorGroup0OutaPins = sdn.get_pins(detectorGroup0, selection=sdn.OUTSIDE)
        # filter
        detectorGroup0OutaPins = list(p for p in detectorGroup0OutaPins if p.inner_pin.port.direction is sdn.OUT)

        # get pins for group1
        detectorGroup1OutaPins = sdn.get_pins(detectorGroup1, selection=sdn.OUTSIDE)
        # filter
        detectorGroup1OutaPins = list(p for p in detectorGroup1OutaPins if p.inner_pin.port.direction is sdn.OUT)

        dwcWiremap0 = surface_pins(detectorGroup0OutaPins, "DRail_0")
        dwcWiremap1 = surface_pins(detectorGroup1OutaPins, "DRail_1")

        self.assertTrue(check_surfaced_pins(detectorGroup0OutaPins,"DRail_0"))
        self.assertTrue(check_surfaced_pins(detectorGroup1OutaPins,"DRail_1"))

        # create library for jtag detector module
        jtagLibrary = sdn.Library()
        jtagLibrary.name = "DWC_JTAG"
        jtagLibrary['EDIF.identifier'] = "DWC_JTAG"
        # create its definition
        jtagDef = jtagLibrary.create_definition()
        jtagDef.name = "dwc_jtag_interface"
        jtagDef['EDIF.identifier'] = "dwc_jtag_interface"
        # add ports for detect rails with correct number of pins
        jtagPortA = jtagDef.create_port()
        jtagPortA.direction = sdn.IN
        jtagPortA.name = "signal_a"
        jtagPortA['EDIF.identifier'] = "signal_a"
        jtagDetectorPinsPortA = jtagPortA.create_pins(len(detectorGroup0))
        jtagPortB = jtagDef.create_port()
        jtagPortB.direction = sdn.IN
        jtagPortB.name = "signal_b"
        jtagPortB['EDIF.identifier'] = "signal_b"
        jtagDetectorPinsPortB = jtagPortB.create_pins(len(detectorGroup1))
        # add the new library to the netlist
        netlist.add_library(jtagLibrary, 1)
        # create a instance of the def in the top module
        jtagInstance = netlist.top_instance.reference.create_child()
        jtagInstance.name = "dwc_jtag_interface_u0"
        jtagInstance['EDIF.identifier'] = "dwc_jtag_interface_u0"
        jtagInstance.reference = jtagDef

        # connect detector rail wires to jtag module's port A
        for wire, portPin in zip(dwcWiremap0.values(), jtagDetectorPinsPortA):
            wire.connect_pin(jtagInstance.pins[portPin])

        # connect detector rail wires to jtag module's port B
        for wire, portPin in zip(dwcWiremap1.values(), jtagDetectorPinsPortB):
            wire.connect_pin(jtagInstance.pins[portPin])

        netlist.compose('registered_detector_dwc2.edf')
        os.remove('registered_detector_dwc2.edf')

    def test_reduction_tree(self):

        # get example netlist
        netlist = sdn_sh.load_example_netlist_by_name("registered_inverter")

        # list of instances we will replicate
        instancesToReplicate = ["PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]", "COMBINATIONAL_LOGIC/O_INST_0"]

        # get H instances of instances to replicate
        hLeafsR = netlist.get_hinstances(instancesToReplicate, recursive=True)

        # get the objects of the H instances
        leafsR = list(l.item for l in hLeafsR)

        from spydrnet_tmr.transformation.replication.nmr import apply_nmr

        replicaMap = apply_nmr(leafsR, 2, "dwc", False)

        outaPins = sdn.get_pins(leafsR, selection=sdn.OUTSIDE)

        # filter
        outaPins = list(p for p in outaPins if p.inner_pin.port.direction is sdn.OUT)

        from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
        from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector

        detectorMap = insert_organs(replicaMap, outaPins, XilinxDWCDetector(), "detectorGaget")

        # seperate first and second detectors
        detectorGroup0 = list(dd[0] for dd in detectorMap.values())
        detectorGroup1 = list(dd[1] for dd in detectorMap.values())
        # gets pins for group0
        detectorGroup0OutaPins = sdn.get_pins(detectorGroup0, selection=sdn.OUTSIDE)
        # filter
        detectorGroup0OutaPins = list(p for p in detectorGroup0OutaPins if p.inner_pin.port.direction is sdn.OUT)

        # get pins for group1
        detectorGroup1OutaPins = sdn.get_pins(detectorGroup1, selection=sdn.OUTSIDE)
        # filter
        detectorGroup1OutaPins = list(p for p in detectorGroup1OutaPins if p.inner_pin.port.direction is sdn.OUT)

        dwcWiremap0 = surface_pins(detectorGroup0OutaPins, "DRail_0")
        dwcWiremap1 = surface_pins(detectorGroup1OutaPins, "DRail_1")

        self.assertTrue(check_surfaced_pins(detectorGroup0OutaPins,"DRail_0"))
        self.assertTrue(check_surfaced_pins(detectorGroup1OutaPins,"DRail_1"))





        hTree = dict()

        # make tree
        for dwcPin, wire in dwcWiremap1.items():
            hpin = list(sdn.get_hpins(dwcPin))
            levels = (hpin[0].name).split("/")
            # print(levels)
            currentTree = hTree
            for l in levels:
                if l is "O":
                    currentTree[hpin[0].name] = wire
                else:
                    inserted = False
                    while (not inserted):
                        if l in currentTree.keys():
                            currentTree = currentTree[l]
                        else:
                            currentTree[l] = dict()
                            currentTree = currentTree[l]
                            inserted = True

        # define lut6
        primitive_library = next(netlist.get_libraries('hdi_primitives'), None)
        if not primitive_library:
            primitive_library = sdn.Library()
            primitive_library.name = 'hdi_primitives'
            primitive_library['EDIF.identifier'] = 'hdi_primitives'
            netlist.add_library(primitive_library, 0)
        lut6 = next(primitive_library.get_definitions('LUT6'), None)
        if not lut6:
            lut6 = primitive_library.create_definition()
            lut6.name = 'LUT6'
            lut6['EDIF.identifier'] = 'LUT6'
            for ii in range(6):
                inport = lut6.create_port()
                inport.name = 'I' + str(ii)
                inport['EDIF.identifier'] = 'I' + str(ii)
                inport.direction = sdn.IN
                inport.create_pin()
            outport = lut6.create_port()
            outport.name = 'O'
            outport['EDIF.identifier'] = 'O'
            outport.direction = sdn.OUT
            outport.create_pin()
        top_definition = netlist.top_instance.reference

        gnd_def = next(primitive_library.get_definitions('GND'), None)
        if not gnd_def:
            gnd_def = primitive_library.create_definition()
            gnd_def.name = 'GND'
            gnd_def['EDIF.identifier'] = 'GND'
            gnd_port = gnd_def.create_port()
            gnd_port.name = 'G'
            gnd_port['EDIF.identifier'] = 'G'
            gnd_port.direction = sdn.OUT
            gnd_port.create_pin()

        # iterate tree
        currentTree = hTree
        stack = []
        # stack.append("TOP")
        nameStack = []
        nameStack.append("DONE")
        # nameStack.append("top")
        currentName = "top"

        lut_counter = 0
        ground_counter = 0
        haveGround = False
        while True:
            leafs = 0
            # print(currentTree)
            # print(currentName)
            digging = False
            for childName, childNode in currentTree.items():
                # print("test:1")
                if isinstance(childNode, dict):
                    # print("test:2")
                    stack.append(currentTree)
                    nameStack.append(currentName)
                    currentTree = childNode
                    currentName = childName
                    digging = True
                    break
                else:
                    # print("test:3")
                    leafs += 1
            if digging:
                continue
            # print("test:4")
            while leafs > 5:
                # instance lut6
                lut6_inst = top_definition.create_child()
                lut6_inst.reference = lut6
                lut6_inst.name = "OR_REDUCTION_" + str(lut_counter)
                lut6_inst['EDIF.identifier'] = "OR_REDUCTION_" + str(lut_counter)
                properties = [{'identifier': 'INIT', 'value': "64'hFFFFFFFFFFFFFFFE"}]
                lut6_inst['EDIF.properties'] = properties

                hPinName = next(iter(currentTree))
                levels = hPinName.split("/")
                hPinName = ""
                for l in levels:
                    if l is currentName:
                        break
                    hPinName += l + "/"

                hPinName += "lut6/O"

                # for i,n in enumerate(sorted(currentTree, key=(lambda s: s.count("/"), lambda s: s))):
                for i, n in enumerate(sorted(currentTree, key=lambda s: (s.count("/"), s))):
                    outer_in_pin = lut6_inst.pins[next(lut6_inst.get_ports('I' + str(i))).pins[0]]
                    currentTree[n].connect_pin(outer_in_pin)
                    del currentTree[n]
                    leafs -= 1
                    if i is 6:
                        break

                outer_out_pin = lut6_inst.pins[next(lut6_inst.get_ports('0')).pins[0]]

                # create new wire
                cable = top_definition.create_cable()
                cable.name = "%s[%d]" % ("LUT6", lut_counter)
                cable['EDIF.identifier'] = "%s_%d_" % ("LUT6", lut_counter)
                # create and connect wire
                wire = cable.create_wire()
                wire.connect_pin(outer_out_pin)

                lut_counter += 1

                currentTree[hPinName] = wire

            if currentName is not "top":
                # put leafs on grandparent
                # get grandparent
                # print("test:5")
                grandparent = stack[len(stack) - 1]
                for childName, childNode in currentTree.items():
                    grandparent[childName] = childNode
                # erase visited child
                grandparent = {key: val for key, val in grandparent.items() if key != currentName}
                stack[len(stack) - 1] = grandparent
                currentTree = stack.pop()

            # top lut
            elif leafs > 1:
                # instance lut6
                lut6_inst = top_definition.create_child()
                lut6_inst.reference = lut6
                lut6_inst.name = "OR_REDUCTION_" + str(lut_counter)
                lut6_inst['EDIF.identifier'] = "OR_REDUCTION_" + str(lut_counter)

                properties = [{'identifier': 'INIT', 'value': "64'hFFFFFFFFFFFFFFFE"}]
                lut6_inst['EDIF.properties'] = properties

                # for i, n in enumerate(sorted(currentTree, key=(lambda s: s.count("/"), lambda s: s))):
                for i, n in enumerate(sorted(currentTree, key=lambda s: (s.count("/"), s))):
                    outer_in_pin = lut6_inst.pins[next(lut6_inst.get_ports('I' + str(i))).pins[0]]
                    currentTree[n].connect_pin(outer_in_pin)
                    del currentTree[n]

                for ii in range(i+1, 6):
                    outer_in_pin = lut6_inst.pins[next(lut6_inst.get_ports('I' + str(ii))).pins[0]]
                    if not haveGround:
                        gnd_inst = top_definition.create_child()
                        gnd_inst.reference = gnd_def
                        gnd_inst.name = "GND"
                        gnd_inst['EDIF.identifier'] = 'GND'
                        gndPin = gnd_inst.pins[next(gnd_inst.get_ports('G')).pins[0]]
                        gnd_cable = top_definition.create_cable()
                        gnd_cable.name = "%s[%d]" % ("LUT_GND", ground_counter)
                        gnd_cable['EDIF.identifier'] = "%s_%d_" % ("LUT_GND", ground_counter)
                        gnd_wire = gnd_cable.create_wire()
                        gnd_wire.connect_pin(gndPin)
                        haveGround = True
                    gnd_wire.connect_pin(outer_in_pin)

                outer_out_pin = lut6_inst.pins[next(lut6_inst.get_ports('O')).pins[0]]

                # create new wire
                cable = top_definition.create_cable()
                cable.name = "%s[%d]" % ("LUT6", lut_counter)
                cable['EDIF.identifier'] = "%s_%d_" % ("LUT6", lut_counter)
                # create and connect wire
                wire = cable.create_wire()
                wire.connect_pin(outer_out_pin)

                lut_counter += 1

                currentTree["DWC_Reduced"] = wire

            currentName = nameStack.pop()

            if currentName is "DONE":
                print(currentTree)
                hTree = currentTree
                break

        netlist.compose('registered_detector_dwc2.edf')
        os.remove('registered_detector_dwc2.edf')

    def test_register_detectors(self):
        # get example netlist
        netlist = sdn_sh.load_example_netlist_by_name("registered_inverter")

        # list of instances we will replicate
        instancesToReplicate = ["PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]", "COMBINATIONAL_LOGIC/O_INST_0"]

        # get H instances of instances to replicate
        hLeafsR = netlist.get_hinstances(instancesToReplicate, recursive=True)

        # get the objects of the H instances
        leafsR = list(l.item for l in hLeafsR)

        from spydrnet_tmr.transformation.replication.nmr import apply_nmr

        replicaMap = apply_nmr(leafsR, 2, "dwc", False)

        outaPins = sdn.get_pins(leafsR, selection=sdn.OUTSIDE)

        # filter
        outaPins = list(p for p in outaPins if p.inner_pin.port.direction is sdn.OUT)

        from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
        from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector

        detectorMap = insert_organs(replicaMap, outaPins, XilinxDWCDetector(), "detectorGaget")

        # seperate first and second detectors
        detectorGroup0 = list(dd[0] for dd in detectorMap.values())
        detectorGroup1 = list(dd[1] for dd in detectorMap.values())
        # gets pins for group0
        detectorGroup0OutaPins = sdn.get_pins(detectorGroup0, selection=sdn.OUTSIDE)
        # filter
        detectorGroup0OutaPins = list(p for p in detectorGroup0OutaPins if p.inner_pin.port.direction is sdn.OUT)

        # get pins for group1
        detectorGroup1OutaPins = sdn.get_pins(detectorGroup1, selection=sdn.OUTSIDE)
        # filter
        detectorGroup1OutaPins = list(p for p in detectorGroup1OutaPins if p.inner_pin.port.direction is sdn.OUT)

        dwcWiremap0 = surface_pins(detectorGroup0OutaPins, "DRail_0")
        dwcWiremap1 = surface_pins(detectorGroup1OutaPins, "DRail_1")

        self.assertTrue(check_surfaced_pins(detectorGroup0OutaPins,"DRail_0"))
        self.assertTrue(check_surfaced_pins(detectorGroup1OutaPins,"DRail_1"))

        # from spydrnet_tmr.transformation.reduction_network import create_reduction_network
        # from spydrnet_tmr.transformation.reduction_network import define_reg
        # from spydrnet_tmr.transformation.reduction_network import registerDWCWires, instance_JTAG_module

        # regDef = define_reg(netlist)

        # dwcWiremap0 = registerDWCWires(netlist, dwcWiremap0, regDef, "Reg_Q_0")
        # dwcWiremap1 = registerDWCWires(netlist, dwcWiremap1, regDef, "Reg_Q_1")

        # rail0Map = create_reduction_network(netlist, dwcWiremap0)
        # rail1Map = create_reduction_network(netlist, dwcWiremap1)

        # instance_JTAG_module(netlist, rail0Map, rail1Map)

        # netlist.compose('registered_detector_dwc2.edf')
