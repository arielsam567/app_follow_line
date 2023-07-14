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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.wicked),
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text('Carregando...'
                      // style: Theme
                      ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
