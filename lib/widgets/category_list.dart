import 'package:flutter/material.dart';
import 'package:testProject/models/user.dart';
import 'package:testProject/shared/util.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var categories=user.month[user.selectedMonth].expenseForCategory;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top:4,right:20,bottom:4,left:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration:
                          BoxDecoration(gradient: grad2, shape: BoxShape.circle),
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        icons[categoryList[index]],
                        color: Colors.white,
                        size: 20.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: <Widget>[
                        Text(
                          categoryList[index],
                          style: TextStyle(
                              fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(categories[index].total.toString(),style: TextStyle(
                              fontSize: 12, )),
                    Text("43%",style:TextStyle(color: Colors.grey[800],fontSize: 10,))
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
