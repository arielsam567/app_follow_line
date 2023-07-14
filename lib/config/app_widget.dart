import 'package:app_follow_line/config/themes/custom_themes.dart';
import 'package:app_follow_line/provider/bt_provider.dart';
import 'package:app_follow_line/services/routes.dart';
import 'package:app_follow_line/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            Storage.init();
          },
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => BluetoothProvider(),
        ),
      ],
      child: MaterialApp(
        theme: CustomThemes().defaultTheme,
        initialRoute: '/splash',
        onGenerateRoute: Routes.generateRoute,
        navigatorKey: Routes.navigator,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
