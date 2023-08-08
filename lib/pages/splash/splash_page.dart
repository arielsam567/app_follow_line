import 'package:app_follow_line/config/assets.dart';
import 'package:app_follow_line/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashController>(
      create: (context) => SplashController(),
      child: Consumer<SplashController>(
        builder: (context, controller, _) {
          return Scaffold(
            bottomNavigationBar: const SizedBox(
              height: 50,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Criado por: Ariel Sam',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'TCC - Relé multifuncional programável via Bluetooth',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    Assets.ifsc,
                    width: 150,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
