import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_application/services/app_data_base.dart/data_base_api.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:provider/provider.dart';

class Storage {
  static Future writeSecureData(String key, String value) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    var writeData = await _storage.setString(key, value);
    return writeData;
  }

  static Future<String> readSecureData(String key) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    var readData = _storage.getString(key);
    return readData ?? "";
  }

  static Future<Map<String, dynamic>> getUserWords() async {
    DataBaseApi db = DataBaseApi();
    return await db.readJson();
  }

  static Future<bool> saveUserWords(BuildContext context) async {
    DataBaseApi db = DataBaseApi();
    WordsProvider wordsProvider = context.read<WordsProvider>();
    for (String key in wordsProvider.wordsScore.keys) {
      wordsProvider.wordsToPass.remove(
          key); // removing each word user already pass from the passTheWords list
      if (wordsProvider.wordsScore[key] == "3") {
        wordsProvider.allWordsData
            .remove(key); // remiving any word the user already know from db
      }
    }
    Map<String, dynamic> userNewDb = {
      "words": wordsProvider.wordsToPass,
      "all words": wordsProvider.allWordsData
    };
    db.writeJson(userNewDb);
    return true;
  }
}
