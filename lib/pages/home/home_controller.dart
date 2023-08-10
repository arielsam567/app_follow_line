import 'package:app_follow_line/config/assets.dart';
import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/models/rele_model.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final List<ReleModel> reles = [];
  late ReleModel rele;
  final BluetoothProvider bt;
  int mode = 0;
  int dias = 0;
  int horas = 0;
  int minutos = 0;
  int segundos = 0;

  final List<String> list = [];

  HomeController(this.bt) {
    initReles();
  }

  @override
  void dispose() {
    super.dispose();
    bt.dispose();
  }

  Future<void> sendValues() async {
    if (!bt.isConnected) {
      showMessageError('Bluetooth não conectado');
      return;
    }
    final int tempo = getTimeInMilliseconds();
    final String textToSend = 'modo:$mode&tempo:$tempo&g:g;';
    bt.sendString(textToSend);
    debugPrint('TEXT TO SEND: $textToSend');
  }

  void setMode(String title, int index) {
    mode = index;
    rele = reles.singleWhere((element) => element.title == title);
    notifyListeners();
  }

  Color buttonColor(int i) {
    if (mode == i) {
      return MyColors.yellow;
    } else {
      return MyColors.lightGrey;
    }
  }

  void initReles() {
    reles.add(
      ReleModel(
        title: 'Relé com retardo na energização',
        url: Assets.onDelay,
        model: 0,
        time: 0,
      ),
    );
    reles.add(
      ReleModel(
        title: 'Relé com retardo na desenergização',
        url: Assets.offDelay,
        model: 1,
        time: 0,
      ),
    );
    reles.add(
      ReleModel(
        title: 'Relé com Ciclico c/ início ON',
        // ciclos repetidos de ligar/desligar a saída enquanto a conexão de entrada estiver energizada
        url: Assets.ciclicoDelayOn,
        model: 3,
        time: 0,
      ),
    );
    reles.add(
      ReleModel(
        title: 'Relé com Ciclico c/ início OFF',
        url: Assets.ciclicoDelayOff,
        model: 4,
        time: 0,
      ),
    );

    rele = reles[0];
    for (final element in reles) {
      list.add(element.title);
    }
  }

  void setTime(int time, String type) {
    if (type == 'dia') {
      dias = time;
    } else if (type == 'hora') {
      horas = time;
    } else if (type == 'min') {
      minutos = time;
    } else if (type == 'seg') {
      segundos = time;
    }
    notifyListeners();
  }

  int getTimeInMilliseconds() {
    int time = 0;
    time += dias * 86400000;
    time += horas * 3600000;
    time += minutos * 60000;
    time += segundos * 1000;
    return time;
  }

  Future<void> sendString(String s) async {
    if (!bt.isConnected) {
      showMessageError('Bluetooth não conectado');
      return;
    }

    await bt.sendString('x');
  }
}
