import 'package:flutter/cupertino.dart';
import 'package:flutter_quasar_app/size_config.dart';

class HomePageEventWidget extends StatelessWidget
{
  Map<dynamic, dynamic> eventMap;
  String title = "";

  /// A simple widget in the homepage list that
  /// represents a joined event. Clicking on
  /// it allows you to view it.
  ///@param eventMap a map of all the info needed
  ///to view and work with this event
  HomePageEventWidget(Map<dynamic, dynamic> eventMap)
  {
    this.eventMap = eventMap;
    this.title = eventMap["MetaData"]["title"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleHorizontal * 8,
      height: SizeConfig.scaleHorizontal * 8,
    );
  }

}