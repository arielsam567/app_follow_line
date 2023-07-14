import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/models/bluetooth_model.dart';
import 'package:app_follow_line/pages/home/home_controller.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/widgets/card_saved_items.dart';
import 'package:app_follow_line/widgets/floating.dart';
import 'package:app_follow_line/widgets/text_field_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final btProvider = Provider.of<BluetoothProvider>(context);
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(btProvider),
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Follow Line',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            floatingActionButton: ExpandableFab(
              distance: 80,
              children: [
                ActionButton(
                  onPressed: () => controller.sendValues(),
                  icon: const Icon(Icons.send),
                ),
                ActionButton(
                  onPressed: () => controller.start(),
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
                ActionButton(
                  onPressed: () => controller.saveStorageList(),
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyColors.success),
                      ),
                      onPressed: () => showModalToConnectBluetooth(controller, context),
                      child: const Text(
                        'CONECTAR',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      children: [
                        ...controller.list.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            final item = entry.value;

                            return SizedBox(
                              width: (MediaQuery.sizeOf(context).width - 32) / 2,
                              child: TextFieldHome(
                                model: item,
                                updateLock: () => controller.updateLock(index),
                                addTextField: controller.getFunctionAddTextField(index),
                                removeTextField: () => controller.removeTextField(index),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Parâmetros salvos',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          ...controller.savedList.map(
                            (e) => CardSavedItems(
                              models: e,
                              delete: () => controller.removeSavedList(e),
                              select: () => controller.selectList(e),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showModalToConnectBluetooth(HomeController controller, context) {
    controller.bt.init();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return ConnectBluetooth(controller: controller);
      },
    );
  }
}

class ConnectBluetooth extends StatefulWidget {
  final HomeController controller;
  const ConnectBluetooth({required this.controller, super.key});

  @override
  State<ConnectBluetooth> createState() => _ConnectBluetoothState();
}

class _ConnectBluetoothState extends State<ConnectBluetooth> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        if (widget.controller.bt.loading) ...[
          const SizedBox(height: 100),
          const Center(
            child: CircularProgressIndicator(),
          )
        ] else if (widget.controller.bt.devices.isNotEmpty) ...[
          ListView.builder(
              itemCount: widget.controller.bt.devices.length,
              itemBuilder: (context, index) {
                return DeviceItem(
                  device: widget.controller.bt.devices[index],
                  connected:
                      widget.controller.bt.devices[index].id == widget.controller.bt.idConnected,
                  onTap: () async {
                    if (widget.controller.bt.isConnected == false) {
                      print('CONNECTANDO');
                      await widget.controller.bt
                          .connectDevice(widget.controller.bt.devices[index].id);
                      print('CONNECTADO');
                    } else {
                      print('DESCONNECTANDO');
                      await widget.controller.bt.disconnect();
                      print('DESCONNECTADO');
                    }
                    setState(() {});
                  },
                );
              })
        ]
      ],
    );
  }
}

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
