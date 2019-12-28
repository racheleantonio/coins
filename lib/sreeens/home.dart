import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:testProject/widgets/category_list.dart';
import 'package:testProject/widgets/chart.dart';
import '../shared/util.dart';
import '../widgets/month_selector.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int counter;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    counter = 500;
    // dataMap.putIfAbsent("Flutter", () => 5);
    // dataMap.putIfAbsent("React", () => 3);
    // dataMap.putIfAbsent("Xamarin", () => 2);
    // dataMap.putIfAbsent("Ionic", () => 2);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      counter += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    var chart = DonutPieChart.withSampleData();

    var total = new Text(
      counter.toString() + '€',
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      textAlign: TextAlign.center,
    );
    var average = new Text(
      'Montly Average\n' + counter.toString() + '€',
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
      textAlign: TextAlign.center,
    );
    var inner = new ListView(
      children: <Widget>[
        total,
        average,
      ],
    );
    var recap = new Container(
        height: 250,
        width: 250,
        child: new Stack(children: <Widget>[chart, Center(child: total)]));

    var button = new Container(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _incrementCounter(),
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            gradient: grad,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              'ADD EXPANSE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(gradient: grad),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: new Center(
              child: Text(
            "Your expenses",
            textAlign: TextAlign.center,
          )),
        ),
        body: Column(
          children: <Widget>[
            MonthSelector(),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    recap,
                    // Expanded(child: recap),
                    CategoryList(),
                    button,
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
            ),
            // bar,
            // dash,
          ],
        ),
      ),
    );
  }
}
