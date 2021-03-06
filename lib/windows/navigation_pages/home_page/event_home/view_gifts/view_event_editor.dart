import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/controller_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/extension_event_editor.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';

/// Loads all events within a column that the user hosts, giving
/// an option to edit metadata, manage users, and/or edit/construct
/// a schedule for each one.
///@author Cody Smith at RIT (bcs4313)
class ViewEventEditorMainPage extends State<CounterPageStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // Widget list to fconstruct in this UI
  ListView eventConstruct;

  ControllerEventEditor controller;

  /// initialize stateful widget with a controller
  ///@param controller the controller to link to that modifies the state of this widget
  ViewEventEditorMainPage(ControllerEventEditor controller)
  {
    this.controller = controller;
    //controller.addParent(this); // add parent so controller can manage its own state
    //controller.constructWidgets();

    // This will remain the event construct until the controller replaces it
    eventConstruct = new ListView(
      children:[
      Padding(
        padding: EdgeInsets.only(top: 6 * SizeConfig.scaleVertical, left: 14 * SizeConfig.scaleHorizontal, right: 14 * SizeConfig.scaleHorizontal),
        child: SizedBox(
          width: 80 * SizeConfig.scaleHorizontal,
          height: 70 * SizeConfig.scaleHorizontal,
          child: CircularProgressIndicator(
            value: null,
            strokeWidth: 0.5 * SizeConfig.scaleVertical,
            color: Col.pink,
          ),
        ),
      ),
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Event Editor"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: AutoSizeText(
                'Manage Your Events',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
              child: SizedBox(
                width: 80 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                    style: ElevatedButton.styleFrom(
                      primary: Col.purple_3, // background
                      onPrimary: Col.pink, // foreground
                    ),
                    child: AutoSizeText('Create A New Event',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                    ),
                    onPressed:() => {
                      controller.transferCreateEvent(context),
                    }
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4 * SizeConfig.scaleHorizontal),
                    child: AutoSizeText('Edit Event Properties',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8 * SizeConfig.scaleHorizontal),
                    child: AutoSizeText('Manage Users',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 3, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6 * SizeConfig.scaleHorizontal),
                    child: AutoSizeText('Build Schedule',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 3, color: Col.pink),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3 * SizeConfig.scaleHorizontal),
              child: Container(
                color: Col.purple_1,
                height: 52 * SizeConfig.scaleVertical,
                width: 900 * SizeConfig.scaleHorizontal,
                child: eventConstruct,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateConstruct(ListView newconstruct)
  {
    setState(() {
      eventConstruct = newconstruct;
    });
  }

}
