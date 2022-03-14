import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:web_application/utilis.dart';

class TimerProvider extends ChangeNotifier {
  int secondsleft = WAITINGTIME;
  late Timer timer;
  static const oneSec = const Duration(seconds: 1);

  void restart() {
    this.secondsleft = WAITINGTIME;
  }

  void update() {
    this.secondsleft--;
    notifyListeners();
  }

  void start() async {
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (secondsleft == 0) {
          cancel();
        } else
          update();
      },
    );
  }

  void cancel() {
    try {
      timer.cancel();
    } catch (e) {}
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }
}
