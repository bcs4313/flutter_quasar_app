import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/email_requester/view_email_requester.dart';
import 'controller_email_requester.dart';

/// Serves as the extension of a stateful widget
/// All variables that cannot be reinitialized must be placed within
/// this class
class EmailRequesterStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ControllerEmailRequester controller = new ControllerEmailRequester();
    ViewEmailRequester parent = new ViewEmailRequester(controller, this);
    return parent;
}
}