import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testProject/shared/util.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'Food', 'April 18'));
    sampleData.add(new RadioModel(false, 'Home', 'April 17'));

    sampleData.add(new RadioModel(false, 'Transport', 'April 16'));
    sampleData.add(new RadioModel(false, 'g', 'April 16'));

    sampleData.add(new RadioModel(false, 'Transport', 'April 16'));
    sampleData.add(new RadioModel(false, 'Shopping', 'April 15'));

    sampleData.add(new RadioModel(false, 'Led', 'April 15'));
        sampleData.add(new RadioModel(false, 'Other', 'April 15'));

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sampleData.length,
          itemBuilder: (BuildContext context, int index) {
            return 
            Column(
              children: <Widget>[
                new InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      sampleData.forEach((element) => element.isSelected = false);
                      sampleData[index].isSelected = true;
                    });
                  },
                  child:
                      //  Text("fds")
                      new RadioItem(sampleData[index]),
                ),
                                new InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      sampleData.forEach((element) => element.isSelected = false);
                      sampleData[index].isSelected = true;
                    });
                  },
                  child:
                      //  Text("fds")
                      new RadioItem(sampleData[index]),
                ),
              ],
            );
          },
        ));
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(8),
       padding: _item.isSelected ?EdgeInsets.all(4):EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: grad2,
        borderRadius: const BorderRadius.all(const Radius.circular(36.0)),
      ),
      // height: 100.0,
      // width: 100.0,
            // padding: const EdgeInsets.all(16.0),

      // padding: _item.isSelected ? new EdgeInsets.all(0): new EdgeInsets.all(15.0),
      // child: new Row(
      //   // mainAxisSize: MainAxisSize.max,
      //   children: <Widget>[
      child: new Container(
        height: 50.0,
        width: 150.0,

        child: new Center(
          child: new Text(_item.buttonText,
              style: new TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: 18.0)),
        ),
        decoration: new BoxDecoration(
          color: _item.isSelected ? Colors.white : Colors.grey[200],
          border: new Border.all(
              width : 1,
              color: Colors.transparent
              ),
          borderRadius: const BorderRadius.all(const Radius.circular(32.0)),
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}
