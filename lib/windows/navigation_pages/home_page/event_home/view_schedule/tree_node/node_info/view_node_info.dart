import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';

import '../../../../../../../col.dart';
import '../../../../../../../size_config.dart';
import '../view_tree_node_static.dart';

/// Sub View of a node allowing a user to see its description
/// plus start/end times.
///@author Cody Smith at RIT (bcs4313)
class ViewNodeInfo extends StatelessWidget
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  ViewTreeNodeStatic base;

  /// Basic Widget to generate upon getting a time range for a node
  Widget rangeWidget = Container();

  /// This String is generated when the user wants
  /// to signify a start/end time.
  String timeRangeString = "";

  /// Simple constructor for this view
  ///@param base the node holding the data needed to display this view
  ViewNodeInfo(ViewTreeNodeStatic base)
  {
    this.base = base;

    if(base.startTime != "choose time" || base.startDate != "choose date" || base.endTime != "choose time"
     || base.endDate != "choose date")
      {
        if(base.startDate != "choose date" && base.endDate != "choose date")
          {
            if(base.startTime == "choose time" || base.endTime == "choose time")
              {
                timeRangeString = "from " + base.startDate + "\n to " + base.endDate;
              }
            else
              {
                timeRangeString = "from " + base.startDate + ", " + base.startTime + "\n to " +
                    base.endDate + ", " + base.endTime;
              }
          }
        if(base.startTime != "choose time" && base.startDate != "choose time")
          {
            if(base.startDate == "choose date" || base.endDate == "choose date")
            {
              timeRangeString = "from " + base.startTime + "\n to " + base.endTime;
            }
          }
      }
    if(timeRangeString != "")
      {
        rangeWidget = Text(
          "Time Range:",
          style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
          textAlign: TextAlign.center,
        );
      }
  }

  @override
  Widget build(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
        key: S_KEY,
        resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
        backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Node Info"),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: Text(
                  base.title,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 4 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
                  child: SingleChildScrollView(
                    child: Container(
                    height: 30 * SizeConfig.scaleVertical,
                    child: TextFormField(
                      maxLines: 999,
                      initialValue: base.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Col.pink, fontSize: 3 * SizeConfig.scaleHorizontal),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple, width: 2),
                        ),
                      ),
                      onChanged:(value) {
                        // ignore changes
                      },
                    ),
                  ),
                  ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: rangeWidget,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: Text(
                  timeRangeString,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
    );
  }
}