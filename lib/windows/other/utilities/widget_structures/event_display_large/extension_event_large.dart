import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/event_display_large/view_event_large.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/friend_display_large/view_friend_large.dart';

import 'controller_event_large.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class U_EventLargeStateful extends StatefulWidget {
  String id = ""; // id of user hosting this event
  String eventName = "Loading..."; // name of the event
  String description = ""; // description of event
  String autoJoin = "false"; // if friends can join without needing a request
  String wishlist; // pfp wishlist
  String bio; // description
  Image pfp; // profile picture of user
  int KEY; // used to separate it from other elements in the list view
  String username; // needed to load a profile without using firebase again
  String eventNum; // lets us know which event index in particular to update

  U_EventLargeStateful(String id, String eventName, String description,
      String autoJoin, Image pfp, String wishlist, String bio, int KEY,
      String username, String eventNum)
  {
    this.id = id;
    this.eventName = eventName;
    this.description = description;
    this.autoJoin = autoJoin;
    this.bio = bio;
    this.wishlist = wishlist;
    this.pfp = pfp;
    this.KEY = KEY;
    this.username = username;
    this.eventNum = eventNum;
    print("creating state?");
  }


  @override
  Key get key => Key("EXTENSION_EVENT_LRG_STATEFUL" + KEY.toString());

  @override
  State<StatefulWidget> createState() {
    ControllerEventLarge controller = new ControllerEventLarge();
    ViewEventLarge parent = new ViewEventLarge(id, eventName, description, autoJoin, pfp,
        controller, wishlist, bio, KEY, username, eventNum);
    return parent;
}
}