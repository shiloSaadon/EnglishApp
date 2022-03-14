import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/pages/level_up_page.dart';
import 'package:web_application/pages/loading_page.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_application/services/cliesnt.dart';
import 'package:web_application/utilis.dart';
import 'package:web_application/widgets/back_button.dart';
import 'package:web_application/widgets/english_card.dart';
import 'package:web_application/widgets/progress_indicator.dart';
import 'package:web_application/widgets/save_button.dart';

// ignore: must_be_immutable
class FirstPage extends StatelessWidget {
  late WordsProvider wordsProvider;
  @override
  Widget build(BuildContext context) {
    wordsProvider = context.read<WordsProvider>();
    if (LoginInfo.name == "") {
      Navigator.pop(context);
      return Container();
    } else if (wordsProvider.wordsToPass.length <= 0) {
      return LevelUpPage();
    }
    startMode(context);
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: relativeHeigth(heigth: 1200, context: context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: relativeWidth(width: 780, context: context),
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      //margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(5, 7),
                              blurRadius: 10,
                              spreadRadius: -3,
                              color: Colors.grey,
                            ),
                          ],
                          //border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          )),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () => updateCard(context),
                              child: EnglishCard()),
                          MyProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ratingBottons(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: MyBackButton(onPressed: () => goBack(context))),
                    Spacer(),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: relativeWidth(width: 250, context: context),
                        child: SaveButton(
                          onPressed: () => saveData(context),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }

  Container ratingBottons(BuildContext context) {
    return Container(
      height: relativeHeigth(heigth: 200, context: context),
      width: relativeWidth(width: 700, context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          button(context, "Lose", "1"),
          button(context, "know", "3"),
        ],
      ),
    );
  }

  Container button(BuildContext context, String text, String score) {
    return Container(
      width: relativeWidth(width: 300, context: context),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Material(
          color: Colors.blue[900],
          child: InkWell(
            child: Container(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              alignment: Alignment.center,
            ),
            onTap: () => nextWord(context, score),
          ),
        ),
      ),
    );
  }

  void startMode(BuildContext context) {
    wordsProvider.wordsScore = {};
    wordsProvider.wordsToPassIndex = 0;
    String stringWord =
        wordsProvider.wordsToPass[wordsProvider.wordsToPassIndex];
    wordsProvider.currentWord = {
      stringWord: wordsProvider.allWordsData[stringWord] ?? []
    };
    setupValues();
  }

  void updateCard(BuildContext context) {
    updateSentencesStatus(context);
    updateTranslation(context);
  }

  void saveData(BuildContext context) async {
    var client = Client();
    //print("${wordsProvider.wordsScore}");
    bool response = await client.saveWords(wordsProvider.wordsScore, context);
    if (response) {
      removePassedWords();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sussesfuly saved!"),
        duration: Duration(milliseconds: 800),
      ));
      Navigator.pop(context);
    } else {
      print("errore save - pass the words");
    }
  }

  void updateCurrentWord(BuildContext context) {
    if (wordsProvider.wordsToPass.length > wordsProvider.wordsToPassIndex) {
      String stringWord =
          wordsProvider.wordsToPass[wordsProvider.wordsToPassIndex];
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
    wordsProvider.imageStatus = true;
  }

  void nextWord(BuildContext context, String score) {
    saveWordScore(score);
    wordsProvider.wordsToPassIndex += 1;
    updateCurrentWord(context);
  }

  void removePassedWords() {
    for (String key in wordsProvider.wordsScore.keys) {
      wordsProvider.wordsToPass.remove(key); // uaser already pass this word
      if (wordsProvider.wordsScore[key] == "1") {
        wordsProvider.learningWords.add(key); // user should learn this word
      } else {
        wordsProvider.allWordsData
            .remove(key); // user know this word - get rid of it
      }
    }
  }

  void goBack(BuildContext context) {
    if (wordsProvider.wordsToPassIndex > 0) {
      print("scores (before)- ${wordsProvider.wordsScore}");
      removeWordScore();
      print("scores (after)- ${wordsProvider.wordsScore}");
      wordsProvider.wordsToPassIndex--;
    }
    updateCurrentWord(context);
  }

  void saveWordScore(String score) {
    String word = wordsProvider.wordsToPass[wordsProvider.wordsToPassIndex];
    wordsProvider.wordsScore[word] = score;
  }

  void removeWordScore() {
    String word = wordsProvider.currentWord.keys.first;
    wordsProvider.wordsScore.remove(word);
  }

  void updateTranslation(BuildContext context) {
    wordsProvider.updateTranslation();
  }

  void updateSentencesStatus(BuildContext context) {
    wordsProvider.updateSentencesStatus();
  }
}
