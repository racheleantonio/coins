import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testProject/widgets/category_list.dart';
import 'package:testProject/widgets/chart.dart';
import '../shared/util.dart';
import '../widgets/month_selector.dart';
import 'package:testProject/models/user.dart';

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
            Animation<Offset> custom=Tween<Offset>(begin: Offset(0,1),end:Offset(0,0.0)).animate(animation);
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

class Dash extends StatefulWidget {
  final Function addExpanse;

  Dash(this.addExpanse);
  @override
  _DashState createState() => _DashState();
}

final controller = PageController(initialPage: user.selectedMonth);

class _DashState extends State<Dash> {
  void _incrementCounter() {
    setState(() {
      user.add(ex1, "Cinema");
      user.add(ex2, "Travel");
      this.widget.addExpanse();
    });
  }

  void _onPageViewChange(int page) {
    setState(() {
      user.selectedMonth = page;
      print(page);
    });
  }

  void changePage(int page) {
    setState(() {
      user.selectedMonth = page;
      controller.animateToPage(page,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    var button = new Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _incrementCounter(),
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
    );
    return Container(
      child: Column(
        children: <Widget>[
          MonthSelector(this.changePage),
          Expanded(
            child: Container(
              child: PageView(
                  controller: controller,
                  onPageChanged: _onPageViewChange,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Page(),
                    Page(),
                    Page(),
                  ]),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36))),
            ),
          ),
          button
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var total = new Text(
      user.month[user.selectedMonth].total.toStringAsFixed(2) +
          '€' +
          user.selectedMonth.toString(),
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      textAlign: TextAlign.center,
    );
    var average = new Text(
      'Montly Average\n' + "TODO".toString() + '€',
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
      textAlign: TextAlign.center,
    );
    var inner = new ListView(
      children: <Widget>[
        total,
        average,
      ],
    );
    var chart = HomePage();

    var recap = new Container(
        height: 250,
        width: 250,
        child: new Stack(children: <Widget>[chart, Center(child: total)]));
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 16.0, left: 16.0),
      child: Column(
        children: <Widget>[
          recap,
          // Expanded(child: recap),
          CategoryList(),
          // button,
        ],
      ),
    );
  }
}

class AddExpanse extends StatefulWidget {
  final Function addExpanse;

  AddExpanse(this.addExpanse);
  @override
  _AddExpanseState createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
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
    var button = new Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _incrementCounter(),
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
    );

    return
        // button;
        Column(
      children: <Widget>[
        Expanded(
          child: Container(
            // child: button,
            // PageView(
            //     controller: controller,
            //     onPageChanged: _onPageViewChange,
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Page(),
            //       Page(),
            //       Page(),
            //     ]),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36))),
          ),
        ),
        button
      ],
    );
    // return Expanded(
    //   child: Container(
    //     child: Column(
    //       children: <Widget>[],
    //     ),
    //     decoration: BoxDecoration(
    //         color: Colors.lightBlue,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(40), topRight: Radius.circular(40))),
    //   ),
    // );
  }
}
