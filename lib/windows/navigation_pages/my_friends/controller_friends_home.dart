import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/view_friends_home.dart';
import '../../../col.dart';
import '../../../size_config.dart';

import 'package:image_picker/image_picker.dart';

import 'find_friends/friend_requests/extension_friend_requests.dart';
import 'find_friends/view_find_friends.dart';

/// Profile Home Controller
///
class ControllerFriendsHome
{
  // used for global scaffold calls (and Snackbars)
  ViewFriendsHome parent; // view of this controller
  PickedFile file; // file stored in this controller to upload

  /// Direct user to friend adding window
  void transferFindFriends(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewFindFriends()));
  }

  /// Direct user to friend request window
  void transferFriendRequests(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new FriendRequestsStateful()));
  }
}