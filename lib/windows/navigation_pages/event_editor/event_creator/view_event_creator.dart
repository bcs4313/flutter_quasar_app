import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_creator/initializer_view_event_creator.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_event_creator.dart';

/// Login Screen UI
///
///
class ViewEventCreator extends State<InitializerEventCreator>
{
  // stateful vars
  bool switchFriendsOnly = true;
  bool switchAutoJoin = true;

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
    ControllerEventCreator controller = new ControllerEventCreator();
    return Scaffold(
        key: S_KEY,
        resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
        backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Event Creator"),
        drawer: DrawerConstruct(),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: Text(
                  'Create an Event',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
                child: Row(
                  children:[
                    Text(
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
                    Text(
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
                            maxLines: 1000000, // max lines controls the container height along with text style
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
                              controller.setDescription(value);
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
                    Text(
                      'Friends Allowed Only',
                      style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: SizedBox(
                        child: Checkbox(
                          value: switchFriendsOnly,
                          onChanged: (bool value) {
                            setState(() {
                              controller.setFriendsOnly(value);
                              switchFriendsOnly = value;
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
                  child: RaisedButton( // Raised buttons have bevels to stand out form the background
                      color: Col.purple_3,
                      disabledColor: Col.purple_3,
                      splashColor: Col.pink,
                      child: Text('Create Event',
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

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}