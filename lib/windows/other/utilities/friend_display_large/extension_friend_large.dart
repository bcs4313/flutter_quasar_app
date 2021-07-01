import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/friend_display_large/view_friend_large.dart';
import 'package:flutter_quasar_app/windows/other/utilities/user_profile_lookup/view_user_profile.dart';

import 'controller_friend_large.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class

class FriendLargeStateful extends StatefulWidget {
  String id = "";

  FriendLargeStateful(String id)
  {
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerFriendLarge controller = new ControllerFriendLarge();
    ViewFriendLarge parent = new ViewFriendLarge(id, controller);
    return parent;
}
}