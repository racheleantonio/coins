import 'package:flutter/material.dart';

import 'sreeens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coins',
      theme: ThemeData(
        fontFamily: 'Gotham',
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo,
        // textTheme: TextTheme(
        //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
      home: HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
