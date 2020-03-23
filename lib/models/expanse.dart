import 'package:coins/models/model.dart';
import 'package:coins/shared/util.dart';
import 'package:flutter/widgets.dart';

class Expanse extends Model {
  static String table = 'expanse_items';

  // int id;
  String causal;
  String category;
  double amount;
  DateTime date;
  String month;

  // static int counter = 0;
  Expanse(this.causal, this.category, this.amount, this.date, this.month);
  Expanse.map(
      // int id,
      String causal,
      double amount,
      String category,
      String date,
      String month) {
    // this.id = id;
    this.amount = amount;
    this.causal = causal;
    this.date = formatter.parse(date);
    this.category = category;
    this.month= month;
  }
  // Expanse createExpanse() {
  //   var thisInstant = new DateTime.now();
  //   return new Expanse(20, "testo", thisInstant, 'Cinema');
  // }

  @override
  String toString() {
    return 
        this.causal.toString() +
        ':' +
         this.amount.toString() +
        ':' +
        this.date.toString() +
        ':' +
        this.category.toString()+
          ':' +
        this.month.toString() ;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    debugPrint(formatter.format(date).toString());
    map['causal'] = causal;
    map['amount'] = amount;
    map['category'] = category;
    map['date'] = formatter.format(date);
    map['month'] = category;
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
        map['date'] +
        ' ' +
        map['month']);
    return new Expanse.map(map['causal'], map['amount'], map['category'],
        map['date'], map['month']);
    // return Expanse.map(map['id'], map['causal'], map['amount'], map['data']);
  }
}
