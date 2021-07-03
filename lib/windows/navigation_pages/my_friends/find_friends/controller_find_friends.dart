import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/id_requester/extension_id_requester.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';
import 'email_requester/extension_email_requester.dart';
import 'model_find_friends.dart';

/// @author Cody Smith at RIT
///
class ControllerForgotPassword
{
  // sets
  void setEmail(String email) { ModelForgotPassword.email = email; }

  // gets
  String getEmail() { return ModelForgotPassword.email; }

  /// send email to recover a password.
  /// @return if email sending process had an error or not in the process.
  bool sendEmailVerification(GlobalKey<ScaffoldState> S_KEY)
  {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.sendPasswordResetEmail(email: getEmail()).catchError((onError)
        {
          U_SimpleSnack('Email formatting was invalid. Please try again.', 5000, S_KEY.currentContext);
          return true;
        });
    return false;
  }

  /// transfer user to email request window
  void transferEmailRequester(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmailRequesterStateful()));
  }

  /// transfer user to id request window
  void transferIDRequester(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => IDRequesterStateful()));
  }
}
