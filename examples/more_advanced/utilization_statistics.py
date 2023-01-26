"""
Utilization Statistics
-----------------------
"""
import spydrnet as sdn

netlist = sdn.parse("b13.edf")

for definition in next(netlist.get_libraries('hdi_primitives')).definitions:
    print(definition.name, len(definition.references))