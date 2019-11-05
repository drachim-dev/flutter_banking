import 'package:flutter/material.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:flutter_banking/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // access SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // get theme from SharedPreferences
  ThemeData theme;
  switch (prefs.getString('theme')) {
    case 'Dark':
      theme = MyTheme.dark;
      break;
    default:
      theme = MyTheme.light;
      break;
  }

  setupLocator();
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({Key key, @required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          initialData: User.initial(),
          builder: (_) => locator<AuthenticationService>().user,
        ),
        StreamProvider<UserLocation>(
          initialData: UserLocation(latitude: 53.158017, longitude: 8.213230),
          builder: (_) => locator<LocationService>().locationStream,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        onGenerateRoute: Router.generateRoute,
        initialRoute: Router.LoginViewRoute,
      ),
    );
  }
}
