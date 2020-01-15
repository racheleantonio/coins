import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testProject/widgets/radio_button.dart';
import '../shared/util.dart';
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
  FocusNode _focusNode = FocusNode();
  String _value = '';
  DecimalNumberSubmitValidator submitValidator = DecimalNumberSubmitValidator();
  void _submit() async {
    bool valid = submitValidator.isValid(_value);
    if (valid) {
      _focusNode.unfocus();
      // widget.onSubmit(_value);
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void _incrementCounter() {
    setState(() {
      user.add(ex1, "Cinema");
      user.add(ex2, "Travel");
      this.widget.addExpanse();
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // counter += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool valid = submitValidator.isValid(_value);

    var button = new Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _incrementCounter(),
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

    return Container(
      padding: EdgeInsets.only(top: 60.0, right: 16.0, left: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36), topRight: Radius.circular(36))),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 60.0, right: 16.0, left: 16.0),
            child: TextField(
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
              autofocus: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                ValidatorInputFormatter(
                  editingValidator: DecimalNumberEditingRegexValidator(),
                ),
              ],
              focusNode: _focusNode,
              onChanged: (value) {
                setState(() => _value = value);
              },
              onEditingComplete: _submit,
            ),
          ),
        
                  CustomRadio(),
  new Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => _incrementCounter(),
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
          ),
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
