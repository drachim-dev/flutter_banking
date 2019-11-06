import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _theme;

  ThemeNotifier(this._theme);

  ThemeData get theme => _theme;

  setTheme(ThemeData themeData) async {
    _theme = themeData;
    notifyListeners();
  }
}