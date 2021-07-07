import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/join_event/view_join_event.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/event_display_large/extension_event_large.dart';

import '../../../col.dart';

/// @author Cody Smith at RIT
///
class ControllerJoinEvent
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  var widgetList = <Widget>[];
  ViewJoinEvent parent; // stateful widget to update after various changes to this controller

  // list of maps to display in this window
  List<Map<String, dynamic>> eventMaps = [];
  List<Image> pfps = []; // loaded pictures to add onto the event list

  // add parent to the following widget
  void addParent(ViewJoinEvent parent)
  {
    this.parent = parent;
  }

  /// Retrieve event info from the friend of each user and display it
  Future<void> loadFriendEvents() async
  {
    print("retrieving event info from all friends...");
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    /// First we will retrieve each friend of this user,
    /// getting their ID
    var ref = firestore.collection("friend_access_profiles").
    doc(auth.currentUser.uid.toString());
    try {
      List<dynamic> friendIDS = [];
      ref.get().then((value) async {
        Map<String, dynamic> map_full = value.data();
        //print(map_full.toString());
        friendIDS = map_full["friends"];

        /// with the list of friend IDS retrieved, we will
        /// go into each profile and load their events
        for(int i = 0; i < friendIDS.length; i++)
          {
            var eventRef = firestore.collection("event_groups").doc(friendIDS[i]);

            // now to load the pfp of the users
            var storage = FirebaseStorage.instance;
            var ref = storage.ref("profile_pictures/" +
                friendIDS[i].toString() + ".png"
            );
            var data = await ref.getData(500000); // max size is in bytes (0.5 megabytes)
            if(data != null) { // if the image was received
              Image img = Image.memory(data); // load the image from memory
              pfps.add(img);

            var doc = eventRef.get().then((value){
              Map<String, dynamic> events_full = value.data();
              Map<String, dynamic> env_base = events_full["base"];

              // go through all of the events from this user and load them
              for(int x = 0; x < env_base.keys.length; x++)
                {
                  Map<String, dynamic> env_map = env_base[env_base.keys.elementAt(x)];
                  env_map["owner"] = friendIDS[i].toString();
                  env_map["index"] = i;
                  eventMaps.add(env_map);
                }
              if(i == friendIDS.length - 1)
                {
                  finishProcess();
                }
            });
          }
      }});
    }
    on FirebaseException catch (e)
    {
      U_SimpleSnack("There was an issue retrieving events from your friends. " + e.toString(),
        7000, parent.context);
    }

  }

  /// This is called when all asynchronous operations from firebase
  /// have finished. At this point we will convert each map into
  /// a special event widget.
  Future<void> finishProcess()
  async {
    widgetList.clear();
    print("looping...");
    for(int i = 0; i < eventMaps.length; i++)
      {
        Map<String, dynamic> eventMap = eventMaps[i];
        print(eventMaps.toString());
        Map<String, dynamic> mapData = eventMap["Data"];
        String eventName = mapData["title"];
        String description = mapData["description"];
        String autoJoin = mapData["auto_join"];
        Image pfp;

        // find out which image to use in the list
        int imgIndex = eventMap["index"];
        print("index = " + imgIndex.toString());
        pfp = pfps[imgIndex];
        print(pfp.toString());
        // create the event widget
        U_EventLargeStateful eventWidget = new U_EventLargeStateful(eventMap["owner"], eventName, description, autoJoin, pfp);
        widgetList.add(eventWidget);
        print(widgetList.length.toString());
      }

    ListView view = new ListView(
      key: Key("UPDATEDVIEW__" + widgetList.length.toString()),
      children: widgetList,
    );

    parent.updateConstruct(view);
  }
}
