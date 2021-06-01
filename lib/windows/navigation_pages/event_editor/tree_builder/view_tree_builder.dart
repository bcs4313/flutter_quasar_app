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

  // key to access the context of the schedule builder container
  GlobalKey builder_key = GlobalKey();

  // controller for this view
  ControllerTreeBuilder controller;
  List<Widget> children = []; // children nodes in tree

  // define container width and height here (shared across all elements)
  static double containerWidth = 95;
  static double containerHeight = 80;

  String editState; // current editing state we are in from dropdown menu

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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 2.7 * SizeConfig.scaleHorizontal),
                child: Container(
                color: Col.white,
                child: DropdownButton<String>(
                  focusColor:Colors.white,
                  value: editState,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor:Colors.black,
                  items: <String>[
                    'None',
                    'Add',
                    'Edit',
                    'Move',
                    'Connect',
                    'Delete',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black),),
                    );
                  }).toList(),
                  hint:Text(
                    "  Edit Mode",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      editState = value;
                    });
                  },
                ),
              ),
            ),
        ),

            InteractiveViewer(
              child: GestureDetector(
                // Here we define some gestures to track the actions of the user
                // These gestures funnel method calls into the controller
                // to be handled
                key: builder_key, // key is used to access the context and therefore this container's renderbox
                onTapUp: (TapUpDetails details) => controller.onTapUp(details, editState, null),
                onTapDown: (TapDownDetails details) => controller.onTapDown(details, editState, null),
              child: Container(
                width: containerWidth * SizeConfig.scaleHorizontal,
                height: containerHeight * SizeConfig.scaleVertical,
                color: Col.purple_1,
                child: Stack(
                    fit: StackFit.expand,
                    children: children,
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