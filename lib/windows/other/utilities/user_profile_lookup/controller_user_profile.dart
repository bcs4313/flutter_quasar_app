import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_quasar_app/windows/other/utilities/user_profile_lookup/view_user_profile.dart';

import 'package:image_picker/image_picker.dart';

/// Profile Home Controller
///
class ControllerUserProfile
{
  // used for global scaffold calls (and Snackbars)
  ViewUserProfile parent; // view of this controller

  /// Get a profile picture and other info from firebase and load it into the view
  Future<void> retrieveInfo() async
  {
    var storage = firebase_storage.FirebaseStorage.instance;
    var auth = FirebaseAuth.instance;

    firebase_storage.Reference ref = storage.ref("profile_pictures/" +
        auth.currentUser.uid.toString() + ".png"
    );

    var data = await ref.getData(500000); // max size is in bytes (0.5 megabytes)
    if(data != null) { // if the image was received
      Image img = Image.memory(data); // load the image from memory
      parent.setState(() {
        parent.pfp = img; // update UI with Image widget
      });
    }
  }
}