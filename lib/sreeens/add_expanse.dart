import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testProject/models/expanse.dart';
import 'package:testProject/widgets/date_picker.dart';
import 'package:testProject/widgets/radio_button.dart';
import '../shared/util.dart';
// import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:testProject/models/user.dart';

class DecimalNumberEditingRegexValidator extends RegexValidator {
  DecimalNumberEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$");
}

class DecimalNumberSubmitValidator implements StringValidator {
  @override
  bool isValid(String value) {
    try {
      final number = double.parse(value);
      return number > 0.0;
    } catch (e) {
      return false;
    }
  }
}

class AddExpanse extends StatefulWidget {
  final Function addExpanse;

  AddExpanse(this.addExpanse);
  @override
  _AddExpanseState createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  final myController = TextEditingController();
  String amount = '';
  String causal = '';
  DateTime selectedDate = DateTime.now();
  String category = '';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showRoundedDatePicker(
      context: context,
      firstDate: DateTime(selectedDate.year, selectedDate.month, 1),
      lastDate: DateTime(selectedDate.year, selectedDate.month, 31),
      // background: Colors.white,
      theme: ThemeData(
        fontFamily: "Gotham",
      ),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // FocusNode _focusNode = FocusNode();
  DecimalNumberSubmitValidator submitValidator = DecimalNumberSubmitValidator();
  // void _submit() async {
  //   bool valid = submitValidator.isValid(amount);
  //   if (valid) {
  //     _focusNode.unfocus();
  //     // widget.onSubmit(amount);
  //   } else {
  //     FocusScope.of(context).requestFocus(_focusNode);
  //   }
  // }

  void _incrementCounter() {
    double a = double.tryParse(amount);
    Expanse e = new Expanse(amount: a, causal: causal, data: selectedDate);
    setState(() {
      user.add(e, category);
      print("Category: " +
          category +
          ", Amount: " +
          amount.toString() +
          " ,Causal" +
          causal.toString() +
          " ,Data" +
          selectedDate.toString());
      // user.add(ex2, "Travel");
      // user.add(ex1, "Food");
      // user.add(ex2, "Travel");
      // user.add(ex3, "Travel");
      this.widget.addExpanse();
    });
  }

  bool checkInput() {
    return causal != '' && category != '' && submitValidator.isValid(amount);
  }

  void changeCategory(index) {
    setState(() {
      category = categoryList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool valid = submitValidator.isValid(amount);
    bool valid = checkInput();
    // var dataPicker =
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     DatePickerTimeline(
    //       DateTime.now(),
    //       onDateChange: (date) {
    //         // New date selected
    //         print(date.day.toString());
    //       },
    //     ),
    //   ],
    // );
    var causalTextField = new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Causal',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (value) {
          setState(() => causal = value);
        }
        // validator: FormValidator().validateEmail,
        // onSaved: (String value) {
        //   _loginData.email = value;
        // },
        );
    var createButton = new Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: () => !checkInput() ? null : _incrementCounter(),
        child: Opacity(
          opacity: valid ? 1.0 : 0.5,
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              gradient: grad,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                'ADD EXPANSE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );

    TextField amountTextField = TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '\€0.00',
        // prefix: Text('\€'),
        // prefixStyle:  TextAlign.center,
      ),
      //  InputDecoration.collapsed(hintText: '\€0.00'),
      style: TextStyle(fontSize: 40.0, color: Colors.black87),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      // autofocus: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        ValidatorInputFormatter(
          editingValidator: DecimalNumberEditingRegexValidator(),
        ),
      ],
      // focusNode: _focusNode,
      onChanged: (value) {
        setState(() => amount = value);
      },
      // onEditingComplete: _submit,
    );
    return Container(
      padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36), topRight: Radius.circular(36))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
                // mainAxisSize: MainAxisSize.min,

                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                      color: Colors.red,
                      icon: new Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onPressed: () => {this.widget.addExpanse()},
                    ),
                  ),
                  amountTextField,
                  CustomRadio(changeCategory),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                    onPressed: () => _selectDate(context),
                    child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                    // Text('Select date'),
                  ),
                  causalTextField
                ]),
          ),
          createButton,
        ],
      ),
    );
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({this.editingValidator});
  final StringValidator editingValidator;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = editingValidator.isValid(oldValue.text);
    final newValueValid = editingValidator.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({this.regexSource});
  final String regexSource;

  /// value: the input string
  /// returns: true if the input string is a full match for regexSource
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}
