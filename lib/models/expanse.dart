import 'package:coins/models/model.dart';
import 'package:coins/shared/util.dart';
import 'package:flutter/widgets.dart';

class Expanse extends Model {
  static String table = 'expanse_items';

  // int id;
  double amount;
  String causal;
  DateTime date;
  String category;

  // static int counter = 0;
  Expanse(this.amount, this.causal, this.date, this.category);
  Expanse.map(
      // int id,
      double amount,
      String causal,
      String date,
      String category) {
    // this.id = id;
    this.amount = amount;
    this.causal = causal;
    this.date = formatter.parse(date);
    this.category = category;
  }
  Expanse createExpanse() {
    var thisInstant = new DateTime.now();
    return new Expanse(20, "testo", thisInstant, 'Cinema');
  }

  @override
  String toString() {
    return this.id.toString() +
        ':' +
        this.causal.toString() +
        ':' +
        this.date.toString();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    debugPrint(formatter.format(date).toString());
    map['amount'] = amount;
    map['causal'] = causal;
    map['date'] = formatter.format(date);
    map['category'] = category;
    return map;
  }
  // await db.execute('CREATE TABLE todo_items (id INTEGER PRIMARY KEY NOT NULL, amount REAL, causal TEXT, date TEXT');

  // Extract a Note object from a Map object
  static Expanse fromMap(Map<String, dynamic> map) {
    debugPrint('Extract from map ' +
        map['id'].toString() +
        ' ' +
        map['amount'].toString() +
        ' ' +
        map['date']);
    return new Expanse.map(
        map['amount'], map['causal'], map['date'], map['category']);
    // return Expanse.map(map['id'], map['causal'], map['amount'], map['data']);
  }
}
