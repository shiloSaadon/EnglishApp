import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/widgets/back_button.dart';
import 'package:web_application/widgets/english_card.dart';
import 'package:web_application/widgets/practice_progress_indicator.dart';
import 'package:web_application/widgets/save_button.dart';
import '../utilis.dart';

// ignore: must_be_immutable
class PracticeLearningUi extends StatelessWidget {
  final void Function()? updateData;
  final void Function()? goBack;
  final void Function()? savoData;
  final void Function(BuildContext, int) nextWord;
  final Widget progressIndicator;
  late WordsProvider wordsProvider;
  PracticeLearningUi(
      {required this.updateData,
      required this.goBack,
      required this.savoData,
      required this.nextWord,
      required this.progressIndicator});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: relativeHeigth(heigth: 1200, context: context),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          width: relativeWidth(width: 780, context: context),
          height: relativeHeigth(heigth: 1700, context: context),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: learningWidget(context),
          ),
        ),
      ),
      Align(alignment: Alignment.bottomCenter, child: backSaveBar(context)),
    ]);
  }

  List<Widget> learningWidget(BuildContext context) {
    return [
      GestureDetector(onTap: updateData, child: EnglishCard()),
      this.progressIndicator,
      Spacer(),
      Container(
          margin: EdgeInsets.only(left: 20, bottom: 10),
          alignment: Alignment.center,
          child: Text("Answered correctly:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
      goodAnswer(context),
      Container(
        margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
        alignment: Alignment.center,
        child: Text(
          "Answered incorrectly:",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      badAnswer(context),
      Spacer()
    ];
  }

  Container backSaveBar(BuildContext context) {
    return Container(
      height: relativeHeigth(heigth: 140, context: context),
      width: relativeWidth(width: 880, context: context),
      padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          MyBackButton(onPressed: goBack),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: relativeWidth(width: 250, context: context),
              child: SaveButton(
                onPressed: savoData,
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector myBtn(String text, VoidCallback? func, BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: relativeWidth(width: 220, context: context),
        height: relativeHeigth(heigth: 130, context: context),
        child: Text(
          text,
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            )),
      ),
    );
  }

  Padding goodAnswer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: relativeWidth(width: 810, context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myBtn("good", () => nextWord(context, 4), context),
            myBtn("hard", () => nextWord(context, 3), context),
          ],
        ),
      ),
    );
  }

  Padding badAnswer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: relativeWidth(width: 810, context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myBtn("oops", () => nextWord(context, 2), context),
            myBtn("hard", () => nextWord(context, 1), context),
            myBtn("blackout", () => nextWord(context, 0), context),
          ],
        ),
      ),
    );
  }
}
