import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../col.dart';
import '../../../size_config.dart';
import 'controller_friends_home.dart';
import 'extension_friends_home.dart';

/// A UI that loads all the friends a user has, 5 per page, and
/// lets them view their profile information, along with an unfriend
/// option.
///@author Cody Smith at RIT (bcs4313)
class ViewFriendsHome extends State<FriendsHomeStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  ControllerFriendsHome controller;
  FriendsHomeStateful stateful;

  ListView eventConstruct; // construct of the friendlist in this view
  int disposition = 0; // current page to look in friend_wise (5 at a time)
  int count = 0; // amount of pages there are

  ViewFriendsHome(ControllerFriendsHome controller, FriendsHomeStateful stateful)
  {
    this.controller = controller;
    this.stateful = stateful;

    // This will remain the event construct until the controller replaces it
    eventConstruct = new ListView(
      children:[
        Padding(
          padding: EdgeInsets.only(top: 6 * SizeConfig.scaleVertical, left: 14 * SizeConfig.scaleHorizontal, right: 14 * SizeConfig.scaleHorizontal),
          child: SizedBox(
            width: 80 * SizeConfig.scaleHorizontal,
            height: 70 * SizeConfig.scaleHorizontal,
            child: CircularProgressIndicator(
              value: null,
              strokeWidth: 0.5 * SizeConfig.scaleVertical,
              color: Col.pink,
            ),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Friends Tab"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                  'My Friends',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 6 * SizeConfig.scaleVertical,
              width: 100 * SizeConfig.scaleHorizontal,
              child: Row(
                children:[
                  IconButton(
                    icon: SizedBox(
                      height: 6 * SizeConfig.scaleVertical,
                      width: 25 * SizeConfig.scaleHorizontal,
                      child: FittedBox(
                        child: Icon(
                            Icons.arrow_back,
                          color: Col.white,
                        ),
                      ),
                    ),
                    color: Colors.white,
                    onPressed: (){ controller.arrowBackward(); },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 34 * SizeConfig.scaleHorizontal),
                  ),
                  Container(
                    width: 10 * SizeConfig.scaleHorizontal,
                    height: 6 * SizeConfig.scaleVertical,
                    child: FittedBox(

                      child: AutoSizeText(
                        "Page " + (disposition+1).toString() + " of " + (count).toString(),
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32 * SizeConfig.scaleHorizontal),
                    child: IconButton(
                      icon: SizedBox(
                        height: 6 * SizeConfig.scaleVertical,
                        width: 25 * SizeConfig.scaleHorizontal,
                        child: FittedBox(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Col.white,
                          ),
                        ),
                      ),
                      color: Colors.white,
                      onPressed: (){ controller.arrowForward(); },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleHorizontal),
              child: Container(
                color: Col.purple_1,
                height: 45 * SizeConfig.scaleVertical,
                width: 100 * SizeConfig.scaleHorizontal,
                child: eventConstruct,
              ),
            ),
            Container(
              height: 2 * SizeConfig.scaleVertical,
            ),
            Container(
              width: 90 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.green,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: AutoSizeText("Find Friends",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.group_add,
                    color: Col.white,
                  ), onPressed: () {
                    controller.transferFindFriends(context);
                },),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
            ),
            Container(
              width: 90 * SizeConfig.scaleHorizontal,
              height: 10 * SizeConfig.scaleVertical,
              color: Col.purple_2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton.icon(
                  label: AutoSizeText("View Requests",
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                          height: 1.3,
                          fontFamily: 'Roboto',
                          color: Col.white)),
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: Col.white,
                  ), onPressed: () {
                  controller.transferFriendRequests(context);
                },),
              ),
            ),
          ],
        ),
      )
    );
  }
}