import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/account_firewall/create_account/view_create_account.dart';
import 'package:flutter_quasar_app/windows/account_firewall/forgot_password/view_forgot_password.dart';

/// The model is responsible for storage of data in this window.
/// This is a model for creating events in Firebase.
/// @author Cody Smith at RIT
///
class ModelEventCreator
{
  // Stored Vars
  static String title = "";
  static String description = "";
  static bool autoJoin = true;
}
