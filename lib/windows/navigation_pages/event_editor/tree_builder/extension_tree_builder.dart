import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

import 'controller_tree_builder.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class TreeBuilderStateful extends StatefulWidget {

  String eventID; // id of event we are modifying

  /// Constructor for this stateful window
  ///@param eventID the id of the event we are modifying with this builder
  TreeBuilderStateful(String eventID)
  {
    this.eventID = eventID;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerTreeBuilder controller = new ControllerTreeBuilder();
    return ViewTreeBuilder(controller);
}
}