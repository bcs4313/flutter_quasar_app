import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/create_account/view_create_account.dart';
import 'package:flutter_quasar_app/windows/account_firewall/login/view_login.dart';

import 'model_forgot_password.dart';

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
          ScaffoldMessenger.of(S_KEY.currentContext).showSnackBar(SnackBar(
            content: Text('Email formatting was invalid. Please try again.'),
            duration: Duration(seconds: 5),
          ));
          return true;
        });
    return false;
  }

  /// Push user to login window (restart window stack)
  void pushLogin(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLogin()));
  }
}
