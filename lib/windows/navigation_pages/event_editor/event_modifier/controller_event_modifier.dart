import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/extension_event_editor.dart';
import 'deletion_confirmation/view_event_deleter.dart';

import 'model_event_modifier.dart';

/// @author Cody Smith at RIT
///
class ControllerEventModifier
{

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
  // sets
  void setTitle(String title) { ModelEventModifier.title = title; }
  void setDescription(String description) {ModelEventModifier.description = description; }
  void setAutoJoin(bool autojoin) { ModelEventModifier.autoJoin = autojoin; }
  void setFriendsOnly(bool friendsonly) { ModelEventModifier.friendsOnly = friendsonly; }
  void setEventNum(String eventNum) { ModelEventModifier.eventNum = eventNum; }
  // gets
  String getTitle() { return ModelEventModifier.title; }
  String getDescription() { return ModelEventModifier.description; }
  bool getAutoJoin() { return ModelEventModifier.autoJoin; }
  bool getFriendsOnly() { return ModelEventModifier.friendsOnly; }
  String getEventNum() { return ModelEventModifier.eventNum; }

  /// Gather event data from a specific event in firebase and display it on screen
  void assignEventData(String eventNum)
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // modify key to work properly with map
    eventNum = "event_" + eventNum;
    setEventNum(eventNum); // store event number in model

    // Initiate list to return later
    firestore.collection('event_groups')
        .doc(auth.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map env_map_full = documentSnapshot.data();
      print("MAP:" + env_map_full.toString());
      Map<dynamic, dynamic> env_cat_map = env_map_full[eventNum];
      print("MAP 2: " + env_cat_map.toString());
      Map<dynamic, dynamic> env_data = env_cat_map["Data"];
      print("MAP 3: " + env_data.toString());

      // set data found by firebase to the event in question
      setTitle(env_data["title"]);
      setDescription(env_data["description"]);

      print("Retrieved Title is: " + env_data["title"]);

      if(env_data["friends_only"] == "true") {
        setFriendsOnly(true);
      }
      else {
        setFriendsOnly(false);
      }

      if(env_data["auto_join"] == "true") {
        setAutoJoin(true);
      }
      else {
        setAutoJoin(false);
      }
    });
  }

  /// Get the data of an event from firebase (dynamic hashmap document) and update the
  /// contents of it for the event with its id stored in this controller's model.
  /// Afterwards, exit the window.
  /// @param context context used to redirect the user back to the event editor mainpage.
  void pushMapUpdate(BuildContext context)
  {
    // Initiate document from database to modify
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('event_groups')
        .doc(auth.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map f_env_map_full = documentSnapshot.data();
      Map f_env_map = f_env_map_full[getEventNum()];
      Map f_data = f_env_map["Data"];

      // now to modify each string in the data of this event
      f_data["description"] = getDescription();
      f_data["title"] = getTitle();
      if(getFriendsOnly() == true) { f_data["friends_only"] = "true"; }
      else { f_data["friends_only"] = "false"; }
      if(getAutoJoin() == true) { f_data["auto_join"] = "true"; }
      else { f_data["auto_join"] = "false"; }

      // update event in document with the data provided
      firestore.collection('event_groups')
          .doc(auth.currentUser.uid.toString()).update(
          { getEventNum() : f_env_map }).then((value) => pushEditorMainPage(context));
        });
  }

  Map generateBaseMap()
  {
    Map env_map_full = new HashMap<String, HashMap<String, HashMap<String, String>>>();
    HashMap env_cat_map = new HashMap<String, HashMap<String, String>>();
    HashMap env_whitelist_map = new HashMap<String, String>();
    HashMap env_data_map = new HashMap<String, String>();

    // Populate Data Category
    env_data_map["event_num"] = "1";
    env_data_map["description"] = getDescription();
    env_data_map["title"] = getTitle();
    if(getFriendsOnly() == true) { env_data_map["friends_only"] = "true"; }
    else { env_data_map["friends_only"] = "false"; }
    if(getAutoJoin() == true) { env_data_map["auto_join"] = "true"; }
    else { env_data_map["auto_join"] = "false"; }

    // Populate Whitelist Category
    FirebaseAuth auth = FirebaseAuth.instance;
    env_whitelist_map["0"] = auth.currentUser.uid.toString();

    // Populate Categorical map
    env_cat_map["Data"] = env_data_map;
    env_cat_map["Whitelist"] = env_whitelist_map;

    env_map_full["event_" + "1"] = env_cat_map;

    return env_map_full;
  }

  ///

  /// Direct user to event mainpage window. Deletes window stack.
  void pushEditorMainPage(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new CounterPageStateful()));
  }

  /// Direct user to event deletion window.
  void transferDeletionConfirmation(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewEventDeleter(getEventNum())));
  }
}
