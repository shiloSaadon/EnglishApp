import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_application/providers/timer_provider.dart';
import 'package:web_application/utilis.dart';

class TimerMonitor extends StatelessWidget {
  late TimerProvider tp;
  int correntSeconds = 0;
  @override
  Widget build(BuildContext context) {
    tp = context.watch<TimerProvider>();
    correntSeconds = tp.secondsleft;
    return Container(
        width: relativeWidth(width: 400, context: context),
        height: relativeHeigth(heigth: 120, context: context),
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "$correntSeconds",
          style: TextStyle(
              fontSize: 25,
              color: correntSeconds == 0 ? Colors.red : Colors.white),
        ));
  }
}
