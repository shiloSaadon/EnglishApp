import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_application/models/user_info.dart';

class DataBaseApi {
  static final DataBaseApi _singleton = DataBaseApi._internal();

  DataBaseApi._internal();

  factory DataBaseApi() {
    DataBaseApi object = _singleton;
    return object;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${UserInfo.userName}.json}');
  }

  Future<bool> writeJson(Map<String, dynamic> json) async {
    if (kIsWeb) {
      return false;
    }
    File _filePath = await _localFile;
    //3. Convert _json ->_jsonString
    String _jsonString = jsonEncode(json);
    //4. Write _jsonString to the _filePath
    try {
      _filePath.writeAsString(_jsonString);
      return true;
    } catch (e) {
      print("error to write file, the error: $e");
      return false;
    }
  }

  Future<bool> fileExist() async {
    if (kIsWeb) {
      return false;
    }
    File _filePath = await _localFile;
    return await _filePath.exists();
  }

  Future<Map<String, dynamic>> readJson() async {
    if (kIsWeb) {
      return {"Error": "isWeb"};
    }
    File _filePath = await _localFile;
    String _jsonString;
    Map<String, dynamic> json;
    try {
      //1. Read _jsonString<String> from the _file.
      _jsonString = await _filePath.readAsString();
      print('1.(_readJson) _jsonString: $_jsonString');

      //2. Update initialized _json by converting _jsonString<String>->_json<Map>
      json = jsonDecode(_jsonString);
      return json;
    } catch (e) {
      // Print exception errors
      print('Tried reading _file error: $e');
      // If encountering an error, return null
    }
    return {"Error": true};
  }

  Future<bool> deleteFile() async {
    try {
      final file = await _localFile;
      if (await fileExist()) await file.delete();
      return true;
    } catch (e) {
      print("errore while deleting is : $e");
      return false;
    }
  }
}
