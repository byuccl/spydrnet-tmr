def find_key(instance,suffix):
    '''
    Finds the tmr boundary key (e.g. TMR_0, TMR_1, or TMR_2
    '''
    start_index = instance.name.find(suffix)
    stop_index = start_index + len(suffix) + 2
    if start_index is -1:
        key = ''
    else:
        key = instance.name[start_index:stop_index]
    return key

def get_original_name(current_instance,suffix):
    '''
    returns the instance's name without the replica suffix appended to it
    '''
    if isinstance(current_instance,str):
        modified_name = current_instance
    else:
        modified_name = current_instance.name
    start_index = modified_name.find(suffix)
    stop_index = start_index + len(suffix) + 2
    while True:
        if start_index is -1:
            return modified_name
        else :
            modified_name = modified_name[:start_index-1] + modified_name[stop_index:]
            start_index = modified_name.find(suffix)
            stop_index = start_index + len(suffix) + 2