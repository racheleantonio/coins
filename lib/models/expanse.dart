import 'package:coins/models/model.dart';
import 'package:flutter/widgets.dart';

class Expanse extends Model {
  static String table = 'expanse_items';

  // int id;
  double amount;
  String causal;
  DateTime date;
  // static int counter = 0;
  Expanse(this.amount, this.causal, this.date);
  Expanse.map(
    // int id,
    double amount,
    String causal,
    String date,
  ) {
    // this.id = id;
    this.amount = amount;
    this.causal = causal;
    this.date = new DateTime.now();
  }
  Expanse createExpanse() {
    var thisInstant = new DateTime.now();
    return new Expanse(20, "testo", thisInstant);
  }

  @override
  String toString() {
    return this.id.toString()+':'+this.causal.toString()+':'+this.date.toString();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    // map['id'] = id;
    map['amount'] = amount;
    map['causal'] = causal;
    map['date'] = 'data';
    return map;
  }
  // await db.execute('CREATE TABLE todo_items (id INTEGER PRIMARY KEY NOT NULL, amount REAL, causal TEXT, date TEXT');

  // Extract a Note object from a Map object
  static Expanse fromMap(Map<String, dynamic> map) {
    debugPrint('Extract from map'+map['id'].toString()+''+map['amount'].toString()+''+map['date'].toString());
    return new Expanse.map(map['amount'],map['causal'], 'data');
    // return Expanse.map(map['id'], map['causal'], map['amount'], map['data']);
  }
}
