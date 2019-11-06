import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';

class MyTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    primaryColor: MyColor.primaryColor,
    // backgroundColor: const Color(0xFFE5E5E5),
    accentColor: MyColor.accentColor,
    accentIconTheme: IconThemeData(color: Colors.white),
    // dividerColor: Colors.white54
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: MyColor.primaryColor,
    // backgroundColor: const Color(0xFF212121),
    accentColor: MyColor.accentColor,
    accentIconTheme: IconThemeData(color: Colors.black),
    // dividerColor: Colors.black12,
    appBarTheme: AppBarTheme(color: Colors.grey[900]),
  );

  static ThemeData getThemeFromName(String themeName) {
    switch (themeName) {
      case 'Light':
        return light;
      case 'Dark':
        return dark;
      default:
        return light;
    }
  }
  
}