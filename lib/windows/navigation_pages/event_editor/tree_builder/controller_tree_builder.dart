

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/extension_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

import '../../../../size_config.dart';
import 'model_tree_builder.dart';

/// @author Cody Smith at RIT
///
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

  // add parent to the following widget
  void addParent(ViewTreeBuilder parent)
  {
    this.parent = parent;
    model = new ModelTreeBuilder();
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

    print("Mode == " + func);
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
    print("Mode == " + func);
    if(func == "Add") {
      parent.setState(() {
        parent.children.add(
            new TreeNodeStateful(l_y, l_x, this)
        );
      }
      );
    }
  }
}
