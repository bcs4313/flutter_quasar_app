import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/login/view_login.dart';

/// @author Cody Smith at RIT
///
class ControllerIDRequester
{
  String id = "";

  // setters/getters
  void setID(String email) { this.id = email; }

  /// Push user to friend home window (deletes window stack)
  void pushLogin(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLogin()));
  }
}
