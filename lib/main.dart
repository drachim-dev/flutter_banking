import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_banking/common/keys.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:flutter_banking/services/firebase_service.dart';
import 'package:flutter_banking/services/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // access SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // get theme from SharedPreferences
  ThemeData theme = MyTheme.getThemeFromName(prefs.getString(Keys.pref_theme));

  setupLocator();
  FirebaseService();

  runZoned<Future<void>>(() async {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(theme),
        child: MyApp(),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          initialData: User.initial(),
          create: (_) => locator<AuthenticationService>().user,
        ),
        // ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Provider.of<ThemeNotifier>(context).theme,
        onGenerateRoute: Router.generateRoute,
        initialRoute: Router.LoginViewRoute,
      ),
    );
  }
}
