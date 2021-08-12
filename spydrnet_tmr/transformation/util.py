import re


def add_suffix_to_name(element, suffix):
    match = re.match(r"(.+)((?:\([^\)]+\))|(?:<[^>]+>)|(?:\[[^\]]+\]))$", element.name)
    if match:
        element.name = match.group(1) + '_' + suffix + match.group(2)
    else:
        element.name = element.name + '_' + suffix

    if 'EDIF.identifier' in element:
        match = re.match(r'(.+)(_[^_]+_)$', element['EDIF.identifier'])
        if match:
            element['EDIF.identifier'] = match.group(1) + '_' + suffix + match.group(2)
        else:
            element['EDIF.identifier'] = element['EDIF.identifier'] + '_' + suffix