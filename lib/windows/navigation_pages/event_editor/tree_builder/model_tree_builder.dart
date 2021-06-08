import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/extension_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

/// @author Cody Smith at RIT
///
/// Model structure used for a scheduler tree
/// Necessary for construction since
/// this tree will have to be stored within firebase
/// and downloaded by users.
///
///Note: Implements an automatic serializer
class ModelTreeBuilder
{
  // Stored Vars
  List<NodePair> pairs = []; // stores a list of node pairs that indicate that they are linked
  List<TreeNodeStateful> nodes = []; // list of individual node objects and their data
  String eventID; // tells us what event this model points to

  /// simple constructor to add an event ID to
  ModelTreeBuilder(String eventID)
  {
    this.eventID = eventID;
  }

  /// Convert a singular node into a hashMap
  ///@param node the node to convert
  ///@return null if invalid, a hashMap if valid
  HashMap<dynamic, dynamic> processNode(ViewTreeNodeDraggable node)
  {
    if(node.disabled == false) {
      HashMap<String, String> nodeMap = new HashMap<String, String>();
      nodeMap["id"] = node.id.toString();
      nodeMap["x"] = node.x.toString();
      nodeMap["y"] = node.y.toString();
      nodeMap["description"] = node.description;
      nodeMap["title"] = node.title;
      nodeMap["startDate"] = node.startDate;
      nodeMap["startTime"] = node.startTime;
      nodeMap["endDate"] = node.endDate;
      nodeMap["endTime"] = node.endTime;
      return nodeMap;
    }
    else
      {
        return null;
      }
  }

  /// Convert a singular pair into a hashMap
  ///@param node the node to convert
  ///@return a hashMap structure of the pair in question
  HashMap<String, String> processPair(NodePair pair)
  {
    HashMap<String, String> pair_map = new HashMap<String, String>();
    pair_map["front"] = pair.front.id.toString();
    pair_map["back"] = pair.back.id.toString();
    return pair_map;
  }

  /// Serializer for this model in question. In other words, absolutely horrifying.
  ///@param context context of app needed to print error codes from upload
  ///@return fully serialized version of this model
  Future<void> serializeModel(BuildContext context) async
  {
    // Create HashMap Frame
    HashMap<dynamic, dynamic> map_full = new HashMap<String,
        HashMap<String, HashMap<String, String>>>(); // main map (string access)
    HashMap<dynamic, dynamic> node_map_full = new HashMap<String,
        HashMap<String, String>>(); // map of each node (integer access)
    HashMap<dynamic, dynamic> pair_map_full = new HashMap<String,
        HashMap<String, String>>(); // map of each pair (integer access)

    // node serialization step
    int index = 0;
    for (int i = 0; i < nodes.length; i++) {
      HashMap<String, String> node_map = processNode(nodes[i].draggable);
      if (node_map != null) {
        node_map_full[index.toString()] = node_map;
        index++;
      }
    }

    // pair serialization step
    index = 0;
    for (int i = 0; i < pairs.length; i++) {
      HashMap<String, String> pair_map = processPair(pairs[i]);
      pair_map_full[index.toString()] = pair_map;
      index++;
    }

    // now to serialize this into a json file
    map_full["node_map_full"] = node_map_full;
    map_full["pair_map_full"] = pair_map_full;

    String jsonString = json.encode(map_full);
    debugPrint("Serialized Schedule Tree:::\n" + jsonString, wrapWidth: 1000);
    List<int> bytes = utf8.encode(jsonString);
    var base64 = base64Encode(bytes);

    FirebaseAuth auth = FirebaseAuth.instance;
    var storage = firebase_storage.FirebaseStorage.instance;
    var reference = storage.ref("event_trees/" +
        auth.currentUser.uid.toString() + "/t_" +
        eventID); // create a path to the storage base

    // now we will upload the json file in base64 format
    try {
      await reference.putString(base64).whenComplete(() =>
      {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
        'Schedule Successfully Uploaded'),
        duration: Duration(seconds: 5),
      ))

      });
    }
    on firebase_storage.FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error: Schedule upload failed. Error Code: ' + e.toString()),
            duration: Duration(seconds: 5),
          ));
    }
  }

  // Take apart an input json and load it into this model and the view
  //@return null if there is no model found, hashmap<String, String> if found
  deserializeModel()
  {

  }
}

