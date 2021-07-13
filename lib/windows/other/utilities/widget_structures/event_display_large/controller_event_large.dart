import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/join_event/event_preview/view_event_preview.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/event_display_large/view_event_large.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/extension_user_profile.dart';

/// Profile Home Controller
///
class ControllerEventLarge
{
  // used for global scaffold calls (and Snackbars)
  ViewEventLarge parent; // view of this controller

  /// Add view as parent to this controller
  void initialize(ViewEventLarge view)
  {
    this.parent = view;
  }

  /// direct user to user profile window
  void transferUserProfile(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new U_UserProfileStateful(parent.username, parent.id, parent.bio, parent.wishlist)));
  }

  /// Direct user to event join window
  void transferEventJoin(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewEventPreview(parent.eventName, parent.description, parent.id, parent.autoJoin, parent.eventNum)));
  }
}