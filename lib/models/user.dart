import '../shared/util.dart';
import 'expanse.dart';
import 'package:intl/intl.dart';

class User {
  int selectedMonth;
  String name;
  List<Month> month;
  double average;
    User.mock(name, month)
      : this.name = name,
        this.average = 0.0,
        this.selectedMonth=0,
        this.month = month;
  User(name)
      : this.name = name,
        this.average = 0.0,
        this.selectedMonth=1,
        this.month = [new Month()];
}

class Month {
  String name;
  double total;
  List<CategoryExpanse> expenseForCategory;
  Month.mock(name, total, monthExpanses)
      : this.expenseForCategory = monthExpanses,
        this.name = name,
        this.total = total;
  Month()
      : this.name = DateFormat('MMMM').format(new DateTime.now()),
        this.total = 0,
        expenseForCategory = [];
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

Month nov = new Month.mock("November", 332.33, [cat1, cat2]);
Month oct = new Month.mock("October", 300, [cat1]);

var thisMonth = DateFormat('MMMM').format(new DateTime.now());
User user = User.mock('Ciccio', [oct, nov, new Month()]);
