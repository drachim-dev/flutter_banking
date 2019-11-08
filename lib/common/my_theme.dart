import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';

class MyTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: MyColor.olbPrimary,
    accentColor: MyColor.olbAccent,
    accentColorBrightness: Brightness.light,
    textSelectionColor: MyColor.olbPrimary.withAlpha(100),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: MyColor.darkGrey,
    accentColor: MyColor.olbAccent,
    accentColorBrightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColor.olbPrimary,
      foregroundColor: Colors.white,
    ),
    bottomAppBarColor: MyColor.darkGrey,
    toggleableActiveColor: MyColor.olbAccent,
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.olbPrimary,
    ),
    indicatorColor: MyColor.olbAccent,
    textSelectionColor: MyColor.olbAccent.withAlpha(100),
    cursorColor: MyColor.lightGrey,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(),
    ),
  );

  static final ThemeData black = dark.copyWith(
    scaffoldBackgroundColor: Colors.black,
    dialogBackgroundColor: MyColor.darkGrey,
    primaryColor: Colors.black,
  );

  static ThemeData getThemeFromName(String themeName) {
    switch (themeName) {
      case 'Light':
        return light;
      case 'Dark':
        return dark;
      case 'Black':
        return black;
      default:
        return light;
    }
  }
  
}