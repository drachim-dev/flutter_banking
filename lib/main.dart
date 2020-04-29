import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking/common/keys.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/router.gr.dart';
import 'package:flutter_banking/services/firebase_service.dart';
import 'package:flutter_banking/services/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // access SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // get theme from SharedPreferences
  final ThemeData theme =
      MyTheme.getThemeFromName(prefs.getString(Keys.pref_theme));

  setupLocator();
  FirebaseService();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (ctx, __) => ExtendedNavigator<Router>(
        router: Router(),
      ),
      theme: Provider.of<ThemeNotifier>(context).theme,
    );
  }
}
