import 'package:flutter/material.dart';
import '../shared/util.dart';

import 'package:testProject/widgets/category_list.dart';
import 'package:testProject/widgets/chart.dart';
import '../widgets/month_selector.dart';
import 'package:testProject/models/user.dart';

class Dash extends StatefulWidget {
  final Function addExpanse;

  Dash(this.addExpanse);
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Widget> _createChildren() {
    return new List<Widget>.generate(user.month.length, (int index) {
      return Page(index:index);
    });
  }

  final controller = PageController(initialPage: user.selectedMonth);

  void _incrementCounter() {
    setState(() {
      user.add(ex1, "Cinema");
      user.add(ex2, "Travel");
      this.widget.addExpanse();
    });
  }

  void _onPageViewChange(int page) {
    setState(() {
      user.selectedMonth = page;
      print(page);
    });
  }

  void changePage(int page) {
    setState(() {
      user.selectedMonth = page;
      controller.animateToPage(page,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    var button = new Container(
      color: Colors.white,
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
      child: Column(
        children: <Widget>[
          MonthSelector(this.changePage),
          Expanded(
            child: Container(
              child: PageView(
                  controller: controller,
                  onPageChanged: _onPageViewChange,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Page(index:0),
                    Page(index:1),
                    Page(index:2),
                  ]),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36))),
            ),
          ),
          button
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int index;
  Page({@required this.index});

  @override
  Widget build(BuildContext context) {
    var total = new Text(
      user.month[index].total.toStringAsFixed(2) + '€',
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      textAlign: TextAlign.center,
    );
    var average = new Text(
      'Montly Average\n' + "TODO".toString() + '€',
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
      textAlign: TextAlign.center,
    );
    var inner = new ListView(
      children: <Widget>[
        total,
        average,
      ],
    );
    var chart = Chart(index: index);

    var recap = new Container(
        height: 250,
        width: 250,
        child: new Stack(children: <Widget>[chart, Center(child: total)]));
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 16.0, left: 16.0),
      child: Column(
        children: <Widget>[
          recap,
          // Expanded(child: recap),
          CategoryList(index: index,),
          // button,
        ],
      ),
    );
  }
}