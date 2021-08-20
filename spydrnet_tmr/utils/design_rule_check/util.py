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
