import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/windows/navigation_pages/drawer_contruct/drawer_utility.dart';
import 'package:flutter_quasar_app/windows/other/app_metadata/app_metadata.dart';

import 'controller_drawer.dart';

class DrawerConstruct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerUtility.createHeader(),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.home, text: 'Home', locale: "ViewHomepage"),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.supervised_user_circle, text: 'My Friends', locale: "ViewFriendsHome"),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.double_arrow_sharp, text: 'Join an Event', locale: "ViewJoinEvent"),
          Divider(),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.mode_edit, text: 'Manage Events', locale: "ViewEventEditorMainPage"),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.face, text: 'My Profile', locale: "ViewProfileHome"),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.settings, text: 'Options', locale: "ViewHomepage"),
          Divider(),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.account_box, text: 'Documentation', locale: "ViewHomepage"),
          DrawerUtility.createDrawerItem(context: context, icon: Icons.bug_report, text: 'Report an issue', locale: "ViewHomepage"),
          ListTile(
            title: Text(AppMetadata.version),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}