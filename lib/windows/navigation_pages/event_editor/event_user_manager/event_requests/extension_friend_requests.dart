import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_user_manager/event_requests/view_friend_requests.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/view_friend_requests.dart';
import '../../widget_event_edtor_event.dart';
import 'controller_friend_requests.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class EventRequestsStateful extends StatefulWidget {

  WidgetMainPageEvent parent;
  String eventID; // index number of the event we are managing

  /// Constructor for the requests view
  ///@param parent the view to update upon friend request acception
  EventRequestsStateful(WidgetMainPageEvent parent)
  {
    this.parent = parent;
    this.eventID = parent.id;
  }

@override
State<StatefulWidget> createState() {
  ControllerEventRequests controller = new ControllerEventRequests(parent, eventID);
  return ViewEventRequests(controller);
}
}