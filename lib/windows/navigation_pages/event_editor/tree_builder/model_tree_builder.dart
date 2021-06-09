import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/extension_tree_node.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/node_pair.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/view_tree_builder.dart';

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
  ViewTreeBuilder parent; // parent to update upon loading an existent tree

  /// simple constructor to add an event ID to
  ModelTreeBuilder(String eventID, ViewTreeBuilder parent)
  {
    this.eventID = eventID;
    this.parent = parent;
    this.deserializeModel(); // load content from firebase
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
  /// Also uploads the serialized model to firebase
  ///@param context context of app needed to print error codes from upload
  Future<void> serializeModel(BuildContext context) async
  {
    // Create HashMap Frame
    HashMap<String, dynamic> map_full = new HashMap<String,
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

    FirebaseAuth auth = FirebaseAuth.instance;
    var storage = FirebaseFirestore.instance;
    var reference = storage.collection("event_trees").doc
      (auth.currentUser.uid.toString()).collection("t_" + eventID).doc("build"); // create a path to the storage base

    // now we will upload the json file in base64 format
    try {
      await reference.set(map_full).whenComplete(() =>
      {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
        'Schedule Successfully Uploaded'),
        duration: Duration(seconds: 5),
      ))

      });
    }
    on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error: Schedule upload failed. Error Code: ' + e.toString()),
            duration: Duration(seconds: 5),
          ));
    }
  }

  // Take apart an input base64 from firebase and load it into this model and the view.
  //@param context used for error codes during the download process
  Future<void> deserializeModel() async
  {
    // clear any potential nodes out of this model and view
    nodes = [];
    pairs = [];
    parent.children = [];

    // retrieve the base64 file
    FirebaseAuth auth = FirebaseAuth.instance;
    var storage = FirebaseFirestore.instance;
    var reference = storage.collection("event_trees").doc
      (auth.currentUser.uid.toString()).collection("t_" + eventID).doc("build"); // create a path to the storage base
    reference
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map env_map_full = documentSnapshot.data();
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
              TreeNodeStateful n = new TreeNodeStateful(double.parse(node_map["y"]), double.parse(node_map["x"]), parent.controller);
              n.id = int.parse(node_map["id"]);
              n.draggable.id = n.id;
              
              n.draggable.title = node_map["title"];
              n.draggable.description = node_map["description"];
              n.draggable.startDate = node_map["startDate"];
              n.draggable.startTime = node_map["startTime"];
              n.draggable.endDate = node_map["endDate"];
              n.draggable.endTime = node_map["endTime"];

              parent.setState(() {
                parent.children.add(n); // add node to view
                parent.controller.addNode(n); // add node to model

              });
              /*
              n.title = node_map["title"];
              n.description = node_map["description"];
              n.startDate = node_map["startDate"];
              n.startTime = node_map["startTime"];
              n.endDate = node_map["endDate"];
              n.endTime = node_map["endTime"];

              // now we will update the node with the stored parameters
              parent.setState(() {
                parent.children.add(n.stateful); // add node to view
                parent.controller.addNode(n.stateful); // add node to model

              });

               */
            }
        }
    });
    
  }
}

