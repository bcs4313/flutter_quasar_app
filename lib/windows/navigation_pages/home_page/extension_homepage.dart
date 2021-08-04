import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/view_homepage.dart';
import 'controller_homepage.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class HomepageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ControllerHomepage controller = new ControllerHomepage();
    return ViewHomepage(controller);
  }
}