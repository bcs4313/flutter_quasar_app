import 'package:flutter/material.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_login.dart';
import 'model_login.dart';

/// Login Screen UI
///
/// This both serves as the controller and view for our window.
/// The model is separate from this file.
class ViewLogin extends StatelessWidget
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // model for view
  ModelLogin model;

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    this.model = new ModelLogin();
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return generatePortraitView(context);
    } else {
    return generateLandscapeView(context);
    }
  }

  /// generate a portrait projection of the window view
  Scaffold generatePortraitView(BuildContext context)
  {
    ControllerLogin controller = new ControllerLogin();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 23 * SizeConfig.scaleVertical),
              child: Text(
                  'Account Login',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 10, fontFamily: 'Roboto', color: Col.pink)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 70 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: Text(
                  'Email',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextField(
                obscureText: false,
                style: TextStyle(color: Col.pink),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),
                // Textfield Change Recording
                onChanged: (value)
                {
                  controller.setEmail(value);
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 70 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: Text('Password',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Col.pink),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),

                // Textfield Change Recording
                onChanged: (value)
                {
                  controller.setPassword(value);
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8 * SizeConfig.scaleVertical),
              child: SizedBox(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: RaisedButton( // Raised buttons have bevels to stand out form the background
                    color: Col.clear,
                    disabledColor: Col.clear,
                    splashColor: Col.pink,
                    child: Text('Log In',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                    ),
                    onPressed:() => {
                      controller.login(context, S_KEY),
                    }
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 4 * SizeConfig.scaleHorizontal),
                  child: SizedBox(
                    width: 42 * SizeConfig.scaleHorizontal,
                    height: 10 * SizeConfig.scaleVertical,
                    child: FlatButton( // flat buttons have no bevels to make them look like buttons
                        splashColor: Col.pink,
                        child: Text('Sign up',
                          style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2),
                        ),
                        onPressed:() => {
                          FocusScope.of(context).unfocus(),
                          controller.transferCreateAccount(context),
                        }
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 4 * SizeConfig.scaleHorizontal),
                  child: SizedBox(
                    width: 46 * SizeConfig.scaleHorizontal,
                    height: 10 * SizeConfig.scaleVertical,
                    child: FlatButton( // flat buttons have no bevels to make them look like buttons
                        splashColor: Col.pink,
                        child: Text('Forgot your Password?',
                          style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 3.7, color: Col.purple_2),
                        ),
                        onPressed:() => {
                          FocusScope.of(context).unfocus(),
                          controller.transferForgotPassword(context),
                        }
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }

//floatingActionButton: FloatingActionButton(
//  onPressed: _incrementCounter,
//  tooltip: 'Increment',
//  child: Icon(Icons.add),
//), // This trailing comma makes auto-formatting nicer for build methods.
}