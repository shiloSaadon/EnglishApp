import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/widgets/regular_botton.dart';
import '../utilis.dart';

class AlreadyFinishWords extends StatelessWidget {
  final String text;
  AlreadyFinishWords({required this.text});
  @override
  Widget build(BuildContext context) {
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
            //height: relativeHeigth(heigth: 1700, context: context),
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
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        //Align(alignment: Alignment.bottomCenter, child: backSaveBar(context)),
      ]),
    );
  }
}
