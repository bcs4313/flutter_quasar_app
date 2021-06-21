import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/view_profile_home.dart';

import 'controller_profile_home.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class

class ProfileHomeStateful extends StatefulWidget {
  String username = "";
  @override
  State<StatefulWidget> createState() {
    ControllerProfileHome controller = new ControllerProfileHome();
    ViewProfileHome parent = new ViewProfileHome(controller, this);
    controller.parent = parent;
    return parent;
}
}