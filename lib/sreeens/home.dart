import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testProject/widgets/add_expanse.dart';
import 'package:testProject/widgets/dashboard.dart';
import '../shared/util.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Widget _myAnimatedWidget;

  void addExpanse() {
    setState(() {
      _myAnimatedWidget = (_myAnimatedWidget.toString() == "Dash")
          ? AddExpanse(this.addExpanse)
          : Dash(this.addExpanse);
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _myAnimatedWidget = Dash(this.addExpanse);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: grad),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: new Center(
              child: Text(
            "Your expenses",
            textAlign: TextAlign.center,
          )),
        ),
        body:
            //     Stack(
            //   children: <Widget>[
            //     _myAnimatedWidget,

            //     SlidingUpPanel(
            //       panel:_myAnimatedWidget
            //       ,borderRadius	:BorderRadius.circular(40),
            //       boxShadow:null,
            //       // border: null
            //     )
            //   ],
            // )
            AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          //Enable this for ScaleTransition
          transitionBuilder: (Widget child, Animation<double> animation) {
            Animation<Offset> custom =
                Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0.0))
                    .animate(animation);
            return SlideTransition(
              child: child,
              position: custom,
            );
          },
          //   //Enable this for RotationTransition
          //   // transitionBuilder: (Widget child, Animation<double> animation) {
          //   //   return RotationTransition(
          //   //     child: child,
          //   //     turns: animation,
          //   //   );
          //   // },
          child: _myAnimatedWidget,
        ),
      ),
    );
  }
}

