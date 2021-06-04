import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/node_editor/view_node_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/widget_event_edtor_event.dart';

/// @author Cody Smith at RIT
///
class ControllerNodeEditor
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  var widgetList = <Widget>[];
  ViewNodeEditor parent; // stateful widget to update after various changes to this controller

  // add parent to the following widget
  void addParent(ViewNodeEditor parent)
  {
    this.parent = parent;
  }
}
