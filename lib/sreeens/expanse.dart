import 'package:coins/models/expanse.dart';
import 'package:flutter/material.dart';
import 'package:coins/models/user.dart';
import 'package:coins/widgets/card.dart';
import 'package:coins/widgets/expanses_list.dart';
import '../shared/util.dart';

class ExpanseScreen extends StatefulWidget {
  ExpanseScreen({
    Key key,
  }) : super(key: key);

  @override
  ExpanseScreenState createState() => ExpanseScreenState();
}

class ExpanseScreenState extends State<ExpanseScreen> {
  void selectExpanse(Expanse exp) {
    setState(() {
      selectedExpanse = exp;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: grad),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: new Center(
                child: Text(
              categoryList[selectedCategory].toString(),
              textAlign: TextAlign.center,
            )),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Container(
                      padding:
                          EdgeInsets.only(top: 20.0, right: 16.0, left: 16.0),
                      child: Column(
                        children: <Widget>[
                          ExpanseCard(),
                          // recap,
                          // Expanded(child: recap),
                          ExpensesList(selectExpanse:selectExpanse,category:categoryList[selectedCategory]),
                          // button,
                        ],
                      ),
                    )

                    // CategoryList(index: 2,)

                    ,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36))),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
