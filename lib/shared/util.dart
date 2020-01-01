import 'package:flutter/material.dart';

enum Category { food, travel, cinema, transport }
final List<String> categoryList = ["Food", "Travel", "Cinema", "Transport", "Home","Shopping"];
final Map<String,IconData> icons= {
  "Food":Icons.fastfood ,
  "Transport":Icons.train,
  "Travel":Icons.flight,
  "Cinema":Icons.movie,
  "Home":Icons.home,
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