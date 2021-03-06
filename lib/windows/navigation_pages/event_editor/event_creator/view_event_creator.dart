import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_event_creator.dart';

/// View that allows users to create an event with a relative title,
/// description, and an option to enable automatic joins or not (on by default)
///@author Cody Smith at RIT (bcs4313)
class ViewEventCreator extends State<InitializerEventCreator>
{
  // stateful vars
  bool switchFriendsOnly = true;
  bool switchAutoJoin = true;

  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context)
  {
    ControllerEventCreator controller = new ControllerEventCreator();
    return Scaffold(
        key: S_KEY,
        resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
        backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Event Creator"),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: AutoSizeText(
                  'Create an Event',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
                child: Row(
                  children:[
                    AutoSizeText(
                      'Title:',
                      style: TextStyle(fontSize: 6 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: Container(
                        width: 70 * SizeConfig.scaleHorizontal,
                        child: TextField(
                            obscureText: false,
                            style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleVertical * 0.52),
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
                              controller.setTitle(value);
                            }
                        ),
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
                      'Description:',
                      style: TextStyle(fontSize: 6 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: Container(
                        width: 51 * SizeConfig.scaleHorizontal,
                        height: 30 * SizeConfig.scaleVertical,
                        child: TextField(
                            maxLines: 10000, // max lines controls the container height along with text style
                            maxLength: 1200,
                            obscureText: false,
                            style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleVertical * 0.52),
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
                              controller.setDescription(value);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
                child: Row(
                  children:[
                    AutoSizeText(
                      'Auto-Join',
                      style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: SizedBox(
                          child: Checkbox(
                            value: switchAutoJoin,
                            onChanged: (bool value) {
                              setState(() {
                                controller.setAutoJoin(value);
                                switchAutoJoin = value;
                              });
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3 * SizeConfig.scaleVertical),
                child: SizedBox(
                  width: 80 * SizeConfig.scaleHorizontal,
                  height: 10 * SizeConfig.scaleVertical,
                  child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                      style: ElevatedButton.styleFrom(
                        primary: Col.purple_3, // background
                        onPrimary: Col.pink, // foreground
                      ),
                      child: AutoSizeText('Create Event',
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                      ),
                      onPressed:() => {
                        controller.createEvent(context, S_KEY),
                      }
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}