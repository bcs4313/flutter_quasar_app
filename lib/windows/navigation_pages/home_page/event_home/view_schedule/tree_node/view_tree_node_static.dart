import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../../../col.dart';
import '../../../../../../size_config.dart';
import '../extension_tree_builder.dart';

import '../controller_tree_builder.dart';

/// Tree Node
/// A basic node that is part of the tree in a schedule builder
///@author Cody Smith at RIT (bcs4313)
class ViewTreeNodeStatic extends StatelessWidget
{
  // dimensional variables
  double x; // x location in tree
  double y; // y location in tree
  double width; // width of node
  double height = 7 * SizeConfig.scaleVertical; // height of node
  ControllerTreeAssembler controller;
  bool disabled = false; // deleted nodes are "disabled"

  // identification variables
  static int identifier = 0;
  int id;

  // Strings that are stored in this node
  String title = ""; // title of node
  String description = ""; // desc of node
  // Time Range Variables
  String startDate = "choose date";
  String startTime = "choose time";
  String endDate = "choose date";
  String endTime = "choose time";

  /// Constructor initialized by stateful itself
  ViewTreeNodeStatic(double y, double x, ControllerTreeAssembler controller)
  {
    this.x = x;
    this.y = y;
    this.title = "title";
    this.controller = controller;
    this.id = identifier;
    identifier++;
    print("node constructor initialized");
  }

  var current_col = Col.purple_2;
  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    this.width = 18 * SizeConfig.scaleHorizontal + (pow(title.length * SizeConfig.scaleHorizontal, 0.9));
    // Arrow element stores data to targets it must point to
    Widget node = Container(
      height: height,
      width: width,
      color: current_col,
      child: FittedBox(
        fit: BoxFit.contain,
      child: TextButton.icon(
          onPressed: () {
            print("detected press on node");
            // view the node, pretty simple compared to the original editor
            controller.transferNodeEditor(controller.parent.context, this);
          },
          label: Text(title,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Col.white)),
          icon: Icon(
            Icons.account_circle,
            color: Col.white,
          ),
      ),
      ),
    );

    print("x = " + x.toString());
    print("y = " + y.toString());
    if (!disabled) {
      return Positioned(
        top: y - height / 2,
        left: x - width / 2,
            child: node);
    }
    else
    {
      return Container();
    }
  }
}