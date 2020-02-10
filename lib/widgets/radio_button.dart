import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coins/shared/util.dart';

class CustomRadio extends StatefulWidget {
  Function callback;
  CustomRadio(this.callback);

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
    categoryList
        .forEach((element) => sampleData.add(new RadioModel(false, element)));
    // sampleData.add(new RadioModel(false, 'Food'));
    // sampleData.add(new RadioModel(false, 'Home'));

    // sampleData.add(new RadioModel(false, 'Transport'));
    // sampleData.add(new RadioModel(false, 'g'));

    // sampleData.add(new RadioModel(false, 'Transport'));
    // sampleData.add(new RadioModel(false, 'Shopping'));

    // sampleData.add(new RadioModel(false, 'Led'));
    // sampleData.add(new RadioModel(false, 'Other'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 264.0,
        width: 400,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sampleData.length ~/ 2,
          itemBuilder: (BuildContext context, int index) {
            int a = index * 2;
            int b = index * 2 + 1;
            return Column(
              children: <Widget>[
                new InkWell(
                  onTap: () {
                    setState(() {
                      sampleData
                          .forEach((element) => element.isSelected = false);
                      sampleData[a].isSelected = true;
                      widget.callback(a);
                    });
                  },
                  child:
                      //  Text("fds")
                      new RadioItem(sampleData[a]),
                ),
                new InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      sampleData
                          .forEach((element) => element.isSelected = false);
                      sampleData[b].isSelected = true;
                      widget.callback(b);
                    });
                  },
                  child:
                      //  Text("fds")
                      new RadioItem(sampleData[b]),
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
      height: 116,
      margin: EdgeInsets.all(8),
      // padding:  EdgeInsets.all(2),

      decoration: BoxDecoration(
        gradient: grad2,
        borderRadius: const BorderRadius.all(const Radius.circular(28.0)),
        boxShadow: [boxShadow],
        // borderRadius: new BorderRadius.all(...),
        // gradient: new LinearGradient(...),
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
        width: 116.0,
        child: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icons[_item.buttonText],
                color: _item.isSelected
                    ? Colors.white
                    : Theme.of(context).accentColor,
                size: 28.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: new Text(_item.buttonText,
                    style: new TextStyle(
                        color: _item.isSelected ? Colors.white : null,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0)),
              ),
            ],
          ),
        ),
        decoration: new BoxDecoration(
          color: _item.isSelected ? Colors.transparent : Colors.white,
          borderRadius: const BorderRadius.all(const Radius.circular(28.0)),
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}
