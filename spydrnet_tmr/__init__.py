"""
SpyDrNet TMR
==============

SpyDrNet TMR is a collection of netlist analysis and transformation applications.
"""

# Release data
from spydrnet_tmr import release

__author__ = "%s <%s>\n%s <%s>\n%s <%s>" % (
    release.authors["Keller"]
    + release.authors["Skouson"]
    + release.authors["Wirthlin"]
)
__license__ = release.license

__date__ = release.date
__version__ = release.version
__release__ = release.release

from spydrnet_tmr.transformation.replication.nmr import apply_nmr
from spydrnet_tmr.transformation.replication.organ_insertion import (
    insert_organs,
)
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import (
    uniquify_nmr_property,
)
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info

import os

base_dir = os.path.dirname(os.path.abspath(__file__))

import glob

example_netlist_names = list()
for filename in glob.glob(
    os.path.join(base_dir, "support_files", "EDIF_netlists", "*")
):
    basename = os.path.basename(filename)
    example_netlist_names.append(basename[: basename.index(".")])
example_netlist_names.sort()

import spydrnet as sdn


def load_example_netlist_by_name(name):
    assert name in example_netlist_names, "Example netlist not found"
    return sdn.parse(
        os.path.join(
            base_dir, "support_files", "EDIF_netlists", name + ".edf.zip"
        )
    )
