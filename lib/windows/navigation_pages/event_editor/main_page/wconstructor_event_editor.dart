
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import 'controller_event_editor.dart';

/// class that builds event editor widgets into a singular class
class wConstructor extends StatelessWidget {
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

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
                  child: Text('Gamer',
                    style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                  ),
                  onPressed:() => {
                    //controller.createEvent(context, S_KEY),
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
}