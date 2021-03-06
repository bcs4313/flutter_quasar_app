import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/extension_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/extension_homepage.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/join_event/extension_join_event.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/extension_friends_home.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/extension_profile_home.dart';

/// Controller of the drawer feature of our application.
/// Basically it takes requests to replace a window with another. The argument
/// is a case sensitive string of the view to push.
///@author Cody Smith at RIT (bcs4313)
class ControllerDrawer {

  static BuildContext context;

  /// This transfer method changes where it goes depending on an input string
  /// update these case statements to add new window options for the drawer
  static void transferFlex(String locale)
  {
    print("transferFlex: " + locale);
    switch(locale)
    {
      case("ViewHomepage"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomepageStateful()));
        break;
      case("ViewEventEditorMainPage"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CounterPageStateful()));
        break;
      case("ViewProfileHome"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileHomeStateful()));
        break;
      case("ViewFriendsHome"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FriendsHomeStateful()));
        break;
      case("ViewJoinEvent"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JoinEventStateful()));
    }
  }
}