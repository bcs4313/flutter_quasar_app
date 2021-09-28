import 'package:flutter/material.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_email_notif.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Simple view that tells users that they need to verify
/// their email before they can be let in.
class ViewEmailNotif extends StatelessWidget
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    final ControllerEmailNotif controller = new ControllerEmailNotif();
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
                  'Welcome to Quasar! To complete your account registration please verify the email '
                      'address you entered into the app. Once you are finished you may log in.',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 34 * SizeConfig.scaleVertical),
              child: SizedBox(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ElevatedButton.styleFrom(
                      primary: Col.clear, // background
                      onPrimary: Col.pink, // foreground
                    ),
                    child: AutoSizeText('Take be back to the login page',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                    onPressed:() {
                      controller.pushLogin(context);
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