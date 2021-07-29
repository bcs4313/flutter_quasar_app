import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_user_profile.dart';
import 'extension_user_profile.dart';

/// Profile Lookup UI
///@author Cody Smith at RIT (bcs4313)
class ViewUserProfile extends State<U_UserProfileStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  Image pfp = Image(image: AssetImage('assets/images/pfp.png'));
  String username;
  String id;
  String bio = "";
  String wishlist = "";
  ControllerUserProfile controller;
  Widget unfriendButton = Container(); // used if the profile being viewed is a friend

  /// Constructor for a basic profile view
  ///@param username name of user
  ///@param id identification number of user
  ///@param controller controller of this view
  ///@param bio bio for the user with the id
  ///@param wishlist list of things that the user wants (from the user with the id)
  ViewUserProfile(String username, String id, ControllerUserProfile controller,
      String bio, String wishlist)
  {
    this.username = username;
    if(username == null)
      {
        this.username = "undefined (unsafe)";
      }
    this.id = id;
    this.controller = controller;
    this.bio = bio;
    this.wishlist = wishlist;
    controller.parent = this;
    controller.retrieveInfo();

    // add friend options if this person is a friend
    controller.friendModify();
  }



  @override
  Widget build(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
        key: S_KEY,
        resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
        backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct(username + "'s Profile"),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3 * SizeConfig.scaleHorizontal),
                    ),
                    Container(
                      color: Col.blue,
                      width: 40 * SizeConfig.scaleHorizontal,
                      height: 7 * SizeConfig.scaleVertical,
                      child: TextButton.icon(
                        label: Text("Bio",
                            style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                                height: 1.3,
                                fontFamily: 'Roboto',
                                color: Col.white)),
                        icon: Icon(
                          Icons.wysiwyg,
                          color: Col.white,
                        ), onPressed: () {
                        controller.transferUserBio(context);
                      },),),
                    Padding(
                      padding: EdgeInsets.only(left: 14 * SizeConfig.scaleHorizontal),
                    ),
                    Container(
                      color: Col.blue,
                      width: 40 * SizeConfig.scaleHorizontal,
                      height: 7 * SizeConfig.scaleVertical,
                      child: TextButton.icon(
                        label: Text("Wishlist",
                            style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 3,
                                height: 1.3,
                                fontFamily: 'Roboto',
                                color: Col.white)),
                        icon: Icon(
                          Icons.list_alt,
                          color: Col.white,
                        ), onPressed: () {
                        controller.transferUserWishlist(context);
                      },),),
                  ]
              ),
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
                child: Text(
                  username,
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical),
                child: CircleAvatar(
                  backgroundImage: pfp.image,
                  radius: 15 * SizeConfig.scaleVertical,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical),
              ),
              Container(
                child: unfriendButton,
              ),
            ],
          ),
        )
    );
  }
}