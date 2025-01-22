import 'package:flutter/material.dart';

abstract class AppScheme {
  static const Color brightGreen = Color(0xFF00FF5F);
  static const MaterialColor gray = MaterialColor(0xFFD9D9D9, <int, Color>{
    1: Color(0xFFD9D9D9),
    2: Color(0xFFBFBFBF),
    3: Color(0xFFA6A6A6),
    4: Color(0xFF464646),
  });
  static const Color lightGray = Color(0xFFEFEFEF);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFFF0000);

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: brightGreen,
      foregroundColor: black,
      titleTextStyle: TextStyle(
        color: black,
        fontSize: 14,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppScheme.brightGreen,
        foregroundColor: AppScheme.black,
        textStyle: const TextStyle(fontSize: 14),
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: gray[4],
        textStyle:
            const TextStyle(fontSize: 12, decoration: TextDecoration.underline),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: gray[4],
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(
        color: gray[4],
        fontSize: 12,
      ),
    ),
  );
}
