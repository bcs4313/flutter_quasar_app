import 'package:flutter/material.dart';

import '../../../col.dart';
import '../../../size_config.dart';

class InitialLoadingView
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