import os
import json
from spydrnet_tmr import base_dir
import spydrnet_tmr


def run():
    tokens = get_primitive_tokens(
        os.path.join(
            base_dir,
            "support_files",
            "primitive_databases",
            "xilinx_primitive_info_db.json",
        )
    )
    vendor_name = "xilinx"
    generate_primitive_token_file(tokens, vendor_name)


def generate_primitive_token_file(tokens, vendor_name):
    """
    Generate Primitive Token File
    =============================
    Create a new file called "primitive_tokens.py" which contains a list of all
    primitive tokens as string constants that can be used to access the
    primitives loaded in from the database.
    """

    f = open(
        os.path.join(
            base_dir,
            "support_files",
            "xilinx_primitive_tokens.py",
        ),
        "w",
    )
    for token in tokens:
        tokenTuple = (token.upper(), "=", '"' + token + '"', "\n")
        f.write(" ".join(tokenTuple))


def get_primitive_tokens(primitive_db_file):
    """
    Get Primitive Tokens
    ====================
    Get all the key words from the primitive token file and return them as a
    sorted list.

    :param primitive_db_file: JSON file containing primitives and accompanying
    information for each primitive
    """
    primitive_info_db = json.load(open(primitive_db_file))

    current_obj = primitive_info_db
    tokens = set()

    def recursive_key_finder(current_obj):
        if isinstance(current_obj, dict):
            for next_obj in current_obj.items():
                recursive_key_finder(next_obj)
        elif isinstance(current_obj, list):
            for next_obj in current_obj:
                recursive_key_finder(next_obj)
        elif isinstance(current_obj, tuple):
            tokens.add(current_obj[0])
            recursive_key_finder(current_obj[1])

    recursive_key_finder(current_obj)

    return sorted(tokens)


run()
# generate_primitive_token_file()
