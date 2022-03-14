import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';
import '../utilis.dart';
//import 'dart:js' as js;
//import 'package:audioplayer/audioplayer.dart';

class EnglishCard extends StatelessWidget {
  final styleOne = TextStyle(
      color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 15);
  final styleTwo = TextStyle(
      color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: relativeWidth(width: 750, context: context),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.centerLeft, children: [
            Center(child: showWord(context)),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: volumeBottom(context))
          ]),
          Center(child: showTranslation(context)),
          Center(child: showImage(context)),
          exampleSentenses(context),
        ],
      ),
    );
  }

  GestureDetector volumeBottom(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: relativeWidth(width: 90, context: context),
          height: relativeHeigth(heigth: 110, context: context),
          child: Icon(
            Icons.volume_up_outlined,
            color: Colors.black,
            size: 40,
          ),
        ),
        onTap: () => playSound(context));
  }

  Future<void> playSound(BuildContext context) async {
    WordsProvider wordsProvider = context.read<WordsProvider>();
    String path = 'https://apienglishserver.shilosaadon.ml/' +
        wordsProvider.currentWord.keys.first +
        '.mp3';
    if (kIsWeb) {
      // try {
      //   print("wwww   ${path}");
      //   js.context.callMethod('playAudio', [path]);
      // } catch (ea) {
      //   print("aaaaaaaaaaa" + ea.toString());
      // }
    } else {
      AudioPlayer audioPlugin = AudioPlayer();
      await audioPlugin.stop();
      await audioPlugin.play(path);
    }
  }

  ClipRRect showImage(BuildContext context) {
    Map<String, List<dynamic>> currentWord =
        context.read<WordsProvider>().currentWord;
    String url = currentWord.values.first[1];
    bool showImage = context.read<WordsProvider>().imageStatus;
    return showImage
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: relativeWidth(width: 650, context: context),
              height: relativeHeigth(heigth: 450, context: context),
            ))
        : ClipRRect();
  }

  Text showWord(BuildContext context) {
    Map<String, List<dynamic>> currentWord =
        context.read<WordsProvider>().currentWord;
    return Text(
      currentWord.keys.first,
      style: TextStyle(fontSize: 27),
    );
  }

  Container showTranslation(BuildContext context) {
    bool translationStatus = context.watch<WordsProvider>().currentTranslation;
    String translation =
        context.read<WordsProvider>().currentWord.values.first[0];
    return Container(
      alignment: Alignment.center,
      width: relativeWidth(width: 500, context: context),
      height: relativeHeigth(heigth: 100, context: context),
      child: Text(
        translationStatus ? translation : "",
        style: TextStyle(fontSize: 27),
      ),
    );
  }

  Container exampleSentenses(BuildContext context) {
    Map<String, List<dynamic>> currentWord =
        context.read<WordsProvider>().currentWord;
    bool sentencesStatus = context.read<WordsProvider>().sentencesStatus;
    Container sc = Container(
      padding: EdgeInsets.only(top: 5),
      //height: relativeHeigth(heigth: 200, context: context),
      child: Text(""),
    );
    List<Widget> sentences = [];
    if (currentWord.values.first.length > 2 && sentencesStatus) {
      List<String> stringSentences = currentWord.values.first[2].split("##");
      for (String sen in stringSentences) {
        sen = '• ' + sen;
        sentences.add(RichText(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: 4,
            text: TextSpan(
                children: sen
                    .split(" ")
                    .map((word) => TextSpan(
                        text: word + " ",
                        style: (currentWord.keys.first.length > 3 &&
                                    word.contains(currentWord.keys.first)) ||
                                (currentWord.keys.first.length < 3 &&
                                    word == currentWord.keys.first) ||
                                (word == '•')
                            ? styleTwo
                            : styleOne))
                    .toList())));
      }
      sc = Container(
          //height: relativeHeigth(heigth: 270, context: context),
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sentences,
          ));
    }
    return sc;
  }
}
