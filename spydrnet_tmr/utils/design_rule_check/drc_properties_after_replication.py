from spydrnet_tmr.utils.design_rule_check.util import get_original_name

def check_properties_after_replication(original_netlist,modified_netlist,suffix,organ_names = list(),write_enable=False):
    '''
    After replication, the properties of each instance should not have changed. This finds corresponding instances between the original and modified netlists and compares their properties.

    For example, if the instance '**a_lut_3**' has a property "*value: 8'hE8*" in the original design, the replicates of that instance (**a_lut_3_TMR_0**, **a_lut_3_TMR_1**, **a_lut_3_TMR_2**) should have the same property.

    :param original_netlist: original netlist
    :param modified_netlist: the replicated netlist. Can contain voters/detectors
    :param suffix: string appended to the replicated instances' names e.g. 'TMR' or 'DWC'
    :param organ_name: list of names of the organs inserted into the design e.g. ['VOTER', 'DETECTOR']
    :param write_enable: output results to text file
    :type write_enable: bool
    :return: bool (matched,not_matched)
    '''
    print("CHECKING PROPERTIES")
    global ORGANS
    ORGANS = organ_names
    ORGANS.append('COMPLEX')
    modified = list(instance for instance in modified_netlist.get_hinstances(recursive=True,filter=lambda x:(not is_organ(x.item)) is True))

    original_non_leafs = get_original_non_leaf_dictionary(original_netlist)

    not_matched = compare_properties(original_non_leafs,modified,suffix,write_enable,original_netlist.name)
    if not_matched:
        # for item in not_matched:
        #     print(item.name)
        print("FAILED")
        return False
    else:
        print("PASSED")
        return True

def is_organ(instance):
    if any(organ in instance.name for organ in ORGANS):
        return True
    return False

def get_original_non_leaf_dictionary(original_netlist):
    '''
    creates a map of non_leaf instances to their leaf children. This allows finding corresponding instances to be quicker.
    '''
    original_non_leafs = {}
    for instance in original_netlist.get_hinstances(recursive = True,filter= lambda x: (not x.item.is_leaf()) is True):
        if instance.item.reference.name in original_non_leafs.keys():
            original_non_leafs[instance.item.reference.name] += list(x for x in instance.item.reference.children)
        else:
            original_non_leafs.update({instance.item.reference.name:list(x for x in instance.item.reference.children)})
    original_non_leafs.update({original_netlist.top_instance.reference.name:list(x for x in original_netlist.top_instance.reference.children)})
    return original_non_leafs

def compare_properties(original,modified,suffix,write_enable,name):
    '''
    find corresponding instances and compares their properties
    '''
    f = None
    if write_enable:
        f = open('drc_property_results_'+name+'.txt','w')
    not_matched = []
    for instance_modified in modified:
        modified_name = get_original_name(instance_modified.item,suffix)
        matched_for_compare = False
        if instance_modified.parent.item.reference.name in original.keys():
            for instance_original in original[instance_modified.parent.item.reference.name]:
                if modified_name == instance_original.name:
                    matched_for_compare = True
                    not_matched += compare_a_match(instance_original,instance_modified.item,suffix,f)
                    break
        if not matched_for_compare:
            not_matched.append(instance_modified.item)
            if f is not None:
                f.write(instance_modified.name + ' had no one to compare to\n')
    if f:
        f.close()
    return not_matched

def compare_a_match(instance_original,instance_modified,suffix,f):
    '''
    compares properties in the given corresponding instances
    '''
    not_matched = []
    if 'EDIF.properties' in instance_modified:
        if 'EDIF.properties' not in instance_original:
            if f:
                f.write('NOT MATCH: '+instance_modified.name+' ' + str(instance_modified["EDIF.properties"])+' did not match '+instance_original.name+' as expected (original had no properties)\n')
            not_matched.append(instance_modified)
            return not_matched
        properties_instance_modified = filter_suffix_from_properties(instance_modified,suffix)
        properties_intance_original = filter_suffix_from_properties(instance_original,suffix)
        if properties_instance_modified == properties_intance_original:
            if f:
                f.write('MATCH: '+instance_modified.name+' ' +str(instance_modified["EDIF.properties"])+' == '+str(instance_original["EDIF.properties"])+' '+instance_original.name+'\n')
        else:
            not_matched.append(instance_modified)
            if f:
                f.write('NOT MATCH: '+instance_modified.name+' ' + str(instance_modified["EDIF.properties"])+' did not match '+instance_original.name+' '+str(instance_original["EDIF.properties"])+' as expected\n')
    return not_matched

def filter_suffix_from_properties(instance,suffix):
    '''
    removes replica suffix from the properties (e.g. removes 'TMR_0' from a property it was uniquified)
    '''
    filtered_properties = str(instance['EDIF.properties'])
    while True:
        start_index = filtered_properties.find(suffix)
        stop_index = start_index + len(suffix) + 2
        if start_index == -1:
            return filtered_properties

        filtered_properties = filtered_properties[:start_index-1] + filtered_properties[stop_index:]
