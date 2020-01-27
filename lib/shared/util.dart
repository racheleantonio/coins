import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final List<String> categoryList = [
  "Food",
  "Travel",
  "Cinema",
  "Transport",
  "Home",
  "Shopping"
];
final Map<String, IconData> icons = {
  "Food": Icons.fastfood,
  "Transport": Icons.train,
  "Travel": Icons.flight,
  "Cinema": Icons.movie,
  "Home": Icons.home,
  "Shopping": Icons.shopping_basket
};
LinearGradient grad =
    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
        // colors: <Color>[Colors.purple, Colors.indigo]);
        colors: <Color>[Color(0xff3957F2), Color(0xff2C45BF)]);
LinearGradient grad2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.topRight,
    colors: <Color>[Color(0xff3957F2), Color(0xff2C45BF)]);
// colors: <Color>[Colors.purple, Colors.indigo]);

Color textColor = Colors.black87;
// List<Color> colors = [
//   Color(0xff9c27b0),
//   Color(0xff6c44b8),
//   Color(0xff6c44b8),
//   Color(0xff524db7),
//   Color(0xff3f51b5),
//   Color(0xff524db7),
//   Color(0xff6c44b8),
//   Color(0xff6c44b8),
// ];


List<Color> colors = [
    Color(0xff889af7),
  Color(0xff6078f4),
  Color(0xff3957f2),
  Color(0xff2d45c1),
  Color(0xff273ca9),
  Color(0xff2d45c1),
  Color(0xff3957f2),
  Color(0xff6078f4),
];



double borderRadius16 = 16;
double borderRadius28 = 28;
double fontSize24 = 24;
double fontSize20 = 20;
double fontSize18 = 18;

int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  return _daysInMonth[month - 1];
}

const List<int> _daysInMonth = <int>[
  31,
  -1,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31,
];

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey[200],
  blurRadius: 4.0, // has the effect of softening the shadow
  spreadRadius: 4.0, // has the effect of extending the shadow
  // offset: Offset(
  //   4, // horizontal, move right 10
  //   4, // vertical, move down 10
  // ),
);
DateFormat formatter = new DateFormat('yyyy-MM-dd');