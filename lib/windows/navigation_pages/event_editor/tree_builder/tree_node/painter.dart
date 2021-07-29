import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';

import '../../../../../col.dart';
import '../controller_tree_builder.dart';
import 'node_pair.dart';

/// Paints connections between nodes in the schedule builder tree.
/// This is done with the NodePair Object.
///@author Cody Smith at RIT (bcs4313)
class NodePainter extends CustomPainter {

  ControllerTreeBuilder controller;

  /// Constructor for this painter
  ///@param controller used for callback to the nodes it must draw connections to.
  NodePainter(ControllerTreeBuilder controller)
  {
    this.controller = controller;
  }

  /// Drawing method for our schedule builder overlay
  ///@param canvas canvas to draw on
  ///@param size data related to the container of the canvas
  @override
  void paint(Canvas canvas, Size size)
  {
    Paint p = new Paint();
    p.color = Col.white;
    p.strokeWidth = 3.0;
    p.blendMode = BlendMode.srcOver;

    // In this loop we will go through each connection found in our model,
    // drawing connections to each pair through a branch-like structure
    List<NodePair> pairs = controller.model.pairs;
    for(int i = 0; i < pairs.length; i++)
      {
        NodePair np = pairs[i];
        ViewTreeNodeDraggable front = np.front;
        ViewTreeNodeDraggable back = np.back;

        // If statements check whether we should draw a connection
        // on top or bottom of a node depending on their location
        if(front.y < back.y) {
          Offset front_vector = new Offset(front.x, front.y + front.height / 2);
          Offset back_vector = new Offset(back.x, back.y - front.height / 2);
          canvas.drawLine(front_vector, back_vector, p);
        }
        else {
          Offset front_vector = new Offset(front.x, front.y - front.height / 2);
          Offset back_vector = new Offset(back.x, back.y + front.height / 2);
          canvas.drawLine(front_vector, back_vector, p);
        }
      }

  }

  ///@return true if the painter should redraw the canvas
  @override
  bool shouldRepaint(CustomPainter old)
  {
     return true;
  }
}