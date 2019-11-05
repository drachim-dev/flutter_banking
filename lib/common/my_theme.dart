import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';

class MyTheme {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      primaryColor: MyColor.primaryColor,
      accentColor: MyColor.accentColor);

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: MyColor.primaryColor,
    accentColor: MyColor.accentColor,
    appBarTheme: AppBarTheme(color: Colors.grey[900]),
  );
}
