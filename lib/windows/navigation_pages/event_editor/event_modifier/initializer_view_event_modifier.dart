import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_modifier/view_event_modifier.dart';

import 'controller_event_modifier.dart';

/// Initializers start up stateful views in our appliation.
/// To initialize a stateful view. Return the class
/// in the create state method of this class.
///
/// Make sure the class extends the state of the initializer
/// like this -- 'class' extends State<initializerClass>
///
/// Views that are stateful are required to store stateful vars inside of the
/// view itself. They are separate from the model's vars.
///
///@author Cody Smith at RIT (bcs4313)
///
class InitializerEventModifier extends StatefulWidget
{

  String eventNum;

  InitializerEventModifier(String eventNum)
  {
    this.eventNum = eventNum;
  }

  @override
  State<StatefulWidget> createState()
  {
    ControllerEventModifier controller = new ControllerEventModifier();
    controller.assignEventData(eventNum);
    return new ViewEventModifier(controller, controller.getAutoJoin(),
        controller.getTitle(), controller.getDescription());
  }
}
