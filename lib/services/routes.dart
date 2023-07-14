import 'package:app_follow_line/pages/home/home_page.dart';
import 'package:app_follow_line/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/home';
  static const String splash = '/splash';
  static String page = '';
  static final navigator = GlobalKey<NavigatorState>();

  static MaterialPageRoute wrapper(child) => MaterialPageRoute(builder: (_) => child);

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    page = settings.name ?? '/splash';
    //final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return wrapper(const SplashPage());
      case home:
        return wrapper(const HomePage());
    }
    return null;
  }

  static void goTo(String route, {bool enableBack = false, args}) {
    debugPrint('GO TO $route');
    Navigator.of(Routes.navigator.currentContext!).pushNamedAndRemoveUntil(
      route,
      arguments: args,
      (route) => enableBack,
    );
  }
}
