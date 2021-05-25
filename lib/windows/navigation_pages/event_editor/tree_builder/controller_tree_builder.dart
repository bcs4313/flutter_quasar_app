import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

/// @author Cody Smith at RIT
///
class ControllerTreeBuilder
{
  ViewTreeBuilder parent; // stateful widget to update after various changes to this controller

  // add parent to the following widget
  void addParent(ViewTreeBuilder parent)
  {
    this.parent = parent;
  }

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
  onTapDown(TapDownDetails details) {
    var g_x = details.globalPosition.dx; // acquiring global position x
    var g_y = details.globalPosition.dy; // acquiring global position y
    var l_x = details.localPosition.dx; // acquiring local position x
    var l_y = details.localPosition.dy; // acquiring local position y
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap down global " + g_x.toString() + ", " + g_y.toString());
  }

  onTapUp(TapUpDetails details) {
    var g_x = details.globalPosition.dx; // acquiring global position x
    var g_y = details.globalPosition.dy; // acquiring global position y
    var l_x = details.localPosition.dx; // acquiring local position x
    var l_y = details.localPosition.dy; // acquiring local position y
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap up global " + g_x.toString() + ", " + g_y.toString());
  }
}
