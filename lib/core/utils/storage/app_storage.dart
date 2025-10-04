import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  late SharedPreferences _storage;

  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  Future<void> setBool(String key, bool value) async {
    await _storage.setBool(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _storage.setString(key, value);
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await _storage.setString(key, json.encode(value));
  }

  Map<String, dynamic>? getJson(String key) {
    final json = _storage.getString(key);
    if (json != null && json.isNotEmpty) {
      return jsonDecode(json);
    }
    return null;
  } 

  bool? getBool(String key) => _storage.getBool(key);

  String getString(String key) => _storage.getString(key) ?? '';

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> clear() async => await _storage.clear();
}
