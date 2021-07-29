import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/create_account/view_create_account.dart';
import 'package:flutter_quasar_app/windows/account_firewall/forgot_password/view_forgot_password.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/home_page/view_homepage.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/simple_snack.dart';

import 'model_login.dart';

/// Controller for the view that lets people log into their account.
/// (ViewLogin)
///@author Cody Smith at RIT (bcs4313)
class ControllerLogin
{
  // sets
  void setEmail(String email) { ModelLogin.email = email; }
  void setPassword(String password) { ModelLogin.password = password; }

  // gets
  String getEmail(){ return ModelLogin.email; }
  String getPassword(){ return ModelLogin.password; }

  /// Log into the Firebase network using the info received by our view and put into our model.
  /// @param S_KEY simple application key to use Snackbars with
  Future<void> login(BuildContext context, GlobalKey<ScaffoldState> S_KEY)
  async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print("LOGIN-CALL");

    try {
      await auth.signInWithEmailAndPassword(
          email: getEmail(), password: getPassword());
      print("LOGIN-SUCCESS");
      transferHomePage(context);
    }
    catch(e)
    {
      print("LOGIN-FAILURE");
      switch(e.message)
      {
        case "The email address is badly formatted":
          U_SimpleSnack('The email seems to be formatted incorrectly. See if you can fix it before trying again.', 6000, context);
          return;
        default:
          U_SimpleSnack("Login Denied.", 2000, context);
          return;
      }
    }
  }

  void transferHomePage(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewHomepage()));
  }

  void transferCreateAccount(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCreateAccount()));
  }

  void transferForgotPassword(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewForgotPassword()));
  }
}
