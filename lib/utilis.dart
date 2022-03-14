import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/cache_controller.dart';
import 'package:web_application/services/cliesnt.dart';

import 'models/Datest.dart';
import 'models/login_info.dart';
import 'models/user_info.dart';

String defultRout = "/home_page";
int WAITINGTIME = 3;
double initialScreenHeigth = 1792; // heigth in ui screen
double initialScreenWidth = 828; // width in ui screen
const int USER_MAX_LEVEL = 7;
const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);
const mainColor = Color(0xff2470c7);

double relativeWidth({required int width, required BuildContext context}) {
  double currentWidth = MediaQuery.of(context).size.width;
  double initialRelative = width / initialScreenWidth;
  return currentWidth * initialRelative;
}

Future<void> saveCerdetional() async {
  await Storage.writeSecureData("mane", LoginInfo.name);
  await Storage.writeSecureData("password", LoginInfo.password);
}

double relativeHeigth({required int heigth, required BuildContext context}) {
  double currentHeigth = MediaQuery.of(context).size.height;
  //print("currentHeigth: $currentHeigth");
  double initialRelative = heigth / initialScreenHeigth;
  //print("a: $heigth / $initialScreenHeigth = initialRelative: $initialRelative");
  return currentHeigth * initialRelative;
}

BoxDecoration background() {
  return BoxDecoration(color: Colors.blue[800]
      //     image: DecorationImage(
      //   fit: BoxFit.cover,
      //   image: AssetImage("assets/app_bar_background.jpg"),
      // )
      );
}
