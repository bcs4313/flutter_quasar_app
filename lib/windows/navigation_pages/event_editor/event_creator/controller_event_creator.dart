import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/extension_event_editor.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';

import 'model_event_creator.dart';

/// Controller of the view that allows users to create events. (ViewEventCreator)
///@author Cody Smith at RIT (bcs4313)
class ControllerEventCreator
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window
  // sets
  void setTitle(String title) { ModelEventCreator.title = title; }
  void setDescription(String description) { ModelEventCreator.description = description; }
  void setAutoJoin(bool autojoin) { ModelEventCreator.autoJoin = autojoin; }

  // gets
  String getTitle() { return ModelEventCreator.title; }
  String getDescription() { return ModelEventCreator.description; }
  bool getAutoJoin() { return ModelEventCreator.autoJoin; }

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
        Map map_full = documentSnapshot.data();
        Map env_map_full = map_full["base"];
        for (int i = 1; i <= 8; i++) {
          if (env_map_full.containsKey("event_" + i.toString()) == false) {
            event_slot = i;
            break;
          }
        }

        print("event slot: " + event_slot.toString());
        // event max check
        if (event_slot == -1) {
          U_SimpleSnack("Event creation failed. Maximum event count for basic users is 8.", 5000, context);
        }
        else
        {
          // update document with new generated event map
          Map cat_map = generateMapUpdate(event_slot);


          firestore.collection('event_groups')
              .doc(auth.currentUser.uid.toString()).update({"base.event_" + event_slot.toString() : cat_map}).then((void val) {
            pushCreateEvent(context);
          });
        }
      }
      else
      {
        firestore.collection('event_groups').doc(auth.currentUser.uid.toString()).set({"base" : {"event_1" : generateBaseMap()}}).then((void val){
          pushCreateEvent(context);
        });
      }
    }
    );
  }

  Map generateMapUpdate(int pos)
  {
    HashMap env_cat_map = new HashMap<String, dynamic>();
    List<String> env_whitelist = [];
    HashMap env_data_map = new HashMap<String, String>();

    // Populate Data Category
    env_data_map["event_num"] = pos.toString();
    env_data_map["description"] = getDescription();
    env_data_map["title"] = getTitle();
    if(getAutoJoin() == true) { env_data_map["auto_join"] = "true"; }
    else { env_data_map["auto_join"] = "false"; }

    // Populate Whitelist Category
    FirebaseAuth auth = FirebaseAuth.instance;
    env_whitelist.add(auth.currentUser.uid.toString());

    // Populate Categorical map
    env_cat_map["Data"] = env_data_map;
    env_cat_map["Whitelist"] = env_whitelist;

    return env_cat_map;
  }

  Map generateBaseMap()
  {
    HashMap env_cat_map = new HashMap<String, HashMap<String, String>>();
    HashMap env_whitelist_map = new HashMap<String, String>();
    HashMap env_data_map = new HashMap<String, String>();

    // Populate Data Category
    env_data_map["event_num"] = "1";
    env_data_map["description"] = getDescription();
    env_data_map["title"] = getTitle();
    if(getAutoJoin() == true) { env_data_map["auto_join"] = "true"; }
    else { env_data_map["auto_join"] = "false"; }

    // Populate Whitelist Category
    FirebaseAuth auth = FirebaseAuth.instance;
    env_whitelist_map["0"] = auth.currentUser.uid.toString();

    // Populate Categorical map
    env_cat_map["Data"] = env_data_map;
    env_cat_map["Whitelist"] = env_whitelist_map;

    return env_cat_map;
  }

  ///
  /// Direct user to event creation window. Deletes window stack.
  void pushCreateEvent(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new CounterPageStateful()));
  }
}