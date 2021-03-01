import 'package:flutter/material.dart';

import '../../../col.dart';
import '../../../size_config.dart';

class InitialLoadErrorView
{
  static Scaffold generatePortraitView()
  {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      //appBar: AppBar(
      //  title: Text(widget.title),
      //),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 23 * SizeConfig.scaleVertical),
              child: Text(
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