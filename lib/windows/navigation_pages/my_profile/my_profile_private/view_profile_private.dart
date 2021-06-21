import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import '../controller_profile_home.dart';
import 'extension_profile_private.dart';

/// Profile Editor UI
///
class ViewProfilePrivate extends State<ProfilePrivateStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ViewProfilePrivate(ControllerProfileHome homecontroller)
  {
    this.homecontroller = homecontroller;
  }

  ControllerProfileHome homecontroller; // updates old window view

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
                  'Edit Private Info',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 77 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: Text(
                  'Email',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextFormField(
                  initialValue: homecontroller.email,
                  obscureText: false,
                  style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleHorizontal),
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
                    homecontroller.email = value;
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 70 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: Text('Password',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextFormField(
                  obscureText: false,
                  initialValue: homecontroller.password,
                  style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleHorizontal),
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
                    homecontroller.password = value;
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
              child: Row(
                children:[
                  Text(
                    'Confirm Email Change',
                    style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                    child: SizedBox(
                        child: Checkbox(
                          value: homecontroller.adjustEmail,
                          onChanged: (bool value) {
                            setState(() {
                              //controller.setAutoJoin(value);
                              homecontroller.adjustEmail = value;
                            });
                          },
                        )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
              child: Row(
                children:[
                  Text(
                    'Confirm Password Change',
                    style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                    child: SizedBox(
                        child: Checkbox(
                          value: homecontroller.adjustPassword,
                          onChanged: (bool value) {
                            setState(() {
                              homecontroller.adjustPassword = value;
                            });
                          },
                        )
                    ),
                  ),
                ],
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