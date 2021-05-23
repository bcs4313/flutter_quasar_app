import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/widget_event_edtor_event.dart';

/// @author Cody Smith at RIT
///
class ControllerEventEditor
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  var widgetList = <Widget>[];


  ///

  ListView constructWidgets()
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Initiate list to return later
    firestore.collection('event_groups')
        .doc(auth.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          Map env_map_full = documentSnapshot.data();
          print("MAP:" + env_map_full.toString());
          for(dynamic nav in env_map_full.keys)
            {
               Map<dynamic, dynamic> env_cat_map = env_map_full[nav];
               print("MAP 2: " + env_cat_map.toString());
               Map<dynamic, dynamic> env_data = env_cat_map["Data"];
               print("MAP 3: " + env_data.toString());
               String title = env_data["title"];
               String event_num = env_data["event_num"];
               Widget widget = new WidgetMainPageEvent(title, event_num);
               print("widget returned: " + widget.toString());
               widgetList.add(widget);
               print("added");
               print("widget just added: " + widgetList[0].toString());
            }
          print("widget just added: " + widgetList[0].toString());
          ListView view = ListView(
            children: widgetList,
          );
          return view;
    });
  }

  /// Direct user to window telling them to verify their email.
  void transferCreateEvent(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitializerEventCreator()));
  }
}
