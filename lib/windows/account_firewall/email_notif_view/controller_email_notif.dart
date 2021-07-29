import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/create_account/view_create_account.dart';
import 'package:flutter_quasar_app/windows/account_firewall/login/view_login.dart';

/// Controller for the view that notifies users that they need to verify their email.
/// (ViewEmailNotif)
///@author Cody Smith at RIT (bcs4313)
class ControllerEmailNotif
{
  /// Push user to login window (restart window stack)
  void pushLogin(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLogin()));
  }
}
