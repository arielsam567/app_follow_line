import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/models/bluetooth_model.dart';
import 'package:flutter/material.dart';

class DeviceItem extends StatefulWidget {
  final BluetoothModel device;
  final bool connected;
  final Function onTap;
  const DeviceItem({
    required this.device,
    required this.connected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onTap();
      },
      title: Text(
        widget.device.name,
        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        widget.device.id,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
      ),
      trailing: Text(
        widget.connected ? 'Conectado' : '',
        style: const TextStyle(color: MyColors.success, fontWeight: FontWeight.w400, fontSize: 14),
      ),
    );
  }
}
