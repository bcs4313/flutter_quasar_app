import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/tree_node/view_tree_node_static.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/event_home/view_schedule/view_tree_builder.dart';

/// Model deserializer for a schedule
/// tree from firebase.
///
///Note: Deserialization has been coded manually.
///@author Cody Smith at RIT (bcs4313)
class ModelTreeDeserializer
{
  // Stored Vars
  List<NodePairAssembler> pairs = []; // stores a list of node pairs that indicate that they are linked
  List<ViewTreeNodeStatic> nodes = []; // list of individual node objects and their data
  String eventID; // tells us what event this model points to
  ViewTreeAssembler parent; // parent to update upon loading an existent tree

  /// simple constructor to add event data to the model with
  ///@param parent view that is attached to this data
  ///@param eventMap data needed to construct an existing schedule
  ModelTreeDeserializer(ViewTreeAssembler parent, Map<dynamic, dynamic> eventMap)
  {
    this.eventID = eventID;
    this.parent = parent;
    this.deserializeModel(eventMap); // load content from firebase
  }

  /// find a node by its id number (for node connecting)
  ///@param id identification number of the node to return
  ///@return a node or null if not found
  ViewTreeNodeStatic findNode(int id)
  {
    for(int i = 0; i < parent.children.length; i++)
    {
      ViewTreeNodeStatic stat = parent.children[i];
      if(id == stat.id)
      {
        return stat;
      }
    }
    return null;
  }

  // Take apart an input base64 from firebase and load it into this model and the view.
  //@param eventMap map of the event that we can retrieve the schedule from
  void deserializeModel(Map<dynamic, dynamic> eventMap)
  {
    // clear any potential nodes out of this model and view
    nodes = [];
    pairs = [];
    parent.children = [];

    print("map to deserialize::: " + eventMap.toString());
      Map env_map_full = eventMap["Schedule"];
      if(env_map_full != null)
        {
          //print("Map Retrieved::: " + env_map_full.toString() + "\n\n building...");
          Map node_map_full = env_map_full["node_map_full"];

          for(int i = 0; i < node_map_full.keys.length; i++)
            {
              // access node map at position i
              Map node_map = node_map_full[node_map_full.keys.elementAt(i)];
              print("current node: " + node_map.toString());

              // create the node
              ViewTreeNodeStatic n = new ViewTreeNodeStatic(double.parse(node_map["y"]), double.parse(node_map["x"]), parent.controller);
              n.id = int.parse(node_map["id"]);
              n.id = n.id;

              n.title = node_map["title"];
              n.description = node_map["description"];
              n.startDate = node_map["startDate"];
              n.startTime = node_map["startTime"];
              n.endDate = node_map["endDate"];
              n.endTime = node_map["endTime"];

              parent.children.add(n); // add node to view
              this.nodes.add(n);
            }

          // now to go through each nodepair connection and add them to this model
          Map pair_map_full = env_map_full["pair_map_full"];
          print("PAIRMAP::: " + pair_map_full.toString());
          for(int i = 0; i < pair_map_full.keys.length; i++)
            {
              Map pair_map = pair_map_full[pair_map_full.keys.elementAt(i)];
              print("basic pair map:: " + pair_map.toString());

              // get ids of pair nodes
              int front_id = int.parse(pair_map["front"]);
              int back_id = int.parse(pair_map["back"]);

              // find nodes by id to create pair with
              ViewTreeNodeStatic front = findNode(front_id);
              ViewTreeNodeStatic back = findNode(back_id);

              // create the pair and add it to the model to draw
              if(front != null && back != null) {
                NodePairAssembler pair = new NodePairAssembler(front, back);
                pairs.add(pair);
              }
              else
                {
                  print("found null connection? issues? \n");
                }
            }}
  }
}

