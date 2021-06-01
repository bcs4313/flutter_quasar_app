

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/extension_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

import '../../../../size_config.dart';

/// @author Cody Smith at RIT
///
class ControllerScheduler
{
  ViewTreeBuilder parent; // stateful widget to update after various changes to this controller

  // add parent to the following widget
  void addParent(ViewTreeBuilder parent)
  {
    this.parent = parent;
  }

  /// Retrieve editing mode
  String getMode()
  {
    return parent.editState;
  }

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
}
