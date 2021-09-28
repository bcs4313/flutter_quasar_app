import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_event_participants.dart';
import 'extension_event_participants.dart';

/// View that lists users in an event that the host
/// can view, manage roles of, and kick.
///@author Cody Smith at RIT (bcs4313)
class ViewEventParticipants extends State<EventParticipantsStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // Widget list to fconstruct in this UI
  ListView eventConstruct;

  ControllerEventParticipants controller; // controls event request states

  /// initialize stateful widget with a controller
  ///@param controller the controller to link to that modifies the state of this widget
  ViewEventParticipants(ControllerEventParticipants controller)
  {
    this.controller = controller;
    controller.addParent(this); // add parent so controller can manage its own state

    // check to prevent unnecessary requests from firebase on setstate rebuild
    if(controller.rebuild != true) {
      controller.constructWidgets();
    }

    // This will remain the event construct until the controller replaces it
    eventConstruct = new ListView(
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
      appBar: DrawerBarConstruct("Event Particpant Viewer"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                'Current Members',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * SizeConfig.scaleVertical, left: 14 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.5 * SizeConfig.scaleHorizontal),
                    child: AutoSizeText('Users',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 22.5 * SizeConfig.scaleHorizontal),
                    child: AutoSizeText('Change Roles',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 3, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13 * SizeConfig.scaleHorizontal),
                    child: AutoSizeText('Kick',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3 * SizeConfig.scaleHorizontal),
              child: Container(
                height: 52 * SizeConfig.scaleVertical,
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
    print("update construct");
    setState(() {
      eventConstruct = newconstruct;
    });
  }

}
