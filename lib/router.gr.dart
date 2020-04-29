// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_banking/view/signup_view.dart';
import 'package:flutter_banking/view/signup_stepper_view.dart';
import 'package:flutter_banking/view/login_view.dart';
import 'package:flutter_banking/view/home_view.dart';
import 'package:flutter_banking/view/spending_view.dart';
import 'package:flutter_banking/view/account_view.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/view/add_account.dart';
import 'package:flutter_banking/view/map_view.dart';
import 'package:flutter_banking/view/preferences_view.dart';
import 'package:flutter_banking/view/contact_selection_view.dart';
import 'package:flutter_banking/view/amount_selection_view.dart';
import 'package:flutter_banking/view/add_transaction_overview.dart';
import 'package:flutter_banking/view/purpose_selection_view.dart';

abstract class Routes {
  static const signUpView = '/';
  static const signUpStepperView = '/sign-up-stepper-view';
  static const loginView = '/login-view';
  static const homeView = '/home-view';
  static const spendingView = '/spending-view';
  static const accountView = '/account-view';
  static const addAccountView = '/add-account-view';
  static const atmMapView = '/atm-map-view';
  static const preferencesView = '/preferences-view';
  static const contactSelectionView = '/contact-selection-view';
  static const addContactView = '/add-contact-view';
  static const amountSelectionView = '/amount-selection-view';
  static const accountSelectionView = '/account-selection-view';
  static const addTransactionOverview = '/add-transaction-overview';
  static const purposeSelectionView = '/purpose-selection-view';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.signUpView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpView(),
          settings: settings,
        );
      case Routes.signUpStepperView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpStepperView(),
          settings: settings,
        );
      case Routes.loginView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.homeView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.spendingView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SpendingView(),
          settings: settings,
        );
      case Routes.accountView:
        if (hasInvalidArgs<AccountViewArguments>(args)) {
          return misTypedArgsRoute<AccountViewArguments>(args);
        }
        final typedArgs =
            args as AccountViewArguments ?? AccountViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AccountView(
              key: typedArgs.key, transaction: typedArgs.transaction),
          settings: settings,
        );
      case Routes.addAccountView:
        if (hasInvalidArgs<AddAccountViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AddAccountViewArguments>(args);
        }
        final typedArgs = args as AddAccountViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddAccountView(
              key: typedArgs.key, createOwnAccount: typedArgs.createOwnAccount),
          settings: settings,
        );
      case Routes.atmMapView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AtmMapView(),
          settings: settings,
        );
      case Routes.preferencesView:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PreferencesView(),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      case Routes.contactSelectionView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ContactSelectionView(),
          settings: settings,
        );
      case Routes.addContactView:
        if (hasInvalidArgs<AddAccountViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AddAccountViewArguments>(args);
        }
        final typedArgs = args as AddAccountViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddAccountView(
              key: typedArgs.key, createOwnAccount: typedArgs.createOwnAccount),
          settings: settings,
        );
      case Routes.amountSelectionView:
        if (hasInvalidArgs<AmountSelectionViewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AmountSelectionViewArguments>(args);
        }
        final typedArgs = args as AmountSelectionViewArguments;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              AmountSelectionView(
                  key: typedArgs.key, transaction: typedArgs.transaction),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      case Routes.accountSelectionView:
        if (hasInvalidArgs<AccountViewArguments>(args)) {
          return misTypedArgsRoute<AccountViewArguments>(args);
        }
        final typedArgs =
            args as AccountViewArguments ?? AccountViewArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => AccountView(
              key: typedArgs.key, transaction: typedArgs.transaction),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      case Routes.addTransactionOverview:
        if (hasInvalidArgs<AddTransactionOverviewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AddTransactionOverviewArguments>(args);
        }
        final typedArgs = args as AddTransactionOverviewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddTransactionOverview(
              key: typedArgs.key, transaction: typedArgs.transaction),
          settings: settings,
        );
      case Routes.purposeSelectionView:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PurposeSelectionView(),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AccountView arguments holder class
class AccountViewArguments {
  final Key key;
  final Transaction transaction;
  AccountViewArguments({this.key, this.transaction});
}

//AddAccountView arguments holder class
class AddAccountViewArguments {
  final Key key;
  final bool createOwnAccount;
  AddAccountViewArguments({this.key, @required this.createOwnAccount});
}

//AmountSelectionView arguments holder class
class AmountSelectionViewArguments {
  final Key key;
  final Transaction transaction;
  AmountSelectionViewArguments({this.key, @required this.transaction});
}

//AddTransactionOverview arguments holder class
class AddTransactionOverviewArguments {
  final Key key;
  final Transaction transaction;
  AddTransactionOverviewArguments({this.key, @required this.transaction});
}
