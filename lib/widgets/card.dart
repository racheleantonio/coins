import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coins/models/user.dart';
import 'package:coins/shared/util.dart';

class ExpanseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (selectedExpanse != null) {
      child = Column(
        children: <Widget>[
          Center(
            // height: 32,
            // color: Colors.black,
            // decoration: BoxDecoration(
            //   gradient: grad,
            //   shape: BoxShape.rectangle,
            //   borderRadius: BorderRadius.circular(21),
            // ),
            // padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Icon(
                //   icons[categoryList[selectedCategory]],
                //   color: Colors.white,
                //   size: 32.0,
                //   semanticLabel: 'Text to announce in accessibility modes',
                // ),
                // SizedBox(
                //   width: 8,
                // ),
                Text(
                  // user.month[selectedMonth].expenseForCategory[selectedCategory]
                  //     .list[selectedExpanse]
                  selectedExpanse.category.toString().toUpperCase(),
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      // height: 55,
                      fontWeight: FontWeight.w900,
                      // fontSize: 12,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                // user.month[selectedMonth].expenseForCategory[selectedCategory]
                //     .list[selectedExpanse]
                selectedExpanse.causal.toString(),
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              // SizedBox(width: 4),
              Text(
                  // formatter.format(user
                  //   .month[selectedMonth]
                  //   .expenseForCategory[selectedCategory]
                  //   .list[selectedExpanse]
                  //   .date)
                  formatter.format(selectedExpanse.date)),
            ],
          ),
          SizedBox(height: 32),
          Text(
            // user.month[selectedMonth].expenseForCategory[selectedCategory]
            //         .list[selectedExpanse].amount
            selectedExpanse.amount.toStringAsFixed(2) + "€",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 32,
                color: Theme.of(context).accentColor),
          ),
        ],
      );
    } else {
      child = Column(children: <Widget>[
        Text("Total category",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        SizedBox(height: 4),
        Text(
          user.month[selectedMonth].expenseForCategory[selectedCategory].total
                  .toStringAsFixed(2) +
              "€",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 32,
              color: Theme.of(context).accentColor),
        )
      ]);
    }
    return Container(
      child: child,
      // margin: EdgeInsets.only(top: 28, bottom: 28),
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        // gradient: grad2,
        borderRadius: const BorderRadius.all(const Radius.circular(28.0)),
        boxShadow: [boxShadow],

        // borderRadius: new BorderRadius.all(...),
        // gradient: new LinearGradient(...),
      ),
      width: 340,
      height: 200,
    );
  }
}
