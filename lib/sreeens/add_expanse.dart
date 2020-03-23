import 'package:coins/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coins/models/expanse.dart';
import 'package:coins/widgets/date_picker.dart';
import 'package:coins/widgets/radio_button.dart';
import '../shared/util.dart';
import 'package:coins/models/user.dart';

class AddExpanse extends StatefulWidget {
  final Function addExpanse;

  AddExpanse(this.addExpanse);
  @override
  _AddExpanseState createState() => _AddExpanseState();
}

void _save(Expanse e) async {
  await DB.insert(Expanse.table, e);
  debugPrint('insert done');
  List<Map<String, dynamic>> _results = await DB.query(Expanse.table);
  var s = _results.map((item) => Expanse.fromMap(item)).toList();
  debugPrint(s.toString());
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
    Expanse e = new Expanse(causal,category,a, selectedDate,mFormatter.format(selectedDate));
    setState(() {
      // user.add(e, category);
      this.widget.addExpanse();
      _save(e);
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
    //         debugPrint(date.day.toString());
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
      style: TextStyle(fontSize: 40.0, color: textColor),
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
      padding: EdgeInsets.only(right: 16.0, left: 16.0),
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
                      icon: new Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
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
