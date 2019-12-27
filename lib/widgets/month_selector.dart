import 'package:flutter/material.dart';
import '../shared/util.dart';

class MonthSelector extends StatefulWidget {
  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  int selectedIndex=0;
  final List<String> months=["December","Jenuary", "February","March"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
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
                    horizontal: 20,vertical: 30
                  ), child: Text(
                    months[index],
                    style: TextStyle(
                      color:index== selectedIndex? Colors.white: Colors.white60,fontSize: 20, fontWeight: FontWeight.bold
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