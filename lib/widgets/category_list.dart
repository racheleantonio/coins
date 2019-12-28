import 'package:flutter/material.dart';
import 'package:testProject/shared/util.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration:
                        BoxDecoration(gradient: grad2, shape: BoxShape.circle),
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      icons[categories[index]],
                      color: Colors.white,
                      size: 16.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        categories[index],
                        style: TextStyle(
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("1000\$",style: TextStyle(
                            fontSize: 12, )),
                  Text("43%",style:TextStyle(color: Colors.grey[800],fontSize: 10,))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
