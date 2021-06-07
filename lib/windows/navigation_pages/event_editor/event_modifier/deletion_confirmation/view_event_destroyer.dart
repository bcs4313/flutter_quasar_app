import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_event_destroyer.dart';


/// Event Modifier UI
///
///
class ViewEventDestroyer extends StatelessWidget
{
  ControllerEventDestroyer controller;

  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  /// Constructor for this view
  ///@param eventNum the event we are currently modifying
  ViewEventDestroyer(String eventNum)
  {
    this.controller = new ControllerEventDestroyer();
    controller.assignEventData(eventNum);
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
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Event Modifier"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 5 * SizeConfig.scaleHorizontal, right: 5 * SizeConfig.scaleHorizontal),
              child: Text(
                'Are you sure you want to delete this event?',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 63.5 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 47 * SizeConfig.scaleHorizontal, height: 10 * SizeConfig.scaleVertical),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Col.gray, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 63.5 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 47 * SizeConfig.scaleHorizontal, height: 10 * SizeConfig.scaleVertical),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: ()
                      {
                        controller.pushMapDeletion(context);
                      },
                      child: const Text('Delete'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}