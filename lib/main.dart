import 'package:flutter/material.dart';
import 'package:flutter_banking/common/keys.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:flutter_banking/services/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // access SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // get theme from SharedPreferences
  ThemeData theme = MyTheme.getThemeFromName(prefs.getString(Keys.pref_theme));

  setupLocator();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      builder: (_) => ThemeNotifier(theme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          initialData: User.initial(),
          builder: (_) => locator<AuthenticationService>().user,
        ),
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
