import 'package:flutter/material.dart';
import 'package:testProject/models/user.dart';
import 'package:testProject/shared/util.dart';

class CategoryList extends StatelessWidget {
  CategoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories = user.month[selectedMonth].expenseForCategory;

    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          double perc = categories[index].total != 0
              ? (categories[index].total / user.month[selectedMonth].total) *
                  100
              : 0.00;
          String p = perc.toStringAsFixed(2);
          // p=p!="NaN"?p:"0.00";
          return GestureDetector(
            onTap: () {
              user.printC();
              selectedCategory = index;
              selectedExpanse = -1;
              Navigator.pushNamed(
                context,
                '/expanse',
              );
              // user.selectedMonth = index;
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
                          icons[categories[index].name],
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
                            categories[index].name,
                            style: TextStyle(fontSize: 16),
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
                            fontSize: 14,
                          )),
                      Text(p + "%",
                          style: TextStyle(
                            color: Colors.grey[800],
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
