import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_scheduler.dart';
import 'extension_scheduler.dart';

/// Login Screen UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewScheduler extends State<SchedulerStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // define container width and height here (shared across all elements)
  static double containerWidth = 95;
  static double containerHeight = 80;

  ControllerScheduler controller;

  ViewScheduler(ControllerScheduler controller)
  {
    this.controller = controller;
  }

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return generatePortraitView(context);
    } else {
      return generateLandscapeView(context);
    }
  }

  /// generate a portrait projection of the window view
  Scaffold generatePortraitView(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Schedule Builder"),
      drawer: DrawerConstruct(),

      body: Center(
            child: InteractiveViewer(
                child: Container(
                  width: 50 * SizeConfig.scaleVertical,
                  height: 100 * SizeConfig.scaleVertical,
                  color: Col.purple_1,
                child: Column(
                  children: [
                    Container(
                      width: 10 * SizeConfig.scaleVertical,
                      height: 10 * SizeConfig.scaleVertical,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                      onPressed: ()
                      {
                        //controller.transferDeletionConfirmation(context);
                      },
                      child: const Text('Origin'),
                    ),
                    ),
                    ]),
                ),
                ),
              ),
          );
  }

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}