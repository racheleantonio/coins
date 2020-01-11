import 'package:flutter/material.dart';
import 'package:testProject/models/user.dart';

class MonthSelector extends StatelessWidget {

   final Function changePage;

  MonthSelector(this.changePage);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: user.month.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                changePage(index);
                // user.selectedMonth = index;
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical:16 ),
                    child: Text(
                      user.month[index].name,
                      // months[index],
                      style: TextStyle(
                          color: index == user.selectedMonth
                              ? Colors.white
                              : Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
