import 'package:app_follow_line/models/text_field.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/services/storage.dart';
import 'package:app_follow_line/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeController extends ChangeNotifier {
  final List<TextFieldModel> list = [];
  final List<List<TextFieldModel>> savedList = [];
  final Storage _storage = Storage();
  final BluetoothProvider bt;
  final ScrollController scrollController = ScrollController();

  HomeController(this.bt) {
    _init();
    scrollController.addListener(() {
      //close keyboard when scroll
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  void dispose() {
    super.dispose();
    bt.dispose();
  }

  void _init() {
    if (list.isEmpty) {
      addTextField();
    }
    getFromMemory();
    if (savedList.isNotEmpty) {
      list.clear();
      list.addAll(savedList.last);
    }
    notifyListeners();
  }

  void getFromMemory() {
    savedList.clear();
    savedList.addAll(_storage.getFromMemory());
  }

  void addTextField() {
    list.add(TextFieldModel());
    notifyListeners();
  }

  void sendValues() {
    if (!validateFields()) {
      showMessageError('Preencha todos os campos');
      return;
    }
    if (!bt.isConnected) {
      showMessageError('Bluetooth não conectado');
      return;
    }

    String textToSend = list.map((e) => '${e.key}:${e.value}').join('&');
    textToSend += ';';
    bt.sendString(textToSend);
    debugPrint('TEXT TO SEND: $textToSend');
  }

  bool validateFields() {
    for (final element in list) {
      if (element.key.isEmpty || element.value.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void saveStorageList() {
    if (!validateFields()) {
      showMessageError('Preencha todos os campos para salvar');
      return;
    }
    _storage.saveList(list);
    getFromMemory();
    showMessageSuccess('Salvo com sucesso');
    notifyListeners();
  }

  Future<void> removeTextField(int index) async {
    final List<TextFieldModel> aux = List.from(list);
    aux.removeAt(index);
    list.clear();
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    list.addAll(aux);
    notifyListeners();
  }

  Function? getFunctionAddTextField(int index) {
    return list.length == index + 1 ? () => addTextField() : null;
  }

  void updateLock(int index) {
    list[index].blocked = !list[index].blocked;
    notifyListeners();
  }

  Future<void> start() async {
    await bt.sendString('s');
  }

  void removeSavedList(List<TextFieldModel> e) {
    savedList.remove(e);
    _storage.removeList(e);
    notifyListeners();
  }

  void selectList(List<TextFieldModel> e) {
    list.clear();
    list.addAll(e);
    notifyListeners();
  }
}
