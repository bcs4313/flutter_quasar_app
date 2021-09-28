import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../col.dart';
import '../../../size_config.dart';

/// A shell for the implementation of an appBar with a
/// Drawer widget.
///@author Cody Smith at RIT (bcs4313)
class DrawerBarConstruct extends StatelessWidget implements PreferredSizeWidget {

  String text;

  DrawerBarConstruct(String text)
  {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AutoSizeText(text),
      flexibleSpace: Container(
        decoration: new BoxDecoration(
        gradient: new LinearGradient(
        colors: [
          Col.pink,
          Col.purple_0,
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(8.0) * SizeConfig.scaleVertical;
}