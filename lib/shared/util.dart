import 'package:flutter/material.dart';

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
var grad = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[Colors.purple, Colors.indigo]);
var grad2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.topRight,
    colors: <Color>[Colors.purple, Colors.indigo]);

var colors = [
  Color(0xff9c27b0),
  Color(0xff6c44b8),
  Color(0xff6c44b8),
  Color(0xff524db7),
  Color(0xff3f51b5),
    Color(0xff524db7),
  Color(0xff6c44b8),
  Color(0xff6c44b8),
];
