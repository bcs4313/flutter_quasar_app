import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/node_editor/extension_node_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/extension_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

import 'deletion_confirmation/view_tree_destroyer.dart';
import 'model_tree_builder.dart';

/// Controller for the complex tree view of the scheduler system (ViewTreeBuilder)
///@author Cody Smith at RIT (bcs4313)
class ControllerTreeBuilder
{
  ViewTreeBuilder parent; // stateful widget to update after various changes to this controller
  ModelTreeBuilder model; // data model for UI

  // stored variables relative to the controller
  //
  // 2 nodes to connect to each other in connect mode
  ViewTreeNodeDraggable connect_1;
  ViewTreeNodeDraggable connect_2;

  // 2 nodes to disconnect to each other in disconnect mode
  ViewTreeNodeDraggable disconnect_1;
  ViewTreeNodeDraggable disconnect_2;

  /// add parent to the following widget
  ///@param parent view that the controller updates with certain operations
  void addParent(ViewTreeBuilder parent)
  {
    this.parent = parent;
    model = new ModelTreeBuilder(parent.eventID, parent);
  }

  /// Retrieve editing mode
  String getMode()
  {
    return parent.editState;
  }

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
  ///
  /// Call for down tapping on the tree background.
  /// @param context build context to work with the coordinate plane of the view
  /// @param details contains variables relative to the tap action
  /// @param func describes which action is currently desired by the user via dropdown
  /// @param link widget (most likely a node) that may or may not have been called.
  onTapDown(TapDownDetails details, String func, Widget link) {
    double l_x = details.localPosition.dx; // acquiring local position x
    double l_y = details.localPosition.dy; // acquiring local position y
    // or user the local position method to get the offset
    //print(details.localPosition);
    print("tap down " + l_x.toString() + ", " + l_y.toString());
  }

  /// Call for down tapping on the tree background.
  /// @param context build context to work with the coordinate plane of the view
  /// @param details contains variables relative to the tap action
  /// @param func describes which action is currently desired by the user via dropdown
  /// @param link widget (most likely a node) that may or may not have been called.
  onTapUp(TapUpDetails details, String func, Widget link) {
    double l_x = details.localPosition.dx; // acquiring local position x
    double l_y = details.localPosition.dy; // acquiring local position y
    // or user the local position method to get the offset
    //print(details.localPosition);
    print("tap up " + l_x.toString() + ", " + l_y.toString());
    print("updating parent: ");

    // Add a node if in "add" mode
    TreeNodeStateful n = new TreeNodeStateful(l_y, l_x, this);
    parent.setState(() {
      parent.children.add(n);
    });
    addNode(n);
  }

  /// Add a node to the data model
  ///@param n the node to be added
  void addNode(TreeNodeStateful n)
  {
    this.model.nodes.add(n);
  }

  /// Add a node pair to the data model that contains the nodes
  /// currently stored in the controller (connect_1/connect_2)
  void addNodePair()
  {
    NodePair np = new NodePair(connect_1, connect_2);
    this.model.pairs.add(np); // add pair to model
  }

  /// remove a node pair if their nodes match with the requested arguments
  ///@param node1 node head in pair to remove
  ///@param node2 node end in pair to remove
  void removePair(ViewTreeNodeDraggable n1, ViewTreeNodeDraggable n2)
  {
    print("removing pair...");
    List<NodePair> pairs = model.pairs;
    for(int i = 0; i < pairs.length; i++)
    {
      NodePair p = pairs[i];
      ViewTreeNodeDraggable o1 = p.front;
      ViewTreeNodeDraggable o2 = p.back;

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
  void removeNode(ViewTreeNodeDraggable node)
  {
    print("Removing Node...");
    // remove all connections
    List<NodePair> pairs = model.pairs;
    for(int i = 0; i < pairs.length; i++)
      {
        NodePair p = pairs[i];
        ViewTreeNodeDraggable n1 = p.front;
        ViewTreeNodeDraggable n2 = p.back;
        if(n1.id == node.id || n2.id == node.id)
          {
            removePair(n1, n2);
            i --;
          }
      }
    // (remove child from parent)
    // we are simply disabling it to reduce code complexity
    node.setState(() {
      node.disabled = true;
    });
  }

  /// Direct user to node editing window
  ///@param node the node we are editing in the node editor window
  void transferNodeEditor(BuildContext context, ViewTreeNodeDraggable node)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NodeEditorStateful(node)));
  }

  /// Direct user to tree deletion window
  void transferTreeDestroyer(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTreeDestroyer(model, parent)));
  }
}
