import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_id_requester.dart';
import 'extension_id_requester.dart';

/// View that lets a user enter an ID number to send a friend request.
///@author Cody Smith at RIT (bcs4313)
class ViewIDRequester extends State<IDRequesterStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ControllerIDRequester controller; // controller for this view
  IDRequesterStateful stateful; // extension of this view's state

  /// Constructor for this view
  ///@param controller manages calls from this view
  ///@param stateful extension of this view that prevents the reinstating of the original controller
  ViewIDRequester(ControllerIDRequester controller, IDRequesterStateful stateful)
  {
    this.controller = controller;
    this.stateful = stateful;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Friend Finder"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                'Please enter a valid ID to complete the request.',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
            ),
            TextField(
                obscureText: false,
                textAlign: TextAlign.center,
                style: TextStyle(color: Col.pink),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),

                // Textfield Change Recording
                onChanged: (value)
                {
                  controller.setID(value);
                }
            ),
            Padding(
              padding:EdgeInsets.only(top: 43 * SizeConfig.scaleVertical),
            ),
            Container(
              color: Col.purple_1,
              child: SizedBox(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: TextButton(
                    child: AutoSizeText("Send",
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                            height: 1.3,
                            fontFamily: 'Roboto',
                            color: Col.white)),
                    onPressed: () {
                      controller.sendIDRequest(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}