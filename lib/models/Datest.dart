import 'package:flutter/cupertino.dart';
import 'package:web_application/providers/progress_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:web_application/services/cache_controller.dart';

class Dates {
  static Future<void> updateDays(BuildContext context) async {
    String lastDate = await Storage.readSecureData("lastDate");
    DateTime date = DateTime.now();
    String dayName = DateFormat('EEEE').format(date).substring(1, 4);
    ProgressProvider pv = context.read<ProgressProvider>();
    print("last date: $lastDate");
    if (lastDate == "") {
      print("1");
      // first time
      pv.daysData["TODAY"] = [dayName, 0];
      await Storage.writeSecureData("TODAY", "$dayName##0");
      await Storage.writeSecureData("lastDate", getDate());
    } else if (lastDate == getDate()) {
      print("2");
      List<String> days = ["TODAY", "B1", "B2", "B3", "B4"];
      for (String key in days) {
        String dayData = await Storage.readSecureData(key);
        if (dayData != "") {
          List<dynamic> value = dayData.split("##");
          pv.updateDays(key, value);
        }
      }
    } else {
      print("3");
      // day passed need to update the storage
      List<String> days = ["TODAY", "B1", "B2", "B3", "B4"];
      for (int i = 0; i < days.length - 1; i++) {
        String dayData = await Storage.readSecureData(days[i]);
        if (dayData != "") {
          List<dynamic> value = dayData.split("##");
          print("value is -${value[1]}-");
          String a = "1";
          print("aaaaaaaaaaaaaaa        ${1 + int.parse(a)}");
          pv.updateDays(days[i + 1], value);
        }
      }
      pv.daysData["TODAY"] = [dayName, 0];
      await Storage.writeSecureData("TODAY", "$dayName##0");
      await Storage.writeSecureData("lastDate", getDate());
    }
  }

  static String getDate() {
    // return "YY-MM-DD" date
    DateTime date = DateTime.now();
    String dayName = DateFormat('yy-mm-dd').format(date);
    return dayName;
  }
}
