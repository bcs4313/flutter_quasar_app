import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import '../model_tree_builder.dart';
import '../view_tree_builder.dart';
import 'controller_tree_destroyer.dart';


/// View to confirm the deletion of a node. Prevents accidental node deletion.
///@author Cody Smith at RIT (bcs4313)
class ViewTreeDestroyer extends StatelessWidget
{
  ControllerTreeDestroyer controller;

  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  /// Constructor for the Tree deleter view
  ///@param model the model to remove children from
  ///@param view the view to update the state of
  ViewTreeDestroyer(ModelTreeBuilder model, ViewTreeBuilder view)
  {
    this.controller = new ControllerTreeDestroyer(model, view);
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Event Modifier"),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 5 * SizeConfig.scaleHorizontal, right: 5 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                'Are you sure you want to clear this schedule?',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 63.5 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 47 * SizeConfig.scaleHorizontal, height: 10 * SizeConfig.scaleVertical),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Col.gray, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      child: const AutoSizeText('Cancel'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 63.5 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 47 * SizeConfig.scaleHorizontal, height: 10 * SizeConfig.scaleVertical),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: ()
                      {
                        controller.pushTreeDeletion(context);
                      },
                      child: const AutoSizeText('Delete'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}