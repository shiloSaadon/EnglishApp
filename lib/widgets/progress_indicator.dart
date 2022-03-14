import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/providers/words_provider.dart';

import 'package:provider/provider.dart';

class MyProgressIndicator extends StatelessWidget {
  late int passed_words;
  late WordsProvider wp;
  @override
  Widget build(BuildContext context) {
    wp = context.watch<WordsProvider>();
    passed_words = wp.wordsToPassIndex;
    return Container(child: Text("$passed_words/${wp.wordsToPass.length}"));
  }
}
