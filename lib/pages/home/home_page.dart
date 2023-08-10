import 'package:app_follow_line/config/strings.dart';
import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/pages/home/home_controller.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/widgets/bt.dart';
import 'package:app_follow_line/widgets/card_select.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final btProvider = Provider.of<BluetoothProvider>(context);
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(btProvider),
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(Strings.appName),
              centerTitle: true,
            ),
            body: DirectSelectContainer(
              child: SingleChildScrollView(
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
                              backgroundColor:
                                  MaterialStateProperty.all(getButtonColor(controller)),
                            ),
                            onPressed: () {
                              if (controller.bt.isConnected) {
                                controller.bt.disconnect();
                              } else {
                                showModalToConnectBluetooth(controller, context);
                              }
                            },
                            child: Text(
                              getStringButton(controller),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: getTextButtonColor(controller),
                              ),
                            ),
                          ),
                        ),
                        if (hasLastConnection(controller)) ...[
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: AnimatedRotation(
                              duration: const Duration(seconds: 5),
                              turns: controller.bt.connecting ? 8 : 0,
                              child: Material(
                                shape: const CircleBorder(),
                                color: controller.bt.connecting ? Colors.black12 : MyColors.green,
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

                    Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            CardSelector(
                              data: controller.list,
                              selectedIndex: controller.mode,
                              onChange: (value, index) => controller.setMode(value, index),
                            ),
                            const SizedBox(height: 20),
                            Image.asset(
                              controller.rele.url,
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                scrollWidget(controller, 'dia', 999),
                                scrollWidget(controller, 'hora', 23),
                                scrollWidget(controller, 'min', 59),
                                scrollWidget(controller, 'seg', 59),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: FilledButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(MyColors.green),
                                ),
                                onPressed: () => controller.sendValues(),
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),

                    //BOTOES COMANDO
                    Center(
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MyColors.blue),
                        ),
                        onPressed: () => controller.sendString('x'),
                        child: const Text(
                          'MUDAR ESTADO',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget scrollWidget(HomeController controller, String title, int maxValue, {step = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
            ),
            height: 100,
            width: 70,
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  left: 10,
                  child: Container(
                    width: 50,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  child: Container(
                    width: 50,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
                WheelChooser.integer(
                  onValueChanged: (i) => controller.setTime(i, title),
                  maxValue: maxValue,
                  minValue: 0,
                  step: step,
                  isInfinite: true,
                ),
              ],
            ),
          ),
        ],
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

  bool hasLastConnection(controller) {
    return controller.bt.hasLastConnected() && !controller.bt.isConnected;
  }

  Color getButtonColor(HomeController controller) {
    if (controller.bt.isConnected) {
      return MyColors.yellow;
    } else {
      if (hasLastConnection(controller)) {
        return MyColors.green.withOpacity(0.5);
      }
      return MyColors.green;
    }
  }

  String getStringButton(HomeController controller) {
    return controller.bt.isConnected ? Strings.desconectar : Strings.conectar;
  }

  Color getTextButtonColor(HomeController controller) {
    return controller.bt.isConnected ? Colors.black : Colors.white;
  }
}
