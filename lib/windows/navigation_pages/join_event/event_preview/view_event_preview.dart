import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'controller_event_preview.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';

/// A view that displays info about the specific event prior to
/// joining/requesting to join an event.
///@author Cody Smith at RIT (bcs4313)
class ViewEventPreview extends StatelessWidget
{
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  String title;
  String description;
  String id;
  String eventNum;
  String joinType; // tells the user whether they request to join or immediately join
  Color joinCol;
  ControllerEventPreview controller;
  String autoJoin;

  /// Constructor for this preview
  ///@param title title of event
  ///@param description description of event
  ///@param id id of user to allow joining via Firebase
  ///@param autojoin communicates whether or not auto-join is enabled for the event
  ///@param eventNum gives us the event index to join
  ViewEventPreview(String title, String description, String id, String autoJoin
      , String eventNum)
  {
    this.title = title;
    this.description = description;
    this.id = id;
    this.eventNum = eventNum;
    this.controller = new ControllerEventPreview(this);
    if(autoJoin == "true")
      {
        joinType = "You will join automatically";
        joinCol = Col.green;
        this.autoJoin = "true";
      }
    else
      {
        joinType = "You will join after your request is accepted";
        joinCol = Col.red;
        this.autoJoin = "false";
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Event Preview"),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children:[
        Padding(
          padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical),
        ),
        AutoSizeText("Join this Event?",
          style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 12,
              height: 1.3,
              fontFamily: 'Roboto',
              color: Col.pink)
          ),
        Padding(
          padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText("Title: ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8,
                    height: 1.3,
                    fontFamily: 'Roboto',
                    color: Col.pink)
            ),
            AutoSizeText(" " + title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8,
                    height: 1.3,
                    fontFamily: 'Roboto',
                    color: Col.pink)
            ),
          ],
        ),
            Padding(
              padding: EdgeInsets.only(top: 15 * SizeConfig.scaleHorizontal),
            ),
            AutoSizeText("Description: ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 5,
                    height: 1.3,
                    fontFamily: 'Roboto',
                    color: Col.pink)
            ),
            Container(
              width: 98 * SizeConfig.scaleHorizontal,
              height: 38 * SizeConfig.scaleVertical,
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
        Padding(
          padding: EdgeInsets.only(top: 4 * SizeConfig.scaleHorizontal),
        ),
        AutoSizeText(joinType,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                height: 1.3,
                fontFamily: 'Roboto',
                color: joinCol)
        ),
        Padding(
          padding: EdgeInsets.only(top: 4 * SizeConfig.scaleHorizontal),
        ),
      Container(
        color: Col.green,
        child: SizedBox(
          width: 90 * SizeConfig.scaleHorizontal,
          height: 10 * SizeConfig.scaleVertical,
          child: FittedBox(
            fit: BoxFit.contain,
            child: TextButton(
              child: AutoSizeText("Yes",
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                      height: 1.3,
                      fontFamily: 'Roboto',
                      color: Col.white)),
              onPressed: () {
                if(autoJoin == "true")
                  {
                    print("joining automatically...");
                    controller.joinEventAuto(context);
                  }
                else
                  {
                  print("sending request...");
                  controller.joinEventRequest(context);
                }
              },
            ),
          ),
        ),
      ),
      ],
      ),),
    );
  }

}