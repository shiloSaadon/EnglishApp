import 'package:flutter/material.dart';

class WordsProvider extends ChangeNotifier {
  // server data
  Map<String, List<dynamic>> allWordsData = {}; // the server databse
  List<String> wordsToPass = []; // pass the words
  List<String> learningWords = []; // learning mode
  List<String> practiceWords = []; // practice mode
  List<String> alreadyPassedWords = []; // playground mode
  // results
  Map<String, String> wordsScore = {}; // save "pass the words" mode
  Map<String, int> wordsRating = {}; // save "practice" and "learning mode"
  Map<String, List<dynamic>> currentWord =
      {}; // save the current word in each mode
  // values for ui
  bool currentTranslation = false;
  bool sentencesStatus = false;
  bool imageStatus = true;
  // the lists indexes
  int wordsToPassIndex = 0;
  int practiceWordsIndex = 0;
  int learningWordsIndex = 0;

  void setup() {
    // clean chach - in case the user logout and login from another user
    allWordsData = {};
    wordsToPass = [];
    learningWords = [];
    practiceWords = [];
    alreadyPassedWords = [];
  }

  void updateTranslation() {
    this.currentTranslation = !this.currentTranslation;
    notifyListeners();
  }

  void updateSentencesStatus() {
    sentencesStatus = !sentencesStatus;
    notifyListeners();
  }

  void updateImageStatus() {
    imageStatus = !imageStatus;
  }

  void updateCurrentWord(Map<String, List<dynamic>> currentWord) {
    this.currentWord = currentWord;
    notifyListeners();
  }
}
