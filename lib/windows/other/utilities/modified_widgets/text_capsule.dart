import 'package:flutter/cupertino.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';

/// A class that simplifies text widget code by
/// forcing text to be a certain size and
/// color.
/// Example: U_TextCapsule("hello", Col.pink, 300, 300)
/// Create a text widget that is in a 300 x 300 box, saying hello.
/// it is pink.
///@author Cody Smith at RIT (bcs4313)
// ignore: must_be_immutable, camel_case_types
class U_TextCapsule extends StatelessWidget
{
  String text;
  double width; // width of text widget, automatically scaled
  double height; // height of text widget
  String font = 'Roboto';
  Color col = Col.pink;
  TextAlign align = TextAlign.center;

  /// Constructor for this text utility
  ///@param text String displayed by text
  ///@param width width of text, automatically scaled to screen dimensions
  ///@param height height of text, automatically scaled to screen dimensions
  ///@opt font font to add to the text capsule
  ///@opt col Color of text (class)
  ///@opt align Text alignment of text (class)
  U_TextCapsule(String text, double width, double height, {String font, Color col, TextAlign align})
  {
    this.text = text;
    this.width = width;
    this.height = height;
    this.font = font;
    this.col = col;
    this.align = align;
  }

  @override
  Widget build(BuildContext context) {
    return
    Container(
      width: width * SizeConfig.scaleHorizontal,
      height: height * SizeConfig.scaleVertical,
      child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text,
            style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8,
                height: 1.2 * SizeConfig.scaleVertical,
                fontFamily: font,
                color: col),
            textAlign: align,
          ))
    );
  }
}