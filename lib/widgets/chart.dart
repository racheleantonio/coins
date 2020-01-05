import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {
// var cols=[ #9c27b0, #942eb2, #8c34b4,       #843ab6,     #7b3eb7, #7341b8,     #6c44b8,      #6447b  #5b4ab8, #524db7, #494fb6, #3f51b5];

    var piedata = [
      new Task('Work', 35.8, Color(0xff9c27b0)),
      new Task('Eeat', 18.3, Color(0xff843ab6)),
      new Task('Commute', 10.8, Color(0xff6c44b8)),
      new Task('TV', 15.6, Color(0xff524db7)),
      new Task('Sleep', 19.2, Color(0xff3f51b5)),
      new Task('Other', 10.3, Color(0xff524db7)),
      new Task('Orther', 10.3, Color(0xff6c44b8)),
      new Task('Eat', 8.3, Color(0xff843ab6)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: charts.PieChart(_seriesPieData,
          animate: true,
          animationDuration: Duration(seconds: 1),
          // behaviors: [
          //   new charts.DatumLegend(
          //     outsideJustification: charts.OutsideJustification.endDrawArea,
          //     horizontalFirst: false,
          //     desiredMaxRows: 2,
          //     cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          //     entryTextStyle: charts.TextStyleSpec(
          //         color: charts.MaterialPalette.purple.shadeDefault,
          //         fontFamily: 'Georgia',
          //         fontSize: 11),
          //   )
          // ],
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 40,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside)
              ])),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
