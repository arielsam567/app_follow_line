import 'package:app_follow_line/services/routes.dart';
import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    _init();
  }

  void _init() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        Routes.goTo(Routes.home);
      },
    );
  }
}
