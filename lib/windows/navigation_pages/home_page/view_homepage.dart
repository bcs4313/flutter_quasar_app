import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'controller_homepage.dart';
import 'extension_homepage.dart';

import '../../../col.dart';
import '../../../size_config.dart';

/// This view serves as the first thing a user sees upon login.
/// Displaying what currently they should be up to and an ordered
/// list of events to look into at any time.
///@author Cody Smith at RIT (bcs4313)
class ViewHomepage extends State<HomepageStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ControllerHomepage controller;

  /// A widget that contains each individual event a user is currently in.
  /// Each event contains a subwidget (widget_event_homepage.dart) that
  /// either is red and lists its starting time, or is green and gives
  /// the time for the next part of the event.
  ListView events;

  /// A widget that contains all event parts that are currently available
  /// for someone to do. These will ONLY show up if there is a timeframe
  /// for the node in the schedule.
  ListView parts;


  /// Initializer that puts a controller in this stateful widget
  ///@param controller manages this stateful view
  ViewHomepage(ControllerHomepage controller)
  {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Home"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
            ),
            Text(
              'Welcome!',
              style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 9, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 3 * SizeConfig.scaleHorizontal),
                  child: Column(children: [Text(
                    'Current Events',
                    style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 5, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                    textAlign: TextAlign.center,
                  ),
                    Padding(
                        padding: EdgeInsets.only(top: 2 * SizeConfig.scaleVertical)
                    ),
                    Container(
                      width: 45 * SizeConfig.scaleHorizontal,
                      height: 60 * SizeConfig.scaleVertical,
                      color: Col.purple_0,
                    ),
                  ],
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 4 * SizeConfig.scaleHorizontal),
                  child: Column(
                    children: [Text(
                    'Things to do',
                    style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 5, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                    textAlign: TextAlign.center,
                  ), Padding(
                        padding: EdgeInsets.only(top: 2 * SizeConfig.scaleVertical)
                    ),
                      Container(
                      width: 45 * SizeConfig.scaleHorizontal,
                        height: 60 * SizeConfig.scaleVertical,
                        color: Col.purple_0,
                      ),
                    ],
                ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}