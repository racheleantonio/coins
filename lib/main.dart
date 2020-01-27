import 'package:flutter/material.dart';
import 'package:testProject/sreeens/expanse.dart';

import 'sreeens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        "/home": (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        "/expanse": (context) => ExpanseScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Coins',
      theme: ThemeData(
          fontFamily: 'Gotham',
          primaryColor: Color(0xff3957F2),
          accentColor: Color(0xff2C45BF),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black87,
              displayColor: Colors.yellow,
              fontFamily: 'Gotham')
          // TextStyle(color: Colors.pink),
          // TextTheme(bodyColor: Colors.pink, displayColor: Colors.pink)

          //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),

          ),
      home: HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
