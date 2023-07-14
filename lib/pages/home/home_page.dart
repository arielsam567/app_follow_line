import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/pages/home/home_controller.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/widgets/bt.dart';
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
                      child: Text(
                        controller.bt.isConnected ? 'DESCONECTAR' : 'CONECTAR',
                        style: const TextStyle(color: Colors.white),
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return ConnectBluetooth(ct: controller);
      },
    );
  }
}
