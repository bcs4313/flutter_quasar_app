import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_event_home.dart';
import 'extension_event_home.dart';

/// Opens when someone taps on one of their current events in the home tab
/// gives access to various functions that a user may want for this event.
///@author Cody Smith at RIT (bcs4313)
class ViewEventHome extends State<EventHomeStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  ControllerEventHome controller;
  EventHomeStateful stateful;

  // event specific info
  Map<dynamic, dynamic> eventMap;
  String title = "";
  String description = "";

  ///@param eventMap a map containing all the data needed to work with this event
  ViewEventHome(ControllerEventHome controller, Map<dynamic, dynamic> eventMap)
  {
    this.controller = controller;
    this.stateful = stateful;
    this.eventMap = eventMap;

    // in this stage we will gather some info to display on the home event page
    // (title, description)
    print("Map loaded for this event home window::: " + eventMap.toString());
    this.title = eventMap["MetaData"]["title"];
    this.description = eventMap["MetaData"]["description"];
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Friends Tab"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              Container(
                width: 75 * SizeConfig.scaleHorizontal,
              ),
              Container(
                padding: EdgeInsets.only(left: 12.5 * SizeConfig.scaleHorizontal),
              width: 25 * SizeConfig.scaleHorizontal,
              height: 5 * SizeConfig.scaleVertical,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("Quit",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.red_1)),
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Col.red_1,
                  ), onPressed: () {
                    controller.transferExitConfirmation(context);
                },),
              ),
            ),]),
            Padding(
              padding: EdgeInsets.only(left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  title,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 98 * SizeConfig.scaleHorizontal,
              height: 48 * SizeConfig.scaleVertical,
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 6 * SizeConfig.scaleHorizontal, right: 6 * SizeConfig.scaleHorizontal),
              child: TextFormField(
                initialValue: description,
                obscureText: false,
                maxLines: 10000,
                style: TextStyle(color: Col.pink),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),
              ),
            ),
            Container(
              height: 5 * SizeConfig.scaleVertical,
            ),
            Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 5 * SizeConfig.scaleHorizontal),
              ),
              Container(
              width: 42.5 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.purple_2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("View Members",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.group_add,
                    color: Col.white,
                  ), onPressed: () {
                    //controller.transferFindFriends(context);
                },),
              ),
            ),
              Padding(
                padding: EdgeInsets.only(left: 5 * SizeConfig.scaleHorizontal),
              ),
              Container(
                width: 42.5 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                color: Col.blue,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: TextButton.icon(
                    label: Text("Add Gifts",
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                            height: 1.3,
                            fontFamily: 'Roboto',
                            color: Col.white)),
                    icon: Icon(
                      Icons.card_giftcard,
                      color: Col.white,
                    ), onPressed: () {
                    //controller.transferFindFriends(context);
                  },),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
            ),
            Container(
              width: 90 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.green,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: Text("View Schedule",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.account_tree,
                    color: Col.black,
                  ), onPressed: () {
                  //controller.transferFriendRequests(context);
                },),
              ),
            ),
          ],
        ),
      )
    );
  }
}