def find_key(instance,suffix):
    start_index = instance.name.find(suffix)
    stop_index = start_index + len(suffix) + 2
    if start_index is -1:
        key = ''
    else:
        key = instance.name[start_index:stop_index]
    return key