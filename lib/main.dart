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
      ),
      home: HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

