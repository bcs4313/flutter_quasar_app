import 'package:flutter/material.dart';

/// A class that simplifies displaying snackbars to the user
/// with only a single line.
/// Example:
/// U_SimpleSnack("tasty", 5, context) would display 'tasty' for 5 seconds
///@author Cody Smith at RIT (bcs4313)
class U_SimpleSnack
{
  /// Construct a snackbar through this constructor
  ///@param text text in the snackbar
  ///@param ms time to display in ms
  ///@param context buildcontext of app window
  U_SimpleSnack(String text, int ms, BuildContext context)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          duration: Duration(milliseconds: ms),
        ));
  }
}