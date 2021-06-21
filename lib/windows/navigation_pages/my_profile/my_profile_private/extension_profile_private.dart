import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/my_profile_private/view_profile_private.dart';

import '../controller_profile_home.dart';
/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class

class ProfilePrivateStateful extends StatefulWidget {

  ControllerProfileHome homecontroller;

  /// Constructor carries over old window controller to preserve updates to the email and password
  ProfilePrivateStateful(ControllerProfileHome homecontroller)
  {
    this.homecontroller = homecontroller;
  }

  @override
  State<StatefulWidget> createState() {
    ViewProfilePrivate parent = new ViewProfilePrivate(homecontroller);
    return parent;
}
}