import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/view_tree_builder.dart';

import 'controller_tree_builder.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class TreeAssemblerStateful extends StatefulWidget {

  String eventID; // id of event we are modifying
  Map<dynamic, dynamic> eventMap; // event metadata and schedule data

  /// Constructor for this stateful window
  ///@param eventID the id of the event we are modifying with this builder
  ///@param eventMap map of the event we are working with
  TreeAssemblerStateful(String eventID, Map<dynamic, dynamic> eventMap)
  {
    this.eventID = eventID;
    this.eventMap = eventMap;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerTreeAssembler controller = new ControllerTreeAssembler();
    return ViewTreeAssembler(controller, eventID, eventMap);
}
}