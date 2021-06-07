import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/extension_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';

/// @author Cody Smith at RIT
///
/// Model structure used for a scheduler tree
/// Necessary for construction since
/// this tree will have to be stored within firebase
/// and downloaded by users.
class ModelTreeBuilder
{
  // Stored Vars
  List<NodePair> pairs = []; // stores a list of node pairs that indicate that they are linked
  List<TreeNodeStateful> nodes = []; // list of individual node objects and their data
}
