import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/scheduler/view_scheduler.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_scheduler.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class SchedulerStateful extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  ControllerScheduler controller = new ControllerScheduler();
  return ViewScheduler(controller);
}
}