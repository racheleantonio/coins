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
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sampleData.length ~/ 2,
          itemBuilder: (BuildContext context, int index) {
            int a = index * 2;
            int b = index * 2 + 1;
            return Column(
              children: <Widget>[
                new InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      sampleData
                          .forEach((element) => element.isSelected = false);
                      sampleData[a].isSelected = true;
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
        // color: Colors.grey,
        gradient: grad2,
        borderRadius: const BorderRadius.all(const Radius.circular(28.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 4.0, // has the effect of softening the shadow
            spreadRadius: 4.0, // has the effect of extending the shadow
            // offset: Offset(
            //   4, // horizontal, move right 10
            //   4, // vertical, move down 10
            // ),
          )
        ],
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
                color: _item.isSelected ? Colors.white : Colors.purple,
                size: 28.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: new Text(_item.buttonText,
                    style: new TextStyle(
                        color: _item.isSelected ? Colors.white : Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0)),
              ),
            ],
          ),
        ),
        decoration: new BoxDecoration(
          color: _item.isSelected ? Colors.transparent : Colors.white,
          // border: _item.isSelected?null:new Border.all(width: 1, color: Colors.grey[400]),
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
