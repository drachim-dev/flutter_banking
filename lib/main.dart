import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:flutter_banking/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
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
        StreamProvider<UserLocation>(
          initialData: UserLocation(latitude: 53.158017, longitude: 8.213230),
          builder: (_) => locator<LocationService>().locationStream,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: MyColor.primaryColor,
          accentColor: MyColor.accentColor,
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: Router.LoginViewRoute,
      ),
    );
  }
}
