import 'dart:convert';

import 'package:app_follow_line/models/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _sharedPreferences;

  Storage() {
    init();
  }

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  void saveList(List<TextFieldModel> list) {
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

  List<List<TextFieldModel>> getFromMemory() {
    final List<String> listString = getList();
    final List<List<TextFieldModel>> list = [];
    for (final element in listString) {
      final List aux = jsonDecode(element);

      final List<TextFieldModel> value = aux.map((e) => TextFieldModel.fromJson(e)).toList();
      list.add(value);
    }
    return list;
  }

  void removeList(List<TextFieldModel> e) {
    final List<String> listString = getList();
    final String str = jsonEncode(e);
    listString.remove(str);
    _sharedPreferences?.setStringList('list', listString);
  }
}
