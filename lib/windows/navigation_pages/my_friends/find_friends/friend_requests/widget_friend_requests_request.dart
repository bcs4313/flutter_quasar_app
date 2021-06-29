
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/event_modifier/initializer_view_event_modifier.dart';
import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_event_editor.dart';

/// class for building an event editor UI widget for a single event
/// in the mainpage (edit event properties, add user, delete user).
class WidgetFriendRequest extends StatelessWidget {
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ControllerFriendRequests controller;
  String nickname; // nickname from friend request
  String id; // ID number of request to use for image loading / callback

  /// Constructor for this widget
  ///@param nickname nickname from friend request
  ///@param id ID number of request to use for image loading and callback
  ///@param controller controller to command upon request rejection/acceptance
  WidgetFriendRequest(String nickname, String id, ControllerFriendRequests controller)
  {
    this.nickname = nickname;
    this.id = id;
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 10 * SizeConfig.scaleVertical,
            child: Row(
            children:[
              Container(
                width: 47 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Col.purple_3),
                    ),
                    child: Text(nickname,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    onPressed:() => {
                      //transferModifyEvent(context, id),
                    }
                ),
              ),
              Container(
                width: 25 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Col.purple_2),
                    ),
                    child: Icon(
                      Icons.check_circle,
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
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Col.green),
                    ),
                    child: Icon(
                      Icons.cancel_rounded,
                      size: 7 * SizeConfig.scaleVertical,
                      color: Col.black_1,
                    ),
                    onPressed:() => {
                      //controller.transferTreeBuilder(context, this.id)
                    }
                ),
              ),
            ]),
    );
  }
}