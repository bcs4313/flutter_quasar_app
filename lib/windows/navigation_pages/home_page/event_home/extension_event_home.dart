import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_event_home.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/view_friends_home.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/view_profile_home.dart';

import 'controller_event_home.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class EventHomeStateful extends StatefulWidget {
  Map<dynamic, dynamic> envMap;

  EventHomeStateful(Map<dynamic, dynamic> envMap)
  {
    this.envMap = envMap;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerEventHome controller = new ControllerEventHome();
    ViewEventHome parent = new ViewEventHome(controller, envMap);
    controller.parent = parent;

    return parent;
}
}