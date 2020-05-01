import 'dart:ui';

import 'package:flutter/material.dart';

class MyColor {
  static final Color lighterGrey = Colors.grey[100];
  static final Color lightGrey = Colors.grey[350];
  static final Color grey = Colors.grey[500];
  static final Color darkGrey = Colors.grey[900];

  static const Color olbGreen = const Color(0xff007858);
  static const Color olbOrange = const Color(0xffff8b02);

  static const Color primary = Colors.teal;
  static const Color accent = olbOrange;

  static final Color transparentPrimary = primary.withOpacity(0.25);
  static final Color transparentAccent = accent.withOpacity(0.15);

  static const Color transparentStatusBarColor = Colors.black26;
}
