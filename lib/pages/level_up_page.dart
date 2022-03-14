import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/home_page.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:provider/provider.dart';
import 'package:web_application/widgets/level_up_botton.dart';
import '../utilis.dart';

class LevelUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (LoginInfo.name == "") Navigator.pop(context);
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: relativeHeigth(heigth: 1200, context: context),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            width: relativeWidth(width: 780, context: context),
            height: relativeHeigth(heigth: 1700, context: context),
            padding: EdgeInsets.only(top: 20, bottom: 10),
            //margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 7),
                    blurRadius: 10,
                    spreadRadius: -3,
                    color: Colors.grey,
                  ),
                ],
                //border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You already passed all your words",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: LevelUpBotton())
              ],
            ),
          ),
        ),
        //Align(alignment: Alignment.bottomCenter, child: backSaveBar(context)),
      ]),
    );
  }
}
