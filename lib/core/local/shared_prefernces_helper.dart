import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  late SharedPreferences sharedPreferences;

  PreferenceHelper() {
    init();
  }

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  dynamic getDataFromSharedPreference(
      {required String key, bool isJson = false}) {
    var value = sharedPreferences.get(key);
    if (isJson) {
      return jsonDecode(value.toString());
    }
    return value;
  }

  List<String>? getListData({required String key}) {
    List<String>? value = sharedPreferences.getStringList(key);
    return value;
  }

  dynamic saveList({required String key, required List<String> value}) {
    sharedPreferences.setStringList(key, value);
  }

  Future<bool> saveDataInSharedPreference(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is List) {
      return await sharedPreferences.setStringList(key, value as List<String>);
    } else if (value is Map) {
      return await sharedPreferences.setString(key, jsonEncode(value));
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future clearData() {
    return sharedPreferences.clear();
  }

  getStringList(String s) {}
}
