import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/view_tree_node_static.dart';

/// A pair of nodes the painter will use to connect
/// with its own lines
///@author Cody Smith at RIT (bcs4313)
class NodePairAssembler {
  ViewTreeNodeStatic front;
  ViewTreeNodeStatic back;
  NodePairAssembler(ViewTreeNodeStatic a, ViewTreeNodeStatic b)
  {
    front = a;
    back = b;
  }
}