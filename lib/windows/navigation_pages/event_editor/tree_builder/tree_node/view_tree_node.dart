import 'package:flutter/material.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';

/// Tree Node
/// A basic node that is part of the tree in a schedule builder
class ViewTreeNode extends StatelessWidget
{
  // dimensional variables
  double x; // x location in tree
  double y; // y location in tree
  double width; // width of node
  double height; // height of node

  // Creation of a node needs an x and y to appear relative to the cursor
  ViewTreeNode(double x, double y)
  {
    this.x = x;
    this.y = y;
    print("node constructor initialized");
  }

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    print("node built");
    return Positioned(
      bottom: x,
      right: y,
      child: Container(
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
      ),
    );
  }
}