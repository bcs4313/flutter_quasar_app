import 'package:flutter/widgets.dart';

/// This file is a grid configuration system for our application. This guaruntees that
/// everything in our app modeled to this file will be properly sized to the screen.
/// The model is a 100 x 100 grid overlay.
/// @author Cody Smith
class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double h_block;
  static double v_block;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double scaleHorizontal;
  static double scaleVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    h_block = screenWidth / 100;
    v_block = screenHeight / 100;
    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    scaleHorizontal = (screenWidth -
        _safeAreaHorizontal) / 100;
    scaleVertical = (screenHeight -
        _safeAreaVertical) / 100;
  }
}