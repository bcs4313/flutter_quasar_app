import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/user_profile_lookup/view_user_profile.dart';

import 'controller_user_profile.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class

class UserProfileStateful extends StatefulWidget {
  String username = "";
  String id = "";

  UserProfileStateful(String username, String id)
  {
    this.username = username;
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerUserProfile controller = new ControllerUserProfile();
    ViewUserProfile parent = new ViewUserProfile(username, id, controller);
    return parent;
}
}