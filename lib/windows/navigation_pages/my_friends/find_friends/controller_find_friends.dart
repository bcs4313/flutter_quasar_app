import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/my_friends/find_friends/id_requester/extension_id_requester.dart';
import 'email_requester/extension_email_requester.dart';

/// Controller of the View that gives request methods.
///@author Cody Smith at RIT (bcs4313)
class ControllerForgotPassword
{
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
