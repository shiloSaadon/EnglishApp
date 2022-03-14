import 'package:flutter/cupertino.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class LearningProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WordsProvider wordsProvider = context.watch<WordsProvider>();
    int passedWords = wordsProvider.learningWordsIndex;
    int whole = min(10, wordsProvider.learningWords.length);
    return Container(child: Text("$passedWords/$whole"));
  }
}
