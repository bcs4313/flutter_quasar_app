import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../col.dart';
import '../../../size_config.dart';

/// This view appears before the user sees the login screen
/// and before all necessary modules for the app to run are intiialized.
///@author Cody Smith at RIT (bcs4313)
class InitialLoadingView
{
  static Scaffold generatePortraitView()
  {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      //appBar: AppBar(
      //  title: AutoSizeText(widget.title),
      //),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 23 * SizeConfig.scaleVertical),
              child: AutoSizeText(
                  'Loading...',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 14, fontFamily: 'Roboto', color: Col.pink)
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 10 * SizeConfig.scaleVertical),
            child: SizedBox(
              width: 30 * SizeConfig.scaleHorizontal,
              height: 30 * SizeConfig.scaleHorizontal,
              child: CircularProgressIndicator(
                value: null,
                strokeWidth: 0.5 * SizeConfig.scaleVertical,
                color: Col.pink,
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}