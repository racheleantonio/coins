import 'package:coins/models/expanse.dart';
import 'package:coins/services/db.dart';
import 'package:flutter/material.dart';
import '../shared/util.dart';

import 'package:coins/widgets/category_list.dart';
import 'package:coins/widgets/chart.dart';
import '../widgets/month_selector.dart';
import 'package:coins/models/user.dart';

class Dash extends StatefulWidget {
  final Function addExpanse;

  Dash(this.addExpanse);
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Widget> _createChildren() {
    return new List<Widget>.generate(user.month.length, (int index) {
      return Page(index: index);
    });
  }

  final controller = PageController(initialPage: selectedMonth);

  void _incrementCounter() {
    setState(() {
      // user.add(ex1, "Cinema");
      // user.add(ex2, "Travel");
      this.widget.addExpanse();
      // _save();
    });
  }

  void _onPageViewChange(int page) {
    setState(() {
      selectedMonth = page;
      selectedCategory = -1;
      selectedExpanse = null;
    });
  }

  void changePage(int page) {
    setState(() {
      selectedMonth = page;
      selectedCategory = -1;
      selectedExpanse = null;
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
          height: 66.0,
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
                    Page(index: 0),
                    Page(index: 1),
                    Page(index: 2),
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

class Page extends StatefulWidget {
  final int index;
  Page({@required this.index});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  double total;
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    // List<Map<String, dynamic>> _results =
    // // await DB.query(Expanse.table);
    //   await DB.queryWhere(Expanse.table,widget.category);
     List<Map<String, dynamic>> _results =await DB.querySumMonth(Expanse.table);
     total= _results[0]['Total'];
    // expanses = _results.map((item) => Expanse.fromMap(item)).toList();

    // debugPrint(expanses.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var textTotal = new Text(
      total != null ? total.toStringAsFixed(2) + '€' : '. . .',
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
        textTotal,
        average,
      ],
    );
    var chart = Chart(index: widget.index);

    var recap = new Container(
        height: 250,
        width: 250,
        child: new Stack(children: <Widget>[chart, Center(child: textTotal)]));
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 16.0, left: 16.0),
      child: Column(
        children: <Widget>[
          recap,
          // Expanded(child: recap),
          CategoryList(),
          // button,
        ],
      ),
    );
  }
}
