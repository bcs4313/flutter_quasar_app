import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/extension_event_editor.dart';

/// @author Cody Smith at RIT
///
class ControllerEventDeleter
{

  String eventNum;

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  /// Gather event data from a specific event in firebase and display it on screen
  void assignEventData(String eventNum)
  {
    // modify key to work properly with map
    this.eventNum = eventNum;
  }

  /// Remove a specific event map in the firebase document for this user
  /// @param context context used to redirect the user back to the event editor mainpage.
  void pushMapDeletion(BuildContext context)
  {
    // Initiate document from database to modify
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('event_groups')
        .doc(auth.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {

      // Remove dynamic map of this specific event from the document in firebase
      firestore.collection('event_groups')
          .doc(auth.currentUser.uid.toString()).update(
          { eventNum: FieldValue.delete() }).then((value) => pushEditorMainPage(context));
    });
  }
  ///

  /// Direct user to event mainpage window. Deletes window stack.
  void pushEditorMainPage(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new CounterPageStateful()));
  }
}
