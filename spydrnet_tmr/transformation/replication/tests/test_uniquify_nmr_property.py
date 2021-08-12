import os
import spydrnet as sdn
from random import randint
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import uniquify_nmr_property
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr


def test_uniquify_nmr_property_tmr():
    example_name = generate_netlists(3,'TMR',{'SOFT_HLUTNM','SOFT_HLUTNM'})
    assert check_uniquify_nmr_property(sdn.parse(example_name+"_modified.edf"),"TMR") is True
    remove_generated_netlists(example_name)

def test_uniquify_nmr_property_dwc():
    example_name = generate_netlists(2,'DWC','SOFT_HLUTNM')
    assert check_uniquify_nmr_property(sdn.parse(example_name+"_modified.edf"),"DWC") is True
    remove_generated_netlists(example_name)


def generate_netlists(copy_amount,suffix,properties):
    '''
    Generates netlists needed for testing by selecting a random example, replicating the design, and composing the netlist.
    '''

    examples_list = ['b13','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']
    random_value = randint(0,len(examples_list)-1)
    example_to_test = examples_list[random_value]

    netlist = sdn.load_example_netlist_by_name(example_to_test)

    uniquify(netlist)
    sdn.compose(netlist,example_to_test + ".edf")

    hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)
    hports_to_replicate = list(netlist.get_hports())
    ports_to_replicate = list(x.item for x in hports_to_replicate)

    replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], copy_amount, name_suffix=suffix, rename_original=True)
    uniquify_nmr_property(replicas, properties, suffix)

    sdn.compose(netlist,example_to_test+"_modified.edf")

    return example_to_test


def remove_generated_netlists(example_name):
    os.remove(example_name+".edf")
    os.remove(example_name+"_modified.edf")

def check_uniquify_nmr_property(netlist,suffix):
    '''
    Check to make sure the domain suffix (e.g. TMR_0) is in the instance property's value name for instances with 'SOFT_HLUTNM'
    '''
    
    instance_properties_after = []
    for instance in netlist.get_instances():
        if "EDIF.properties" in instance._data:
            if len(instance["EDIF.properties"]) > 1:
                if 'soft_lut' in str(instance["EDIF.properties"][1]['value']):
                    instance_properties_after.append({'instance':instance,'property':instance["EDIF.properties"][1].copy()})

    #f = open("results.txt",'w')
    not_matched = []
    for item in instance_properties_after:
        instance_name = item['instance'].name
        start_index = instance_name.find(suffix)
        stop_index = instance_name.find("_",start_index+4)
        if start_index is -1:
            key = ''
        elif stop_index is -1:
            key = instance_name[start_index:]
        else :
            key = instance_name[start_index:stop_index]

        if key in item['property']['value']:
            # f.write("\nYES "+instance_name+"\t"+str(item['property']['value']))
            None
        else:
            # f.write("\nNO "+instance_name+"\t"+str(item['property']['value']))
            not_matched.append(item)
    # f.close()

    if not_matched:
        return False
    else:
        return True