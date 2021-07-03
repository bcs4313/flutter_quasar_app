import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/unfriend_confirmation/view_friend_destroyer.dart';
import 'package:flutter_quasar_app/windows/other/utilities/windows/user_profile_lookup/view_user_profile.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';

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
  }

  /// direct user to unfriend confirmation window
  void transferUnfriendConfirmation(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewFriendDestroyer(parent.id)));
  }

  /// Check on whether or not this view
  /// contains a friend, if so, include
  /// friend specific controls
  void friendModify()
  {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    bool profileIsFriend = false;
    firestore.collection("friend_access_profiles").doc(auth.currentUser.uid).
    get().then((value){
      if(value != null)
        {
          Map<String, dynamic> data = value.data();
          List<dynamic> friends = data["friends"];
          for(int i = 0; i < friends.length; i++)
            {
              String friendID = friends[i];
              if(friendID == parent.id)
                {
                  profileIsFriend = true;
                  break;
                }
            }
          // add friend widgets if this is a friend
          if(profileIsFriend == true)
            {
              parent.unfriendButton =
                  Container(
                      width: 50 * SizeConfig.scaleHorizontal,
                      height: 10 * SizeConfig.scaleVertical,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Col.red),
                  ),
                      child: Text("Unfriend",
                    style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.white),
                    textAlign: TextAlign.center,
                  ),
                  onPressed:() => {
                    transferUnfriendConfirmation(parent.context),
                  }
              )));
            }
        }
    });
  }
}