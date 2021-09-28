import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/controller_drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../col.dart';

/// Utility class that generates drawer items for us to use.
/// @author Chema Rubio from the flutter community
/// @editor Cody Smith
/// source: https://medium.com/flutter-community/flutter-vi-navigation-drawer-flutter-1-0-3a05e09b0db9
class DrawerUtility
{
  /// Header item generator for the drawer class
  /// Associated with an icon and text bundled together.`
  static Widget createDrawerItem({BuildContext context, IconData icon, String text, String locale})
  {
    ControllerDrawer.context = context;
    return ListTile(
      //selectedTileColor: Col.purple_3,
      //tileColor: Col.purple_3,
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(padding: EdgeInsets.only(left: 8.0), child: AutoSizeText(text))
          ],
        ),
        onTap: () => ControllerDrawer.transferFlex(locale),
      );
    }

    /// Header generator for our drawer class
  static Widget createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            //color: Col.purple_1,
            //backgroundBlendMode: BlendMode.src,
            //image: DecorationImage(
                //fit: BoxFit.fill,
                //image:  AssetImage('path/to/header_background.png')),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: AutoSizeText("Main Menu",
                  style: TextStyle(
                      color: Col.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}