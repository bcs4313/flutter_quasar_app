import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_members/view_event_members.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/friend_display_large/extension_friend_large.dart';

/// Controller of the event members window (ViewEventMembers)
///@author Cody Smith at RIT (bcs4313)
class ControllerEventMembers
{
  // used for global scaffold calls (and Snackbars)
  ViewEventMembers parent; // view of this controller
  List<List<String>> memberList = []; // list to use

  /// Analyze the event document a user is in and create
  /// individual "pages" of users for them to scroll through
  ///@param eventMap map needed to retrieve all the users
  ///that are in the event.
  ///@return list of friend groups, 8 at a time, with ids as
  ///each individual string uid in the list
  void initializeMemberList(Map<dynamic, dynamic> eventMap)
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // retrieve info of the members from the event Map
    var doc = eventMap;
    print("event doc: " + doc.toString());
    List<dynamic> members = doc["Whitelist"];

    if(members != null) {
      print("list loop length: " + members.length.toString());
      // hard limit of 80 member retrievals
      for (int i = 0; i < members.length && i < 10; i++) {
        List<String> member_group = [];
        for (int f = 0; f < 8 && (f + (i * 8) < members.length); f++) {
          String member_id = members[i + f].toString();
          member_group.add(member_id);
        }
        memberList.add(member_group);
      }
      print("member list constructed: " + memberList.toString());
      parent.count = (memberList.length / 8).ceil();
      displayEight(memberList, 0);
    }
    else
      {
        // update the listview to remove the loading circle
        var view = new ListView(
          children: [Container()],
        );

        parent.setState(() {
          parent.eventConstruct = view;
          parent.count = 0;
          parent.disposition = -1;
        });
      }
  }

  /// Take a list of 8 members and display them in the
  /// view.
  ///@param friends, the friends that we have loaded in.
  ///@param step, the group of 8 to look in, first index 0
  Future<void> displayEight(List<List<String>> friends, int step)
  async {
    List<Widget> widgets = [];
    print("user list being used: " + friends.toString());

    ListView view;
    try {
      // loop through the list and display them in the view
      for (int i = 0; i < friends[step].length; i++) {
        U_FriendLargeStateful friendWidget;
        friendWidget = new U_FriendLargeStateful(friends[step][i]);
        widgets.add(friendWidget);
      }
      view = new ListView(
        children: widgets,
      );
    }
    on RangeError catch (e)
    {
      view = new ListView(
        children: [Container()],
      );
    }

    parent.addView(view, step);
  }

  /// Go back a page in the view if applicable
  void arrowBackward()
  {
    if(parent.disposition > 0)
      {
        displayEight(memberList, parent.disposition - 1);
      }
  }

  /// Go forward a page in the view if applicable
  void arrowForward()
  {
    if(parent.disposition < (parent.count - 1))
      {
        displayEight(memberList, parent.disposition - 1);
      }
  }
}