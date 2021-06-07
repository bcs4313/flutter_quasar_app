import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_bar_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_construct.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/extension_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/main_page/widget_event_edtor_event.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/tree_node/view_tree_node_draggable.dart';

import '../../../../../col.dart';
import '../../../../../size_config.dart';
import 'controller_node_editor.dart';
import 'extension_node_editor.dart';

/// Event Editing Mainpage UI
///
/// This both serves as the model and view for our window.
/// The controller is separate from this file.
class ViewNodeEditor extends State<NodeEditorStateful>
{
  // used for global scaffold calls (and Snackbars)
  final GlobalKey<ScaffoldState> S_KEY = new GlobalKey<ScaffoldState>();

  // controller for this view
  ControllerNodeEditor controller;

  // node we are editing the data from
  ViewTreeNodeDraggable node;

  /// initialize stateful widget with a controller
  ///@param controller the controller to link to that modifies the state of this widget
  ViewNodeEditor(ControllerNodeEditor controller, ViewTreeNodeDraggable node)
  {
    this.controller = controller;
    controller.addParent(this); // add parent so controller can manage its own state
    this.node = node;
    print("currently editing the node: " + node.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: S_KEY,
      resizeToAvoidBottomInset: false, // prevents resizing upon keyboard appearing. Avoids an error.
      backgroundColor: Col.purple_0,
      appBar: DrawerBarConstruct("Node Editor"),
      drawer: DrawerConstruct(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5 * SizeConfig.scaleVertical, left: 8 * SizeConfig.scaleHorizontal, right: 8 * SizeConfig.scaleHorizontal),
              child: Text(
                'Title',
                style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 8, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical),
              child: SizedBox(
                width: 80 * SizeConfig.scaleHorizontal,
                height: 10 * SizeConfig.scaleVertical,
                child: TextFormField(
                obscureText: false,
                    initialValue: node.title,
                style: TextStyle(color: Col.pink),
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
                      node.setState(() {
                        node.title = value;
                      });
                    }
              ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3 * SizeConfig.scaleVertical, bottom: 2 * SizeConfig.scaleVertical),
              child: Text(
                'Description:',
                style: TextStyle(fontSize: 6 * SizeConfig.scaleHorizontal, height: 1.3, fontFamily: 'Roboto', color: Col.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2 * SizeConfig.scaleHorizontal),
              child: Container(
                width: 90 * SizeConfig.scaleHorizontal,
                height: 20 * SizeConfig.scaleVertical,
                child: TextFormField(
                    initialValue: node.description,
                    maxLines: 100, // max lines controls the container height along with text style
                    obscureText: false,
                    style: TextStyle(color: Col.pink, fontSize: 4 * SizeConfig.scaleHorizontal),
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
                      node.setState(() {
                        node.description = value;
                        print(node.description);
                      });
                    }
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 2 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4 * SizeConfig.scaleHorizontal),
                    child: Text('Node Icon:',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10 * SizeConfig.scaleHorizontal),
                    child: Container(
                      color: Col.purple_2,
                      child: IconButton(
                        iconSize: 14 * SizeConfig.scaleHorizontal,
                        icon: Icon(
                          Icons.account_circle,
                          color: Col.white,
                          size: 14 * SizeConfig.scaleHorizontal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 5 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
              child: Row(
                children: [
                  Container(
                    width: 20 * SizeConfig.scaleHorizontal,
                    height: 5 * SizeConfig.scaleVertical,
                    child: Text('Start:',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5 * SizeConfig.scaleHorizontal),
                      child: Row(
                        children: [
                          Container(
                        width: 30 * SizeConfig.scaleHorizontal,
                        height: 7 * SizeConfig.scaleVertical,
                        color: Col.purple_1,
                        child: TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                  maxTime: DateTime(DateTime.now().year+4, 12, 31),
                                  onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    setState(() {
                                      node.startDate = controller.DateToStrD(date);
                                    });
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            child: Text(
                              node.startDate,
                              style: TextStyle(color: Colors.blue),
                            )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5 * SizeConfig.scaleHorizontal),
                          child: Container(
                            width: 30 * SizeConfig.scaleHorizontal,
                            height: 7 * SizeConfig.scaleVertical,
                            color: Col.purple_1,
                            child: TextButton(
                                onPressed: () {
                                  DatePicker.showTime12hPicker(context, showTitleActions: true,
                                  onChanged: (time) {
                                    print('change $time in time zone ' +
                                    time.timeZoneOffset.inHours.toString());
                                  }, onConfirm: (time) {
                                      print('confirm $time');
                                      setState(() {
                                        node.startTime = controller.DateToStrT(time);
                                      });
                                  }, currentTime: DateTime.now());
                                },
                                child: Text(
                                  node.startTime,
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          ),
                        ]
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 4 * SizeConfig.scaleVertical, left: 5 * SizeConfig.scaleHorizontal, right: 4 * SizeConfig.scaleHorizontal),
              child: Row(
                children: [
                  Container(
                    width: 20 * SizeConfig.scaleHorizontal,
                    height: 5 * SizeConfig.scaleVertical,
                    child: Text('End:',
                      style: TextStyle(fontSize: SizeConfig.scaleHorizontal * 6, color: Col.pink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5 * SizeConfig.scaleHorizontal),
                    child: Row(
                        children: [
                          Container(
                            width: 30 * SizeConfig.scaleHorizontal,
                            height: 7 * SizeConfig.scaleVertical,
                            color: Col.purple_1,
                            child: TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                      maxTime: DateTime(DateTime.now().year+4, 12, 31),
                                      onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        setState(() {
                                          node.endDate = controller.DateToStrD(date);
                                        });
                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                                },
                                child: Text(
                                  node.endDate,
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5 * SizeConfig.scaleHorizontal),
                            child: Container(
                              width: 30 * SizeConfig.scaleHorizontal,
                              height: 7 * SizeConfig.scaleVertical,
                              color: Col.purple_1,
                              child: TextButton(
                                  onPressed: () {
                                    DatePicker.showTime12hPicker(context, showTitleActions: true,
                                        onChanged: (time) {
                                          print('change $time in time zone ' +
                                              time.timeZoneOffset.inHours.toString());
                                        }, onConfirm: (time) {
                                          print('confirm $time');
                                          setState(() {
                                            node.endTime = controller.DateToStrT(time);
                                          });
                                        }, currentTime: DateTime.now());
                                  },
                                  child: Text(
                                    node.endTime,
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
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
      //eventConstruct = newconstruct;
    });
  }

}
