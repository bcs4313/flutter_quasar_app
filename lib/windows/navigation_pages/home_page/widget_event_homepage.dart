import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/size_config.dart';
import 'controller_homepage.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../col.dart';

/// A widget that represents an event that a user
/// has joined. Clicking on it results in getting to
/// the home window for that specific event.
class HomePageEventWidget extends StatelessWidget
{
  Map<dynamic, dynamic> eventMap;
  ControllerHomepage controller;
  String title = "";

  /// A simple widget in the homepage list that
  /// represents a joined event. Clicking on
  /// it allows you to view it.
  ///@param eventMap a map of all the info needed
  ///to view and work with this event
  HomePageEventWidget(Map<dynamic, dynamic> eventMap, ControllerHomepage controller)
  {
    this.eventMap = eventMap;
    if(eventMap == null)
      {
       return;
      }
    this.title = eventMap["MetaData"]["title"];
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    if(eventMap == null)
      {
        return Container();
      }
    return Container(
      width: SizeConfig.scaleHorizontal * 45,
      height: SizeConfig.scaleHorizontal * 15,
      decoration: BoxDecoration(
          color: Col.purple_2,
          border: Border.all(color: Col.pink)
      ),
      child: TextButton(child: AutoSizeText(title,
            style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 5,
                height: 1.3,
                fontFamily: 'Roboto',
                color: Col.pink)), onPressed: () { controller.transferEventHome(context, eventMap); },
      ),
    );
  }

}