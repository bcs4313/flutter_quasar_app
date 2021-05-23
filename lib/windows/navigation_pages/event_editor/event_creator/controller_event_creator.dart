import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';

import 'model_event_creator.dart';

/// @author Cody Smith at RIT
///
class ControllerEventCreator
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
  // sets
  void setTitle(String title) { ModelEventCreator.title = title; }
  void setDescription(String description) { ModelEventCreator.description = description; }
  void setAutoJoin(bool autojoin) { ModelEventCreator.autoJoin = autojoin; }
  void setFriendsOnly(bool friendsonly) { ModelEventCreator.friendsOnly = friendsonly; }

  // gets
  String getTitle() { return ModelEventCreator.title; }
  String getDescription() { return ModelEventCreator.description; }
  bool getAutoJoin() { return ModelEventCreator.autoJoin; }
  bool getFriendsOnly() { return ModelEventCreator.friendsOnly; }

  /// Create an event within the Firebase database with the given information
  /// from our model.
  /// If the event creation was successful the event creation mainpage is pushed
  /// to the user.
  void createEvent(BuildContext context, GlobalKey<ScaffoldState> S_KEY)
  {
    int event_slot = -1;

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('event_groups')
        .doc(auth.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Event Document exists');
        Map env_map_full = documentSnapshot.data();
        for (int i = 1; i <= 8; i++) {
          if (env_map_full.containsKey("event_" + i.toString()) == false) {
            event_slot = i;
            break;
          }
        }

        print("event slot: " + event_slot.toString());
        // event max check
        if (event_slot == -1) {
          S_KEY.currentState.showSnackBar(SnackBar(
            content: Text(
                "Event creation failed. Maximum event count for basic users is 8."),
            duration: Duration(seconds: 5),
          ));
        }
        else
          {
            // update document with new generated event map
            Map cat_map = generateMapUpdate(event_slot);


            firestore.collection('event_groups')
                .doc(auth.currentUser.uid.toString()).update(cat_map).then((void val) {
              pushCreateEvent(context);
            });
          }
      }
      else
          {
            firestore.collection('event_groups').doc(auth.currentUser.uid.toString()).set(generateBaseMap()).then((void val){
              pushCreateEvent(context);
            });
          }
      }
    );
  }

  Map generateMapUpdate(int pos)
  {
    Map env_map_full = new HashMap<String, HashMap<String, HashMap<String, String>>>();
    HashMap env_cat_map = new HashMap<String, HashMap<String, String>>();
    HashMap env_whitelist_map = new HashMap<String, String>();
    HashMap env_data_map = new HashMap<String, String>();

    // Populate Data Category
    env_data_map["event_num"] = pos.toString();
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

    // shove event in full map
    env_map_full["event_" + pos.toString()] = env_cat_map;

    return env_map_full;
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

  /// Direct user to event creation window. Deletes window stack.
  void pushCreateEvent(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewEventEditorMainPage()));
  }
}
