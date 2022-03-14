import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/models/login_info.dart';
import 'package:web_application/providers/timer_provider.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/widgets/custom_botton.dart';
import 'package:provider/provider.dart';
import 'package:web_application/widgets/timer_monitor.dart';

import '../utilis.dart';

class SimpleHeToEn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SimpleHeToEnState();
}

class SimpleHeToEnState extends State<SimpleHeToEn> {
  bool initial = true;
  String timeOver = "";
  List<Color> colors = [Colors.white, Colors.white, Colors.white, Colors.white];
  List<String> words = [];
  Map<String, String> currentWord = {};
  int wordIndex = 0;
  late WordsProvider wp;
  late TimerProvider tp;
  List<Widget> options = [];
  @override
  Widget build(BuildContext context) {
    wp = context.read<WordsProvider>();
    tp = context.read<TimerProvider>();
    print("start len: ${wp.alreadyPassedWords.length}");
    if (LoginInfo.name == "" || wp.alreadyPassedWords.length == 0) {
      print("poping");
      Navigator.pop(context);
      return Container();
    } else if (initial) initializeVars();
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Stack(children: [
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
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: relativeWidth(width: 780, context: context),
              height: relativeHeigth(heigth: 1300, context: context),
              padding: EdgeInsets.only(top: 20),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TimerMonitor(),
                  Spacer(),
                  showCorrentWord(),
                  SizedBox(
                    height: 30,
                  ),
                  getOptions(),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                  onTap: nextWord,
                  child: Container(
                      width: relativeWidth(width: 160, context: context),
                      height: relativeHeigth(heigth: 120, context: context),
                      margin: EdgeInsets.only(
                          bottom:
                              relativeHeigth(heigth: 350, context: context)),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_forward, color: Colors.white))))
        ]));
  }

  void paintTheAnswer() {
    tp.cancel();
    tp.restart();
    tp.start();
  }

  Text showCorrentWord() {
    return Text(
      currentWord.values.first,
      style: TextStyle(fontSize: 30),
    );
  }

  void initializeVars() {
    colors = [Colors.white, Colors.white, Colors.white, Colors.white];
    //print("list:   ${wp.alreadyPassedWords}");
    String english = wp.alreadyPassedWords[wordIndex];
    //print("english:    $english");
    List<dynamic> value = wp.allWordsData[english] ?? [];
    this.currentWord = {english: value[0]};
    getRandomWords();
  }

  void nextWord() {
    this.wordIndex++;
    if (this.wordIndex < wp.alreadyPassedWords.length) {
      initializeVars();
      paintTheAnswer();
      setState(() {});
    } else {
      Navigator.pop(context);
    }
  }

  void getRandomWords() {
    var rng = new Random();
    words = [currentWord.keys.first];
    for (var i = 0; i < 3; i++) {
      List<String> keywords = wp.allWordsData.keys.toList();
      int index = rng.nextInt(keywords.length);
      words.add(keywords[index]);
      words.shuffle();
    }
  }

  void updateColor(int i) {
    Color colorToChangeFor;
    if (words[i] == currentWord.keys.first)
      colorToChangeFor = Colors.green;
    else
      colorToChangeFor = Colors.red;
    setState(() {
      initial = false;
      colors[i] = colorToChangeFor;
    });
  }

  Padding getOptions() {
    options = [];
    for (int i = 0; i < words.length; i++) {
      options.add(Container(
        margin: EdgeInsets.only(bottom: 20),
        child: GestureDetector(
            onTap: () => updateColor(i),
            child: CustomBotton(
              color: colors[i],
              answer: currentWord.values.first,
              text: words[i],
            )),
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: options,
      ),
    );
  }
}
