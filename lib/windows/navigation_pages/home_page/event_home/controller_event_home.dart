import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/extension_tree_builder.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/exit_event_confirmation/view_event_exiter.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_event_home.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_members/extension_event_members.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_members/view_event_members.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/extension_tree_builder.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/friend_display_large/extension_friend_large.dart';

import 'package:image_picker/image_picker.dart';

/// Controller of the event home window (ViewEventHome)
///@author Cody Smith at RIT (bcs4313)
class ControllerEventHome
{
  // used for global scaffold calls (and Snackbars)
  ViewEventHome parent; // view of this controller

  /// Direct user to the event quitting confirmation window
  void transferExitConfirmation(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
    new ViewEventExiter(parent.eventMap)));
  }

  /// Direct user to the member display window
  void transferViewMembers(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
    new EventMembersStateful(parent.eventMap)));
  }

  /// Direct user to schedule viewer
  void transferScheduleView(BuildContext context)
  {
    // make sure to supply an event map to be in viewing mode for the tree builder
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
    new TreeAssemblerStateful(parent.eventMap["MetaData"]["event_num"], parent.eventMap)));
  }
}