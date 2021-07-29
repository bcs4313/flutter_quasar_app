import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/join_event/view_join_event.dart';
import 'controller_join_event.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class JoinEventStateful extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  ControllerJoinEvent controller = new ControllerJoinEvent();
  return ViewJoinEvent(controller);
}
}