import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/extension_friends_home.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';

/// @author Cody Smith at RIT
///
class ControllerFriendDestroyer
{
  String friendID; // friend string id we are targeting for destruction

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  /// Gather friend data and store it
  void assignFriendData(String friendID)
  {
    // modify key to work properly with map
    this.friendID = friendID;
  }

  /// Remove a specific event map in the firebase document for this user
  /// Also deletes any potential schedule associated with it.
  void pushFriendDeletion(BuildContext context)
  {


    // Remove user id from friend's directory
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<String> attachmentSelf = [auth.currentUser.uid];
    List<String> attachmentFriend = [friendID];
    try
    {
    firestore.collection('friend_access_profiles')
        .doc(friendID)
        .update({"friends" : FieldValue.arrayRemove(attachmentSelf)}).then((value)
        {
          // remove user id of friend from self
          firestore.collection('friend_access_profiles')
              .doc(auth.currentUser.uid)
              .update({"friends" : FieldValue.arrayRemove(attachmentFriend)}).then((value)
              {
                pushFriendsHome(context);
              });
        });
    }
    on Exception catch(e)
    {
      U_SimpleSnack('There was an issue unfriending this user: ' + e.toString(), 5000, context);
    }
  }
  ///

  /// Direct user to friends home window. Deletes window stack.
  void pushFriendsHome(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new FriendsHomeStateful()));
  }
}
