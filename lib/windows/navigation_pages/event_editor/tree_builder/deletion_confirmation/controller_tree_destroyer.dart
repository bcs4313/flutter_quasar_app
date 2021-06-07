import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/extension_event_editor.dart';

import '../model_tree_builder.dart';
import '../view_tree_builder.dart';

/// @author Cody Smith at RIT
///
class ControllerTreeDestroyer
{

  ModelTreeBuilder model; // model to delete nodes from
  ViewTreeBuilder view; // view to update from this controller upon deletion

  /// Constructor for this controller
  ///@param model the model to remove children from
  ///@param view the view to update the state of
  ControllerTreeDestroyer(ModelTreeBuilder model, ViewTreeBuilder view)
  {
    this.model = model;
    this.view = view;
  }

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  /// Remove all nodes from the tree builder model upon request
  void pushTreeDeletion(BuildContext context)
  {
    view.setState(() {
      model.nodes = [];
      model.pairs = [];
      view.children = [];
    });
    Navigator.pop(context);
  }
}
