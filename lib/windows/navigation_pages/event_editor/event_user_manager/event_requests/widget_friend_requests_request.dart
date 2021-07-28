
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_friend_requests.dart';

/// class for building an event editor UI widget for a single event
/// in the mainpage (edit event properties, add user, delete user).
class WidgetEventRequest extends StatelessWidget {
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ControllerEventRequests controller;
  String username; // nickname from friend request
  String id; // ID number of request to use for image loading / callback
  String bio;
  String wishlist;

  /// Constructor for this widget
  ///@param nickname nickname from friend request
  ///@param id ID number of request to use for image loading and callback
  ///@param controller controller to command upon request rejection/acceptance
  WidgetEventRequest(String username, String id, ControllerEventRequests controller)
  {
    this.username = username;
    if(username == null)
      {
        this.username = "undefined (unsafe)";
      }
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
                    child: Text(username,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    onPressed:() => {
                      controller.transferUserProfile(username, id,
                          "(Friendship is required to view this bio)", ("Friendship is required to view this wishlist")),
                    }
                ),
              ),
              Container(
                width: 25 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Col.green),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 7 * SizeConfig.scaleVertical,
                      color: Col.black_1,
                    ),
                    onPressed:() => {
                      controller.addToEvent(id, context)
                    }
                ),
              ),
              Container(
                width: 28 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Col.red),
                    ),
                    child: Icon(
                      Icons.cancel_rounded,
                      size: 7 * SizeConfig.scaleVertical,
                      color: Col.black_1,
                    ),
                    onPressed:() => {
                      controller.removeFromDump(id, context)
                    }
                ),
              ),
            ]),
    );
  }
}