import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_event_large.dart';
import 'extension_event_large.dart';

/// class for building an event widget that is linked to a host
/// user. (Event Name + Link, Host User + Link)
///@author Cody Smith at RIT (bcs4313)
class ViewEventLarge extends State<U_EventLargeStateful> {
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // A long list of variables for the constructor to update
  // to provide important info for the user without extra
  // requests
  String id = "???";
  String wishlist = "";
  String bio = "";
  ControllerEventLarge controller;
  String eventName = "Loading...";
  String eventNum = "-1";
  String username = "?";
  String description = "";
  String autoJoin = "false";
  int KEY;

  // Image of the user
  Image pfp;

  /// A massive constructor for this event widget. This is necessary
  /// for this utility because if we called Firebase for this info
  /// unnecessary calls would be made.
  ///@param id id of the user who owns the event
  ///@param eventName name of the event
  ///@param description description of the event
  ///@param autoJoin can a user join without needing to request? ("false", "true")
  ///@param pfp an Image object of the user's profile picture
  ///@param controller manages this widget
  ///@param wishlist wishlist of the user
  ///@param bio bio of the user
  ///@param KEY a unique integer key that allows this object to update asynchronously
  ///@param username username of the user in question
  ///@param eventNum event index location for this user
  ViewEventLarge(String id, String eventName, String description, String autoJoin,
      Image pfp, ControllerEventLarge controller, String wishlist, String bio
      , int KEY, String username, String eventNum)
  {
    this.id = id;
    this.eventName = eventName;
    this.autoJoin = autoJoin;
    this.description = description;
    this.controller = controller;
    this.pfp = pfp;
    this.wishlist = wishlist;
    this.bio = bio;
    this.KEY = KEY;
    this.username = username;
    this.eventNum = eventNum;
    print("bio =" + bio);
    print("KEY = " + KEY.toString());
    controller.initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    if(pfp == null)
      {
        return Container(key: Key("ENV_LARGE + " + KEY.toString()));
      }

    // if these pieces of data are done loading then return the full widget
    return Container(
            key: Key("ENV_LARGE + " + KEY.toString()),
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
                    child: Text(eventName,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    onPressed:() => {
                      controller.transferEventJoin(context),
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: GestureDetector(
                  onTap: () => {controller.transferUserProfile(context)},
                  child: SizedBox(
                  width: 9 * SizeConfig.scaleVertical,
                  height: 10.2 * SizeConfig.scaleVertical,
                  child: CircleAvatar(
                  backgroundImage: pfp.image,
                  radius: 2 * SizeConfig.scaleVertical,
                ),),
              )),

            ]),
    );
  }
}