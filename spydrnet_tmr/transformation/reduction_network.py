import spydrnet as sdn

lut_counter = 0

def _create_h_tree(wireMap):
    hTree = dict()

    # make tree
    for dwcPin, wire in wireMap.items():
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
    return hTree


# define lut6
def _define_lut6(netlist):
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
    return lut6

def _instance_lut6(netlist, lut_counter):
    # instance lut6
    lut6_inst = netlist.top_instance.reference.create_child()
    lut6_def = _define_lut6(netlist)
    lut6_inst.reference = lut6_def
    lut6_inst.name = "OR_REDUCTION_" + str(lut_counter)
    lut6_inst['EDIF.identifier'] = "OR_REDUCTION_" + str(lut_counter)
    properties = [{'identifier': 'INIT', 'value': "64'hFFFFFFFFFFFFFFFE"}]
    lut6_inst['EDIF.properties'] = properties
    return lut6_inst

def _get_gnd_wire(netlist):
    primitive_library = next(netlist.get_libraries('hdi_primitives'), None)
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
    gnd_inst = next(netlist.top_instance.get_instances('GND'), None)
    if not gnd_inst or gnd_inst.reference != gnd_def:
        gnd_inst = netlist.top_instance.reference.create_child()
        gnd_inst.reference = gnd_def
        gnd_inst.name = "GND"
        gnd_inst['EDIF.identifier'] = 'GND'
    gndPin = gnd_inst.pins[next(gnd_inst.get_ports('G')).pins[0]]
    gnd_wire = next(gndPin.get_wires(selection="OUTSIDE"), None)
    if not gnd_wire:
        gnd_cable = netlist.top_instance.reference.create_cable()
        gnd_cable.name = "%s[%d]" % ("LUT_GND", 0)
        gnd_cable['EDIF.identifier'] = "%s_%d_" % ("LUT_GND", 0)
        gnd_wire = gnd_cable.create_wire()
        gnd_wire.connect_pin(gndPin)
    return gnd_wire


def _add_lut6(netlist, currentTree, currentName, lutMap, lut_counter, gnd_wire):
    lut6_inst = _instance_lut6(netlist, lut_counter)

    if currentName is "top":
        hPinName = "DWC_REDUCED"
    else:
        hPinName = next(iter(currentTree))
        levels = hPinName.split("/")
        hPinName = ""

        for l in levels:
            if l is currentName:
                break
            hPinName += l + "/"
        hPinName += "lut6_"+str(lut_counter)+"/O"

    # for i,n in enumerate(sorted(currentTree, key=(lambda s: s.count("/"), lambda s: s))):
    for i, n in enumerate(sorted(currentTree, key=lambda s: (s.count("/"), s))):
        outer_in_pin = lut6_inst.pins[next(lut6_inst.get_ports('I' + str(i))).pins[0]]
        currentTree[n].connect_pin(outer_in_pin)
        del currentTree[n]
        if i is 5:
            break
    haveGround = False
    for ii in range(i + 1, 6):
        outer_in_pin = lut6_inst.pins[next(lut6_inst.get_ports('I' + str(ii))).pins[0]]
        gnd_wire.connect_pin(outer_in_pin)

    outer_out_pin = lut6_inst.pins[next(lut6_inst.get_ports('O')).pins[0]]

    # create new wire
    cable = netlist.top_instance.reference.create_cable()
    cable.name = "%s[%d]" % ("LUT6", lut_counter)
    cable['EDIF.identifier'] = "%s_%d_" % ("LUT6", lut_counter)
    # create and connect wire
    wire = cable.create_wire()
    wire.connect_pin(outer_out_pin)
    lutMap[hPinName] = wire

def _pass_leafs_grandparent(currentTree, currentName, stack):
    grandparent = stack[len(stack) - 1]
    for childName, childNode in currentTree.items():
        grandparent[childName] = childNode
    # erase visited child
    grandparent = {key: val for key, val in grandparent.items() if key != currentName}
    return grandparent


def create_reduction_network(netlist, wireMap):
    '''
    Creates a network of reduction voters. Ensures that no clock domains are crossed.

    For example, when doing DWC, one may want to know when a difference is detected. Instead of creating top-level output ports for every separate detector, a network of XOR gates can be created to signal when one of the detectors signals an error. This network output would require only one output port.

        :param netlist:
        :param wireMap:
        :return:
    '''
    global lut_counter
    hTree = _create_h_tree(wireMap)
    gnd_wire = _get_gnd_wire(netlist)

    # iterate tree
    currentTree = hTree
    stack = []
    nameStack = []
    nameStack.append("DONE")
    currentName = "top"

    while True:
        #iterate through childen, if child is a dict go to child
        for childName, childNode in currentTree.items():
            if isinstance(childNode, dict):
                stack.append(currentTree)
                nameStack.append(currentName)
                currentTree = childNode
                currentName = childName
                break
        #no childen are dicts, meaning all are leafs
        else:
            #if we have enough leafs to make a lut
            while len(currentTree) > 5:
                lutMap = dict()
                while len(currentTree) > 5:
                    _add_lut6(netlist, currentTree, currentName, lutMap, lut_counter, gnd_wire)
                    lut_counter += 1
                currentTree = {**currentTree,**lutMap}
            #pass remaining leafs to the grandparent and remove current parent from grandparent
            #If we are at top there is no grandparent so skip
            if currentName is not "top":
                stack[len(stack) - 1] = _pass_leafs_grandparent(currentTree, currentName, stack)
                currentTree = stack.pop()

            # We are back at the top of the tree. If there is more than 1 leaf remaining we need to
            #add one more lut6
            elif len(currentTree) > 1:
                # instance lut6
                lutMap = dict()
                _add_lut6(netlist, currentTree, currentName, lutMap, lut_counter, gnd_wire)
                lut_counter += 1
                currentTree = {**currentTree, **lutMap}

            currentName = nameStack.pop()
            #print(currentTree)
            if currentName is "DONE":
                return currentTree

def define_reg(netlist):
    # create library for jtag detector module
    regLibrary = sdn.Library()
    regLibrary.name = "detector_reg"
    regLibrary['EDIF.identifier'] = "detector_reg"
    # create its definition
    regDef = regLibrary.create_definition()
    regDef.name = "detector_register"
    regDef['EDIF.identifier'] = "detector_register"
    # add input ports, clk and D
    clkPort = regDef.create_port()
    clkPort.direction = sdn.IN
    clkPort.name = "clk"
    clkPort['EDIF.identifier'] = "clk"
    clkPort.create_pin()
    DPort = regDef.create_port()
    DPort.direction = sdn.IN
    DPort.name = "D"
    DPort['EDIF.identifier'] = 'D'
    Dpin = DPort.create_pin()
    #add outputport, Q
    QPort = regDef.create_port()
    QPort.name = 'Q'
    QPort['EDIF.identifier'] = 'Q'
    QPort.direction = sdn.OUT
    Qpin = QPort.create_pin()
    # add the new library to the netlist
    netlist.add_library(regLibrary, 0)

    return regDef

def registerDWCWires(netlist, wireMap, regDef, regName):


    # create a instance of the def in the top module
    top_definition = netlist.top_instance.reference
    regCounter = 0
    for dwcPin, wire in wireMap.items():
        regInstance = top_definition.create_child()
        regInstance.reference = regDef
        regInstance.name = "Reg_%s[%d]" % (regName, regCounter)
        regInstance['EDIF.identifier'] = "Reg_%s_%d" % (regName, regCounter)
        #print(next(regInstance.get_ports()).pins[0].name)
        DPin = regInstance.pins[next(regInstance.get_ports('D')).pins[0]]
        #DPin = regInstance.pins[InPin]
        wire.connect_pin(DPin)

        QPin = regInstance.pins[next(regInstance.get_ports('Q')).pins[0]]
        #QPin = regInstance.pins[OutPin]
        q_cable = top_definition.create_cable()
        q_cable.name = "%s[%d]" % (regName, regCounter)
        q_cable['EDIF.identifier'] = "%s_%d_" % (regName, regCounter)
        q_wire = q_cable.create_wire()
        q_wire.connect_pin(QPin)

        wireMap[dwcPin] = q_wire

        regCounter += 1

    return wireMap

def instance_JTAG_module(netlist, rail0Map, rail1Map):
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
    jtagDetectorPinsPortA = jtagPortA.create_pins(len(rail0Map))
    jtagPortB = jtagDef.create_port()
    jtagPortB.direction = sdn.IN
    jtagPortB.name = "signal_b"
    jtagPortB['EDIF.identifier'] = "signal_b"
    jtagDetectorPinsPortB = jtagPortB.create_pins(len(rail1Map))
    # add the new library to the netlist
    netlist.add_library(jtagLibrary, 1)
    # create a instance of the def in the top module
    jtagInstance = netlist.top_instance.reference.create_child()
    jtagInstance.reference = jtagDef
    jtagInstance.name = "jtag_interface"
    jtagInstance['EDIF.identifier'] = "jtag_interface"

    # connect detector rail wires to jtag module's port A
    for wire, portPin in zip(rail0Map.values(), jtagDetectorPinsPortA):
        wire.connect_pin(jtagInstance.pins[portPin])

    # connect detector rail wires to jtag module's port B
    for wire, portPin in zip(rail1Map.values(), jtagDetectorPinsPortB):
        wire.connect_pin(jtagInstance.pins[portPin])
