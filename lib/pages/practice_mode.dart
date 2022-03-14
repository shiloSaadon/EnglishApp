import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/already_finish_words.dart';
import 'package:web_application/pages/practice_learning_ui.dart';
import 'package:web_application/providers/progress_provider.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:provider/provider.dart';
import 'package:web_application/widgets/practice_progress_indicator.dart';
import 'package:web_application/widgets/regular_botton.dart';
import '../utilis.dart';

// ignore: must_be_immutable
class PracticeMode extends StatelessWidget {
  late WordsProvider wordsProvider;
  @override
  Widget build(BuildContext context) {
    wordsProvider = context.read<WordsProvider>();
    if (LoginInfo.name == "" || wordsProvider.allWordsData.length <= 0)
      Navigator.pop(context);
    print("practiceWords length - ${wordsProvider.practiceWords.length}");
    if (wordsProvider.practiceWords.length == 0) {
      return AlreadyFinishWords(text: "You already finish practice everyting");
    }
    setupVars(context);
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: PracticeLearningUi(
          updateData: () => updateData(context),
          goBack: () => goBack(context),
          savoData: () => saveData(context),
          nextWord: nextWord,
          progressIndicator: PracticeProgressIndicator(),
        ));
  }

  void setupVars(BuildContext context) {
    wordsProvider.wordsRating = {};
    wordsProvider.practiceWordsIndex = 0;
    wordsProvider.practiceWords.shuffle();
    String stringWord =
        wordsProvider.practiceWords[wordsProvider.practiceWordsIndex];
    wordsProvider.currentWord = {
      stringWord: wordsProvider.allWordsData[stringWord] ?? []
    };
    setupValues();
  }

  void updateCurrentWord(BuildContext context) {
    if (wordsProvider.practiceWords.length > wordsProvider.practiceWordsIndex) {
      String stringWord =
          wordsProvider.practiceWords[wordsProvider.practiceWordsIndex];
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
    String word = wordsProvider.practiceWords[wordsProvider.practiceWordsIndex];
    wordsProvider.wordsRating[word] = rating;
  }

  void nextWord(BuildContext context, int rate) {
    saveWordRating(rate);
    wordsProvider.practiceWordsIndex++;
    updateCurrentWord(context);
  }

  void goBack(BuildContext context) {
    if (wordsProvider.practiceWordsIndex > 0) {
      removeWordRating();
      print(wordsProvider.wordsRating);
      wordsProvider.practiceWordsIndex--;
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

  void removePassedPracticeWords() {
    for (String key in wordsProvider.wordsRating.keys) {
      print("qqqqqqqqq: ${wordsProvider.wordsRating[key]}");
      if (wordsProvider.wordsRating[key]! >= 4) {
        wordsProvider.practiceWords.remove(key);
      }
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
      context
          .read<ProgressProvider>()
          .updateTodayWords(wordsProvider.practiceWordsIndex);
      Navigator.pop(context);
      removePassedPracticeWords();
    }
  }
}
