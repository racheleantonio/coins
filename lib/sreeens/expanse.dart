import 'package:flutter/material.dart';
import 'package:testProject/models/user.dart';
import 'package:testProject/widgets/card.dart';
import 'package:testProject/widgets/expanses_list.dart';
import '../shared/util.dart';

class ExpanseScreen extends StatefulWidget {
  ExpanseScreen({
    Key key,
  }) : super(key: key);

  @override
  ExpanseScreenState createState() => ExpanseScreenState();
}

class ExpanseScreenState extends State<ExpanseScreen> {
  void selectExpanse(int exp) {
    setState(() {
      selectedExpanse = exp;
      user.printC();
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
                          ExpensesList(selectExpanse:selectExpanse),
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
