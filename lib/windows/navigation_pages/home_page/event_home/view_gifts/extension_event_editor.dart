import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/controller_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/view_event_editor.dart';
import 'package:auto_size_text/auto_size_text.dart';


/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
///@author Cody Smith at RIT (bcs4313)
class CounterPageStateful extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  ControllerEventEditor controller = new ControllerEventEditor();
  return ViewEventEditorMainPage(controller);
}
}