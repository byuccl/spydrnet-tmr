
def compare_properties(original_netlist,modified_netlist,suffix,organ_name = 'None'):
    '''
    Finds instances with the same name and same parent and compares their properties.

        :param original netlist: original netlist
        :param modified netlist: the replicated netlist. Can contain voters/detectors
        :param suffix: suffix appended to the replicated instances' names e.g. 'TMR' or 'DWC'
        :param organ_name: name of organ inserted e.g. 'VOTER' or 'DETECTOR'
        :return: bool (matched,not_matched)

    Note: to see the results of the comparison, uncomment the appropriate lines.
    '''

    original = list(instance for instance in original_netlist.get_instances())
    modified = list(instance for instance in modified_netlist.get_instances(filter = lambda x: (organ_name not in x.name) is True))
    #f = open("connections.txt",'w')
    not_matched = []
    for instance_modified in modified:
        modified_name_prefix = None
        start_index = instance_modified.name.find(suffix)
        stop_index = instance_modified.name.find("_",start_index+1)
        if start_index is -1:
            modified_name_prefix = instance_modified.name
        elif stop_index is -1:
            modified_name_prefix = instance_modified.name[:start_index-1]
        else :
            modified_name_prefix = instance_modified.name[:start_index-1] + instance_modified.name[stop_index+2:]

        matched_for_compare = False
        for instance_original in original:
            if modified_name_prefix.strip() == instance_original.name.strip():
                if instance_modified.parent.name.strip() in instance_original.parent.name.strip():
                    matched_for_compare = True
                    # f.write('\n'+instance_modified.name+' --- '+instance_original.name)
                    # f.write('\n\t'+"Parents Match: \n\t\t"+instance_modified.parent.name+' == '+instance_original.parent.name)
                    if 'EDIF.properties' in instance_modified._data and "EDIF.properties" in instance_original._data:
                        if instance_modified["EDIF.properties"] == instance_original["EDIF.properties"]:
                            None
                            # f.write('\n\tProperties Match'+'\n\t\t'+str(instance_modified["EDIF.properties"])+'\n\t\t'+str(instance_original["EDIF.properties"]))
                        else:
                            # f.write('\n\tProperties DO NOT Match')
                            not_matched.append(instance_modified)
                    else:
                        None
                        # f.write("\n\tNo Properties to Compare")
                    break
        if not matched_for_compare:
            # f.write('\n'+instance_modified.name+' did not have anyone to compare to')
            not_matched.append(instance_modified)

    if not_matched:
        # f.write("\n\nModified Instances That Did Not Match An Instance in the Original Design:")
        # for instance in not_matched:
            # f.write('\n\t'+instance.name)
        # f.close()
        return False
    else:
        # f.write("\n\nAll Modified Instances Matched An Instance in the Original Design")
        # f.close()
        return True



# netlist = sdn.parse("b13.edf")
# netlist2 = sdn.parse("b13_with_voters.edf")

# print(compare_properties(netlist,netlist2,"TMR",'VOTER'))
