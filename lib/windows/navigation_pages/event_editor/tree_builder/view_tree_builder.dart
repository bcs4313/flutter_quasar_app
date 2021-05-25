import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_tree_builder.dart';
import 'extension_tree_builder.dart';

/// Login Screen UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewTreeBuilder extends State<TreeBuilderStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // controller for this view
  ControllerTreeBuilder controller;

  ViewTreeBuilder(ControllerTreeBuilder controller)
  {
    this.controller = controller;
    controller.addParent(this);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'Event Schedule',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            InteractiveViewer(
              child: GestureDetector(
                // Here we define some gestures to track the actions of the user
                // These gestures funnel method calls into the controller
                // to be handled
                onTapUp: (TapUpDetails details) => controller.onTapUp(details),
                onTapDown: (TapDownDetails details) => controller.onTapDown(details),
              child: Container(
                width: 95 * SizeConfig.scaleHorizontal,
                height: 80 * SizeConfig.scaleVertical,
                color: Col.purple_1,
                child: Stack(
                    fit: StackFit.expand,
                    children: [
                    Positioned(
                      bottom: 100,
                      right: 300,
                      child: Icon(Icons.home, color: Colors.red),
                    ),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ])
        ),
      );
  }

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}