import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/view_friends_home.dart';
import 'package:flutter_quasar_app/windows/other/utilities/friend_display_large/extension_friend_large.dart';
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

  /// Analyze the friend document a user has and create
  /// individual "pages" for them to scroll through
  ///@return list of friend groups in 5, with ids as
  ///each individual string in the list
  void initializeFriendList()
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<List<String>> friendsList = [];

    // retrieve friend data from firebase
    firestore.collection("friend_access_profiles").doc(auth.currentUser.uid).get().then((value)
    {
      var doc = value.data();
      print("friend doc: " + doc.toString());
      List<dynamic> friends = doc["friends"];

      print("list loop length: " + friends.length.toString());
      // hard limit of 50 friend retrievals
      for(int i = 0; i < friends.length && i < 10; i++)
        {
          List<String> friend_group = [];
          for(int f = 0; f < 5 && (f + (i * 5) < friends.length); f++)
            {
              String friend_id = friends[i + f].toString();
              friend_group.add(friend_id);
            }
          friendsList.add(friend_group);
        }
      print("friend list constructed: " + friendsList.toString());
      displayFive(friendsList, 0);
    });
  }

  /// Take a list of 5 friends and display them in the
  /// view.
  ///@param friends, the friends that we have loaded in.
  ///@param step, the group of 5 to look in, first index 0
  Future<void> displayFive(List<List<String>> friends, int step)
  async {
    List<Widget> widgets = [];
    print("friend list being used: " + friends.toString());
    // loop through the list and display them in the view
    for(int i = 0; i < friends[step].length; i++)
      {
        FriendLargeStateful friendWidget;
        friendWidget = new FriendLargeStateful(friends[step][i]);
        widgets.add(friendWidget);
      }
    ListView view = new ListView(
      children: widgets,
    );

    parent.setState(() {
      parent.eventConstruct = view;
    });
  }

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