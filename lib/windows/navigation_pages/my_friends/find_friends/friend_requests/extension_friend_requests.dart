import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/view_friend_requests.dart';
import '../../view_friends_home.dart';
import 'controller_friend_requests.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class FriendRequestsStateful extends StatefulWidget {

  ViewFriendsHome parent;

  /// Constructor for the requests view
  ///@param parent the view to update upon friend request acception
  FriendRequestsStateful(ViewFriendsHome parent)
  {
    this.parent = parent;
  }

@override
State<StatefulWidget> createState() {
  ControllerFriendRequests controller = new ControllerFriendRequests(parent);
  return ViewFriendRequests(controller);
}
}