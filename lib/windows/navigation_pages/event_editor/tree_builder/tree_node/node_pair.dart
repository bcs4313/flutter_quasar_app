import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

import '../../../../../col.dart';
import '../controller_tree_builder.dart';
import 'extension_tree_node.dart';

/// A pair of nodes the painter will use to connect
/// with its own lines
///@author Cody Smith at RIT (bcs4313)
class NodePair {
  ViewTreeNodeDraggable front;
  ViewTreeNodeDraggable back;
  NodePair(ViewTreeNodeDraggable a, ViewTreeNodeDraggable b)
  {
    front = a;
    back = b;
  }
}