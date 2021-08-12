
def check_properties_after_replication(original_netlist,modified_netlist,suffix,organ_names = [],write_enable=False):
    '''
    After replication, the properties of each instance should not have changed. This finds corresponding instances between the original and modified netlists and compares their properties.

    For example, if the instance '**a_lut_3**' has a property "*value: 8'hE8*" in the original design, the replicates of that instance (**a_lut_3_TMR_0**, **a_lut_3_TMR_1**, **a_lut_3_TMR_2**) should have the same property as well.

    :param original_netlist: original netlist
    :param modified_netlist: the replicated netlist. Can contain voters/detectors
    :param suffix: string appended to the replicated instances' names e.g. 'TMR' or 'DWC'
    :param organ_name: list of names of the organs inserted into the design e.g. ['VOTER', 'DETECTOR']
    :param write_enable: output results to text file
    :type write_enable: bool
    :return: bool (matched,not_matched)
    '''
    print("CHECKING PROPERTIES")
    global organs
    organs = organ_names
    organs.append('COMPLEX')
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

def get_original_non_leaf_dictionary(original_netlist):
    original_non_leafs = {}
    for instance in original_netlist.get_hinstances(recursive = True,filter= lambda x: (not x.item.is_leaf()) is True):
        if instance.item.reference.name in original_non_leafs.keys():
            original_non_leafs[instance.item.reference.name] += list(x for x in instance.item.reference.children)
        else:
            original_non_leafs.update({instance.item.reference.name:list(x for x in instance.item.reference.children)})
    original_non_leafs.update({original_netlist.top_instance.reference.name:list(x for x in original_netlist.top_instance.reference.children)})
    return original_non_leafs

def is_organ(instance):
    if any(organ in instance.name for organ in organs):
        return True
    return False

def find_name(current_instance,suffix):
    modified_name = None
    start_index = current_instance.name.find(suffix)
    stop_index = start_index + len(suffix) + 2
    if start_index is -1:
        modified_name = current_instance.name
    else :
        modified_name = current_instance.name[:start_index-1] + current_instance.name[stop_index:]
    return modified_name

def filter_suffix_from_value(value,suffix):
    filtered_value = None
    start_index = str(value).find(suffix)
    stop_index = start_index + len(suffix) + 2
    if start_index is -1:
        filtered_value = value
    else:
        filtered_value = str(value)[:start_index-1] + str(value)[stop_index:]
    return filtered_value

def compare_properties(original,modified,suffix,write_enable,name):
    f = None
    if write_enable:
        f = open('drc_property_results_'+name+'.txt','w')
    not_matched = []
    for instance_modified in modified:
        modified_name = find_name(instance_modified.item,suffix)
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
    not_matched = []
    if 'EDIF.properties' in instance_modified._data:
        try:
            instance_original["EDIF.properties"]
        except KeyError:
            instance_original['EDIF.properties'] = []
        for i in range(len(instance_modified["EDIF.properties"])):
            try:
                instance_original["EDIF.properties"][i]
            except IndexError:
                instance_original['EDIF.properties'].append({})
            for key in instance_modified["EDIF.properties"][i].keys():
                try:
                    instance_original["EDIF.properties"][i][key]
                except KeyError:
                    instance_original['EDIF.properties'][i][key] = None
                
                if filter_suffix_from_value(instance_modified["EDIF.properties"][i][key],suffix) == instance_original['EDIF.properties'][i][key]:
                    if f is not None:
                        f.write('MATCH: '+instance_modified.name+' ' +str(instance_modified["EDIF.properties"])+' == '+str(instance_original["EDIF.properties"])+' '+instance_original.name+'\n')
                else:
                    not_matched.append(instance_modified)
                    if f is not None:
                        f.write('NOT MATCH: '+instance_modified.name+' ' + str(instance_modified["EDIF.properties"])+' did not match '+instance_original.name+' '+str(instance_original["EDIF.properties"])+' as expected\n')
                    break
    return not_matched
