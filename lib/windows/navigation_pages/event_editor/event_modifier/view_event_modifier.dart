import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_event_modifier.dart';
import 'initializer_view_event_modifier.dart';


/// View that allows a user to modify the metadata of an event and submit
/// it to firebase.
///@author Cody Smith at RIT (bcs4313)
class ViewEventModifier extends State<InitializerEventModifier>
{
  // stateful vars
  bool switchAutoJoin = true;

  ControllerEventModifier controller;

  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  ViewEventModifier(ControllerEventModifier controller, bool switchAutoJoin, String title, String description)
  {
    this.controller = controller;
    this.switchAutoJoin = switchAutoJoin;
    controller.setAutoJoin(switchAutoJoin);
    controller.setDescription(description);
    controller.setTitle(title);
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
                  'Modify event properties',
                  style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
                child: Row(
                  children:[
                    AutoSizeText(
                      'Title:',
                      style: TextStyle(fontSize: 6 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: Container(
                        width: 70 * SizeConfig.scaleHorizontal,
                        child: TextFormField(
                          initialValue: controller.getTitle(),
                          obscureText: false,
                          maxLength: 50,
                          style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleVertical * 0.52),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                            ),
                          ),
                          // Textfield Change Recording
                          onChanged: (value)
                          {
                            controller.setTitle(value);
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
                child: Row(
                  children:[
                    AutoSizeText(
                      'Description:',
                      style: TextStyle(fontSize: 6 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: Container(
                        width: 51 * SizeConfig.scaleHorizontal,
                        height: 35 * SizeConfig.scaleVertical,
                        child: TextFormField(
                            initialValue: controller.getDescription(),
                            maxLength: 1200,
                            maxLines: 100, // max lines controls the container height along with text style
                            obscureText: false,
                            style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleVertical * 0.52),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.purple, width: 1.0),
                              ),
                            ),
                            // Textfield Change Recording
                            onChanged: (value)
                            {
                              controller.setDescription(value);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal),
                child: Row(
                  children:[
                    AutoSizeText(
                      'Auto-Join',
                      style: TextStyle(fontSize: 4 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
                      child: SizedBox(
                          child: Checkbox(
                            value: switchAutoJoin,
                            onChanged: (bool value) {
                              setState(() {
                                controller.setAutoJoin(value);
                                switchAutoJoin = value;
                              });
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
              Padding(
                padding: EdgeInsets.only(top: 3 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal),
                child: SizedBox(
                  width: 47 * SizeConfig.scaleHorizontal,
                  height: 10 * SizeConfig.scaleVertical,
                  child: ElevatedButton( // Raised buttons have bevels to stand out form the background
                      style: ElevatedButton.styleFrom(
                        primary: Col.purple_3, // background
                        onPrimary: Col.pink, // foreground
                      ),
                      child: AutoSizeText('Confirm Changes',
                        style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 4, color: Col.pink),
                      ),
                      onPressed:() => {
                        controller.pushMapUpdate(context),              }
                  ),
                ),
              ),
                  Padding(
                    padding: EdgeInsets.only(top: 3 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 47 * SizeConfig.scaleHorizontal, height: 10 * SizeConfig.scaleVertical),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Col.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: ()
                        {
                          controller.transferDeletionConfirmation(context);
                        },
                        child: const AutoSizeText('Remove Event'
                        ),
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