import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'controller_join_event.dart';
import 'extension_join_event.dart';

import '../../../col.dart';
import '../../../size_config.dart';

/// A view that lists events that a user may potentially join from friends.
///@author Cody Smith at RIT (bcs4313)
class ViewJoinEvent extends State<JoinEventStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // Widget list to fconstruct in this UI
  ListView eventConstruct;

  ControllerJoinEvent controller;

  /// initialize stateful widget with a controller
  ///@param controller the controller to link to that modifies the state of this widget
  ViewJoinEvent(ControllerJoinEvent controller)
  {
    this.controller = controller;
    controller.addParent(this); // add parent so controller can manage its own state
    controller.loadFriendEvents(); // get friend events from ALL friends

    // This will remain the event construct until the controller replaces it
    eventConstruct = new ListView(
      key: Key("loading construct..."),
      children:[
      Padding(
        padding: EdgeInsets.only(top: 6 * SizeConfig.scaleVertical, left: 14 * SizeConfig.scaleHorizontal, right: 14 * SizeConfig.scaleHorizontal),
        child: SizedBox(
          width: 80 * SizeConfig.scaleHorizontal,
          height: 70 * SizeConfig.scaleHorizontal,
          child: CircularProgressIndicator(
            value: null,
            strokeWidth: 0.5 * SizeConfig.scaleVertical,
            color: Col.pink,
          ),
        ),
      ),
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Join an Event"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, bottom: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                'Events from Friends',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 33 * SizeConfig.scaleHorizontal),
                    child: Text('Event',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.5 * SizeConfig.scaleHorizontal),
                    child: Text('Host',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 3, color: Col.pink),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2 * SizeConfig.scaleHorizontal),
              child: Container(
                color: Col.purple_1,
                height: 71 * SizeConfig.scaleVertical,
                width: 900 * SizeConfig.scaleHorizontal,
                child: eventConstruct,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateConstruct(ListView newconstruct)
  {
    setState(() {
      eventConstruct = newconstruct;
    });
  }

}
