"""
Feedback Analysis Example
-------------------------

This is an example of doing feedback analysis on a netlist. This example specificially uses the b13 netlist.

**Run the following code**

.. code-block::

   import spydrnet as sdn
   import spydrnet_tmr as sdn_tmr
   from spydrnet_tmr.analysis.adjacency_list import adjacency_list
   from spydrnet_tmr import fold_feedback
   import networkx as nx

   global depth_dict
   depth_dict = dict()

   def print_feedback_hierarchy(f_set, indent="", depth=0):
      global depth_dict
      if depth not in depth_dict.keys():
         depth_dict[depth] = list()
      for x in f_set:
         if isinstance(x, frozenset):
               print_feedback_hierarchy(x, indent+"   ", depth+1)
         else:
               print(indent + str(depth) + ": " + x.name)
               depth_dict[depth].append(x)



   netlist = sdn.load_example_netlist_by_name("b13")   

   # create connectivity graph
   all_leaf_hinstances = list(netlist.get_hinstances(recursive=True, 
                                                   filter=lambda x: x.item.reference.is_leaf() is True))
   all_top_level_ports = list(netlist.get_hports())
   connections = adjacency_list([*all_leaf_hinstances, *all_top_level_ports])
   connectivity_graph = nx.DiGraph(connections)

   # Notes:
   # feedback_hierarchy - frozensets inside frozensets inside frozensets. Feedback hierarchy from large loops down to small loops
   # distances - a dictionary. Keys are frozensets of hinstances in the feedback loop. Item is the distance.
   # working_graph - networkx digraph. The resulting graph after all feedback has been folded down
   feedback_hierarchy, distances, working_graph = fold_feedback(connectivity_graph)

   print_feedback_hierarchy(feedback_hierarchy)

**The output should look something like this:** ::

   There are 38 SCC nodes
   38 SCC is feedforward
   37 SCC is feedforward
   36 SCC is feedforward
   35 SCC is feedforward
   34 SCC is feedforward
   33 SCC is feedforward
   32 SCC is feedforward
   31 SCC is feedforward
   30 SCC is feedforward
   29 SCC is feedforward
   28 SCC is feedforward
   27 SCC is feedforward
   26 SCC is feedforward
   25 SCC is feedforward
   24 SCC is feedforward
   23 SCC is feedforward
   22 SCC is feedforward
   21 SCC is feedforward
   20 SCC is feedforward
   19 SCC is feedforward
   18 SCC is feedforward
   17 SCC is feedforward
   16 SCC is feedforward
   15 SCC is feedforward
   14 SCC is feedforward
   13 SCC is feedforward
   12 SCC is feedforward
   11 SCC is feedforward
   10 SCC is feedforward
   9 SCC is multi-node
   2 nodes remain
   8 SCC is multi-node
   2 nodes remain
   7 SCC is multi-node
   2 nodes remain
   6 SCC is multi-node
   2 nodes remain
   5 SCC is multi-node
   2 nodes remain
   4 SCC is multi-node
   2 nodes remain
   3 SCC is multi-node
   2 nodes remain
   2 SCC is multi-node
   2 nodes remain
   1 SCC is multi-node
   69 nodes remain
   37 nodes remain
   35 nodes remain
   25 nodes remain
   24 nodes remain
   19 nodes remain
   18 nodes remain
   17 nodes remain
   16 nodes remain
   15 nodes remain
   14 nodes remain
   13 nodes remain
   12 nodes remain
   11 nodes remain
   10 nodes remain
   2 nodes remain
   0: out_reg_reg[0]
      1: conta_tmp[0]_i_1
      1: conta_tmp_reg[0]
   0: out_reg_reg[1]
   0: add_mpx2
   0: out_reg_reg[2]
   0: data_out_i_1
   0: clock
   0: out_reg_reg[3]
   0: data_out_i_2
      1: error_reg
      1: error_i_1
   0: data_out
   0: out_reg_reg[4]
   0: data_out_i_3
   0: out_reg_reg[5]
   0: dsr
   0: data_out_i_4
      1: soc_reg
      1: soc_i_1
   0: out_reg_reg[6]
   0: eoc
   0: out_reg_reg[7]
   0: data_out_i_6
   0: error
   0: data_out_reg
   0: load_dato
   0: mux_en
   0: GND
      1: add_mpx2_i_1
      1: add_mpx2_reg
   0: reset
   0: soc
   0: VCC
      1: mux_en_i_1
      1: mux_en_reg
   0: canale[3:0]
   0: data_in[7:0]
      1: FSM_onehot_S1_reg[6]
         2: FSM_onehot_S1_reg[1]
         2: FSM_onehot_S1[0]_i_1
            3: FSM_onehot_S1[3]_i_1
            3: FSM_onehot_S1_reg[3]
         2: FSM_onehot_S1_reg[2]
            3: FSM_onehot_next_bit_reg[0]
                  5: FSM_onehot_next_bit_reg[2]
                        7: FSM_onehot_next_bit_reg[4]
                           8: FSM_onehot_next_bit_reg[5]
                              9: FSM_onehot_next_bit_reg[6]
                                 10: FSM_onehot_next_bit_reg[7]
                                    11: FSM_onehot_next_bit_reg[8]
                                       12: FSM_onehot_next_bit[9]_i_1
                                          13: FSM_sequential_itfc_state[0]_i_1
                                          13: send_data_reg
                                          13: FSM_onehot_S1_reg[7]
                                          13: FSM_sequential_itfc_state[1]_i_1
                                          13: FSM_onehot_S1[7]_i_1
                                          13: FSM_sequential_S2[0]_i_1
                                          13: confirm_i_1
                                          13: FSM_sequential_itfc_state_reg[1]
                                          13: FSM_sequential_S2[1]_i_1
                                          13: shot_i_1
                                          13: confirm_reg
                                          13: FSM_sequential_itfc_state[1]_i_2
                                          13: mpx_i_1
                                          13: FSM_sequential_S2_reg[0]
                                          13: shot_reg
                                          13: mpx_reg
                                          13: rdy_i_1
                                          13: FSM_sequential_S2_reg[1]
                                          13: rdy_reg
                                          13: FSM_sequential_itfc_state_reg[0]
                                          13: send_data_i_1
                                       12: FSM_onehot_next_bit_reg[9]
                                                15: tx_conta_reg[3]
                                                15: tx_conta[3]_i_1
                                             14: tx_end_i_1
                                                15: send_en_reg
                                                15: send_en_i_1
                                             14: data_out_i_5
                                                15: tx_conta_reg[0]
                                                15: tx_conta[0]_i_1
                                             14: tx_end_reg
                                                15: tx_conta_reg[1]
                                                15: tx_conta[1]_i_1
                                                15: tx_conta_reg[4]
                                                15: tx_conta[4]_i_1
                                             14: tx_conta[6]_i_2
                                                   16: tx_conta_reg[6]
                                                   16: tx_conta[6]_i_1
                                                   16: tx_conta_reg[5]
                                                   16: tx_conta[5]_i_1
                                                15: FSM_onehot_next_bit[9]_i_2
                                                15: tx_conta_reg[2]
                                                15: tx_conta[2]_i_1
                                             14: tre_reg
                                             14: tre_i_1
                                          13: send_reg
                                          13: send_i_1
                                          13: load_i_1
                                          13: load_reg
                     6: FSM_onehot_next_bit_reg[3]
               4: FSM_onehot_next_bit_reg[1]
         2: FSM_onehot_S1[4]_i_1
         2: FSM_onehot_S1_reg[4]
         2: FSM_onehot_S1_reg[0]
         2: FSM_onehot_S1_reg[5]
      1: conta_tmp[2]_i_1
      1: conta_tmp_reg[2]
      1: conta_tmp_reg[1]
      1: conta_tmp[1]_i_1
      1: load_dato_reg
      1: load_dato_i_1
   0: out_reg[7]_i_1

The feedback analysis checks how "tight" a feedback loop is. The tighter the feedback loop the smaller the path and number of instances that are connected in it. 
In this design feedback loop 16 is the smallest loop and it is inside feedback loop 15. Feedback loop 15 is inside feedback loop 14, 14 inside 13, etc.
This continues until feedback loop 0 which is the largest feedback loop that contains all other feedback loops. 

**The following code is for feedback analysis**
"""

import spydrnet as sdn
import spydrnet_tmr as sdn_tmr
from spydrnet_tmr.analysis.adjacency_list import adjacency_list
from spydrnet_tmr import fold_feedback
import networkx as nx

global depth_dict
depth_dict = dict()

def print_feedback_hierarchy(f_set, indent="", depth=0):
    global depth_dict
    if depth not in depth_dict.keys():
        depth_dict[depth] = list()
    for x in f_set:
        if isinstance(x, frozenset):
            print_feedback_hierarchy(x, indent+"   ", depth+1)
        else:
            print(indent + str(depth) + ": " + x.name)
            depth_dict[depth].append(x)



netlist = sdn.load_example_netlist_by_name("b13")   

# create connectivity graph
all_leaf_hinstances = list(netlist.get_hinstances(recursive=True, 
                                                filter=lambda x: x.item.reference.is_leaf() is True))
all_top_level_ports = list(netlist.get_hports())
connections = adjacency_list([*all_leaf_hinstances, *all_top_level_ports])
connectivity_graph = nx.DiGraph(connections)

# Notes:
# feedback_hierarchy - frozensets inside frozensets inside frozensets. Feedback hierarchy from large loops down to small loops
# distances - a dictionary. Keys are frozensets of hinstances in the feedback loop. Item is the distance.
# working_graph - networkx digraph. The resulting graph after all feedback has been folded down
feedback_hierarchy, distances, working_graph = fold_feedback(connectivity_graph)

print_feedback_hierarchy(feedback_hierarchy)
