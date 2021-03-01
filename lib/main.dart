// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quasar_app/size_config.dart';
import 'package:flutter_quasar_app/col.dart';
import 'package:flutter_quasar_app/windows/account_firewall/login/view_login.dart';
import 'package:flutter_quasar_app/windows/other/initial_load_error/initial_load_error_view.dart';
import 'package:flutter_quasar_app/windows/other/initial_loading/initial_loading_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quasar App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        hintColor: Col.purple_3,
      ),
      home: MyHomePage(title: 'Hello guys and gals Mutahar here.'),

    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This method is rerun every time setState is called, for instance as done
  // by the _incrementCounter method above.
  //
  // The Flutter framework has been optimized to make rerunning build methods
  // fast, so that you can just rebuild anything that needs updating rather
  // than having to individually change instances of widgets
  @override
  Widget build(BuildContext context) {
    // initialize our size config to create grid layout
    SizeConfig().init(context);

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    FutureBuilder future = FutureBuilder(
      // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return InitialLoadErrorView.generatePortraitView();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            Future.delayed(Duration.zero, () { // force delay to prevent pop stacking
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLogin()));
            });
            //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return InitialLoadingView.generatePortraitView();
        });
      if(future != null)
      {
        return future;
      }
      else
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLogin()));
        }
  }
}
