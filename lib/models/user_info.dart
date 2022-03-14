import 'package:flutter/cupertino.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';

class UserInfo {
  //initial by server
  static int userLevel = 0;
  static String userName = "Shilo"; // user private name
  static int totalWords = 3000; // user total words by level
  static int shouldLearn = 0; // words the user painted as "lose"
  static int neverLearned = 0; // words the user didn't see in "learning mode"
  static int startedPractice =
      0; // words the user see at least one time in "learning mode"
  static int learnedPerfectly = 0; // words by record higher than 5
  // change by using tha application
  late int leftToPass;
  late int alreadyPassed;
  late int youKnew;

  UserInfo(BuildContext context) {
    this.leftToPass = context.watch<WordsProvider>().wordsToPass.length;
    this.alreadyPassed =
        totalWords - context.watch<WordsProvider>().wordsToPass.length;
    this.youKnew =
        totalWords - context.watch<WordsProvider>().allWordsData.length;
  }
  static bool setup(Map<String, dynamic> userInfo) {
    if (userInfo.isEmpty) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      return false;
    } else {
      userName = userInfo["privateName"];
      totalWords = userInfo["totalAmountWords"];
      shouldLearn = userInfo["shouldLearn"];
      neverLearned = userInfo["neverLearned"];
      startedPractice = userInfo["startedPractice"];
      learnedPerfectly = userInfo["learnedPerfectly"];
      userLevel = userInfo["userLevel"];
      return true;
    }
  }

  static initialVars() {
    userName = "";
    totalWords = 3000;
    shouldLearn = 0;
    neverLearned = 0;
    startedPractice = 0;
    learnedPerfectly = 0;
    userLevel = 0;
  }
}
