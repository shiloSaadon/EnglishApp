import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/utilis.dart';
import 'package:web_application/widgets/dashboardFolder/charts_page.dart';
import 'package:web_application/widgets/dashboardFolder/progress_info_page.dart';

class DashboardPages extends StatefulWidget {
  final List<Widget> pages = [ProgresssInfoPage(), ChartsPage()];
  @override
  _DashboardPagesState createState() => _DashboardPagesState();
}

class _DashboardPagesState extends State<DashboardPages> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      this.widget.pages[currentPage],
      ConvexAppBar(
        height: relativeHeigth(heigth: 150, context: context),
        backgroundColor: Colors.blue[800],
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.list),
          //TabItem(icon: Icons.info),
          TabItem(icon: Icons.assessment),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => updateScreen(i),
      ),
    ]);
  }

  void updateScreen(int i) {
    setState(() {
      this.currentPage = i;
    });
  }
}
