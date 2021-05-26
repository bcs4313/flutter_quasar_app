import 'package:flutter/material.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import '../controller_tree_builder.dart';

/// Tree Node
/// A basic node that is part of the tree in a schedule builder
class ViewTreeNodeStateless extends StatelessWidget
{
  // dimensional variables
  double x; // x location in tree
  double y; // y location in tree
  double width; // width of node
  double height; // height of node
  ControllerTreeBuilder controller;

  // Tree node constructor
  //@param x coord x of node to be created
  //@param y coord y of node to be created
  //@param controller ControllerTreeBuilder controller that manages aspects of this node from the view
  ViewTreeNodeStateless(double x, double y, ControllerTreeBuilder controller)
  {
    this.x = x;
    this.y = y;
    this.controller = controller;
    print("node constructor initialized");
  }

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    print("node built");
    return Container(
      color: Col.purple_2,
      child: TextButton.icon(
          label: Text('Title',
              style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, height: 1.3, fontFamily: 'Roboto', color: Col.white)),
          icon: Icon(
            Icons.account_circle,
            color: Col.white,
          ),
          onPressed: () {
            print('Pressed');
          }
      ),
    );
  }
}