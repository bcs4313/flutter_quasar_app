import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/size_config.dart';

import '../../../col.dart';

class HomePageEventWidget extends StatelessWidget
{
  Map<dynamic, dynamic> eventMap;
  String title = "";

  /// A simple widget in the homepage list that
  /// represents an event part. Clicking on
  /// it allows you to view it.
  ///@param eventMap a map of all the info needed
  ///to view and work with this event
  HomePageEventWidget(Map<dynamic, dynamic> eventMap)
  {
    this.eventMap = eventMap;
    if(eventMap == null)
      {
       return;
      }
    this.title = eventMap["MetaData"]["title"];
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
      child: TextButton(child: Text(title,
            style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 5,
                height: 1.3,
                fontFamily: 'Roboto',
                color: Col.pink)), onPressed: () {
        //controller.transferEmailRequester(context);
      },
      ),
    );
  }

}