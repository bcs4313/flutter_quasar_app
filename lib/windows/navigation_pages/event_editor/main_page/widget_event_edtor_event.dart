
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_modifier/initializer_view_event_modifier.dart';
import 'controller_event_editor.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';

/// class for building an event editor UI widget for a single event
/// in the mainpage (edit event properties, add user, delete user).
class WidgetMainPageEvent extends StatelessWidget {
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // Identify the event by title
  String title = "?";

  // Find the event in Firebase by id
  String id = "-1";

  WidgetMainPageEvent(String title, String id)
  {
    this.title = title;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    ControllerEventEditor controller = new ControllerEventEditor();
    return Container(
            height: 10 * SizeConfig.scaleVertical,
            child: Row(
            children:[
              Container(
                width: 47 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: RaisedButton( // Raised buttons have bevels to stand out form the background
                    color: Col.purple_3,
                    disabledColor: Col.purple_3,
                    splashColor: Col.pink,
                    child: Text(title,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                    onPressed:() => {
                      transferModifyEvent(context, id),
                    }
                ),
              ),
              Container(
                width: 25 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: RaisedButton( // Raised buttons have bevels to stand out form the background
                    color: Col.green,
                    disabledColor: Col.green,
                    splashColor: Col.green,
                    child: Icon(
                      Icons.add_circle,
                      size: 7 * SizeConfig.scaleVertical,
                      color: Col.black_1,
                    ),
                    onPressed:() => {
                      //controller.createEvent(context, S_KEY),
                    }
                ),
              ),
              Container(
                width: 28 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: RaisedButton( // Raised buttons have bevels to stand out form the background
                    color: Col.red,
                    disabledColor: Col.red,
                    splashColor: Col.red,
                    child: Icon(
                      Icons.remove_circle,
                      size: 7 * SizeConfig.scaleVertical,
                      color: Col.black_1,
                    ),
                    onPressed:() => {
                      //controller.createEvent(context, S_KEY),
                    }
                ),
              ),
            ]),
    );
  }
  /// Direct user to event modification window
  void transferModifyEvent(BuildContext context, String eventNum)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new InitializerEventModifier(eventNum)));
  }
}