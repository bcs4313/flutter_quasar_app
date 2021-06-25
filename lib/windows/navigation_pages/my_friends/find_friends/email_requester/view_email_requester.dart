import 'package:flutter/material.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_email_requester.dart';
import 'extension_email_requester.dart';

/// Login Screen UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewEmailRequester extends State<EmailRequesterStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return generatePortraitView(context);
    } else {
      return generateLandscapeView(context);
    }
  }

  ControllerEmailRequester controller; // controller for this view
  EmailRequesterStateful stateful; // extension of this view's state

  /// Constructor for this view
  ///@param controller manages calls from this view
  ///@param stateful extension of this view that prevents the reinstating of the original controller
  ViewEmailRequester(ControllerEmailRequester controller, EmailRequesterStateful stateful)
  {
    this.controller = controller;
    this.stateful = stateful;
  }

  /// generate a portrait projection of the window view
  Scaffold generatePortraitView(BuildContext context)
  {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: AppBar(
        title: Text("Friend Finder"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'Please enter a valid email to complete the request.',
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
                  controller.setEmail(value);
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
                    child: Text("Send",
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4,
                            height: 1.3,
                            fontFamily: 'Roboto',
                            color: Col.white)),
                    onPressed: () {
                    controller.sendEmailRequest(context);
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

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}