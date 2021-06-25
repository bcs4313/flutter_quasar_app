import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/login/view_login.dart';

/// @author Cody Smith at RIT
///
class ControllerEmailRequester
{
  String email = "";

  // setters/getters
  void setEmail(String email) { this.email = email; }

  /// Push user to friend home window (deletes window stack)
  void pushLogin(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLogin()));
  }
}
