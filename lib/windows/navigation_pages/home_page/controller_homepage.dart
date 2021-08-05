import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/view_homepage.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/widget_event_homepage.dart';

import 'event_home/extension_event_home.dart';

/// Controller for the main home view. Responsible for
/// listing events the user is in with proper ordering and
/// any upcoming parts of an event in process.
///@author Cody Smith at RIT (bcs4313)
class ControllerHomepage {
  ViewHomepage parent;

  /// Take the event links from the friend_access_profiles location of firebase
  /// and download each individual event from them. Take these events and
  /// add them to a list to be processed. Pass into a method flow
  /// that constructs the rest of the home view.
  /// Method flow process
  /// => loadEvents => organizeLinks => retrieveEvents => constructWidgets
  void loadEvents() {
    /// first step is to download the links from friend_access_profiles
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      firestore.collection("friend_access_profiles").doc(
          auth.currentUser.uid.toString()).get().then((value) {
        Map<dynamic, dynamic> doc = value.data();
        List<dynamic> eventLinks = doc["eventLinks"];

        if(eventLinks == null)
          {
            print("no event Links found. nothing will be loaded!");
            return;
          }

        print(eventLinks.toString());
        organizeLinks(eventLinks);
      });
    }
    on FirebaseException catch (e) {
      print("HOME SCREEN ERROR! " + e.toString());
    }
  }

  /// Take a list of event links and move them into a structure
  /// that minimizes request count (one request per UID instead of per event)
  ///@param eventLinks a list containing Strings to user ids and a respective event number
  void organizeLinks(List<dynamic> eventLinks)
  {
    // Each position in the list is a list with the first position being a uid, and all the
    // corresponding positions being an event index number.
    List<List<String>> struct = [];

    // used to assign each individual ID a position when a new one is found
    Map<String, int> IDMap = new Map();
    int structIndex = 0; // tracks next new ID position

    for(int i = 0; i < eventLinks.length; i++)
      {
        // Now to get the id and index via string split
        String index = eventLinks[i].split("#")[0];
        String id = eventLinks[i].split("#")[1];

        if(IDMap.containsKey(id))
          {
            struct[IDMap[id]].add(index);
            structIndex++;
          }
        else
          {
            IDMap[id] = structIndex;
            struct.insert(structIndex, []);
            struct[IDMap[id]].add(id);
            struct[IDMap[id]].add(index);
            structIndex++;
          }
      }
    print("Struct constructed::: " + struct.toString());
    retrieveEvents(struct);
  }

  /// Take an event link list and retrieve each event map
  /// needed from it, putting them into a list.
  ///@param struct a list of lists with each list containing a uid and
  ///event indexes that the user needs to load the events properly.
  void retrieveEvents(List<List<String>> struct)
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    List<dynamic> eventList = [];
    for(int i = 0; i < struct.length; i++)
      {
        // retrieve the doc containing all of the events from this user
        firestore.collection("event_groups").doc(struct[i][0]).get().then((value)
        {
          Map<String, dynamic> doc = value.data();
          print("doc gathered: " + doc.toString());

          // loop through the remaining event indexes
          for(int x = 1; x < struct[i].length; x++)
            {
              String index = struct[i][x];
              Map<dynamic, dynamic> group = doc["base"];
              Map<dynamic, dynamic> event = group["event_" + index];
              if(event == null)
                {
                  print("null event found--> \n" + "eventLinks."
                      + index.toString() + "#" +  struct[i][0].toString() + "\n ... deleting");
                  // Since the event is null, we no longer should be including it
                  // as a proper event link.
                  List<String> eventLink = [];
                  eventLink.add(index.toString() + "#" +  struct[i][0].toString());
                  firestore.collection("friend_access_profiles").
                  doc(auth.currentUser.uid.toString()).update({"eventLinks":
                  FieldValue.arrayRemove(eventLink)});
                }
              eventList.add(event);
            }
          if(i == struct.length - 1) // if the loop is finished we go to the next part
            {
              constructWidgets(eventList);
            }
        });
      }
  }

  /// Take a list of organized event maps and populate the view with
  /// with widgets of what to do and what events the user is part of.
  /// Color code current events based on if they are active or not.
  ///@param eventList a list of event map structures to process
  ///and display on the screen to use.
  void constructWidgets(List<dynamic> eventList)
  {
    List<Widget> events = [];
    List<Widget> parts = [];
    for(int i = 0; i < eventList.length; i++)
      {
        print("eventList: " + eventList[i].toString());
        var eventWidget = HomePageEventWidget(eventList[i], this);
        events.add(eventWidget);
      }

    ListView currentEvents = new ListView(
      children: events,
    );
    // the parent is the protected member stinky code
    // ignore: invalid_use_of_protected_member
    parent.setState(() {
      parent.eventView = currentEvents;
      parent.partView = ListView();
    });
  }

  /// Add the parent of this controller to be
  /// modified.
  ///@param homepage the parent to control
  void addParent(ViewHomepage parent)
  {
    this.parent = parent;
  }

  /// Direct user to event Home window
  ///@param envMap event map info needed to view and work with this event
  void transferEventHome(BuildContext context, Map<dynamic, dynamic> envMap)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new EventHomeStateful(envMap)));
  }
}
