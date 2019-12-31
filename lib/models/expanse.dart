class Expanse {
  final double amount;
  final String causal;
  final DateTime data;

  Expanse({this.amount, this.causal, this.data});
  Expanse createExpanse(){
    var thisInstant = new DateTime.now();
    return new Expanse(amount: 20,causal: "test",data:thisInstant);
  }
}
