import 'dart:async';
import 'dart:convert';

import 'package:app_follow_line/models/bluetooth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
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
    await _startDiscovery();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }

  Future<bool> checkBluetoothStatus() async {
    final PermissionStatus status = await Permission.bluetooth.status;

    if (status.isDenied) {
      await Permission.bluetooth.request();
    }

    final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    return flutterBlue.isOn;
  }

  Future<void> _startDiscovery() async {
    try {
      await checkBluetoothStatus();
      debugPrint('start discovery');
      await FlutterBluetoothSerial.instance.getBondedDevices().then((bondedDevices) {
        for (final element in bondedDevices) {
          debugPrint('element.name ${element.name}');
          devices.add(
            BluetoothModel(
              name: element.name ?? '',
              id: element.address,
            ),
          );
        }
        debugPrint('devices ${devices.length}');

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
      print('address $address');
      connection = await BluetoothConnection.toAddress(address);

      connection!.input!.listen((data) {
        //print('Data incoming a: $data');

        debugPrint('Data incoming: ${ascii.decode(data)}');
        connection!.output.add(data); // Sending data

        if (ascii.decode(data).contains('!')) {
          connection!.finish(); // Closing connection
          debugPrint('Disconnecting by local host');
        }
      }).onDone(() {
        debugPrint('Disconnected by remote request');
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
    debugPrint('AFF ${DateTime.now()}');
    connection!.output.add(ascii.encode(comando));
    await connection!.output.allSent;
    debugPrint('AFF ${DateTime.now()}');
  }
}
