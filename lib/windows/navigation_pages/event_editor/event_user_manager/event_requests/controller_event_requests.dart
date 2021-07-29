import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_user_manager/event_requests/view_event_requests.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_user_manager/event_requests/widget_event_requests_request.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/extension_user_profile.dart';

import '../../widget_event_edtor_event.dart';

/// Controller for a view that lists requests to join an event
/// from other users (ViewEventRequests)
///@author Cody Smith at RIT (bcs4313)
class ControllerEventRequests
{
  var widgetList = <Widget>[];
  WidgetMainPageEvent host; // parent object to gather event info from
  ViewEventRequests parent; // stateful widget to update upon gathering requests
  String eventID; // id number of the event this controls
  bool rebuild = false; // used to prevent unecessary extra requests to firebase

  // This data structure is a bit annoying but useful. Its a map
  // of each individual widget that is used in the UI with the uid of the
  // user who requested attached. This allows us to easy retrieve the Widget
  // to remove from the UI without having to request from firebase again,
  // saving valuable data
  Map<String, Widget> widgetMap = new Map();

  /// Constructor for this controller
  ///@param host communicates information about the event we are editing
  ///@param eventID id number of the event this controls
  ControllerEventRequests(WidgetMainPageEvent host, String eventID)
  {
    this.host = host;
    this.eventID = eventID;
    print("event ID for this controller: " + eventID);
  }

  /// construct an array of widgets with each row dedicated to a
  /// singular event request in the Firebase database for this user.
  ListView constructWidgets()
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    print("construct_call");

    // Initiate list to return later
          int index = 0;
          firestore.collection('request_env_dump')
              .doc(auth.currentUser.uid).collection("event_" + eventID).get().then((value_2){
            var requests = value_2.docs;
            // limitation of 10 requests in view for usability purposes
            for(int i = 0; i < 10 - index; i++)
            {
              if(i < requests.length)
              {
                print("retrieve");
                var request = requests.elementAt(i);
                var map_full = request.data();
                var nickname = map_full["Username"];
                if(nickname == null)
                {
                  nickname = "undefined (unsafe)";
                }
                var id = map_full["ID"];
                print("name: " + nickname);
                WidgetEventRequest tab = new WidgetEventRequest(nickname, id, parent.controller);

                // assign widget to a map for expected deletions
                widgetMap[id] = tab;

                index++;
                print("found a friend (event)");
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
    return new ListView();
  }

  // add parent to the following widget
  void addParent(ViewEventRequests parent)
  {
    this.parent = parent;
  }

  /// Add the user to the whitelist of the event in question,
  /// giving them access to the info within and basic permissions.
  ///@param uid the id of the user to add.
  ///@param context context of the request view for Snackbars
  addToEvent(String uid, BuildContext context)
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // reference the location of the event and update the respective
    // "whitelist" value
    try {
      List<String> uidLink = [];
      uidLink.add(uid);
      firestore.collection("event_groups").doc(auth.currentUser.uid)
          .update({"base.event_" + eventID + ".Whitelist" : FieldValue.arrayUnion(uidLink)}).then((value)
      {
        // since we updated the whitelist properly we can now safely remove the request
        // from the ui and from firebase
        removeFromDump(uid, context);
      });
    }
    on FirebaseException catch (e)
    {
      U_SimpleSnack("There was an issue accepting the request: " + e.toString(),
      8000, context);
    }
  }

  /// remove the event request from the env dump
  /// in firebase. Also remove the widget in question from the requests
  /// area of the request UI.
  ///@param uid user ID to remove from the requests area
  ///@param context context of the request view for Snackbars
  removeFromDump(String uid, BuildContext context)
  {
    print("Dump remove call");
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // destroy the request from this event in particular
      firestore.collection("request_env_dump").doc(
          auth.currentUser.uid.toString()).
      collection("event_" + eventID).doc(uid).delete().then((value) {
        // since no error was thrown we update the UI for the user
        rebuild = true;
        widgetList.remove(widgetMap[uid]);

        // construct a new listview with the updated widget list
        ListView newList = new ListView(
          children: widgetList,
        );
        parent.updateConstruct(newList);
      });
    }
    on FirebaseException catch (e)
    {
      U_SimpleSnack("There was an issue removing the request: " + e.toString(), 8000, context);
    }
  }

  /// Direct user to basic profile window with some specialized info
  ///@param username name of user
  ///@param id identification number of user to load bio/image
  void transferUserProfile(String username, String id, String wishlist, String bio)
  {
    Navigator.push(parent.context, MaterialPageRoute(builder: (context) => new U_UserProfileStateful(username, id, wishlist, bio)));
  }
}
