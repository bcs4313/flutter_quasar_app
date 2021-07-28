import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_user_manager/view_user_manager.dart';
import 'event_requests/extension_friend_requests.dart';

/// @author Cody Smith at RIT
///
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
}
