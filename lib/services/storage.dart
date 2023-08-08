import 'dart:convert';

import 'package:app_follow_line/models/rele_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _sharedPreferences;

  Storage() {
    init();
  }

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  void saveList(List<ReleModel> list) {
    final String str = jsonEncode(list);
    final List<String> listString = getList();
    listString.add(str);
    _sharedPreferences?.setStringList('list', listString);
  }

  List<String> getList() {
    final List<String>? listString = _sharedPreferences?.getStringList('list');
    if (listString != null) {
      return listString;
    }
    return [];
  }

  void saveLastConnected(String s) {
    _sharedPreferences!.setString('lastConnected', s);
  }

  String? getLastConnected() {
    return _sharedPreferences!.getString('lastConnected');
  }
}
