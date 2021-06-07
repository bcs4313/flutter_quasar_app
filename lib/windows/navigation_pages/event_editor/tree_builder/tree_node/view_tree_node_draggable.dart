import 'dart:math';

import 'package:flutter/material.dart';
import '../view_tree_builder.dart';
import 'extension_tree_node.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import '../controller_tree_builder.dart';

/// Tree Node
/// A basic node that is part of the tree in a schedule builder
class ViewTreeNodeDraggable extends State<TreeNodeStateful>
{
  // dimensional variables
  double x; // x location in tree
  double y; // y location in tree
  double width; // width of node
  double height = 7 * SizeConfig.scaleVertical; // height of node
  ControllerTreeBuilder controller;
  TreeNodeStateful stateful;
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

  ViewTreeNodeDraggable(double y, double x, ControllerTreeBuilder controller, TreeNodeStateful stateful)
  {
    this.x = x;
    this.y = y;
    this.title = "title";
    this.controller = controller;
    this.stateful = stateful;
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
    Widget node = AnimatedContainer(
      height: height,
      width: width,
      color: current_col,
      duration: Duration(milliseconds: 420),
      child: FittedBox(
        fit: BoxFit.contain,
      child: TextButton.icon(
          label: Text(title,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Col.white)),
          icon: Icon(
            Icons.account_circle,
            color: Col.white,
          ),
          onPressed: () {
            print("detected press on node");
            // check to see if the user is trying to connect nodes together
            ViewTreeBuilder parent = controller.parent;
            if (parent.editState == "Connect") {
              // if there is currently no nodes selected for connection
              if (controller.connect_1 == null) {
                controller.connect_1 = this;
                // change the color of the node to indicate a connection
                setState(() {
                  current_col = Col.white;
                });
              }
              else if (!identical(controller.connect_1,
                  this)) { // create a node connection for the model
                controller.connect_2 = this;
                controller.addNodePair();
                controller.connect_1.setState(() {
                  controller.connect_1.current_col = Col.purple_2;
                });
                controller.connect_1 = null;
              }
              else {
                controller.connect_1.setState(() {
                  controller.connect_1.current_col = Col.purple_2;
                });
                controller.connect_1 = null;
              }
            }
            else if (parent.editState == "Disconnect") {
              if (controller.disconnect_1 == null) {
                controller.disconnect_1 = this;
                // change the color of the node to indicate a disconnection
                setState(() {
                  current_col = Col.red_1;
                });
              }
              else {
                controller.disconnect_2 = this;
                controller.removePair(
                    controller.disconnect_1, controller.disconnect_2);
                controller.disconnect_1.setState(() {
                  controller.disconnect_1.current_col = Col.purple_2;
                });
                controller.disconnect_1 = null;
              }
            }
            else if (parent.editState == "Delete") {
              controller.removeNode(this);
            }
            else if (parent.editState == "Edit" || parent.editState == null)
              {
                controller.transferNodeEditor(context, this);
              }
          }
      ),
      ),
    );

    print("x = " + x.toString());
    print("y = " + y.toString());
    if (!disabled) {
      return Positioned(
        top: y - height / 2,
        left: x - width / 2,
        child: AbsorbPointer(
          // true absorbing state disables the draggable, allowing other controls to exist
          absorbing: false,
          child: Draggable(
            child: node,
            feedback: node,
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              controller.parent.setState(() {
                setState(() {
                  print(offset.toString());
                  // not 100% sure why this works. Flutter is strange sometimes

                  RenderBox renderBox1 = controller.parent.context
                      .findRenderObject();
                  final size1 = renderBox1.size;
                  print("SIZE of parent: $size1");

                  RenderBox renderBox = controller.parent.builder_key
                      .currentContext.findRenderObject();
                  final size = renderBox.size;
                  print("SIZE of box: $size");
                  print("old x = " + offset.dx.toString());
                  print("old y = " + offset.dy.toString());
                  offset = renderBox.globalToLocal(offset);
                  print("new x = " + offset.dx.toString());
                  print("new y = " + offset.dy.toString());
                  y = offset.dy + height / 2;
                  x = offset.dx + width / 2;
                });
              });
            },
            childWhenDragging: Container(),
          ),
        ),
      );
    }
    else
    {
      return Container();
    }
  }
}