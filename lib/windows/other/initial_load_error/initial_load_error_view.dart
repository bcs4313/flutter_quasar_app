import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../col.dart';
import '../../../size_config.dart';

/// If the phone loading this application is outdated,
/// this window will show up, telling them that
/// the application is not compatible with the device.
///@author Cody Smith at RIT (bcs4313)
class InitialLoadErrorView
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
                  'There was an error loading this application.\nIt may not be compatible with your device.',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 10, fontFamily: 'Roboto', color: Col.pink)
              ),
            ),
          ],
        ),
      ),
    );
  }
}