import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/view_user_profile.dart';

import 'controller_user_profile.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class U_UserProfileStateful extends StatefulWidget {
  String username = "";
  String id = "";
  String bio = "";
  String wishlist = "";

  bool isFriend = false;
  U_UserProfileStateful(String username, String id, String bio, String wishlist)
  {
    this.username = username;
    this.id = id;
    this.bio = bio;
    this.wishlist = wishlist;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerUserProfile controller = new ControllerUserProfile();
    ViewUserProfile parent = new ViewUserProfile(username, id, controller, bio, wishlist);
    return parent;
}
}