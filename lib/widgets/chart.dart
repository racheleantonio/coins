import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coins/models/user.dart';
import 'package:coins/shared/util.dart';

// class HomePage extends StatefulWidget {
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

class Chart extends StatelessWidget {
  final int index;
  Chart({@required this.index});

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _seriesPieData = List<charts.Series<Task, String>>();
  //   _generateData();
  // }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Task, String>> _seriesPieData;

    _seriesPieData = List<charts.Series<Task, String>>();
    var categories = user.month[selectedMonth].expenseForCategory;
    List<Task> piedata;
// var cols=[ #9c27b0, #942eb2, #8c34b4,       #843ab6,     #7b3eb7, #7341b8,     #6c44b8,      #6447b  #5b4ab8, #524db7, #494fb6, #3f51b5];
    if (user.month[selectedMonth].total == 0) {
      piedata = [new Task("Empty", 0.00000001, colors[0])];
    } else {
      piedata = new List<Task>.generate(categoryList.length, (int index) {
        return Task(categories[index].name, categories[index].total,
            colors[index % colors.length]);
      });
    }
    // var piedata = [
    //   new Task('Work', 35.8, colors[0]),
    //   new Task('Eeat', 18.3, colors[1]),
    //   new Task('Commute', 10.8, colors[2]),
    //   new Task('TV', 15.6, colors[3]),
    //   new Task('Sleep', 19.2, colors[4]),
    //   new Task('Other', 10.3, colors[5]),
    //   new Task('Orther', 10.3, colors[6]),
    //   new Task('Eat', 8.3, colors[7]),
    // ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Cagegory',
        data: piedata,
        // data:data,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    return Container(
      child: charts.PieChart(_seriesPieData,
          animate: true,
          animationDuration: Duration(seconds: 1),
          defaultRenderer: new charts.ArcRendererConfig(
            // symbolRenderer: new IconRenderer(Icons.cloud),
            arcWidth: 45,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside)
            ]
          )),
    );
  }
}

// class Pollution {
//   String place;
//   int year;
//   int quantity;

//   Pollution(this.year, this.place, this.quantity);
// }

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;

  IconRenderer(this.iconData);

  @override
  Widget build(BuildContext context, {Color color, Size size, bool enabled}) {
    return new SizedBox.fromSize(
        size: size,
        child: new Text(
          'Ciao',
          style: TextStyle(color: Colors.yellow),
        ));
  }

  // Widget build(BuildContext context,
  //     {Size size, Color color, bool isSelected}) {
  //   return new SizedBox.fromSize(
  //       size: size, child: new Icon(iconData, color: Colors.white, size: 55.0));
  // }
}

// class Sales {
//   int yearval;
//   int salesval;

//   Sales(this.yearval, this.salesval);
// }
