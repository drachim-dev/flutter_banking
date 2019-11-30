import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/view/add_account.dart';
import 'package:flutter_banking/view/amount_selection_view.dart';
import 'package:flutter_banking/view/account_view.dart';
import 'package:flutter_banking/view/add_transaction_overview.dart';
import 'package:flutter_banking/view/contact_selection_view.dart';
import 'package:flutter_banking/view/home_view.dart';
import 'package:flutter_banking/view/login_view.dart';
import 'package:flutter_banking/view/map_view.dart';
import 'package:flutter_banking/view/preferences_view.dart';
import 'package:flutter_banking/view/purpose_selection_view.dart';
import 'package:flutter_banking/view/spending_view.dart';
import 'package:flutter_banking/view/undefined_view.dart';

class Router {
  static const String loginView = '/';
  static const String homeView = '/home';
  static const String spendingView = '/spending/list';
  static const String mapView = '/mapview';
  static const String preferencesView = '/preferences';

  static const String accountView = '/account/list';
  static const String addAccountView = '/account/list/add';

  static const String contactSelectionView = '/transaction/contact/list';
  static const String addContactView = '/transaction/contact/list/add';

  static const String amountSelectionView = '/transaction/send/amount';
  static const String purposeSelectionView = '/transaction/send/purpose';
  static const String accountSelectionView = '/transaction/send/account';
  static const String addTransactionOverview =
      '/transaction/send/overview';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginView:
        return MaterialPageRoute(builder: (_) => LoginView());

      case homeView:
        return MaterialPageRoute(builder: (_) => HomeView());

      case spendingView:
        return MaterialPageRoute(builder: (_) => SpendingView());

      case accountView:
        return MaterialPageRoute(builder: (_) => AccountView());

      case addAccountView:
        return MaterialPageRoute(
            builder: (_) => AddAccountView(createOwnAccount: true));

      case mapView:
        return MaterialPageRoute(builder: (_) => MapView());

      case preferencesView:
        return MaterialPageRoute(builder: (_) => PreferencesView());

      case contactSelectionView:
        return MaterialPageRoute(builder: (_) => ContactSelectionView());

      case addContactView:
        return MaterialPageRoute(
            builder: (_) => AddAccountView(createOwnAccount: false));

      case amountSelectionView:
        final Transaction transaction = settings.arguments;

        return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) =>
              AmountSelectionView(transaction: transaction),
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );

      case accountSelectionView:
        final Transaction transaction = settings.arguments;

        return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) {
            return AccountView(transaction: transaction);
          },
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );

      case addTransactionOverview:
        final Transaction transaction = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => AddTransactionOverview(transaction: transaction));

      case purposeSelectionView:
        return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) {
            return PurposeSelectionView();
          },
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );

      default:
        return MaterialPageRoute(
            builder: (_) => UndefinedView(name: settings.name));
    }
  }
}
