import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/create_account/view_create_account.dart';
import 'package:flutter_quasar_app/windows/account_firewall/email_notif_view/view_email_notif.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';

import 'model_create_account.dart';

/// @author Cody Smith at RIT
///
class ControllerCreateAccount
{
  // sets
  void setEmail(String email) { ModelCreateAccount.email = email; }
  void setPassword(String password) { ModelCreateAccount.password = password; }
  void setDisplayName(String displayname) { ModelCreateAccount.displayname = displayname; }

  // gets
  String getEmail() { return ModelCreateAccount.email; }
  String getPassword() { return ModelCreateAccount.password; }
  String getDisplayName() { return ModelCreateAccount.displayname; }

  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  ///
  void createAccount(email, password, GlobalKey<ScaffoldState> S_KEY, context)
  async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      User user = userCredential.user;
      // check if retrieving the user id works before anything else
      if(user.uid != null)
      {
        // send Email Verification
        user.sendEmailVerification();

        Map<String, dynamic>  map_full = new HashMap();
        map_full["owner_username"] = getDisplayName();
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        // generate basic hashmap to store events and user data
        firestore.collection('friend_access_profiles')
            .doc(auth.currentUser.uid.toString())
            .set(map_full);

        // direct to email guide window
        pushEmailRedirect(context);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        U_SimpleSnack('The password provided was too weak to use. Try making the password a bit longer.', 5000, context);
      } else if (e.code == 'email-already-in-use') {
        U_SimpleSnack('This email is already in use. To recover the account check the Forgot Password? section of the app', 8000, context);
      }
    } catch (e) {
      U_SimpleSnack('Error Creating Account: ' + e.toString(), 8000, context);
    }
  }

  /// Direct user to window telling them to verify their email.
  void pushEmailRedirect(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewEmailNotif()));
  }
}
