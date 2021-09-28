import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/painter.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/view_tree_node_static.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_tree_builder.dart';
import 'extension_tree_builder.dart';

/// A complex view of a schedule built by
/// the host of an event.
///@author Cody Smith at RIT (bcs4313)
class ViewTreeAssembler extends State<TreeAssemblerStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // key to access the context of the schedule builder container
  GlobalKey builder_key = GlobalKey();

  // controller for this view
  ControllerTreeAssembler controller;
  List<ViewTreeNodeStatic> children = []; // children nodes in tree

  // define container width and height here (shared across all elements)
  static double containerWidth = 95;
  static double containerHeight = 80;

  String editState; // current editing state we are in from dropdown menu
  String eventID; // tells us which event is currently being edited

  ///@param eventMap since we are loading an existing map this is required for
  ///the schedule to be loaded.
  ViewTreeAssembler(ControllerTreeAssembler controller, String eventID, Map<dynamic, dynamic> eventMap)
  {
    this.controller = controller;
    this.eventID = eventID;
    controller.addParent(this, eventMap);
  }

  @override
  Widget build(BuildContext context)
  {
    print("building...");
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Schedule Viewer"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 3 * SizeConfig.scaleVertical,
                  bottom: 3 * SizeConfig.scaleVertical),
              child: AutoSizeText("Event Schedule",
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6,
                    height: 1.3,
                    fontFamily: 'Roboto',
                    color: Col.pink))),

            InteractiveViewer(
                child: CustomPaint(
                  painter: new NodePainterAssembler(controller),
              child: GestureDetector(
                // Here we define some gestures to track the actions of the user
                // These gestures funnel method calls into the controller
                // to be handled
                key: builder_key, // key is used to access the context and therefore this container's renderbox
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
              ),
            Padding(
              padding: EdgeInsets.only(left: 2.7 * SizeConfig.scaleHorizontal),
            ),
          ])
        ),
      );
  }
}