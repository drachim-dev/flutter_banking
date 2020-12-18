// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';
import 'view/account_view.dart';
import 'view/add_account.dart';
import 'view/add_transaction_overview.dart';
import 'view/amount_selection_view.dart';
import 'view/contact_selection_view.dart';
import 'view/home_view.dart';
import 'view/login_view.dart';
import 'view/map_view.dart';
import 'view/preferences_view.dart';
import 'view/purpose_selection_view.dart';
import 'view/signup_mobile.dart';
import 'view/signup_stepper_view.dart';
import 'view/spending_view.dart';

class Routes {
  static const String signUpMobile = '/';
  static const String signUpStepperView = '/sign-up-stepper-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String spendingView = '/spending-view';
  static const String addAccountView = '/add-account-view';
  static const String atmMapView = '/atm-map-view';
  static const String preferencesView = '/preferences-view';
  static const String contactSelectionView = '/contact-selection-view';
  static const String amountSelectionView = '/amount-selection-view';
  static const String accountView = '/account-view';
  static const String addTransactionOverview = '/add-transaction-overview';
  static const String purposeSelectionView = '/purpose-selection-view';
  static const all = <String>{
    signUpMobile,
    signUpStepperView,
    loginView,
    homeView,
    spendingView,
    addAccountView,
    atmMapView,
    preferencesView,
    contactSelectionView,
    amountSelectionView,
    accountView,
    addTransactionOverview,
    purposeSelectionView,
  };
}

class AutoRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.signUpMobile, page: SignUpMobile),
    RouteDef(Routes.signUpStepperView, page: SignUpStepperView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.spendingView, page: SpendingView),
    RouteDef(Routes.addAccountView, page: AddAccountView),
    RouteDef(Routes.atmMapView, page: AtmMapView),
    RouteDef(Routes.preferencesView, page: PreferencesView),
    RouteDef(Routes.contactSelectionView, page: ContactSelectionView),
    RouteDef(Routes.amountSelectionView, page: AmountSelectionView),
    RouteDef(Routes.accountView, page: AccountView),
    RouteDef(Routes.addTransactionOverview, page: AddTransactionOverview),
    RouteDef(Routes.purposeSelectionView, page: PurposeSelectionView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SignUpMobile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpMobile(),
        settings: data,
      );
    },
    SignUpStepperView: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SignUpStepperView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    SpendingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SpendingView(),
        settings: data,
      );
    },
    AddAccountView: (data) {
      final args = data.getArgs<AddAccountViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddAccountView(
          key: args.key,
          createOwnAccount: args.createOwnAccount,
        ),
        settings: data,
      );
    },
    AtmMapView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AtmMapView(),
        settings: data,
      );
    },
    PreferencesView: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PreferencesView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    ContactSelectionView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ContactSelectionView(),
        settings: data,
      );
    },
    AmountSelectionView: (data) {
      final args = data.getArgs<AmountSelectionViewArguments>(nullOk: false);
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AmountSelectionView(
          key: args.key,
          transaction: args.transaction,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    AccountView: (data) {
      final args = data.getArgs<AccountViewArguments>(
        orElse: () => AccountViewArguments(),
      );
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => AccountView(
          key: args.key,
          transaction: args.transaction,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
    AddTransactionOverview: (data) {
      final args = data.getArgs<AddTransactionOverviewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddTransactionOverview(
          key: args.key,
          transaction: args.transaction,
        ),
        settings: data,
      );
    },
    PurposeSelectionView: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PurposeSelectionView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AddAccountView arguments holder class
class AddAccountViewArguments {
  final Key key;
  final bool createOwnAccount;
  AddAccountViewArguments({this.key, @required this.createOwnAccount});
}

/// AmountSelectionView arguments holder class
class AmountSelectionViewArguments {
  final Key key;
  final Transaction transaction;
  AmountSelectionViewArguments({this.key, @required this.transaction});
}

/// AccountView arguments holder class
class AccountViewArguments {
  final Key key;
  final Transaction transaction;
  AccountViewArguments({this.key, this.transaction});
}

/// AddTransactionOverview arguments holder class
class AddTransactionOverviewArguments {
  final Key key;
  final Transaction transaction;
  AddTransactionOverviewArguments({this.key, @required this.transaction});
}
