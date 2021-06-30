import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/view_profile_home.dart';
import '../../../col.dart';
import '../../../size_config.dart';

import 'package:image_picker/image_picker.dart';

import 'my_profile_private/extension_profile_private.dart'; // select images to import in IOS/ANDROID

/// Profile Home Controller
///
class ControllerProfileHome
{
  // used for global scaffold calls (and Snackbars)
  final ImagePicker imagePicker = ImagePicker(); // object to pick images with
  ViewProfileHome parent; // view of this controller
  PickedFile file; // file stored in this controller to upload

  // private info storage
  String email = FirebaseAuth.instance.currentUser.email; // email to store in profile
  String ID = FirebaseAuth.instance.currentUser.uid; // id to store in profile
  String password = "????????"; // password to store in profile

  bool adjustEmail = false; // confirm email to be adjusted
  bool adjustPassword = false; // confirm password to be adjusted

  /// Select an image to upload to firebase as a profile picture,
  /// then display it in the view of the app
  Future<void> updateImage()
  async {
    try {
      final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, // get the image from the gallery of the user

        maxHeight: 1000,
        maxWidth: 1000,

        // Notably the image quality will be maximized upon the initial load of the image,
        // since there is no network overhead.
        imageQuality: 100, // 0-100 range, 100 being max, and 0 being min for quality
      );
      file = pickedFile; // store file in controller
      Image img = Image.file(new File(pickedFile.path));
      parent.setState(() {
        parent.pfp = img;
      });
    } catch (e) {
      ScaffoldMessenger.of(parent.context).showSnackBar(SnackBar(
        content: Text(
            "Image Loading Failed. Error Message: " + e.toString()),
        duration: Duration(seconds: 5),
      ));
    }
  }

  /// Take data that was inputted by the user and upload it to
  /// their respective locations.
  Future<void> uploadChanges()
  async {
    var storage = firebase_storage.FirebaseStorage.instance;
    var auth = FirebaseAuth.instance;

    firebase_storage.Reference ref = storage.ref("profile_pictures/" +
        auth.currentUser.uid.toString() + ".png"
    );

    // Resize the image to a 400x400 thumbnail (maintaining the aspect ratio).
    File compressedFile;
    if(file!= null) {
      ImageProperties properties = await FlutterNativeImage.getImageProperties(
          file.path);
      compressedFile = await FlutterNativeImage.compressImage(
          file.path, quality: 80,
          targetWidth: 400,
          targetHeight: (properties.height * 400 / properties.width).round());
    }

    try
    {
      if(file != null) {
        await ref.putFile(
            compressedFile); // the file should be at max 100,000 bytes in size
      }
      try
      {
        FirebaseAuth auth = FirebaseAuth.instance;
        var firestore = FirebaseFirestore.instance;
        var reference = firestore.collection('friend_access_profiles')
            .doc(auth.currentUser.uid.toString());
        await reference.set({'owner_username': parent.stateful.username});
        ScaffoldMessenger.of(parent.context).showSnackBar(
            SnackBar(
              content: Text('Profile Successfully Updated'),
              duration: Duration(seconds: 5),
            ));
        try
            {
              if(adjustEmail == true)
                {
                  auth.currentUser.updateEmail(email);
                }
              if(adjustPassword == true)
                {
                  auth.currentUser.updatePassword(password);
                }
            }
            on FirebaseException catch(e)
            {
              ScaffoldMessenger.of(parent.context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to update private info: ' + e.toString()),
                    duration: Duration(seconds: 5),
                  ));
            }
      }
      on FirebaseException catch(e)
      {
        ScaffoldMessenger.of(parent.context).showSnackBar(
            SnackBar(
              content: Text('Failed to update public username: ' + e.toString()),
              duration: Duration(seconds: 5),
            ));
      }
    }
    on FirebaseException catch (e)
    {
      ScaffoldMessenger.of(parent.context).showSnackBar(
          SnackBar(
            content: Text('Image failed to upload: ' + e.toString()),
            duration: Duration(seconds: 5),
          ));
    }
  }

  /// Get a profile picture and other info from firebase and load it into the view
  Future<void> retrieveInfo() async
  {
    var storage = firebase_storage.FirebaseStorage.instance;
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    var collection = await firestore.collection('friend_access_profiles')
        .doc(auth.currentUser.uid.toString()).get();
    Map<String, dynamic> map = collection.data();
    parent.setState(() {
      if(map.keys.contains("owner_username")) {
        parent.stateful.username = map["owner_username"];
        parent.textController.text = map["owner_username"];
      }
    });

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

  /// Direct user to private info editor window.
  void transferProfilePrivate(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new ProfilePrivateStateful(this)));
  }
}