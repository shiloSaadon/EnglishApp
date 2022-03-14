import 'package:flutter/cupertino.dart';
import 'package:web_application/models/user_info.dart';
import 'package:web_application/providers/words_provider.dart';
import 'dashboardItem.dart';
import 'package:provider/provider.dart';

class DashboardListItems extends StatefulWidget {
  @override
  _DashboardListItemsState createState() => _DashboardListItemsState();
}

class _DashboardListItemsState extends State<DashboardListItems> {
  int status = 0;
  late UserInfo ui;
  @override
  Widget build(BuildContext context) {
    ui = UserInfo(context);
    return GestureDetector(
      onTap: updateIndicate,
      child: Column(
        children: [
          Center(
            child: Text(
              "Total words",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            child: Text(
              UserInfo.totalWords.toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
          DashboardItem(
            text: "Left to pass",
            percent: getPrecentage(
                UserInfo.totalWords - ui.leftToPass, UserInfo.totalWords),
            numValue: ui.leftToPass,
            status: this.status,
          ),
          DashboardItem(
            text: "Already pass",
            percent: getPrecentage(ui.alreadyPassed, UserInfo.totalWords),
            numValue: ui.alreadyPassed,
            status: this.status,
          ),
          DashboardItem(
            text: "You knew",
            percent: getPrecentage(ui.youKnew, UserInfo.totalWords),
            numValue: ui.youKnew,
            status: this.status,
          ),
          DashboardItem(
            text: "Should learn",
            percent: getPrecentage(UserInfo.shouldLearn, ui.alreadyPassed),
            numValue: UserInfo.shouldLearn,
            status: this.status,
          ),
          SizedBox(
            height: 30,
          ),
          DashboardItem(
            text: "Started practice",
            percent:
                getPrecentage(UserInfo.startedPractice, UserInfo.shouldLearn),
            numValue: UserInfo.startedPractice,
            status: this.status,
          ),
          DashboardItem(
            text: "Never learned",
            percent: getPrecentage(UserInfo.neverLearned, UserInfo.shouldLearn),
            numValue: UserInfo.neverLearned,
            status: this.status,
          ),
          DashboardItem(
            text: "Learned perfectly",
            percent:
                getPrecentage(UserInfo.learnedPerfectly, UserInfo.shouldLearn),
            numValue: UserInfo.learnedPerfectly,
            status: this.status,
          ),
        ],
      ),
    );
  }

  double getPrecentage(int part, int whole) {
    if (whole == 0) return 1;
    return (0.0 + part) / whole;
  }

  void updateIndicate() {
    setState(() {
      if (status == 0)
        status = 1;
      else
        status = 0;
    });
  }
}
