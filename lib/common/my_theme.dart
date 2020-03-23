import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/dimens.dart';

class MyTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: MyColor.olbPrimary,
    accentColor: MyColor.olbAccent,
    accentColorBrightness: Brightness.dark,
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.olbAccent,
      padding: const EdgeInsets.all(Dimens.buttonPadding),
    ),
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
      padding: const EdgeInsets.all(Dimens.buttonPadding),
    ),
    indicatorColor: MyColor.olbAccent,
    textSelectionColor: MyColor.olbAccent.withAlpha(100),
    cursorColor: MyColor.lightGrey,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: MyColor.darkGrey,
      modalBackgroundColor: MyColor.darkGrey,
    ),
  );

  static final ThemeData black = dark.copyWith(
    scaffoldBackgroundColor: Colors.black,
    dialogBackgroundColor: MyColor.darkGrey,
    primaryColor: Colors.black,
  );

  static ThemeData getThemeFromName(String themeName) {
    ThemeData theme = light;

    switch (themeName) {
      case 'Light':
        theme = light;
        break;
      case 'Dark':
        theme = dark;
        break;
      case 'Black':
        theme = black;
        break;
    }

    return initTheme(theme);
  }

  static ThemeData initTheme(ThemeData theme) {
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        headline1: theme.textTheme.headline1.copyWith(
          fontSize: 48.0,
        ),
        headline2: theme.textTheme.headline2.copyWith(
          fontSize: 32.0,
        ),
        headline3: theme.textTheme.headline3.copyWith(
          fontSize: 28.0,
        ),
        headline4: theme.textTheme.headline4.copyWith(
          fontSize: 24.0,
        ),
        headline5: theme.textTheme.headline5.copyWith(
          fontSize: 20.0,
        ),
        headline6: theme.textTheme.headline6.copyWith(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
