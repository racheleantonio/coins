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
  int total;
  HashMap<Category, List<Expanse>> monthExpanses;
  Month({this.monthExpanses, this.name, this.total});
}

