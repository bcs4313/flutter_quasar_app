import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_friend_large.dart';
import 'extension_friend_large.dart';

/// class for building a friend widget for a singular friend
/// in the friend mainpage (profile info / username, User image).
class ViewFriendLarge extends State<FriendLargeStateful> {
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // Identify the user by id
  String id = "???";
  ControllerFriendLarge controller;

  // username of this friend
  String username = "Loading...";

  // Image of the user
  Image pfp;

  /// constructor for this profile widget
  ///@param id id number of the user to load
  ///@param controller controls this stateful view
  ViewFriendLarge(String id, ControllerFriendLarge controller)
  {
    this.id = id;
    this.controller = controller;
    controller.initialize(this);
    controller.retrieveInfo();
  }

  @override
  Widget build(BuildContext context) {
    if(username == null || pfp == null)
      {
        return Container();
      }

    // if these pieces of data are done loading then return the full widget
    return Container(
            height: 9 * SizeConfig.scaleVertical,
            child: Row(
            children:[
              Container(
                width: 80 * SizeConfig.scaleHorizontal,
                height: 9 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Col.purple_3),
                    ),
                    child: Text(username,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    onPressed:() => {
                      controller.transferUserProfile(context),
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: SizedBox(
                  width: 9 * SizeConfig.scaleVertical,
                  height: 10.2 * SizeConfig.scaleVertical,
                  child: CircleAvatar(
                  backgroundImage: pfp.image,
                  radius: 2 * SizeConfig.scaleVertical,
                ),),
              ),

            ]),
    );
  }
}