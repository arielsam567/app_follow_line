import 'package:app_follow_line/pages/home/home_controller.dart';
import 'package:app_follow_line/services/routes.dart';
import 'package:app_follow_line/widgets/device_item.dart';
import 'package:flutter/material.dart';

class ConnectBluetooth extends StatefulWidget {
  final HomeController ct;
  const ConnectBluetooth({required this.ct, super.key});

  @override
  State<ConnectBluetooth> createState() => _ConnectBluetoothState();
}

class _ConnectBluetoothState extends State<ConnectBluetooth> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Center(
              child: Text(
                'DEVICES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (widget.ct.bt.loading) ...[
            const SizedBox(height: 100),
            const Center(
              child: CircularProgressIndicator(),
            )
          ] else if (widget.ct.bt.devices.isNotEmpty) ...[
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.ct.bt.devices.length,
              itemBuilder: (context, index) {
                return DeviceItem(
                  device: widget.ct.bt.devices[index],
                  connected: widget.ct.bt.devices[index].id == widget.ct.bt.idConnected,
                  onTap: () async {
                    if (widget.ct.bt.isConnected == false) {
                      debugPrint('CONECTANDO');
                      await widget.ct.bt.connectDevice(widget.ct.bt.devices[index].id);
                      Routes.pop();
                      debugPrint('CONECTADO');
                    } else {
                      await widget.ct.bt.disconnect();
                      debugPrint('DESCONECTADO');
                    }
                    setState(() {});
                  },
                );
              },
            )
          ]
        ],
      ),
    );
  }

  Future<void> init() async {
    await widget.ct.bt.searchDevices();

    setState(() {});
  }
}
