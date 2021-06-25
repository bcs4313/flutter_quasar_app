import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/id_requester/view_id_requester.dart';
import 'controller_id_requester.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class IDRequesterStateful extends StatefulWidget {
  String username = "";
  @override
  State<StatefulWidget> createState() {
    ControllerIDRequester controller = new ControllerIDRequester();
    ViewIDRequester parent = new ViewIDRequester(controller, this);
    return parent;
}
}