
import 'package:flutter/widgets.dart';

class Expanse {
  final double amount;
  final String causal;
  final DateTime data;

  Expanse({@required this.amount, @required this.causal, @required this.data});
  Expanse createExpanse(){
    var thisInstant = new DateTime.now();
    return new Expanse(amount: 20,causal: "test",data:thisInstant);
  }
}
