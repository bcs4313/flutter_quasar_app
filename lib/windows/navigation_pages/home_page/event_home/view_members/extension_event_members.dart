import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_members/view_event_members.dart';
import 'controller_event_members.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class EventMembersStateful extends StatefulWidget {
  Map<dynamic, dynamic> eventMap;

  ///Constructor for this stateful object
  ///@param eventMap map needed to retrieve the members
  ///of individual events.
  EventMembersStateful(Map<dynamic, dynamic> eventMap)
  {
    this.eventMap = eventMap;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerEventMembers controller = new ControllerEventMembers();
    ViewEventMembers parent = new ViewEventMembers(controller, this, eventMap);

    return parent;
}
}