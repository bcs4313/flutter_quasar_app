import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

import '../../../../size_config.dart';

/// @author Cody Smith at RIT
///
class ControllerTreeBuilder
{
  ViewTreeBuilder parent; // stateful widget to update after various changes to this controller

  // stored variables relative to the controller
  int TUP_x; // tap down x coord
  int TUP_y; // tap down y coord
  int TDN_x; // tap down x coord
  int TDN_y; // tap down y coord

  // add parent to the following widget
  void addParent(ViewTreeBuilder parent)
  {
    this.parent = parent;
  }

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
  onTapDown(TapDownDetails details) {
    double l_x = details.localPosition.dx; // acquiring local position x
    double l_y = details.localPosition.dy; // acquiring local position y
    // or user the local position method to get the offset
    //print(details.localPosition);
    print("tap down " + l_x.toString() + ", " + l_y.toString());
  }

  onTapUp(TapUpDetails details) {
    double l_x = details.localPosition.dx; // acquiring local position x
    double l_y = details.localPosition.dy; // acquiring local position y
    // or user the local position method to get the offset
    //print(details.localPosition);
    print("tap up " + l_x.toString() + ", " + l_y.toString());
    print("updating parent: ");

    // by default a tap_up will simply add a node at the cursor location
    parent.setState(()
        {
          parent.children.add(
              new ViewTreeNode((ViewTreeBuilder.containerHeight *
                  SizeConfig.scaleVertical) - l_y,
                  (ViewTreeBuilder.containerWidth * SizeConfig.scaleHorizontal) - l_x)
          );
        }
    );
  }
}
