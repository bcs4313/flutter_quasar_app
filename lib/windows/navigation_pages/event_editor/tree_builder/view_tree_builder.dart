import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';

/// Login Screen UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewTreeBuilder extends StatelessWidget
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

  /// generate a portrait projection of the window view
  Scaffold generatePortraitView(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Schedule Builder"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                  'Event Schedule',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 95 * SizeConfig.scaleHorizontal,
              height: 80 * SizeConfig.scaleVertical,
              color: Col.purple_1,

              // This container has a complex staggered grid view to model a sophisticated scheduler system.
              // @param staggeredtiles property lists each individual tile's spacing (respective)
              // @param children property lists each item that will be placed in each staggeredtile (respective)
              // @param crossAxisCount number of columns defined
              // @param crossaxisspacing number of pixels between each tile produced (column split)
              // @param mainaxisspacing number of pixels between each tile produced (row split)
              child: StaggeredGridView.count(
                padding: const EdgeInsets.all(12.0),
                crossAxisCount: 4,
                mainAxisSpacing: 24,
                crossAxisSpacing: 12,
                staggeredTiles: [
                  StaggeredTile.count(1, 2),
                  StaggeredTile.count(1, 2),
                  StaggeredTile.count(2, 2),
                  StaggeredTile.count(2, 2),
                  StaggeredTile.count(2, 2),
                  StaggeredTile.count(2, 2),
                  StaggeredTile.count(2, 2),
                  StaggeredTile.count(2, 2),
                ],
                children:
                  [
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.home, color: Colors.white),
                  ]
              ),
            ),
          ])
        ),
      );
  }

  /// generate a landscape projection of the window view
  Scaffold generateLandscapeView(BuildContext context)
  {
    return generatePortraitView(context);
  }
}