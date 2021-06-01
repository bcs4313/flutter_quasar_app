import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

/// @author Cody Smith at RIT
///
/// Model structure used for a scheduler tree
/// Necessary for construction since
/// this tree will have to be stored within firebase
/// and downloaded by users.
class ModelTreeBuilder
{
  // remove a node pair if their nodes match with the requested arguments
  //@param node1 node head in pair to remove
  //@param node2 node end in pair to remove
  void removePair(ViewTreeNodeDraggable n1, ViewTreeNodeDraggable n2)
  {
    print("removing pair...");
    print("length = " + pairs.length.toString());
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
    print("length = " + pairs.length.toString());
  }

  // Stored Vars



  // stored in firebase
  List<NodePair> pairs = [];
}
