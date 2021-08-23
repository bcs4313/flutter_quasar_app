import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/extension_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/exit_event_confirmation/view_event_exiter.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/extension_homepage.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';

/// Controller of a view that confirms the leave of a selected event.
/// Prevents an accidental event leave (ViewEventExiter)
///@author Cody Smith at RIT (bcs4313)
class ControllerEventExiter
{
  /// used to cross-reference variables from the view
  ViewEventExiter parent;

  /// Add parent view to this controller that
  /// this controller updates and queries
  void assignParent(ViewEventExiter parent)
  {
    this.parent = parent;
  }

  /// Leave an event by removing the eventLink from the user's
  /// profile and removing the user from the event whitelist.
  /// @param context context used to redirect the user back to the homepage.
  void pushLeave(BuildContext context)
  {
    // Initiate document from database to modify
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<dynamic, dynamic> map = parent.eventMap;
    List<String> idLink = [];
    idLink.add(auth.currentUser.uid.toString());

    try {
      // step one, remove self from whitelist
      firestore.collection('event_groups')
          .doc(map["MetaData"]["owner"]).update(
          { "base.event_" + map["MetaData"]["event_num"]
              + ".Whitelist": FieldValue.arrayRemove(idLink)}).then((value) {
        print(map["MetaData"]["owner"] + "/Whitelist//" + idLink.toString());
        print(map.toString());
        List<String> eventLink = [];
        eventLink.add(map["MetaData"]["event_num"]
            + "#" + map["MetaData"]["owner"]);

        // step two, remove the link from the user's own profile
        // directory (friend_access_profiles)
        firestore.collection('friend_access_profiles')
            .doc(auth.currentUser.uid.toString()).update(
            { "eventLinks": FieldValue.arrayRemove(eventLink)}).then((value) {
              U_SimpleSnack("Event Was Left Successfully", 4000, context);
          pushHome(context);
        });
      });
    }
    on FirebaseException catch(e)
    {
      U_SimpleSnack("There was an issue leaving this event: "
          + e.toString(), 7000, context);
    }
  }
  ///

  /// Direct user to the home window. Deletes window stack.
  void pushHome(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new HomepageStateful()));
  }
}
