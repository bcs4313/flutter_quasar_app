import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import '../controller_profile_home.dart';
import 'extension_profile_private.dart';

/// A private tab where a user can view their own id, email address,
/// and password respectively. These can also be edited.
///@author Cody Smith at RIT (bcs4313)
class ViewProfilePrivate extends State<ProfilePrivateStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ViewProfilePrivate(ControllerProfileHome homecontroller)
  {
    this.homeController = homecontroller;
  }

  ControllerProfileHome homeController; // updates old window view

  @override
  Widget build(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Profile Viewer and Updater"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                  'Edit Private Info',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                'ID',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 2 * SizeConfig.scaleVertical, left: 12 * SizeConfig.scaleHorizontal, right: 12 * SizeConfig.scaleHorizontal),
                child: TextFormField(
                    initialValue: homeController.ID,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Col.pink, fontSize: 3 * SizeConfig.scaleHorizontal),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple, width: 0.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple, width: 0.2),
                      ),
                    ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(right: 77 * SizeConfig.scaleHorizontal, top: 4 * SizeConfig.scaleVertical),
              child: AutoSizeText(
                  'Email',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextFormField(
                  initialValue: homeController.email,
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
                    homeController.email = value;
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 70 * SizeConfig.scaleHorizontal, top: 8 * SizeConfig.scaleVertical),
              child: AutoSizeText('Password',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.purple_2)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextFormField(
                  obscureText: false,
                  initialValue: homeController.password,
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
                    homeController.password = value;
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
              child: Row(
                children:[
                  AutoSizeText(
                    'Confirm Email Change',
                    style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                    child: SizedBox(
                        child: Checkbox(
                          value: homeController.adjustEmail,
                          onChanged: (bool value) {
                            setState(() {
                              //controller.setAutoJoin(value);
                              homeController.adjustEmail = value;
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
                  AutoSizeText(
                    'Confirm Password Change',
                    style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                    child: SizedBox(
                        child: Checkbox(
                          value: homeController.adjustPassword,
                          onChanged: (bool value) {
                            setState(() {
                              homeController.adjustPassword = value;
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
}