import spydrnet as sdn

def check_nmr(netlist,all_elements_to_replicate,degree,suffix):
    """
    Checks to make sure all ports/instances specified to be replicated were replicated and those not specified were not replicated
    
    :param netlist: current netlist
    :param all_elements_to_replicate: a list of hierarchical references to the instances and ports specified to be replicated
    :type all_elements_to_replicate: list of Hrefs
    :param degree: degree of replication (e.g. 3)
    :param suffix: suffix appended to replicas (e.g. 'TMR')
    :return: True/False
    """
    stuff_to_replicate = list((fix_name(x,suffix),x.item.__class__) for x in all_elements_to_replicate)

    correct = True
    instance_dict = {}
    port_dict = {}
    for instance in netlist.get_hinstances(recursive=True):
        name = fix_name(instance,suffix)
        # print(name)
        if name in instance_dict.keys():
            instance_dict[name] += 1
            if instance_dict[name] > 3:
                print(instance.name,'just got added to',name, 'as ',instance_dict[name])
        else:
            instance_dict[name] = 1
    for port in netlist.get_hports():
        name = fix_name(port,suffix)
        if name in port_dict.keys():
            port_dict[name] += 1
        else:
            port_dict[name] = 1

    for item in instance_dict:
        if instance_dict[item] is degree and any((item == x[0] and x[1] is sdn.Instance) for x in stuff_to_replicate):
            continue
        elif instance_dict[item] is 1 and not any((item == x[0] and x[1] is sdn.Instance) for x in stuff_to_replicate):
            continue
        else: 
            # print("instance",item,':',instance_dict[item],'\t',any((item == x[0] and x[1] is sdn.Instance) for x in stuff_to_replicate))
            correct = False

    for item in port_dict:
        if port_dict[item] is degree and any((item == x[0] and x[1] is sdn.Port) for x in stuff_to_replicate):
            continue
        elif port_dict[item] is 1 and not any((item == x[0] and x[1] is sdn.Port) for x in stuff_to_replicate):
            continue
        else: 
            # print('port',item,':',port_dict[item],'\t',any((item == x[0] and x[1] is sdn.Port) for x in stuff_to_replicate))
            correct = False
    return correct

def fix_name(current_instance,suffix):
    modified_name_prefix = current_instance.name
    while True:
        start_index = modified_name_prefix.find(suffix)
        stop_index = start_index + len(suffix) + 2
        if start_index is -1:
            return modified_name_prefix
        modified_name_prefix =modified_name_prefix[:start_index-1] + modified_name_prefix[stop_index:]