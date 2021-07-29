import 'package:flutter/cupertino.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/node_editor/view_node_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';

import 'controller_node_editor.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class NodeEditorStateful extends StatefulWidget {

  ViewTreeNodeDraggable node;

  /// Node Editor Constructor
  ///@param node the draggable node that is being edited in this window
  NodeEditorStateful(ViewTreeNodeDraggable node)
  {
    this.node = node;
  }
@override
State<StatefulWidget> createState() {
  ControllerNodeEditor controller = new ControllerNodeEditor();
  return new ViewNodeEditor(controller, node);
}
}