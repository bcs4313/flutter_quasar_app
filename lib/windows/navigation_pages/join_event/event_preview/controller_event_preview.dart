import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/join_event/event_preview/view_event_preview.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';

/// Controller that manages the preview for an event (ViewEventPreview).
///@author Cody Smith @ RIT (bcs4313)
class ControllerEventPreview
{
  ViewEventPreview parent;

  /// Constructor for this controller
  ///@param parent view that this controller is called by
  ControllerEventPreview(ViewEventPreview parent)
  {
    this.parent = parent;
  }

  /// add yourself to this event. Only works
  /// if auto-join is enabled on this event.
  /// Afterwards, close this window and reload
  /// the event join window.
  ///@param context used to push out of
  ///the window after the event is joined.
  joinEventAuto(BuildContext context)
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    List<String> uidLink = [];
    uidLink.add(auth.currentUser.uid.toString());

    // Add user uid to the whitelist, giving higher permissions to the user
    try {
      firestore.collection("event_groups").
      doc(parent.id).update({"base.event_" + parent.eventNum + ".Whitelist":
      FieldValue.arrayUnion(uidLink)}).then((value) {

        // now we will add a doc link to the user's friend_access_profile to
        // make finding which events they're in an efficient process
        List<String> eventLink = [];
        eventLink.add(parent.eventNum + "#" + parent.id);

        firestore.collection("friend_access_profiles").doc(auth.currentUser.uid.toString()).
        update({"eventLinks" : FieldValue.arrayUnion(eventLink)}).then((value){
          print("update complete");
          U_SimpleSnack("Event Successfully joined",
              4000, context);
          Navigator.pop(context); // close the window
        });
      });
    }
    on FirebaseException catch (e)
    {
      U_SimpleSnack("There was an issue auto-joining this event: " + e.toString(),
      7000, context);
    }
  }

  /// Add yourself to the dump for event requests
  /// if auto-join is disabled
  /// Afterwards, close this window and reload
  /// the event join window.
  ///@param context used to push out of
  ///the window after the request is sent.
  joinEventRequest(BuildContext context)
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    List<String> uidLink = [];
    uidLink.add(auth.currentUser.uid.toString());

    try {
      // we need to retrieve our own username for the request
      firestore.collection("friend_access_profiles").doc(auth.currentUser.uid.
      toString()).get().then((value) {
        Map<String, dynamic> userMap = value.data();
        String username = userMap["owner_username"];
        Map<String, dynamic> requestMap = new Map();
        requestMap["ID"] = auth.currentUser.uid.toString();
        requestMap["Username"] = username;

        // now we will update the dump doc with this request
        firestore.collection("request_env_dump").doc(parent.id).collection("event_" + parent.eventNum).doc
          (auth.currentUser.uid.toString()).set(requestMap).then((value) {

          // now we will add a doc link to the user's friend_access_profile to
          // make finding which events they're in an efficient process
          List<String> eventLink = [];
          eventLink.add(parent.eventNum + "#" + parent.id);
          firestore.collection("friend_access_profiles").doc(auth.currentUser.uid.toString()).
          update({"eventLinks" : FieldValue.arrayUnion(eventLink)}).then((value){
            print("update complete");
            U_SimpleSnack("Request sent successfully",
                4000, context);
            Navigator.pop(context); // close the window
          });
        });
      });
    }
    on FirebaseException catch (e)
    {
      U_SimpleSnack("There was an issue sending a request for this event: " + e.toString(),
          7000, context);
      return;
    }
  }
}