import 'package:flutter/cupertino.dart';
import 'package:web_application/widgets/dashboardFolder/dashboardListItems.dart';

class ProgresssInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        //height: relativeHeigth(heigth: 700, context: context),
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: DashboardListItems());
  }
}
