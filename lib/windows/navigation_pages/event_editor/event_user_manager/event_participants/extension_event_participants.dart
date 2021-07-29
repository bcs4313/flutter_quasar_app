import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_user_manager/event_participants/view_event_participants.dart';
import '../../widget_event_edtor_event.dart';
import 'controller_event_participants.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class EventParticipantsStateful extends StatefulWidget {

  WidgetMainPageEvent parent;
  String eventID; // index number of the event we are managing

  /// Constructor for the requests view
  ///@param parent the view to update upon friend request acception
  EventParticipantsStateful(WidgetMainPageEvent parent)
  {
    this.parent = parent;
    this.eventID = parent.id;
  }

@override
State<StatefulWidget> createState() {
  ControllerEventParticipants controller = new ControllerEventParticipants(parent, eventID);
  return ViewEventParticipants(controller);
}
}