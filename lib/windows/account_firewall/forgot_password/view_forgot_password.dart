import 'package:flutter/material.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_forgot_password.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// View that lets a user request for their password to be changed
/// via an email verification method.
///@author Cody Smith at RIT (bcs4313)
class ViewForgotPassword extends StatelessWidget
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      //appBar: AppBar(
      //  title: AutoSizeText(widget.title),
      //),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                  'To recover your account, an email will be sent to your address to recover it. '
                      '\n\nEnter your email address below.',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
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
              padding: EdgeInsets.only(top: 6 * SizeConfig.scaleVertical),
              child: SizedBox(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ElevatedButton.styleFrom(
                      primary: Col.clear, // background
                      onPrimary: Col.pink, // foreground
                    ),
                    child: AutoSizeText('Send ',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                    onPressed:() {
                      bool sendError = controller.sendEmailVerification(S_KEY);
                      if(sendError == false) {
                        controller.pushLogin(context);
                      }
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}