import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_friends_home.dart';
import 'extension_friends_home.dart';

/// Friend View UI
///
class ViewFriendsHome extends State<FriendsHomeStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  ControllerFriendsHome controller;
  FriendsHomeStateful stateful;

  ViewFriendsHome(ControllerFriendsHome controller, FriendsHomeStateful stateful)
  {
    this.controller = controller;
    this.stateful = stateful;
  }

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
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Friends Tab"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'My Friends',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 6 * SizeConfig.scaleVertical,
            ),
            Container(
              width: 90 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.green,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("Find Friends",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.group_add,
                    color: Col.white,
                  ), onPressed: () {
                    controller.transferFindFriends(context);
                },),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
            ),
            Container(
              width: 90 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.purple_2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("View Requests",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: Col.white,
                  ), onPressed: () {
                  controller.transferFriendRequests(context);
                },),
              ),
            ),
          ],
        ),
      )
    );
  }

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}