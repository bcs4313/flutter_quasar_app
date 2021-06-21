import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/extension_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/extension_tree_builder.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/view_homepage.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/extension_profile_home.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/view_profile_home.dart';

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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewHomepage()));
        break;
      case("ViewEventEditorMainPage"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CounterPageStateful()));
        break;
      case("ViewProfileHome"):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileHomeStateful()));
        break;
    }
  }
}