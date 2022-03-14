import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/already_finish_words.dart';
import 'package:web_application/pages/practice_learning_ui.dart';
import 'package:web_application/providers/progress_provider.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:web_application/widgets/CustomBottonNavigationBar.dart';
import 'package:web_application/widgets/back_button.dart';
import 'package:web_application/widgets/english_card.dart';
import 'package:provider/provider.dart';
import 'package:web_application/widgets/learning_progress_indicator.dart';
import 'package:web_application/widgets/practice_progress_indicator.dart';
import 'package:web_application/widgets/regular_botton.dart';
import 'package:web_application/widgets/save_button.dart';
import '../utilis.dart';

// ignore: must_be_immutable
class LearningMode extends StatelessWidget {
  late WordsProvider wordsProvider;
  @override
  Widget build(BuildContext context) {
    wordsProvider = context.read<WordsProvider>();
    if (LoginInfo.name == "" || wordsProvider.allWordsData.length <= 0)
      Navigator.pop(context);
    print("learning length - ${wordsProvider.learningWords.length}");
    if (wordsProvider.learningWords.length == 0) {
      return AlreadyFinishWords(text: "You have learned all your words !!");
    }
    setupVars(context);
    return Scaffold(
        //bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: Colors.blue[900],
        body: PracticeLearningUi(
          updateData: () => updateData(context),
          goBack: () => goBack(context),
          savoData: () => saveData(context),
          nextWord: nextWord,
          progressIndicator: LearningProgressIndicator(),
        ));
  }

  void setupVars(BuildContext context) {
    wordsProvider = context.read<WordsProvider>();
    wordsProvider.wordsRating = {};
    wordsProvider.learningWordsIndex = 0;
    String stringWord =
        wordsProvider.learningWords[wordsProvider.learningWordsIndex];
    wordsProvider.currentWord = {
      stringWord: wordsProvider.allWordsData[stringWord] ?? []
    };
    setupValues();
  }

  void updateCurrentWord(BuildContext context) {
    if (min(11, wordsProvider.learningWords.length) >
        wordsProvider.learningWordsIndex) {
      String stringWord =
          wordsProvider.learningWords[wordsProvider.learningWordsIndex];
      wordsProvider.updateCurrentWord(
          {stringWord: wordsProvider.allWordsData[stringWord] ?? []});
      setupValues();
    } else {
      saveData(context);
    }
  }

  void setupValues() {
    wordsProvider.currentTranslation = false;
    wordsProvider.sentencesStatus = false;
    wordsProvider.imageStatus = false;
  }

  void saveWordRating(int rating) {
    String word = wordsProvider.learningWords[wordsProvider.learningWordsIndex];
    wordsProvider.wordsRating[word] = rating;
  }

  void nextWord(BuildContext context, int rate) {
    saveWordRating(rate);
    wordsProvider.learningWordsIndex++;
    updateCurrentWord(context);
  }

  void goBack(BuildContext context) {
    if (wordsProvider.learningWordsIndex > 0) {
      removeWordRating();
      print(wordsProvider.wordsRating);
      wordsProvider.learningWordsIndex--;
    }
    updateCurrentWord(context);
  }

  void removeWordRating() {
    String word = wordsProvider.currentWord.keys.first;
    wordsProvider.wordsRating.remove(word);
  }

  void updateData(BuildContext context) {
    wordsProvider.updateImageStatus();
    wordsProvider.updateTranslation();
    wordsProvider.updateSentencesStatus();
  }

  void removePassedLearningWords() {
    for (String key in wordsProvider.wordsRating.keys) {
      if (wordsProvider.wordsRating[key]! < 4) {
        wordsProvider.practiceWords.add(key);
      }
      wordsProvider.learningWords.remove(key);
    }
    wordsProvider.wordsRating = {};
  }

  void saveData(BuildContext context) async {
    var client = Client();
    print("words rating - ${wordsProvider.wordsRating}");
    bool response = await client.saveLearningWords(wordsProvider.wordsRating);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sussesfuly saved!"),
        duration: Duration(milliseconds: 800),
      ));
      removePassedLearningWords();
      Navigator.pop(context);
    }
  }
}
