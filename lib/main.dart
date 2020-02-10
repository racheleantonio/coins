import 'package:flutter/material.dart';
import 'package:coins/sreeens/expanse.dart';
import 'package:coins/shared/util.dart';
import 'package:coins/services/db.dart';

import 'sreeens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        "/home": (context) =>
            // TodoList(),
            HomeScreen(),
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
              bodyColor: textColor,
              displayColor: Colors.yellow,
              fontFamily: 'Gotham')
          // TextStyle(color: Colors.pink),
          // TextTheme(bodyColor: Colors.pink, displayColor: Colors.pink)

          //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),

          ),
      home:
          // TodoList(),
          HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
