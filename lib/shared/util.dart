import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


final List<String> categoryList = [
  "Food",
  "Travel",
  "Cinema",
  "Transport",
  "Home",
  "Shopping"
];
final Map<String, IconData> icons = {
  "Food": Icons.fastfood,
  "Transport": Icons.train,
  "Travel": Icons.flight,
  "Cinema": Icons.movie,
  "Home": Icons.home,
  "Shopping": Icons.shopping_basket
};
LinearGradient grad =
    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
        // colors: <Color>[Colors.purple, Colors.indigo]);
        colors: <Color>[Color(0xff3957F2), Color(0xff2C45BF)]);
LinearGradient grad2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.topRight,
    colors: <Color>[Color(0xff3957F2), Color(0xff2C45BF)]);
// colors: <Color>[Colors.purple, Colors.indigo]);

Color textColor = Colors.black87;
Color greyColor = Colors.grey[600];
// List<Color> colors = [
//   Color(0xff9c27b0),
//   Color(0xff6c44b8),
//   Color(0xff6c44b8),
//   Color(0xff524db7),
//   Color(0xff3f51b5),
//   Color(0xff524db7),
//   Color(0xff6c44b8),
//   Color(0xff6c44b8),
// ];


List<Color> colors = [
    Color(0xff889af7),
  Color(0xff6078f4),
  Color(0xff3957f2),
  Color(0xff2d45c1),
  Color(0xff273ca9),
  Color(0xff2d45c1),
  Color(0xff3957f2),
  Color(0xff6078f4),
];



double borderRadius16 = 16;
double borderRadius28 = 28;
double fontSize24 = 24;
double fontSize20 = 20;
double fontSize18 = 18;

int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  return _daysInMonth[month - 1];
}

const List<int> _daysInMonth = <int>[
  31,
  -1,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31,
];

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey[200],
  blurRadius: 4.0, // has the effect of softening the shadow
  spreadRadius: 4.0, // has the effect of extending the shadow
  // offset: Offset(
  //   4, // horizontal, move right 10
  //   4, // vertical, move down 10
  // ),
);
DateFormat formatter = new DateFormat('dd-MM-yyyy');



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


