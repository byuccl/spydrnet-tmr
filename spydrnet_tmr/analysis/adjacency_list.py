import spydrnet as sdn


def adjacency_list(hierarchical_elements):
    '''
    Used in :ref:`find_voter_insertion_points`. 

    :param hierarchical_elements:
    :return: hierarchical elements, a map from each element to the elements it drives
    '''
    hierarchical_elements = dict.fromkeys(hierarchical_elements)
    for hierarchical_element in hierarchical_elements:
        adjacent_elements = set()
        if isinstance(hierarchical_element.item, sdn.Port):
            houtpins = hierarchical_element.get_hpins(filter=lambda hpin: hpin.parent.item.direction in
                                                                          {sdn.IN, sdn.INOUT})
        elif isinstance(hierarchical_element.item, sdn.Instance):
            houtpins = hierarchical_element.get_hpins(filter=lambda hpin: hpin.parent.item.direction in
                                                                       {sdn.OUT, sdn.INOUT})
        else:
            continue
        for houtpin in houtpins:
            found = {houtpin}
            direction = houtpin.parent.item.direction
            if direction == sdn.OUT:
                search_seed = houtpin.get_hwires(selection='OUTSIDE')
            elif direction == sdn.IN:
                search_seed = houtpin.get_hwires(selection='INSIDE')
            elif direction == sdn.INOUT:
                search_seed = houtpin.get_hwires(selection='BOTH')
            else:
                continue
            search_stack = list(search_seed)
            while search_stack:
                hwire = search_stack.pop()
                hcable = hwire.parent
                hparent_inst = hcable.parent
                for hpin in hwire.get_hpins(hwire):
                    if hpin not in found:
                        found.add(hpin)
                        hport = hpin.parent
                        hinst = hport.parent
                        if hport in hierarchical_elements:
                            adjacent_elements.add(hport)
                        elif hinst in hierarchical_elements:
                            adjacent_elements.add(hinst)
                        else:
                            if hparent_inst == hinst:
                                search_stack += hpin.get_hwires(selection='OUTSIDE')
                            else:
                                search_stack += hpin.get_hwires(selection='INSIDE')
        hierarchical_elements[hierarchical_element] = list(adjacent_elements)
    return hierarchical_elements
