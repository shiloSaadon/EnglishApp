import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_application/pages/login_package/entrance_page.dart';
import 'package:web_application/providers/words_provider.dart';
import 'package:web_application/services/app_data_base.dart/data_base_api.dart';
import 'package:web_application/services/cache_controller.dart';
import 'package:web_application/services/cliesnt.dart';

import 'models/Datest.dart';
import 'models/login_info.dart';
import 'models/user_info.dart';

Future<bool> getCerdetional(BuildContext context) async {
  if (LoginInfo.name != "" && LoginInfo.password != "") return true;
  if (LoginInfo.name == "") {
    LoginInfo.name = await Storage.readSecureData("mane");
    LoginInfo.password = await Storage.readSecureData("password");
    return true;
  }
  if (LoginInfo.name == "") {
    print("out");
    return false;
    //Future.microtask(() => Navigator.pop(context));
    //Future.microtask(() => Navigator.of(context)
    //  .push(MaterialPageRoute(builder: (_) => EntrancePage())));
    /*Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EntrancePage(),
          ),
          (route) => false,
        )*/
  }
  return false;
}

Future<bool> stupAllData(
    BuildContext context, WordsProvider wordsProvider) async {
  try {
    bool isLoggin = await getCerdetional(context);
    print("is loggin - $isLoggin");
    if (!isLoggin) return false;
    var client = Client();
    // update the dashboard
    UserInfo.setup(await client.getUserInfo());
    if (wordsProvider.wordsToPass.length == 0 &&
        wordsProvider.allWordsData.length == 0) {
      wordsProvider.wordsToPass = [];
      var wordsDict = await client.getWords();
      //print(
      //    "data-\nwordsDict[words] : ${wordsDict["words"].length}\nwordsDict[all words] - ${wordsDict["all words"].length}");
      wordsDict["words"].forEach((value) {
        wordsProvider.wordsToPass.add("$value");
      });
      wordsDict["all words"].forEach((key, value) {
        wordsProvider.allWordsData[key] = value;
      });
      //print(
      //    "lens - ${wordsProvider.wordsToPass.length},  ${wordsProvider.allWordsData.length}");
    }
    // after passing tha words get the new words..
    wordsProvider.learningWords = await client.getUnLearnedWords();
    //print("len is - ${wordsProvider.alllearningWords.length}");
    if (wordsProvider.practiceWords.length == 0) {
      wordsProvider.practiceWords = await client.getPracticeWords();
    }
    if (wordsProvider.alreadyPassedWords.length == 0) {
      wordsProvider.alreadyPassedWords = await client.getAlreadyPassedWords();
      // print(
      //     "wordsProvider.already_passed_words.length: ${wordsProvider.alreadyPassedWords.length}");
    }
    await Dates.updateDays(context);
    return true;
  } catch (e) {
    print("error:  $e");
    return false;
  }
}
