import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/tree_builder/node_editor/view_node_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/view_event_editor.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/event_editor/widget_event_edtor_event.dart';

/// Controller for editing an individual node (ViewNodeEditor)
///@author Cody Smith at RIT (bcs4313)
class ControllerNodeEditor
{
  /// OPERATIONS
  /// -- These methods do things that are specific to this app window

  var widgetList = <Widget>[];
  ViewNodeEditor parent; // stateful widget to update after various changes to this controller

  // add parent to the following widget
  void addParent(ViewNodeEditor parent)
  {
    this.parent = parent;
  }

  // convert date variable to certain string formats

  /// Converts a date variable into a formatted string of date.
  ///@param DateTime variable that stores data about a selected time/date
  ///@return String in format (MM/DD/YYYY)
  String DateToStrD(DateTime dat)
  {
    String month = dat.month.toString();
    String day = dat.day.toString();
    String year = dat.year.toString();
    return month + "/" + day + "/" + year;
  }

  /// Converts a date variable into a formatted string of time.
  ///@param DateTime variable that stores data about a selected time/date
  ///@return String in format (00:00 AM/PM)
  String DateToStrT(DateTime dat)
  {
    String minute = dat.minute.toString();
    if(dat.minute < 10)
      {
        minute = "0" + minute;
      }

    if(dat.hour >= 12)
      {
        if(dat.hour != 12) {
          String hour = (dat.hour - 12).toString();
          return hour + ":" + minute + " PM";
        }
        else
          {
            return "12:" + minute + " PM";
          }
      }
    else {
      if(dat.hour != 0) {
        String hour = dat.hour.toString();
        return hour + ":" + minute + " AM";
      }
      else
        {
          return "12:" + minute + " AM";
      }
    }
  }
}
