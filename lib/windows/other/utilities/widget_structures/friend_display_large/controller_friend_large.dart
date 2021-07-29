import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/widget_structures/friend_display_large/view_friend_large.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/extension_user_profile.dart';

/// Controller for the friend viewing widget in friendlists
///@author Cody Smith at RIT (bcs4313)
class ControllerFriendLarge
{
  // used for global scaffold calls (and Snackbars)
  ViewFriendLarge parent; // view of this controller

  /// Add view as parent to this controller
  void initialize(ViewFriendLarge view)
  {
    this.parent = view;
  }

  /// Get a profile picture and other info from firebase and load it into the view
  Future<void> retrieveInfo() async
  {
    var storage = firebase_storage.FirebaseStorage.instance;
    var firestore = FirebaseFirestore.instance;

    // retrieve image data
    firebase_storage.Reference ref = storage.ref("profile_pictures/" +
        parent.id.toString() + ".png"
    );

    var data = await ref.getData(500000); // max size is in bytes (0.5 megabytes)
    if(data != null) { // if the image was received
      Image img = Image.memory(data); // load the image from memory
      parent.setState(() {
        parent.pfp = img; // update UI with Image widget
      });
    }

    // retrieve username data
    firestore.collection("friend_access_profiles").doc(parent.id).get().then((value) {
      var doc = value.data();
      String name = doc["owner_username"];
      String b;
      String w;
      if(doc["owner_bio"] != null) {
        b = doc["owner_bio"];
      }
      if(doc["owner_wishlist"] != null) {
        w = doc["owner_wishlist"];
      }
      parent.setState(() {
        parent.username = name;
        parent.bio = b;
        parent.wishlist = w;
      });
    });
  }

  /// direct user to user profile window
  void transferUserProfile(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new U_UserProfileStateful(parent.username, parent.id, parent.bio, parent.wishlist)));
  }
}