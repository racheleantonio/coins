import 'dart:collection';

import '../shared/util.dart';
import 'expanse.dart';

class User {
  List<Month> month;
  double average;
  User({this.month, this.average});
}

class Month {
  String name;
  HashMap<Category, List<Expanse>> month_expanses;
  Month({this.month_expanses, this.name});
}

