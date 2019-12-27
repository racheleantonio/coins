import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
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
        height: 300,
        width: 300,
        child: new Stack(children: <Widget>[chart, Center(child: inner)]));

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
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(gradient: grad),
          child: Column(
            children: <Widget>[
              MonthSelector(),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(child: recap),
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
        ));
  }
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        animationDuration: Duration(milliseconds: 1000),
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 50));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
