import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/view_friends_home.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/view_profile_home.dart';

import 'controller_friends_home.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class FriendsHomeStateful extends StatefulWidget {
  String username = "";
  @override
  State<StatefulWidget> createState() {
    ControllerFriendsHome controller = new ControllerFriendsHome();
    ViewFriendsHome parent = new ViewFriendsHome(controller, this);
    controller.parent = parent;

    // generate a list of friends to look through
    controller.initializeFriendList();
    return parent;
}
}