import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/view_friend_requests.dart';
import 'controller_friend_requests.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class FriendRequestsStateful extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  ControllerFriendRequests controller = new ControllerFriendRequests();
  return ViewFriendRequests(controller);
}
}