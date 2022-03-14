import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/utilis.dart';

class DashboardItem extends StatelessWidget {
  final String text;
  final double percent;
  final int status;
  final int numValue;
  DashboardItem(
      {required this.text,
      required this.percent,
      required this.status,
      required this.numValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: relativeHeigth(heigth: 130, context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.text,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          status == 0
              ? CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  value: this.percent,
                )
              : Text(
                  "${this.numValue}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )
        ],
      ),
    );
  }
}
