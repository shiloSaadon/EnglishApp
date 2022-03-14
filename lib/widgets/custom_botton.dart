import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utilis.dart';

class CustomBotton extends StatelessWidget {
  final color;
  final answer;
  final text;
  double fontSize;
  CustomBotton({
    required this.text,
    required this.answer,
    required this.color,
    this.fontSize = 20,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: relativeWidth(width: 500, context: context),
        height: relativeHeigth(heigth: 150, context: context),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: this.color,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Text(
          this.text,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
        ));
  }
}
