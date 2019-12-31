import '../shared/util.dart';
import 'expanse.dart';
import 'package:intl/intl.dart';

class User {
  String name;
  List<Month> month;
  double average;
  // User({this.month, this.average});
  User(name, month)
      : this.name = name,
        this.average = 0.0,
        this.month = month;
}

class Month {
  String name;
  double total;
  List<CategoryExpanse> monthExpanses;
  Month({this.monthExpanses, this.name, this.total});
}

class CategoryExpanse {
  Category name;
  List<Expanse> list;
  double total;
  CategoryExpanse({this.name, this.total, this.list});
}

Expanse ex1 = new Expanse(
    amount: 300.0,
    causal: "Plane ticket",
    data: new DateTime(2019, 11, 11, 11, 11));
Expanse ex2 = new Expanse(
    amount: 32.33, causal: "Launch", data: new DateTime(2019, 11, 12, 11, 11));
CategoryExpanse cat1 =
    new CategoryExpanse(name: Category.food, list: [ex2], total: 32.33);
CategoryExpanse cat2 =
    new CategoryExpanse(name: Category.travel, list: [ex1], total: 300);

Month nov =
    new Month(name: "November", total: 332.33, monthExpanses: [cat1, cat2]);
Month oct = new Month(name: "October", total: 0, monthExpanses: []);

var thisMonth = DateFormat('MMMM').format(new DateTime.now());
User user = User('Ciccio',
    [oct, nov, new Month(name: thisMonth, total: 0.0, monthExpanses: [])]);
