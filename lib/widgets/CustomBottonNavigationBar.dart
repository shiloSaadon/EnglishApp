import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/utilis.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[900], borderRadius: BorderRadius.circular(40)),
        //padding: EdgeInsets.only(top: 50),
        child: Icon(Icons.arrow_back),
        height: relativeHeigth(heigth: 120, context: context),
      ),
    );
  }
}
