import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/view_friend_requests.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/friend_requests/widget_friend_requests_request.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/extension_user_profile.dart';

import '../../view_friends_home.dart';

/// @author Cody Smith at RIT
///
class ControllerFriendRequests
{
  var widgetList = <Widget>[];
  ViewFriendRequests parent; // stateful widget to update after various changes to this controller
  ViewFriendsHome host; // host object to update the state of upon updating the friendlist

  /// Constructor for this controller
  ///@param host friends list view to redraw upon modifying the friend list
  ControllerFriendRequests(ViewFriendsHome host)
  {
    this.host = host;
  }

  /// construct an array of widgets with each row dedicated to a
  /// singular event in the Firebase database for this user.
  /// Allows the editing and deletion of individual events,
  /// along with the addition of users.
  ListView constructWidgets()
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    print("construct_call");

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
                  print("found a friend (email)");
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
                print("retrieve");
                var request_2 = requests_2.elementAt(i);
                var map_full = request_2.data();
                var nickname = map_full["Username"];
                if(nickname == null)
                {
                  nickname = "undefined (unsafe)";
                }
                var id = map_full["ID"];
                print("name: " + nickname);
                WidgetFriendRequest tab = new WidgetFriendRequest(nickname, id, parent.controller);
                index++;
                print("found a friend (id)");
                widgetList.add(tab);
              }
            }
            print(widgetList.length);
            ListView view = ListView(
              key: Key(widgetList.length.toString()),
              children: widgetList,
            );

            // update the stateful widget of the mainpage, populating it
            // with event buttons
            print("updating...");
            parent.updateConstruct(view);
            return view;
          });
    });
    return new ListView();
  }

  /// Accept a friend request by putting their id into the friends list
  /// of the current user.
  /// in the friend_access_profiles directory
  ///@param id id of user to accept
  void acceptFriend(String id)
  {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    List<String> attachment = [id];
    firestore.collection('friend_access_profiles')
        .doc(auth.currentUser.uid).update({"friends" : FieldValue.arrayUnion(attachment)}).then((value)
    {
      removeFriend(id, true);
    });
  }

  /// Remove friend from the request areas
  /// In the dump directories. Later, notify that friend of acception.
  ///@param id id of user to remove
  ///@param decline if the user is being declined.
  void removeFriend(String id, bool decline)
  {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    // email dump deletion
    firestore.collection('request_email_dump').
    doc(auth.currentUser.email).collection("docs").doc(id).delete();

    // id dump deletion
    firestore.collection('request_ID_dump').
    doc(auth.currentUser.uid).collection("docs").doc(id).delete();

    print(widgetList.length);
    // now remove this widget from the friend request view as a visual indicator.
    for(int i = 0; i < widgetList.length; i++)
      {
        Widget w = widgetList[i];
        WidgetFriendRequest tab = w;
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

    if(decline == false) {
      updateFriend(view_new, id, false);
    }
    else
      {
        updateFriend(view_new, id, true);
      }
  }

  /// Update the friend that requested
  /// a friendship's pending requests, removing the
  /// id from the list. Also add the id of that friend
  /// to the friends list
  ///@param view_new the listview to update after this process completes
  ///(its the final process of accepting the request).
  ///@param id id of user to accept
  ///@param decline if the user is being declined
  void updateFriend(ListView view_new, String id, bool decline)
  {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    if(decline == false) {
      // write own id in the user's "Friends" tab
      List<String> attachmentFRIEND = [auth.currentUser.uid.toString()];
      firestore.collection('friend_access_profiles').doc(id).update(
          {"friends": FieldValue.arrayUnion(attachmentFRIEND)}).then((value) {
        // remove id in pending tabs
        List<String> attachmentID = [id];
        firestore.collection('friend_access_profiles').doc(id)
            .update(
            {"pending_requests_id": FieldValue.arrayRemove(attachmentID)})
            .then((value) {
          List<String> attachmentEMAIL = [auth.currentUser.email];
          // remove email in pending tabs
          firestore.collection('friend_access_profiles')
              .doc(id)
              .update(
              {
                "pending_requests_email": FieldValue.arrayRemove(
                    attachmentEMAIL)
              })
              .then((value) {
            parent.updateConstruct(view_new);

            // reload friendlist
            host.setState(() {
              host.controller.initializeFriendList();
            });
          });
        });
      });
    }
    else {
      // remove id in pending tabs
      List<String> attachmentID = [id];
      firestore.collection('friend_access_profiles').doc(id)
          .update(
          {"pending_requests_id": FieldValue.arrayRemove(attachmentID)})
          .then((value) {
        List<String> attachmentEMAIL = [auth.currentUser.email];
        // remove email in pending tabs
        firestore.collection('friend_access_profiles')
            .doc(id)
            .update(
            {
              "pending_requests_email": FieldValue.arrayRemove(
                  attachmentEMAIL)
            })
            .then((value) {
          parent.updateConstruct(view_new);

          // reload friendlist
          host.setState(() {
            host.controller.initializeFriendList();
          });
        });

        parent.updateConstruct(view_new);

        // reload friendlist
        host.setState(() {
          host.controller.initializeFriendList();
        });
      });
    }
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
    Navigator.push(parent.context, MaterialPageRoute(builder: (context) => new U_UserProfileStateful(username, id)));
  }
}
