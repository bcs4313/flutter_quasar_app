import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_user_profile.dart';
import 'extension_user_profile.dart';

/// Profile Editor UI
///
class ViewUserProfile extends State<UserProfileStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  Image pfp = Image(image: AssetImage('assets/images/pfp.png'));
  String username;
  String id;
  ControllerUserProfile controller;

  /// Constructor for a basic profile view
  ViewUserProfile(String username, String id, ControllerUserProfile controller)
  {
    this.username = username;
    if(username == null)
      {
        this.username = "undefined (unsafe)";
      }
    this.id = id;
    this.controller = controller;
    controller.parent = this;
    controller.retrieveInfo();
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
        appBar: DrawerBarConstruct(username + "'s Profile"),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: Text(
                  username,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical),
                child: CircleAvatar(
                  backgroundImage: pfp.image,
                  radius: 15 * SizeConfig.scaleVertical,
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