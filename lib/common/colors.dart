import 'dart:ui';

import 'package:flutter/material.dart';

class MyColor {

  static final Color lighterGrey = Colors.grey[100];
  static final Color lightGrey = Colors.grey[350];
  static final Color grey = Colors.grey[500];
  static final Color darkGrey = Colors.grey[900];

  static const Color olbPrimary = const Color(0xff007858);
  static const Color olbAccent = Colors.deepOrangeAccent;

  static final Color transparentOlbPrimary = olbPrimary.withOpacity(0.10);
  static final Color transparentOlbAccent = olbAccent.withOpacity(0.10);

  static const Color transparentStatusBarColor = Colors.black26;

}