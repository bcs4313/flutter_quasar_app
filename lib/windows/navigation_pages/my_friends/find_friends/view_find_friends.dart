import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_find_friends.dart';

/// Login Screen UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewFindFriends extends StatelessWidget
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
      appBar: DrawerBarConstruct("Friends Tab"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
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
                    controller.transferEmailRequester(context);
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
                    controller.transferIDRequester(context);
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
}