import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/login/view_login.dart';

/// @author Cody Smith at RIT
///
class ControllerEmailRequester
{
  String email = "";
  String username = "";

  // setters/getters
  void setEmail(String email) { this.email = email; }

  /// Puts a request in the dump of a users request document.
  /// This request may be cleared at ANY time.
  /// Note: This will give the other user the ID of the requester,
  /// along with other info needed to know who this person is.
  void sendEmailRequest(BuildContext context)
  {
    // load firebase modules
    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;

    // retrieve info for request
    Map<String, String> dump = new HashMap<String, String>();
    retrieveUsername().whenComplete(() {
      dump["ID"] = auth.currentUser.uid;
      dump["Username"] = username;

      // create a reference in user's dump directory
      var ref = firestore.collection("request_email_dump").doc(email).collection("docs").doc(auth.currentUser.uid);

      // update dump with request info
      ref.set(dump);

      // update dump with request info
      ref.set(dump).then((value)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Friend request was sent.'),
              duration: Duration(seconds: 5),
            ));
        Navigator.pop(context); // go back a window as an indicator of the request completion
      });
    });

  }

  /// Get the username of the current user to include in this request
  Future<void> retrieveUsername()
  async {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    var collection = await firestore.collection('friend_access_profiles')
        .doc(auth.currentUser.uid.toString()).get();
    Map<String, dynamic> map = collection.data();

    username = map["owner_username"];
  }
}
