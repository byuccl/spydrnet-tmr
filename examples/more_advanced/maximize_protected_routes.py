"""
Maximize Protected Routes
--------------------------
"""
import spydrnet as sdn
import spydrnet_shrec as sdn_shrec
import networkx as nx

try:
    from gurobipy import *
except:
    print("This example requires Gurobi. Please see gurobi.com for install and to aquire a license.")
    exit(0)

graph = None
model = None

nodeToIDMap = None
IDtoNodeMap = None
nodeSetVarMap = None
nodeUnsetVarMap = None

maxCoverage = None
maxInstances = None
selectedInstances = None
protectedEdges = None
neededReductionVoters = None

import sys, traceback


def run():
    global graph
    global maxCoverage
    
    graph = get_connectivity_graph()
    
    totalNodes = graph.number_of_nodes()
    totalEdges = graph.number_of_edges()
    
    with open("results.csv", 'w') as fi:
        for nodeCount in range(2, totalNodes + 1):
            maxCoverage = nodeCount/totalNodes
            run_solver()
            if selectedInstances > 0:
                export_dot("dot/b13_{}.dot".format(nodeCount), graph)
                fi.write("{},{},{},{},{}\n".format(nodeCount,selectedInstances, protectedEdges, neededReductionVoters, protectedEdges/selectedInstances*totalNodes/totalEdges)) 
    
def run_solver():
    global model
    try:
        model = Model("maxP")
        solve_model()
    except GurobiError as e:
        print('Error code ' + str(e.errno) + ": " + str(e))
        traceback.print_exc(file=sys.stdout)

    except AttributeError:
        print('Encountered an attribute error')
        
def get_connectivity_graph():
    netlist = sdn.load_example_netlist_by_name("b13")

    all_leaf_hinstances = list(
        netlist.get_hinstances(
            recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
        )
    )
    all_top_level_ports = list(netlist.get_hports())
    connections = sdn_shrec.adjacency_list([*all_leaf_hinstances, *all_top_level_ports])
    connectivity_graph = nx.DiGraph(connections)
    
    return connectivity_graph
    
def solve_model():
    create_variables_constraints_and_objective()
    optimize_model()
    
def create_variables_constraints_and_objective():
    global nodeToIDMap
    global IDtoNodeMap
    global nodeSetVarMap
    global nodeUnsetVarMap
    global maxInstances
    
    nodeToIDMap = dict()
    IDtoNodeMap = dict()
    nodeSetVarMap = dict()
    nodeUnsetVarMap = dict()
    
    nodeIndex = 0
    edgeIndex = 0
    
    for node in graph.nodes():
        nodeToIDMap[node] = nodeIndex
        IDtoNodeMap[nodeIndex] = node
        setVar = model.addVar(vtype=GRB.BINARY, name="s{}".format(nodeIndex))
        nodeSetVarMap[node] = setVar
        unsetVar = model.addVar(vtype=GRB.BINARY, name="u{}".format(nodeIndex))
        nodeUnsetVarMap[node] = unsetVar
        
        model.addConstr(setVar + unsetVar == 1, "i{}".format(nodeIndex))
        nodeIndex += 1
    
    plusVars = list()
    minusVars = list()
    for node in graph.nodes():
        for successor in graph.successors(node):
            plusVar = model.addVar(vtype = GRB.BINARY, name="p{}".format(edgeIndex))
            minusVar = model.addVar(vtype = GRB.BINARY, name="m{}".format(edgeIndex))
            model.addConstr(plusVar == and_(nodeSetVarMap[node], nodeSetVarMap[successor]), "a{}".format(edgeIndex))
            model.addConstr(minusVar == and_(nodeSetVarMap[node], nodeUnsetVarMap[successor]), "an{}".format(edgeIndex))
            plusVars.append(plusVar)
            minusVars.append(minusVar)
            edgeIndex += 1
        
    setVars = list(nodeSetVarMap.values())
    maxInstances = int(len(setVars)*maxCoverage)
    model.addConstr(quicksum(setVars) <= maxInstances, "c")
    model.setObjective(quicksum(plusVars) - quicksum(minusVars), GRB.MAXIMIZE)
        
def optimize_model():
    global selectedInstances
    global protectedEdges
    global neededReductionVoters
    model.optimize()

    #for c in model.getConstrs():
    #   print(c)
    #for v in model.getVars():
    #   print('%s %g' % (v.varName, v.x))
    selectedInstances = len([x for x in model.getVars() if x.varName.startswith("s") and x.x == 1])
    protectedEdges = len([x for x in model.getVars() if x.varName.startswith("p") and x.x == 1])
    neededReductionVoters = len([x for x in model.getVars() if x.varName.startswith("m") and x.x == 1])
    print('Obj: %g' % model.objVal)
    print("Max Coverage:", maxCoverage)
    print("Max Instances:", maxInstances)
    print("Selected Instances:", selectedInstances)
    print("Protected Nets:", protectedEdges)
    print("Necessary Reduction Voters:", neededReductionVoters)
    
def export_dot(filename, graph):
    create_filename_directory_if_not_present(filename)
    
    index = 0
    mapping = dict()
    with open(filename, 'w') as fi:
        fi.write("digraph {\n")
        for node in graph.nodes:
            color = ""
            shape = ""
            mapping[node] = index;
            label = node.item['EDIF.identifier']
            if model.getVarByName("s{}".format(nodeToIDMap[node])).x == 1:
                color = ",color=blue"
            if isinstance(node.item, sdn.Port):
                shape = "rarrow"
            elif isinstance(node.item, sdn.Instance):
                if node.item.reference['EDIF.identifier'].startswith("FD") == True:
                    shape = ",shape=box"
            fi.write('  {}[label="{}"{}{}];\n'.format(index,label,color,shape))
            index = index + 1
        for node in graph.nodes:
            for successor in graph.successors(node):
                fi.write('  {} -> {};\n'.format(mapping[node], mapping[successor]))
        fi.write('}\n');

def create_filename_directory_if_not_present(filename):
    directory = os.path.dirname(filename)
    if os.path.exists(directory) is False:
        os.makedirs(directory)

run()