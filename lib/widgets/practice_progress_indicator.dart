import 'package:flutter/cupertino.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';

class PracticeProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WordsProvider wordsProvider = context.watch<WordsProvider>();
    int passedWords = wordsProvider.practiceWordsIndex;
    return Container(
        child: Text("$passedWords/${wordsProvider.practiceWords.length}"));
  }
}
