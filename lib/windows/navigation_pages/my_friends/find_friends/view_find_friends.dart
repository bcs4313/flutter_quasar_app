import 'package:flutter/material.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_forgot_password.dart';

/// Login Screen UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewFindFriends extends StatelessWidget
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return generatePortraitView(context);
    } else {
      return generateLandscapeView(context);
    }
  }

  /// generate a portrait projection of the window view
  Scaffold generatePortraitView(BuildContext context)
  {
    final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      //appBar: AppBar(
      //  title: Text(widget.title),
      //),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'To send a friend request to someone, choose one of the options below.',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:EdgeInsets.only(top: 35 * SizeConfig.scaleVertical),
            ),
            Container(
              color: Col.green,
              child: SizedBox(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("Request Via Email",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.email,
                    color: Col.white,
                  ), onPressed: () {
                  //controller.uploadChanges();
                },
                ),
              ),
              ),
            ),
            Padding(
              padding:EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
            ),
            Container(
              color: Col.purple_1,
              child: SizedBox(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: TextButton.icon(
                    label: Text("Request Via ID",
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                            height: 1.3,
                            fontFamily: 'Roboto',
                            color: Col.white)),
                    icon: Icon(
                      Icons.perm_identity,
                      color: Col.white,
                    ), onPressed: () {
                    //controller.uploadChanges();
                  },
                  ),
                ),
              ),
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
}