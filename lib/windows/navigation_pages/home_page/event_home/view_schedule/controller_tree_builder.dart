import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/node_info/view_node_info.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/view_tree_node_static.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/view_tree_builder.dart';

import 'model_tree_builder.dart';

/// Controller for the complex tree view of the scheduler system (ViewTreeAssembler)
///@author Cody Smith at RIT (bcs4313)
class ControllerTreeAssembler
{
  ViewTreeAssembler parent; // stateful widget to update after various changes to this controller
  ModelTreeDeserializer model; // data model for UI

  // stored variables relative to the controller
  //
  // 2 nodes to connect to each other in connect mode
  ViewTreeNodeStatic connect_1;
  ViewTreeNodeStatic connect_2;

  // 2 nodes to disconnect to each other in disconnect mode
  ViewTreeNodeDraggable disconnect_1;
  ViewTreeNodeDraggable disconnect_2;

  /// add parent to the following widget
  ///@param parent view that the controller updates with certain operations
  ///@param eventMap map needed to make a schedule in the model
  void addParent(ViewTreeAssembler parent, Map<dynamic, dynamic> eventMap)
  {
    this.parent = parent;
    model = new ModelTreeDeserializer(parent, eventMap);
  }

  /// Retrieve editing mode
  String getMode()
  {
    return parent.editState;
  }

  /// Add a node pair to the data model that contains the nodes
  /// currently stored in the controller (connect_1/connect_2)
  void addNodePair()
  {
    NodePairAssembler np = new NodePairAssembler(connect_1, connect_2);
    this.model.pairs.add(np); // add pair to model
  }

  /// remove a node pair if their nodes match with the requested arguments
  ///@param node1 node head in pair to remove
  ///@param node2 node end in pair to remove
  void removePair(ViewTreeNodeStatic n1, ViewTreeNodeStatic n2)
  {
    print("removing pair...");
    List<NodePairAssembler> pairs = model.pairs;
    for(int i = 0; i < pairs.length; i++)
    {
      NodePairAssembler p = pairs[i];
      ViewTreeNodeStatic o1 = p.front;
      ViewTreeNodeStatic o2 = p.back;

      if(identical(n1, o1) && identical(n2, o2))
      {
        pairs.removeAt(i);
        print("removed");
      }
      if(identical(n2, o1) && identical(n1, o2))
      {
        pairs.removeAt(i);
        print("removed");
      }
    }
  }

  /// remove a node object from the tree
  ///@param node the node to remove
  void removeNode(ViewTreeNodeStatic node)
  {
    print("Removing Node...");
    // remove all connections
    List<NodePairAssembler> pairs = model.pairs;
    for(int i = 0; i < pairs.length; i++)
      {
        NodePairAssembler p = pairs[i];
        ViewTreeNodeStatic n1 = p.front;
        ViewTreeNodeStatic n2 = p.back;
        if(n1.id == node.id || n2.id == node.id)
          {
            removePair(n1, n2);
            i --;
          }
      }
  }

  /// Direct user to node display window
  ///@param node the node we are entering in the node editor window
  void transferNodeEditor(BuildContext context, ViewTreeNodeStatic node)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNodeInfo(node)));
  }
}
