import spydrnet as sdn
from spydrnet.util.selection import Selection
from spydrnet.util.netlist_type import EDIF, VERILOG, EBLIF


class Organ:
    def ensure_definition_in_netlist(self, netlist):
        pass

    def get_primary_input_pin(self):
        return None

    def get_other_input_pins(self):
        return None

    def get_primary_output_pin(self):
        return None

    def create_instance(self):
        return None


class XilinxTMRVoter(Organ):
    """
    A LUT3 with INIT value 8'hE8. Votes by majority. To ensure that properties of the voter are correct for the target netlist type, the netlist_type must be specified.

    .. figure:: ../../figures/voter.*
        :width: 800px
        :align: center

    :param netlist_type: either EDIF, EBLIF, or Verilog
    """
    def __init__(self, netlist_type=EDIF):
        self.netlist_type = netlist_type
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None
        self.organ_class = None
    
    def ensure_definition_in_netlist(self, netlist):
        if (self.netlist_type is EBLIF or self.netlist_type == "EBLIF"):
            # print("EBLIF voter detected")
            self.organ_class = XilinxTMRVoterEBLIF()
            self.organ_class.ensure_definition_in_netlist(netlist)
        elif (self.netlist_type is EDIF or self.netlist_type == "EDIF"):
            # print("EDIF voter detected")
            self.organ_class = XilinxTMRVoterEDIF()
            self.organ_class.ensure_definition_in_netlist(netlist)
        elif (self.netlist_type is VERILOG or self.netlist_type == "Verilog"):
            # print("Verilog voter detected")
            self.organ_class = XilinxTMRVoterVerilog()
            self.organ_class.ensure_definition_in_netlist(netlist)
        else: #default to EDIF
            self.organ_class = XilinxTMRVoterEDIF()
            self.organ_class.ensure_definition_in_netlist(netlist)

    def get_primary_input_pin(self):
        return self.organ_class.get_primary_input_pin()

    def get_other_input_pins(self):
        return self.organ_class.get_other_input_pins()

    def get_primary_output_pin(self):
        return self.organ_class.get_primary_output_pin()

    def create_instance(self):
        return self.organ_class.create_instance()


class XilinxTMRVoterEDIF(Organ):
    """
    A LUT3 with INIT value 8'hE8. Votes by majority.

    .. figure:: ../../figures/voter.*
        :width: 800px
        :align: center
    """

    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("hdi_primitives"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "hdi_primitives"
            primitive_library["EDIF.identifier"] = primitive_library.name

        primitive_definition = next(
            primitive_library.get_definitions("LUT3"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "LUT3"
            primitive_definition["EDIF.identifier"] = primitive_definition.name
            for ii in range(3):
                input_port = primitive_definition.create_port()
                input_port.name = "I" + str(ii)
                input_port["EDIF.identifier"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()
            output_port = primitive_definition.create_port()
            output_port.name = "O"
            output_port["EDIF.identifier"] = output_port.name
            output_port.direction = sdn.OUT
            output_port.create_pin()

        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("I0")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("I1")).pins[0],
            next(self._definition.get_ports("I2")).pins[0],
        ]
        self._primary_output_pin = next(self._definition.get_ports("O")).pins[
            0
        ]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        properties = [{"identifier": "INIT", "value": "8'hE8"}]
        instance["EDIF.properties"] = properties
        instance.reference = self._definition
        return instance

class XilinxTMRVoterEBLIF(Organ):
    """
    A LUT3 with INIT value 8'hE8. Votes by majority.

    .. figure:: ../../figures/voter.*
        :width: 800px
        :align: center
    """

    def __init__(self, netlist_type="EBLIF"):
        self.netlist_type = netlist_type
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries(), None)
        primitive_definition = next(
            primitive_library.get_definitions("LUT3"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "LUT3"
            primitive_definition["EBLIF.blackbox"] = True
            for ii in range(3):
                input_port = primitive_definition.create_port()
                input_port.name = "I" + str(ii)
                input_port["EBLIF.cname"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()
            output_port = primitive_definition.create_port()
            output_port.name = "O"
            output_port["EBLIF.cname"] = output_port.name
            output_port.direction = sdn.OUT
            output_port.create_pin()

        primitive_definition["EBLIF.blackbox"] = True
        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("I0")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("I1")).pins[0],
            next(self._definition.get_ports("I2")).pins[0],
        ]
        self._primary_output_pin = next(self._definition.get_ports("O")).pins[
            0
        ]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        properties = {"INIT":"8'hE8"}
        instance["EBLIF.param"] = properties
        instance.reference = self._definition
        instance['TYPE'] = ".subckt"
        return instance

class XilinxTMRVoterVerilog(Organ):
    """
    A LUT3 with INIT value 8'hE8. Votes by majority.

    .. figure:: ../../figures/voter.*
        :width: 800px
        :align: center
    """

    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("hdi_primitives"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "hdi_primitives"
            # primitive_library["EDIF.identifier"] = primitive_library.name

        primitive_definition = next(
            primitive_library.get_definitions("LUT3"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "LUT3"
            primitive_definition["VERILOG.primitive"] = True
            for ii in range(3):
                input_port = primitive_definition.create_port()
                input_port.name = "I" + str(ii)
                # input_port["EDIF.identifier"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()
            output_port = primitive_definition.create_port()
            output_port.name = "O"
            # output_port["EDIF.identifier"] = output_port.name
            output_port.direction = sdn.OUT
            output_port.create_pin()

        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("I0")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("I1")).pins[0],
            next(self._definition.get_ports("I2")).pins[0],
        ]
        self._primary_output_pin = next(self._definition.get_ports("O")).pins[
            0
        ]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        properties = {"INIT": "8'hE8"}
        instance["VERILOG.Parameters"] = properties
        instance.reference = self._definition
        return instance


class XilinxDWCDetector(Organ):
    """
    A LUT2 with INIT value 4'h6. Acts like an XOR gate.

    .. figure:: ../../figures/detector.*
        :width: 800px
        :align: center
    """

    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("hdi_primitives"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "hdi_primitives"
            primitive_library["EDIF.identifier"] = primitive_library.name

        primitive_definition = next(
            primitive_library.get_definitions("LUT2"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "LUT2"
            primitive_definition["EDIF.identifier"] = primitive_definition.name
            for ii in range(2):
                input_port = primitive_definition.create_port()
                input_port.name = "I" + str(ii)
                input_port["EDIF.identifier"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()
            output_port = primitive_definition.create_port()
            output_port.name = "O"
            output_port["EDIF.identifier"] = output_port.name
            output_port.direction = sdn.OUT
            output_port.create_pin()

        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("I0")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("I1")).pins[0]
        ]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return None

    def create_instance(self):
        instance = sdn.Instance()
        properties = [{"identifier": "INIT", "value": "4'h6"}]
        instance["EDIF.properties"] = properties
        instance.reference = self._definition
        return instance

class GenericEBLIFVoter(Organ):
    """
    A TMR voter in a generic blif format. Votes by majority.

    .. figure:: ../../figures/voter.*
        :width: 800px
        :align: center
    """

    def __init__(self, netlist_type=EBLIF):
        self.netlist_type = netlist_type
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries(), None)
        primitive_definition = next(
            primitive_library.get_definitions("logic-gate_3"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "logic-gate_3"
            for ii in range(3):
                input_port = primitive_definition.create_port()
                input_port.name = "in_" + str(ii)
                input_port["EBLIF.cname"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()
            output_port = primitive_definition.create_port()
            output_port.name = "out"
            output_port["EBLIF.cname"] = output_port.name
            output_port.direction = sdn.OUT
            output_port.create_pin()

        primitive_definition["EBLIF.blackbox"] = True
        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("in_0")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("in_1")).pins[0],
            next(self._definition.get_ports("in_2")).pins[0],
        ]
        self._primary_output_pin = next(self._definition.get_ports("out")).pins[
            0
        ]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        # properties = {"INIT":"8'hE8"}
        # instance["EBLIF.param"] = properties
        output_covers = list()
        output_covers.append("011 1")
        output_covers.append("110 1")
        output_covers.append("101 1")
        output_covers.append("111 1")
        instance["EBLIF.output_covers"] = output_covers
        instance.reference = self._definition
        instance["EBLIF.type"] = "EBLIF.names"
        return instance


class StickyDWCDetector(Organ):
    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("dwc_support"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "dwc_support"
            primitive_library["EDIF.identifier"] = primitive_library.name

        primitive_definition = next(
            primitive_library.get_definitions("sticky_detector"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "sticky_detector"
            primitive_definition["EDIF.identifier"] = primitive_definition.name
            for ii in range(2):
                input_port = primitive_definition.create_port()
                input_port.name = "I" + str(ii)
                input_port["EDIF.identifier"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()

            input_port = primitive_definition.create_port()
            input_port.name = "clk"
            input_port["EDIF.identifier"] = input_port.name
            input_port.direction = sdn.IN
            input_port.create_pin()

            input_port = primitive_definition.create_port()
            input_port.name = "rst"
            input_port["EDIF.identifier"] = input_port.name
            input_port.direction = sdn.IN
            input_port.create_pin()

        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("I0")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("I1")).pins[0]
        ]
        self._other_input_pins.append(
            next(self._definition.get_ports("rst")).pins[0]
        )
        self._other_input_pins.append(
            next(self._definition.get_ports("clk")).pins[0]
        )

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return None

    def create_instance(self):
        instance = sdn.Instance()
        properties = [{"identifier": "INIT", "value": "4'h6"}]
        instance["EDIF.properties"] = properties
        instance.reference = self._definition
        return instance


class JTAG(Organ):
    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("dwc_support"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "dwc_support"
            primitive_library["EDIF.identifier"] = primitive_library.name

        primitive_definition = next(
            primitive_library.get_definitions("jtag"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "jtag"
            primitive_definition["EDIF.identifier"] = primitive_definition.name

            output_port = primitive_definition.create_port()
            output_port.direction = sdn.OUT
            output_port.create_pins(32)
            output_port.name = "O[31:0]"
            output_port["EDIF.identifier"] = "O_31_0_"

        self._definition = primitive_definition
        self._primary_output_pin = next(
            self._definition.get_ports("O[31:0]")
        ).pins[0]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        instance.reference = self._definition
        return instance


class XilinxCombinedOrgan(Organ):
    """
    Contains both a voter (:ref:`xilinx_tmr_voter`) and a detector (:ref:`xilinx_dwc_detector`). The voter votes like normal, and the detector signals if that TMR domain's signal is different from the majority vote (it's the odd man out)

    .. figure:: ../../figures/combined_organ.*
        :width: 800px
        :align: center
    """

    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None
        self.netlist_type = EDIF # only edif is supported for now

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("organs"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "organs"
            primitive_library["EDIF.identifier"] = primitive_library.name
        primitive_definition = next(
            primitive_library.get_definitions("combined_organ"), None
        )
        if primitive_definition is None:
            def_combined_organ = primitive_library.create_definition(
                name="combined_organ"
            )
            port_a = def_combined_organ.create_port(
                name="Primary", direction=sdn.IN
            )
            port_combined_organ_b = def_combined_organ.create_port(
                name="Other_1", direction=sdn.IN
            )
            port_combined_organ_c = def_combined_organ.create_port(
                name="Other_2", direction=sdn.IN
            )
            port_q1 = def_combined_organ.create_port(
                name="Q1", direction=sdn.OUT
            )
            port_q2 = def_combined_organ.create_port(
                name="Q2", direction=sdn.OUT
            )

            pin_combined_organ_a = port_a.create_pin()
            pin_combined_organ_b = port_combined_organ_b.create_pin()
            pin_combined_organ_c = port_combined_organ_c.create_pin()
            pin_combined_organ_q1 = port_q1.create_pin()
            pin_combined_organ_q2 = port_q2.create_pin()

            cable_a = def_combined_organ.create_cable(name="Primary")
            cable_b = def_combined_organ.create_cable(name="Other_1")
            cable_c = def_combined_organ.create_cable(name="Other_2")
            cable_q_1 = def_combined_organ.create_cable(name="Q1")
            cable_q_2 = def_combined_organ.create_cable(name="Q2")

            wire_a = cable_a.create_wire()
            wire_b = cable_b.create_wire()
            wire_c = cable_c.create_wire()
            wire_q_1 = cable_q_1.create_wire()
            wire_q_2 = cable_q_2.create_wire()

            XilinxTMRVoter.ensure_definition_in_netlist(self, netlist)
            voter = XilinxTMRVoter.create_instance(self)
            voter.name = "VOTER"

            XilinxDWCDetector.ensure_definition_in_netlist(self, netlist)
            detector = XilinxDWCDetector.create_instance(self)
            detector.name = "DETECTOR"

            def_combined_organ.add_child(voter)
            def_combined_organ.add_child(detector)

            wire_a.connect_pin(pin_combined_organ_a)
            port = next(voter.get_ports("I0"), None)
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is voter,
                )
            )
            wire_a.connect_pin(pin)

            wire_b.connect_pin(pin_combined_organ_b)
            port = next(voter.get_ports("I1"), None)
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is voter,
                )
            )
            wire_b.connect_pin(pin)

            wire_c.connect_pin(pin_combined_organ_c)
            port = next(voter.get_ports("I2"), None)
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is voter,
                )
            )
            wire_c.connect_pin(pin)

            wire_q_1.connect_pin(pin_combined_organ_q1)
            port = next(voter.get_ports("O"), None)
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is voter,
                )
            )
            wire_q_1.connect_pin(pin)

            port = next(detector.get_ports("I0"))
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is detector,
                )
            )
            wire_a.connect_pin(pin)

            port = next(detector.get_ports("I1"))
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is detector,
                )
            )
            wire_q_1.connect_pin(pin)

            wire_q_2.connect_pin(pin_combined_organ_q2)
            port = next(detector.get_ports("O"))
            pin = next(
                port.get_pins(
                    selection=Selection.OUTSIDE,
                    filter=lambda x: x.instance is detector,
                )
            )
            wire_q_2.connect_pin(pin)

            self._definition = def_combined_organ
            self._primary_input_pin = next(
                self._definition.get_ports("Primary")
            ).pins[0]
            self._other_input_pins = [
                next(self._definition.get_ports("Other_1")).pins[0]
            ]
            self._other_input_pins.append(
                next(self._definition.get_ports("Other_2")).pins[0]
            )
            self._primary_output_pin = pin_combined_organ_q1

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        instance.reference = self._definition
        return instance

class LatticeTMRVoter(Organ):
    """
    A LUT3 with INIT value 8'hE8. Votes by majority.

    .. figure:: ../../figures/voter.*
        :width: 800px
        :align: center
    """

    def __init__(self):
        self._definition = None
        self._primary_input_pin = None
        self._other_input_pins = None
        self._primary_output_pin = None

    def ensure_definition_in_netlist(self, netlist):
        primitive_library = next(netlist.get_libraries("hdi_primitives"), None)
        if primitive_library is None:
            primitive_library = sdn.Library()
            netlist.add_library(primitive_library, 0)
            primitive_library.name = "hdi_primitives"
            # primitive_library["EDIF.identifier"] = primitive_library.name

        primitive_definition = next(
            primitive_library.get_definitions("LUT4"), None
        )
        if primitive_definition is None:
            primitive_definition = primitive_library.create_definition()
            primitive_definition.name = "LUT4"
            # primitive_definition["EDIF.identifier"] = primitive_definition.name
            for ii in ["A", "B", "C", "D"]:
                input_port = primitive_definition.create_port()
                input_port.name = ii
                # input_port["EDIF.identifier"] = input_port.name
                input_port.direction = sdn.IN
                input_port.create_pin()
            output_port = primitive_definition.create_port()
            output_port.name = "Z"
            # output_port["EDIF.identifier"] = output_port.name
            output_port.direction = sdn.OUT
            output_port.create_pin()

        self._definition = primitive_definition
        self._primary_input_pin = next(self._definition.get_ports("A")).pins[
            0
        ]
        self._other_input_pins = [
            next(self._definition.get_ports("B")).pins[0],
            next(self._definition.get_ports("C")).pins[0]
            # next(self._definition.get_ports("D")).pins[0] # ignore this pin
        ]
        self._primary_output_pin = next(self._definition.get_ports("Z")).pins[
            0
        ]

    def get_primary_input_pin(self):
        return self._primary_input_pin

    def get_other_input_pins(self):
        return self._other_input_pins

    def get_primary_output_pin(self):
        return self._primary_output_pin

    def create_instance(self):
        instance = sdn.Instance()
        properties = {"INIT": "\"0xFCC0\""}
        instance["VERILOG.Parameters"] = properties
        instance.reference = self._definition
        return instance