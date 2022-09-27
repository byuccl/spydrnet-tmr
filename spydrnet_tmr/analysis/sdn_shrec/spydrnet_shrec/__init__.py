"""
SpyDrNet SHREC
==============

SpyDrNet SHREC is a collection of netlist analysis and transformation applications for space, high-performance, and
resilient computing.
"""

# Release data
from spydrnet_shrec import release

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
from spydrnet_shrec.analysis.adjacency_list import adjacency_list
from spydrnet_shrec.analysis.feedback_folding import fold_feedback
from spydrnet_shrec.analysis.find_all_leaf_cells import find_all_leaf_cells
from spydrnet_shrec.analysis.pin_clock_domain_analysis import (
    pin_clock_domain_analysis,
)
from spydrnet_shrec.analysis.find_synchronizers import find_synchronizers
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter,XilinxDWCDetector

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
