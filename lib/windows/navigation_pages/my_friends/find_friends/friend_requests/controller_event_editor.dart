import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/widget_event_edtor_event.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/extension_tree_builder.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/view_friend_requests.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/widget_friend_requests_request.dart';

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
          // there will be a limitation of
          ListView view = ListView(
            children: widgetList,
          );

          // update the stateful widget of the mainpage, populating it
          // with event buttons
          parent.updateConstruct(view);

          return view;
    });
  }

  // add parent to the following widget
  void addParent(ViewFriendRequests parent)
  {
    this.parent = parent;
  }
}
