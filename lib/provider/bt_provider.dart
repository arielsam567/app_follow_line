import 'dart:async';
import 'dart:convert';

import 'package:app_follow_line/models/bluetooth_model.dart';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:vibration/vibration.dart';

class BluetoothProvider extends ChangeNotifier {
  BluetoothConnection? connection;
  String idConnected = '';
  bool isConnected = false;
  bool loading = true;
  List<BluetoothModel> devices = [];
  StreamSubscription? streamAce;

  Future<void> init() async {
    if (devices.isNotEmpty) {
      devices.clear();
    }
    _startDiscovery();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }

  Future<bool> checkBluetoothStatus() async {
    bool isEnable = false;
    BluetoothEnable.enableBluetooth.then((result) {
      debugPrint('result $result');
      if (result == 'true') {
        isEnable = true;
      }
    });
    return isEnable;
  }

  Future<void> _startDiscovery() async {
    try {
      print('start discovery');
      await FlutterBluetoothSerial.instance.getBondedDevices().then((bondedDevices) {
        for (final element in bondedDevices) {
          print('element.name ${element.name}');
          devices.add(
            BluetoothModel(
              name: element.name ?? '',
              id: element.address,
            ),
          );
        }
        print('devices ${devices.length}');

        loading = false;
        notifyListeners();
      });
    } catch (error) {
      loading = false;
      notifyListeners();
    }
  }

  void reloadDevices() {
    loading = true;
    notifyListeners();
    devices = [];
    _startDiscovery();
  }

  Future<void> disconnect() async {
    await connection?.close();
    await connection?.finish();
    streamAce?.cancel();
    idConnected = '';
    isConnected = false;
    notifyListeners();
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [200, 200, 200, 200]);
    }
  }

  Future<void> _setAsConnected(String id) async {
    isConnected = true;
    idConnected = id;
    notifyListeners();
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 300);
    }
  }

  Future<bool> connectDevice(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);

      connection!.input!.listen((data) {
        //print('Data incoming a: $data');

        print('Data incoming: ${ascii.decode(data)}');
        connection!.output.add(data); // Sending data

        if (ascii.decode(data).contains('!')) {
          connection!.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
        disconnect();
      });

      _setAsConnected(address);

      return true;
    } catch (exception) {
      print('ERROR $exception)');

      disconnect();
      return false;
    }
  }

  Future<void> done(String comando) async {
    print('AFF ${DateTime.now()}');
    connection!.output.add(ascii.encode(comando));
    await connection!.output.allSent;
    print('AFF ${DateTime.now()}');
  }
}
