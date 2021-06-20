import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:image_picker/image_picker.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_profile_home.dart';
import 'extension_profile_home.dart';
import 'dart:io'; // input/output streams

/// Profile Editor UI
///
class ViewProfileHome extends State<ProfileHomeStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  Image pfp = Image(image: AssetImage('assets/images/pfp.png'));
  ControllerProfileHome controller;

  ViewProfileHome(ControllerProfileHome controller)
  {
    this.controller = controller;
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
        appBar: DrawerBarConstruct("Profile Viewer and Updater"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'My Profile',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: TextField(
                  obscureText: false,
                  style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleHorizontal),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Col.pink),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Col.pink),
                    ),
                    ),
                    onChanged: (value)
                    {
                      //controller.setEmail(value);
                    }
                  ),
                  // Textfield Change Recording
              ),
            GestureDetector(
              onTap: ()
                {
                  controller.updateImage();
                },
              child: Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical),
                child: CircleAvatar(
                  backgroundImage: pfp.image,
                  radius: 15 * SizeConfig.scaleVertical,
                ),
              ),
            ),
            Container(
              height: 6 * SizeConfig.scaleVertical,
            ),
            Container(
              width: 90 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.purple_2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("Edit Private Info",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.edit_attributes,
                    color: Col.white,
                  ), onPressed: () {
                  //controller.transferTreeDestroyer(context);
                },
                ),
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
                  label: Text("Confirm Changes",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.edit_attributes,
                    color: Col.white,
                  ), onPressed: () {
                  //controller.transferTreeDestroyer(context);
                },
                ),
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