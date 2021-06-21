import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/view_event_creator.dart';

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
/// @author Cody Smith at RIT
///
class InitializerEventCreator extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return new ViewEventCreator();
  }
}