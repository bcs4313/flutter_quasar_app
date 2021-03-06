import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../col.dart';
import '../../../../size_config.dart';
import '../controller_profile_home.dart';
import 'extension_my_wishlist.dart';

/// A simple view of a user's wishlist that can be edited.
/// Edits of a wishlist are transferred to ViewProfileHome.
///@author Cody Smith at RIT (bcs4313)
class ViewMyWishlist extends State<MyWishlistStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ViewMyWishlist(ControllerProfileHome homecontroller, [String username])
  {
    this.homeController = homecontroller;
  }

  ControllerProfileHome homeController; // updates old window view

  @override
  Widget build(BuildContext context)
  {
    //final ControllerForgotPassword controller = new ControllerForgotPassword();
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
        appBar: DrawerBarConstruct("Profile Viewer and Updater"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                  'Edit Wishlist',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 4 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
                child: Container(
                  height: 73 * SizeConfig.scaleVertical,
                  child: TextFormField(
                    maxLines: 999,
                    maxLength: 1200,
                    initialValue: homeController.wishlist,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Col.pink, fontSize: 3 * SizeConfig.scaleHorizontal),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple, width: 2),
                      ),
                    ),
                    onChanged:(value) {
                      homeController.wishlist = value;
                    },
                ),
                )
            ),
          ],
        ),
      )
    );
  }
}