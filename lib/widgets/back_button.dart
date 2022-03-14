import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/utilis.dart';

class MyBackButton extends StatelessWidget {
  void Function()? onPressed;
  MyBackButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        width: relativeWidth(width: 100, context: context),
        height: relativeHeigth(heigth: 100, context: context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue[800],
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 7),
              blurRadius: 10,
              spreadRadius: -3,
              color: Colors.grey,
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
