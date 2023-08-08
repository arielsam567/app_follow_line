import 'package:app_follow_line/config/strings.dart';
import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/pages/home/home_controller.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/widgets/bt.dart';
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
              title: const Text(Strings.appName),
              centerTitle: true,
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
                            controller.bt.isConnected ? Strings.desconectar : Strings.conectar,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: controller.bt.isConnected ? Colors.black : Colors.white,
                            ),
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

                  Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Row(
                        children: [],
                      ),
                    ),
                  ),

                  //BOTOES COMANDO
                  Center(
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyColors.blue),
                      ),
                      onPressed: () {
                        controller.bt.sendString('x');
                      },
                      child: const Text(
                        'MUDAR ESTADO',
                        style: TextStyle(color: Colors.white),
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
