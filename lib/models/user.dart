import 'package:testProject/shared/util.dart';
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
        this.selectedMonth = 0,
        this.month = month;
  User(name)
      : this.name = name,
        this.average = 0.0,
        this.selectedMonth = 1,
        this.month = [new Month()];

  void add(Expanse e, String c) {
    month[selectedMonth].expenseForCategory.forEach((c1) => {
          if (c == c1.name) {c1.list.add(e), c1.total += e.amount}
        });
    month[selectedMonth].total += e.amount;
  }
}

class Month {
  String name;
  double total;
  List<CategoryExpanse> expenseForCategory;
  List<CategoryExpanse> createCategory() {
    return [];
  }

  Month.mock(name)
      : this.name = name,
        this.total = 0,
        // todo create for
        expenseForCategory = [
          new CategoryExpanse("Cinema"),
          new CategoryExpanse("Food"),
          new CategoryExpanse("Transport"),
          new CategoryExpanse("Travel"),
          new CategoryExpanse("Home"),
          new CategoryExpanse("Shopping"),
        ];
  Month()
      : this.name = DateFormat('MMMM').format(new DateTime.now()),
        this.total = 0,
        expenseForCategory = [
          new CategoryExpanse("Cinema"),
          new CategoryExpanse("Food"),
          new CategoryExpanse("Transport"),
          new CategoryExpanse("Travel"),
          new CategoryExpanse("Home"),
          new CategoryExpanse("Shopping"),
        ];
}

class CategoryExpanse {
  String name;
  List<Expanse> list;
  double total;
  CategoryExpanse(name)
      : this.name = name,
        this.total = 0,
        this.list = [];
}

Expanse ex1 = new Expanse(
    amount: 300.0,
    causal: "Plane ticket",
    data: new DateTime(2019, 11, 11, 11, 11));
Expanse ex2 = new Expanse(
    amount: 32.33, causal: "Launch", data: new DateTime(2019, 11, 12, 11, 11));

Month nov = new Month.mock("November");
Month oct = new Month.mock("December");
User user = User.mock('Ciccio', [oct, nov,new Month()]);
// user.selectedMonth=2;
var s = user.add(ex1, "Food");
var c = user.add(ex2, "Travel");
