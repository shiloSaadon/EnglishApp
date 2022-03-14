import 'package:flutter/material.dart';
import 'package:web_application/services/cache_controller.dart';
import 'package:web_application/widgets/dashboardFolder/charts_page.dart';

class ProgressProvider extends ChangeNotifier {
  int todayAmount = 0; //initial by loading from storage
  Map<String, List<dynamic>> daysData = {};

  List<SalesData> getProgressList() {
    List<SalesData> progressList = [];
    if (this.daysData.keys.contains("TODAY")) {
      progressList
          .add(SalesData(daysData["TODAY"]![0], daysData["TODAY"]![1] + 0.0));
    }
    if (this.daysData.keys.contains("B1")) {
      progressList.add(SalesData(daysData["B1"]![0], daysData["B1"]![1] + 0.0));
    }
    if (this.daysData.keys.contains("B2")) {
      progressList.add(SalesData(daysData["B2"]![0], daysData["B2"]![1] + 0.0));
    }
    if (this.daysData.keys.contains("B3")) {
      progressList.add(SalesData(daysData["B3"]![0], daysData["B3"]![1] + 0.0));
    }
    if (this.daysData.keys.contains("B4")) {
      progressList.add(SalesData(daysData["B4"]![0], daysData["B4"]![1] + 0.0));
    }
    return progressList;
  }

  void updateTodayWords(int amount) {
    print("assss");
    this.daysData["TODAY"]![1] += amount;
    Storage.writeSecureData("TODAY",
        "${this.daysData["TODAY"]![0]}##${this.daysData["TODAY"]![1]}");
    notifyListeners();
  }

  void updateDays(String key, List<dynamic> value) {
    print("value here is - ${value.toString()}");
    //value[1] += 0.0;
    //print("asssssss");
    daysData[key] = [value[0], double.parse(value[1])];
  }
}
