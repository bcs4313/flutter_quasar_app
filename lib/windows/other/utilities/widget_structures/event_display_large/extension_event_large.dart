import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/event_display_large/view_event_large.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/friend_display_large/view_friend_large.dart';

import 'controller_event_large.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class

class U_EventLargeStateful extends StatefulWidget {
  String id = ""; // id of user hosting this event
  String eventName = "Loading..."; // name of the event
  String description = ""; // description of event
  String autoJoin = "false"; // if friends can join without needing a request
  Image pfp; // profile picture of user

  U_EventLargeStateful(String id, String eventName, String description, String autoJoin, Image pfp)
  {
    this.id = id;
    this.eventName = eventName;
    this.description = description;
    this.autoJoin = autoJoin;
    this.pfp = pfp;
  }

  @override
  State<StatefulWidget> createState() {
    ControllerEventLarge controller = new ControllerEventLarge();
    ViewEventLarge parent = new ViewEventLarge(id, eventName, description, autoJoin, pfp, controller);
    return parent;
}
}