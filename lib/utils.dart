import 'package:flutter/material.dart';
// file for utility code
abstract class AssetPaths {
  static const mobigicLogoPath = 'assets/logos/mobigic_logo.svg';
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(milliseconds: 1500),
  ));
}

final defaultTheme = ThemeData(
  primaryColor: Colors.purple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.purple,
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).titleLarge,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.purple,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.orange)
      .copyWith(background: Colors.white),
);
