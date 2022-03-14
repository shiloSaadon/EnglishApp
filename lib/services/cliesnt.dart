import 'package:flutter/cupertino.dart';
import 'package:web_application/models/user_info.dart';
import 'package:web_application/services/app_data_base.dart/data_base_api.dart';
import 'package:web_application/services/cache_controller.dart';
import 'package:web_application/services/server_communication.dart';
import 'package:web_application/utilis.dart';

class Client {
  static final Client _singleton = Client._internal();

  Client._internal();

  factory Client() {
    Client object = _singleton;
    return object;
  }
  Future<Map<String, dynamic>> getWords() async {
    DataBaseApi db = DataBaseApi();
    Map<String, dynamic> serverJson;
    if (!await db.fileExist()) {
      serverJson = await ServerCommunication.getServerWords();
      db.writeJson(serverJson);
    } else {
      serverJson = await db.readJson();
    }
    return serverJson;
  }

  Future<bool> saveWords(
      Map<String, String> wordScores, BuildContext context) async {
    bool response = await ServerCommunication.saveServerWords(wordScores);
    if (response) {
      Storage.saveUserWords(context);
    }
    return response;
  }

  Future<List<String>> getUnLearnedWords() async {
    return ServerCommunication.getUnLearnedWords();
  }

  Future<bool> saveLearningWords(Map<String, int> wordRating) async {
    return ServerCommunication.saveServerLearningWords(wordRating);
  }

  Future<List<String>> getPracticeWords() async {
    return ServerCommunication.getPracticeWords();
  }

  Future<List<String>> getAlreadyPassedWords() async {
    return ServerCommunication.getAlreadyPassedWords();
  }

  Future<bool> startDefaultProgram() async {
    return ServerCommunication.startDefaultProgram();
  }

  Future<bool> levelUp() async {
    if (UserInfo.userLevel < USER_MAX_LEVEL) {
      bool response = await ServerCommunication.levelUp();
      print(response);
      if (response) {
        DataBaseApi db = DataBaseApi();
        await db.deleteFile();
      }
      return response;
    }
    return false;
  }

  Future<List<dynamic>> register(
      String name, String password, String privateName) async {
    return ServerCommunication.register(name, password, privateName);
  }

  Future<List<dynamic>> login(String name, String password) async {
    return ServerCommunication.login(name, password);
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    return ServerCommunication.getUserInfo();
  }
}
