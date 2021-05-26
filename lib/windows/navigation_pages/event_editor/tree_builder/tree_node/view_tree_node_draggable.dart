import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_stateless.dart';
import '../view_tree_builder.dart';
import 'extension_tree_node.dart';
import 'view_tree_node.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import '../controller_tree_builder.dart';

/// Tree Node
/// A basic node that is part of the tree in a schedule builder
class ViewTreeNodeDraggable extends ViewTreeNode
{
  ViewTreeNodeDraggable(double x, double y, ControllerTreeBuilder controller) : super(x, y, controller);

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    print("node built");
    ViewTreeNodeStateless node = new ViewTreeNodeStateless(x, y, controller);
    return Positioned(
      bottom: y,
      right: x,
      child: Draggable(
        child: node,
        feedback: node,
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          controller.parent.setState(() {
            setState(() {
              print(offset.toString());
              // not 100% sure why this works. Flutter is strange sometimes
              y = (SizeConfig.screenHeight - ViewTreeBuilder.containerHeight) - offset.dy - 13;
              x = (SizeConfig.screenWidth - ViewTreeBuilder.containerWidth) - offset.dx + 5;
              print("new x = " + x.toString());
              print("new y = " + y.toString());
            });
          });
        },
        childWhenDragging: Container(),
      ),
    );
  }
}