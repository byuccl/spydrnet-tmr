import unittest
from collections import deque
from spydrnet_tmr.analysis.adjacency_list import adjacency_list
import spydrnet as sdn
import networkx as nx


class TestAdjacencyList(unittest.TestCase):

    def test_adjacency_list(self):
        netlist = sdn.load_example_netlist_by_name('b13')
        hports = netlist.get_hports()
        hinstances = netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True)
        from itertools import chain
        b13_adjacency_list = adjacency_list(chain(hports, hinstances))
        connectivity_graph = nx.DiGraph(b13_adjacency_list)
        self.assertEqual(connectivity_graph.number_of_nodes(), 114)
        self.assertEqual(connectivity_graph.number_of_edges(), 396)
