import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_profile/view_profile_home.dart';

import '../../../col.dart';
import '../../../size_config.dart';

import 'package:image_picker/image_picker.dart'; // select images to import in IOS/ANDROID

/// Profile Home Controller
///
class ControllerProfileHome
{
  // used for global scaffold calls (and Snackbars)
  final ImagePicker imagePicker = ImagePicker(); // object to pick images with
  ViewProfileHome parent; // view of this controller

  /// Select an image to upload to firebase as a profile picture,
  /// then display it in the view of the app
  Future<void> updateImage()
  async {
    try {
      final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, // get the image from the gallery of the user

        // Notably the image quality will be maximized upon the initial load of the image,
        // since there is no network overhead.
        imageQuality: 100, // 0-100 range, 100 being max, and 0 being min for quality
      );
      Image img = Image(image: AssetImage(pickedFile.path));
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
}