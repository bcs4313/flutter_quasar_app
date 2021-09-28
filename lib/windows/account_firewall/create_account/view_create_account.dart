import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/other/utilities/modified_widgets/text_capsule.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_create_account.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// View that lets users create an account for themselves.
///@author Cody Smith at RIT (bcs4313)
class ViewCreateAccount extends StatelessWidget
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    final ControllerCreateAccount controller = new ControllerCreateAccount();
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
              padding: EdgeInsets.only(top: 12 * SizeConfig.scaleVertical),
              child: AutoSizeText(
                  'Sign Up',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 10, fontFamily: 'Roboto', color: Col.pink)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 63 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: AutoSizeText(
                  'Email Address',
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
              padding: EdgeInsets.only(right: 64 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: AutoSizeText(
                  'Display Name',
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
                    controller.setDisplayName(value);
                  }

              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 70 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: AutoSizeText('Password',
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
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ElevatedButton.styleFrom(
                      primary: Col.clear, // background
                      onPrimary: Col.pink, // foreground
                    ),
                    child: AutoSizeText('Create Your Account',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                    ),
                    onPressed:() {
                      String email = controller.getEmail();
                      String password = controller.getPassword();
                      controller.createAccount(email, password, S_KEY, context);
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