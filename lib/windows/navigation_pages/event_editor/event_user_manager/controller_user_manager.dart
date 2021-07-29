import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_user_manager/view_user_manager.dart';
import 'event_participants/extension_event_participants.dart';
import 'event_requests/extension_event_requests.dart';

/// Controller of the view that lists event participants to manage  as the host.
/// (ViewUserManager)
///@author Cody Smith at RIT (bcs4313)
class ControllerUserManager
{

  ViewUserManager parent;

  ControllerUserManager(ViewUserManager parent)
  {
    this.parent = parent;
  }

  /// transfer user to event request window
  void transferEventRequests(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventRequestsStateful(parent.parent)));
  }

  /// transfer user to event participant window
  void transferEventParticipants(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventParticipantsStateful(parent.parent)));
  }
}
