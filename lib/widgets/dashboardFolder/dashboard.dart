import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/widgets/dashboardFolder/dashboardListItems.dart';
import 'package:web_application/widgets/dashboardFolder/progress_info_page.dart';
import '../../utilis.dart';
import 'dashboard_pages.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final int CLOSE_HEIGTH = 200;
  final int OPEN_HEIGTH = 1450;
  late Widget CLOSE_WIDGET;
  late Widget OPEN_WIDGET;
  late Widget _child =
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Text(
        "Progress",
        style: TextStyle(
            fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    ),
    Icon(Icons.arrow_upward_outlined, color: Colors.black, size: 35)
  ]);
  int _heigth = 200;
  @override
  Widget build(BuildContext context) {
    setupWidgets();
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: GestureDetector(
        onTap: updateState,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AnimatedContainer(
              height: relativeHeigth(heigth: _heigth, context: context),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, -2),
                      blurRadius: 10,
                      spreadRadius: -3,
                      color: Colors.grey,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: AssetImage("assets/app_bar_background.jpg"),
                  // ),
                  ),
              alignment: Alignment.center,
              duration: Duration(milliseconds: 300),
              child: _child),
        ),
      ),
    );
  }

  void setupWidgets() {
    this.OPEN_WIDGET = DashboardPages();
    this.CLOSE_WIDGET =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Text(
          "Progress",
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      Icon(Icons.arrow_upward_outlined, color: Colors.black, size: 35)
    ]);
  }

  void updateState() {
    setState(() {
      if (_heigth == CLOSE_HEIGTH) {
        _heigth = OPEN_HEIGTH;
        _child = OPEN_WIDGET;
      } else {
        _heigth = CLOSE_HEIGTH;
        _child = CLOSE_WIDGET;
      }
    });
  }
}
