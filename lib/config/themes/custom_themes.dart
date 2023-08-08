import 'package:app_follow_line/config/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomThemes {
  final defaultTheme = ThemeData(
    cardColor: MyColors.white,
    popupMenuTheme: PopupMenuThemeData(
      shadowColor: MyColors.black,
      surfaceTintColor: MyColors.white,
      color: MyColors.white,
      elevation: 12,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(
          color: MyColors.black,
          fontSize: 14,
        ),
      ),
      textStyle: const TextStyle(
        color: MyColors.black,
        fontSize: 14,
      ),
    ),
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
      backgroundColor: MyColors.green,
      iconTheme: IconThemeData(
        color: MyColors.white,
      ),
      actionsIconTheme: IconThemeData(),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
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
      onPrimary: Colors.amber,
      primary: Colors.black,
      background: Colors.amber,
      onSurface: Colors.amber,
      //APPBAR BACKGROUND
      surface: Colors.amber,
      secondary: Colors.amber,
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
    cardTheme: const CardTheme(
      surfaceTintColor: MyColors.white,
      shadowColor: MyColors.black,
      color: Color(0xfffcfcfc),
      elevation: 8,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
