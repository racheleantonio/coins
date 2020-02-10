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
      margin: EdgeInsets.only(top: 28, bottom: 28),
      padding: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
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
