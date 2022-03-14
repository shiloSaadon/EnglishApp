import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utilis.dart';

// ignore: must_be_immutable
class RegularBotton extends StatelessWidget {
  final width;
  final height;
  final text;
  final VoidCallback? onPressed;
  double fontSize;
  RegularBotton(
      {required this.width,
      required this.height,
      required this.text,
      required this.onPressed,
      this.fontSize = 20});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: relativeWidth(width: this.width, context: context),
      height: relativeHeigth(heigth: this.height, context: context),
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          )),
    );
  }
}
