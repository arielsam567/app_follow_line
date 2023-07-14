import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool openKeyboard() {
  // ignore: deprecated_member_use
  return WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
}

void showMessageError(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: openKeyboard() ? ToastGravity.CENTER : ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    timeInSecForIosWeb: 3,
    webBgColor: 'red',
    fontSize: 16.0,
  );
}

void showMessageSuccess(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: openKeyboard() ? ToastGravity.CENTER : ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
    timeInSecForIosWeb: 3,
    webBgColor: 'green',
  );
}
