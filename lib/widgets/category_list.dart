import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testProject/models/user.dart';
import 'package:testProject/shared/util.dart';


// class CategoryList extends StatefulWidget {
//   CategoryList({@required this.index});
//   final int index;

//   @override
//   _CategoryListState createState() => _CategoryListState();
// }

// class _CategoryListState extends State<CategoryList> {
// // var e=user.selectedMonth=2;
//   @override
//   Widget build(BuildContext context) {

class CategoryList extends StatelessWidget {
  final int index;
  CategoryList({@required this.index});

  @override
  Widget build(BuildContext context) {
    var categories = user.month[index].expenseForCategory;

    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          double perc = categories[index].total != 0
              ? (categories[index].total /
                      user.month[user.selectedMonth].total) *
                  100
              : 0.00;
          String p = perc.toStringAsFixed(2);
          // p=p!="NaN"?p:"0.00";
          return Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: grad2, shape: BoxShape.circle),
                      padding: EdgeInsets.all(8.0),
                      child: 
                      Icon(
                        icons[categories[index].name],
                        color: Colors.white,
                        size: 20.0,
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
                          categories[index].name,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(categories[index].total.toStringAsFixed(2) + '€',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(p + "%",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 10,
                        ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
