import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/friend_display_large/view_friend_large.dart';

import 'controller_friend_large.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class U_FriendLargeStateful extends StatefulWidget {
  String id = "";

  U_FriendLargeStateful(String id)
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