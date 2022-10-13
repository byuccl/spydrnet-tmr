import spydrnet as sdn


def find_all_leaf_cells(netlist):
    return set(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))