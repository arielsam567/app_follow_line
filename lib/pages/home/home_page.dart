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
            floatingActionButton: ExpandableFab(
              distance: 80,
              children: [
                ActionButton(
                  onPressed: () => controller.sendValues(),
                  icon: const Icon(Icons.send),
                  active: controller.bt.isConnected,
                ),
                ActionButton(
                  onPressed: () => controller.start(),
                  icon: const Icon(Icons.play_arrow_rounded),
                  active: controller.bt.isConnected,
                ),
                ActionButton(
                  onPressed: () => controller.saveStorageList(),
                  icon: const Icon(Icons.save),
                  active: true,
                ),
              ],
            ),
            body: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  //BOTOES  CONECTAR BT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              controller.bt.isConnected ? MyColors.yellow : MyColors.success,
                            ),
                          ),
                          onPressed: () {
                            if (controller.bt.isConnected) {
                              controller.bt.disconnect();
                            } else {
                              showModalToConnectBluetooth(controller, context);
                            }
                          },
                          child: Text(
                            controller.bt.isConnected ? 'DESCONECTAR' : 'CONECTAR',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      if (controller.bt.hasLastConnected() && !controller.bt.isConnected) ...[
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: AnimatedRotation(
                            duration: const Duration(seconds: 5),
                            turns: controller.bt.connecting ? 8 : 0,
                            child: Material(
                              shape: const CircleBorder(),
                              color: controller.bt.connecting ? Colors.black12 : Colors.black,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () => controller.bt.connectLastDevice(),
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                  const SizedBox(height: 20),
                  //LISTA DE TEXTFIELDS
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

                  //DIVIDER
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  //BOTOES COMANDO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MyColors.error),
                        ),
                        onPressed: () {
                          controller.bt.sendString('y');
                        },
                        child: const Text(
                          'Y',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MyColors.blue),
                        ),
                        onPressed: () {
                          controller.bt.sendString('x');
                        },
                        child: const Text(
                          'X',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.all(20),
                    color: Colors.black,
                    width: MediaQuery.sizeOf(context).width,
                    child: Center(
                      child: Text(
                        controller.bt.lastAux,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),

                  //DIVIDER
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  //TEXT PARAMETROS SALVOS
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

  Future<void> showModalToConnectBluetooth(HomeController controller, context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return ConnectBluetooth(ct: controller);
      },
    );
  }
}
