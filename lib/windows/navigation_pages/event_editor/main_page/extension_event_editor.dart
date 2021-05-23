import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/widget_event_edtor_event.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_event_editor.dart';

class CounterPageStateful extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  ControllerEventEditor controller = new ControllerEventEditor();
  return ViewEventEditorMainPage(controller);
}
}