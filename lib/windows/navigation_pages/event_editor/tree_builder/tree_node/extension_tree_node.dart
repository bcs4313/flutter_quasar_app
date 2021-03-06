import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';

import '../controller_tree_builder.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class TreeNodeStateful extends StatefulWidget {
  // dimensional variables
  double x; // x location in tree
  double y; // y location in tree
  double width; // width of node`
  double height; // height of node
  ControllerTreeBuilder controller;
  ViewTreeNodeDraggable draggable;
  int id;

  TreeNodeStateful(double x, double y, ControllerTreeBuilder controller)
  {
    this.x = x;
    this.y = y;
    this.controller = controller;
    id = controller.parent.children.length;
    this.draggable = ViewTreeNodeDraggable(x, y, controller, this);
    print("node constructor initialized");
  }

  @override
  State<StatefulWidget> createState() {
    return draggable;
  }
}