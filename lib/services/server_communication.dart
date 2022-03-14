import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_application/models/login_info.dart';

const String SERVER_URL = "apienglishserver.shilosaadon.ml";

class ServerCommunication {
  static Future<Map<String, dynamic>> getServerWords() async {
    Uri url = Uri.https(
        SERVER_URL, "/", {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    Map<String, dynamic> jsonData = {"words": [], "all words": {}};
    json["words"]!.forEach((value) {
      jsonData["words"].add(value);
    });
    json["all words"]!.forEach((key, value) {
      jsonData["all words"]![key] = value;
    });
    return jsonData;
  }

  static Future<bool> saveServerWords(Map<String, String> wordScores) async {
    List words = [];
    List scores = [];
    wordScores.forEach((key, value) {
      words.add(key);
      scores.add(value);
    });
    Map<String, dynamic> cerdetionals = {
      "info": "${LoginInfo.name} ${LoginInfo.password}"
    };
    Map<String, dynamic> queryParameters = {"words": words, "scores": scores};
    String unencodedPath = '/send_data';
    var url = Uri.https(SERVER_URL, unencodedPath, cerdetionals);
    var response = await http.put(url, body: jsonEncode(queryParameters));
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    return json["ok"];
  }

  static Future<List<String>> getUnLearnedWords() async {
    String unencodedPath = '/unlearned_words';
    var url = Uri.https(SERVER_URL, unencodedPath,
        {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    List<dynamic> json = jsonDecode(body);
    List<String> jsonData = json.cast();
    return jsonData;
  }

  static Future<List<String>> getPracticeWords() async {
    String unencodedPath = '/practice_daily_words';
    var url = Uri.https(SERVER_URL, unencodedPath,
        {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    List<dynamic> json = jsonDecode(body);
    List<String> jsonData = json.cast();
    return jsonData;
  }

  static Future<bool> saveServerLearningWords(
      Map<String, int> wordsRating) async {
    List<String> words = [];
    List<int> ratings = [];
    wordsRating.forEach((key, value) {
      words.add(key);
      ratings.add(value);
    });
    Map<String, dynamic> queryParameters = {"words": words, "ratings": ratings};
    String unencodedPath = '/send_words_rating';
    var url = Uri.https(SERVER_URL, unencodedPath,
        {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.post(url, body: jsonEncode(queryParameters));
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    return json["ok"];
  }

  static Future<List<String>> getAlreadyPassedWords() async {
    String unencodedPath = '/already_passed_words';
    var url = Uri.https(SERVER_URL, unencodedPath,
        {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    List<dynamic> json = jsonDecode(body);
    List<String> jsonData = json.cast();
    return jsonData;
  }

  static Future<List<dynamic>> register(
      String name, String password, String privateName) async {
    String unencodedPath = '/register';
    Map<String, String> queryParameters = {
      "name": name,
      "password": password,
      "private_name": privateName
    };
    var url = Uri.https(SERVER_URL, unencodedPath, queryParameters);
    var response = await http.post(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    List<dynamic> data = [json["ok"] ?? false, json["log"] ?? ""];
    return data;
  }

  static Future<List<dynamic>> login(String name, String password) async {
    String unencodedPath = '/login';
    Map<String, String> queryParameters = {"info": "$name $password"};
    var url = Uri.https(SERVER_URL, unencodedPath, queryParameters);
    var response = await http.put(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    print(json);
    List<dynamic> data = [
      json["ok"] ?? false,
      json["log"] ?? json["detail"] ?? ""
    ];
    return data;
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    String unencodedPath = '/get_user_info';
    Map<String, String> queryParameters = {
      "info": "${LoginInfo.name} ${LoginInfo.password}"
    };
    var url = Uri.https(SERVER_URL, unencodedPath, queryParameters);
    var response = await http.put(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    return json["ok"] ?? {};
  }

  static Future<bool> startDefaultProgram() async {
    String unencodedPath = '/default_program';
    var url = Uri.https(SERVER_URL, unencodedPath,
        {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.put(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    return json["ok"] ?? false;
  }

  static Future<bool> levelUp() async {
    String unencodedPath = '/level_up';
    var url = Uri.https(SERVER_URL, unencodedPath,
        {"info": "${LoginInfo.name} ${LoginInfo.password}"});
    var response = await http.put(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(body);
    return json["ok"] ?? false;
  }
}
