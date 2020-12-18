import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking/auto_router.gr.dart';
import 'package:flutter_banking/common/keys.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/services/biometric_auth_notifier.dart';
import 'package:flutter_banking/services/firebase_service.dart';
import 'package:flutter_banking/services/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // access SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // get settings from SharedPreferences
  final ThemeData theme =
      MyTheme.getThemeFromName(prefs.getString(Keys.pref_theme));
  final bool _biometricLogin = prefs.getBool(Keys.pref_biometric_login);

  setupLocator();
  FirebaseService();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(theme),
      ),
      ChangeNotifierProvider<BiometricAuthNotifier>(
        create: (context) => BiometricAuthNotifier(_biometricLogin),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeNotifier>(context).theme,
      builder: ExtendedNavigator.builder<AutoRouter>(
        router: AutoRouter(),
      ),
    );
  }
}
