import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/view_friend_requests.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/widget_friend_requests_request.dart';
import 'package:flutter_quasar_app/windows/other/utilities/user_profile_lookup/extension_user_profile.dart';

/// @author Cody Smith at RIT
///
class ControllerFriendRequests
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  var widgetList = <Widget>[];
  ViewFriendRequests parent; // stateful widget to update after various changes to this controller

  /// construct an array of widgets with each row dedicated to a
  /// singular event in the Firebase database for this user.
  /// Allows the editing and deletion of individual events,
  /// along with the addition of users.
  ListView constructWidgets()
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;



    // Initiate list to return later
    firestore.collection('request_email_dump')
        .doc(auth.currentUser.email).collection("docs").get().then((value)  {
          var requests = value.docs;


          int index = 0;
          // limitation of 10 requests in view for usability purposes
          for(int i = 0; i < 10; i++)
            {
              if(i < requests.length)
                {
                  var request = requests.elementAt(i);
                  var map_full = request.data();
                  var nickname = map_full["Username"];
                  var id = map_full["ID"];
                  if(nickname == null)
                    {
                      nickname = "undefined (unsafe)";
                    }
                  WidgetFriendRequest tab = new WidgetFriendRequest(nickname, id, parent.controller);
                  index++;
                  widgetList.add(tab);
                }
            }
          firestore.collection('request_ID_dump')
              .doc(auth.currentUser.uid).collection("docs").get().then((value_2){
            var requests_2 = value_2.docs;
            // limitation of 10 requests in view for usability purposes
            for(int i = 0; i < 10 - index; i++)
            {
              if(i < requests_2.length)
              {
                var request_2 = requests_2.elementAt(i);
                var map_full = request_2.data();
                var nickname = map_full["Username"];
                var id = map_full["ID"];
                WidgetFriendRequest tab = new WidgetFriendRequest(nickname, id, parent.controller);
                index++;
                widgetList.add(tab);
              }
            }
          });
          ListView view = ListView(
            key: Key(widgetList.length.toString()),
            children: widgetList,
          );

          // update the stateful widget of the mainpage, populating it
          // with event buttons
          parent.updateConstruct(view);

          return view;
    });
  }

  /// Accept a friend request by putting their id into a friends list
  /// in the friend_access_profiles directory
  ///@param id id of user to accept
  void acceptFriend(String id)
  {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    var map = new Map<String, dynamic>();
    var map_friends = new Map<String, String>();
    map_friends[id] = "true";
    map["friends"] = map_friends;

    firestore.collection('friend_access_profiles')
        .doc(auth.currentUser.uid).update(map).then((value)
    {
      removeFriend(id);
    });
  }

  /// Remove friend from the request areas
  /// In the dump directories
  ///@param id id of user to decline
  void removeFriend(String id)
  {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    // email dump deletion
    firestore.collection('request_email_dump').
    doc(auth.currentUser.email).collection("docs").doc(id).delete();

    // id dump deletion
    firestore.collection('request_id_dump').
    doc(auth.currentUser.uid).collection("docs").doc(id).delete();

    print(widgetList.length);
    // now remove this widget from the friend request view as a visual indicator.
    for(int i = 0; i < widgetList.length; i++)
      {
        Widget w = widgetList[i];
        WidgetFriendRequest tab = w;
        print("tab id: ==" + tab.id);
        if(tab.id == id)
          {
            print("removing...");
            widgetList.remove(w);
          }
      }
    // now update the view
    ListView view_new = ListView(
      key: Key(widgetList.length.toString()),
      children: widgetList,
    );
    print(widgetList.length);
    parent.updateConstruct(view_new);
  }

  // add parent to the following widget
  void addParent(ViewFriendRequests parent)
  {
    this.parent = parent;
  }

  /// Direct user to basic profile window with some specialized info
  ///@param username name of user
  ///@param id identification number of user to load bio/image
  void transferUserProfile(String username, String id)
  {
    Navigator.push(parent.context, MaterialPageRoute(builder: (context) => new UserProfileStateful(username, id)));
  }
}
