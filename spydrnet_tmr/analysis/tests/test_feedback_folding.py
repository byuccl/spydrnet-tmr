from spydrnet_tmr.analysis.adjacency_list import adjacency_list
import spydrnet_tmr as sdn_tmr
import spydrnet as sdn
import networkx as nx

import unittest
from collections import deque


class TestFeedbackFolding(unittest.TestCase):
    def test_feedback_folding(self):
        netlist = sdn.load_example_netlist_by_name("b13")
        hports = netlist.get_hports(
            filter=lambda x: x.name not in {"clk", "srst"}
        )
        hinstances = netlist.get_hinstances(
            recursive=True,
            filter=lambda x: x.item.reference.is_leaf() is True
            and x.item.reference.name not in {"GND", "VCC"},
        )

        from itertools import chain

        b13_adjacency_list = adjacency_list(chain(hports, hinstances))
        connectivity_graph = nx.DiGraph(b13_adjacency_list)

        (
            feedback_hierarchy,
            distances,
            collapsed_graph,
        ) = sdn_tmr.fold_feedback(connectivity_graph)
        node_counts = self.get_node_counts(feedback_hierarchy)
        influence_counts = self.get_influence_counts(
            collapsed_graph, node_counts
        )

        self.report_feedback_hierarchy(
            feedback_hierarchy, distances, node_counts, influence_counts
        )
        self.export_dot_graph(connectivity_graph, feedback_hierarchy)
        self.remove_files()

    def get_node_counts(self, feedback_hierarchy):
        counts = dict()
        search_stack = [(feedback_hierarchy, False)]
        while search_stack:
            member, visited = search_stack.pop()
            if not visited:
                if isinstance(member, frozenset):
                    search_stack.append((member, True))
                    search_stack += ((x, False) for x in member)
            else:
                count = 0
                for child in member:
                    if isinstance(child, frozenset):
                        count += counts[child]
                    else:
                        count += 1
                counts[member] = count
        return counts

    def get_influence_counts(self, collapsed_graph, node_counts):
        result = dict()
        found = dict()
        for node in reversed(list(nx.topological_sort(collapsed_graph))):
            node_set = found.get(node, set())
            node_set.add(node)
            for predecessor in collapsed_graph.predecessors(node):
                pred_set = found.get(predecessor, set())
                pred_set |= node_set
                found[predecessor] = pred_set
            if node in found:
                del found[node]
            count = sum(node_counts.get(x, 1) for x in node_set)
            result[node] = count
        return result

    def report_feedback_hierarchy(
        self, feedback_hierarchy, distances, node_counts, influence_counts
    ):
        with open("feedback_hierarchy.txt", "w") as fi:
            for member in sorted(
                feedback_hierarchy,
                key=lambda x: influence_counts[x],
                reverse=True,
            ):
                search_stack = list()
                search_stack.append((member, 0))
                while search_stack:
                    search_member, level = search_stack.pop()
                    # fi.write('  '*level)
                    fi.write(str(level) + " ")
                    if isinstance(search_member, frozenset):
                        fi.write("FeedbackGroup")
                        fi.write(" ")
                        fi.write(str(distances[search_member]))
                        fi.write(" ")
                        fi.write(str(node_counts[search_member]))

                        search_stack += ((x, level + 1) for x in search_member)
                    else:
                        fi.write(search_member.name)
                    if level == 0:
                        fi.write(" ")
                        fi.write(str(influence_counts[search_member]))
                    fi.write("\n")

    def export_dot_graph(self, connectivity_graph, feedback_hierarchy):
        with open("test_adjacency_list.dot", "w") as fi:
            fi.write("digraph {} ".format(id(connectivity_graph)))
            fi.write("{\n")
            fi.write(
                "  rankdir=LR; // Left to Right, instead of Top to Bottom\n"
            )
            for member in feedback_hierarchy:
                search_stack = [(member, False)]
                while search_stack:
                    search_member, visited = search_stack.pop()
                    if isinstance(search_member, frozenset):
                        if visited:
                            fi.write("}\n")
                        else:
                            search_stack.append((search_member, True))
                            fi.write(
                                "subgraph cluster_{}".format(id(search_member))
                            )
                            fi.write('{\nlabel="FeedbackGroup";\n')
                            search_stack += ((x, False) for x in search_member)
                    else:
                        fi.write(
                            '  {} [label="{}"];\n'.format(
                                id(search_member), search_member.name
                            )
                        )
            fi.write("\n")
            for node in connectivity_graph.nodes:
                for successor in connectivity_graph.successors(node):
                    fi.write("  {} -> {};\n".format(id(node), id(successor)))
            fi.write("}\n")

    def remove_files(self):
        import os
        os.remove("feedback_hierarchy.txt")
        os.remove("test_adjacency_list.dot")