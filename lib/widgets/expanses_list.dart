import 'package:coins/services/db.dart';
import 'package:flutter/material.dart';
import 'package:coins/models/expanse.dart';
import 'package:coins/models/user.dart';
import 'package:coins/shared/util.dart';

// class ExpensesList extends StatefulWidget {
//   ExpensesList({@required this.index});
//   final int index;

//   @override
//   _ExpensesListState createState() => _ExpensesListState();
// }

// class _ExpensesListState extends State<ExpensesList> {
// // var e=user.selectedMonth=2;
//   @override
//   Widget build(BuildContext context) {

class ExpensesList extends StatefulWidget {
  final Function selectExpanse;
  final String category;
  ExpensesList({
    @required this.selectExpanse,
    @required this.category,
    Key key,
  }) : super(key: key);

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  List<Expanse> expanses = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results =
        // await DB.query(Expanse.table);
        await DB.queryWhere(Expanse.table, widget.category);

    expanses = _results.map((item) => Expanse.fromMap(item)).toList();

    debugPrint(expanses.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // user.printC();
    // List<Expanse> expanses =
    //     user.month[selectedMonth].expenseForCategory[selectedCategory].list;
    // if (expanses.length == 0) return null;

    return Expanded(
      child: ListView.builder(
        itemCount: expanses.length,
        itemBuilder: (BuildContext context, int index) {
          double perc = expanses[index].amount != 0
              ? (expanses[index].amount /
                      user.month[selectedMonth]
                          .expenseForCategory[selectedCategory].total) *
                  100
              : 0.00;
          String p = perc.toStringAsFixed(2);
          // p=p!="NaN"?p:"0.00";
          return GestureDetector(
            onTap: () {
              widget.selectExpanse(expanses[index]);
              // selectedExpanse = index;
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            gradient: grad2, shape: BoxShape.circle),
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          icons[categoryList[selectedCategory]],
                          color: Colors.white,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            expanses[index].causal,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(expanses[index].amount.toStringAsFixed(2) + '€',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      Text(p + "%",
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 12,
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
