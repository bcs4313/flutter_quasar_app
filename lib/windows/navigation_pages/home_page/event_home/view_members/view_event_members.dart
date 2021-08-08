import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_event_members.dart';
import 'extension_event_members.dart';

/// A UI that loads the members of a joined event 8 per page, and
/// lets them view their profile information, along with an unfriend
/// option (if applicable).
///@author Cody Smith at RIT (bcs4313)
class ViewEventMembers extends State<EventMembersStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();
  ControllerEventMembers controller;
  EventMembersStateful stateful;

  ListView eventConstruct; // construct of the friendlist in this view
  int disposition = 0; // current page to look in friend_wise (5 at a time)
  int count = 0; // amount of pages there are

  ViewEventMembers(ControllerEventMembers controller, EventMembersStateful stateful,
      Map<dynamic, dynamic> eventMap)
  {
    this.controller = controller;
    this.stateful = stateful;
    controller.parent = this;

    // generate a list of event members to look through
    // This binder forces the setState to be called after
    // the window is constructed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeMemberList(eventMap);
    });

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
        appBar: DrawerBarConstruct("Event Member Viewer"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'Event Participants',
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

                      child: Text(
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
                height: 72 * SizeConfig.scaleVertical,
                width: 100 * SizeConfig.scaleHorizontal,
                child: eventConstruct,
              ),
            ),
          ],
        ),
      )
    );
  }

  /// Add the member list constructed by the controller
  /// to this view, and rebuild all widgets
  ///@param view listview to update the window with
  ///@param step the current viewing step of the controller
  void addView(ListView view, int step)
  {
    setState(() {
      this.eventConstruct = view;
      this.count = step+1;
    });
  }
}