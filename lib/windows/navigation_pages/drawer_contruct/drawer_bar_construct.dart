import 'package:flutter/material.dart';

import '../../../col.dart';
import '../../../size_config.dart';

class DrawerBarConstruct extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Homepage"),
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