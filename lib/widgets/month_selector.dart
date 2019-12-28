import 'package:flutter/material.dart';
import '../shared/util.dart';

class MonthSelector extends StatefulWidget {
  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  int selectedIndex=0;
  final List<String> months=["December","Jenuary", "February","March", "April", "May", "June"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:months.length,
        itemBuilder:(BuildContext context, int index){
          return 
          GestureDetector(
            onTap:(){
              setState(() {
                selectedIndex=index;
              });
            } ,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,vertical: 16
                  ), child: Text(
                    months[index],
                    style: TextStyle(
                      color:index== selectedIndex? Colors.white: Colors.white60,fontSize: 16, fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}