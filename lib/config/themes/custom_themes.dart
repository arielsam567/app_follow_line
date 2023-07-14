import 'package:app_follow_line/config/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomThemes {
  final defaultTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: MyColors.white,
    dividerColor: Colors.transparent,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blueAccent,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0XFFF7F8F9),
      filled: true,
      suffixStyle: TextStyle(
        color: MyColors.grey,
        fontSize: 14,
      ),
      counterStyle: TextStyle(
        color: MyColors.grey,
        fontSize: 14,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.3, color: MyColors.grey),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.3, color: MyColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.3, color: MyColors.grey),
      ),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      hintStyle: TextStyle(color: Colors.black38, fontSize: 16.0),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: MyColors.blue,
      ),
      actionsIconTheme: IconThemeData(),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
      elevation: 0,
    ),
    colorScheme: const ColorScheme(
      onBackground: Colors.redAccent,
      //ICONES
      onSecondary: Colors.black,
      onError: MyColors.error,
      error: MyColors.error,
      brightness: Brightness.light,
      onPrimary: Colors.red,
      primary: Colors.black,
      background: Colors.red,
      onSurface: Colors.amber,
      //APPBAR BACKGROUND
      surface: Colors.red,
      secondary: Colors.red,
    ),
    textTheme: const TextTheme(
      //BODY
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColors.success,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),

      //headline
      headlineLarge: TextStyle(
        fontSize: 20,
        color: MyColors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MyColors.primary,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),

      //display
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: MyColors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
    ),
  );
}

InputDecoration inputDecoration({String hintText = ''}) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(10, 15, 5, 15),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
