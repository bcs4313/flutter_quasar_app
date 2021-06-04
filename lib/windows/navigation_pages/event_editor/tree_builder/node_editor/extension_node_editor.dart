import 'package:flutter/cupertino.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/node_editor/view_node_editor.dart';

import 'controller_node_editor.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class NodeEditorStateful extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  ControllerNodeEditor controller = new ControllerNodeEditor();
  return new ViewNodeEditor(controller);
}
}