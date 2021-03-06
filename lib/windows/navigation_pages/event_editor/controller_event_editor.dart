import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/widget_event_edtor_event.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/extension_tree_builder.dart';

import 'event_user_manager/event_requests/view_event_requests.dart';
import 'event_user_manager/view_user_manager.dart';

/// Controller for the view that lists events for a user
/// to manage (ViewEventEditor)
///@author Cody Smith at RIT (bcs4313)
class ControllerEventEditor
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  var widgetList = <Widget>[];
  ViewEventEditorMainPage parent; // stateful widget to update after various changes to this controller

  /// construct an array of widgets with each row dedicated to a
  /// singular event in the Firebase database for this user.
  /// Allows the editing and deletion of individual events,
  /// along with the addition of users.
  ListView constructWidgets()
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Initiate list to return later
    firestore.collection('event_groups')
        .doc(auth.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          Map map_full = documentSnapshot.data();
          Map env_map_full = map_full["base"];
          print("MAP:" + env_map_full.toString());
          for(dynamic nav in env_map_full.keys)
            {
               Map<dynamic, dynamic> env_cat_map = env_map_full[nav];
               print("MAP 2: " + env_cat_map.toString());
               Map<dynamic, dynamic> env_data = env_cat_map["MetaData"];
               print("MAP 3: " + env_data.toString());
               String title = env_data["title"];
               String event_num = env_data["event_num"];
               Widget widget = new WidgetMainPageEvent(title, event_num);
               widgetList.add(widget);
            }
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
  void addParent(ViewEventEditorMainPage parent)
  {
    this.parent = parent;
  }

  /// Direct user to event creation window
  void transferCreateEvent(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitializerEventCreator()));
  }

  /// Direct user to tree building window, passing the event to edit with it.
  ///@param eventID the id of the event we are editing
  void transferTreeBuilder(BuildContext context, String eventID)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TreeBuilderStateful(eventID)));
  }

  /// Direct user to User Manager window, changing which window to direct to
  /// depending on if the event has auto-join or not.
  ///@param eventID the id of the event we are editing
  void transferUserManager(BuildContext context, WidgetMainPageEvent parent)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUserManager(parent)));
  }
}
