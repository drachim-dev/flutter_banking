import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_banking/model/transaction.dart';
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

  static const String ContactSelectionViewRoute = '/transaction/send/contact';
  static const String AmountSelectionViewRoute = '/transaction/send/amount';
  static const String PurposeSelectionViewRoute = '/transaction/send/purpose';
  static const String AccountSelectionViewRoute = '/transaction/send/account';
  static const String AddTransactionOverviewRoute = '/transaction/send/overview';
  static const String LoginViewRoute = 'login';
  static const String HomeViewRoute = '/';
  static const String AccountViewRoute = 'account_list';
  static const String MapViewRoute = 'map';
  static const String SpendingViewRoute = 'spending_list';
  static const String PreferencesViewRoute = 'preferences';

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case ContactSelectionViewRoute:
        return MaterialPageRoute(builder: (_) => ContactSelectionView());

      case AmountSelectionViewRoute:
        final Transaction transaction = settings.arguments;

        return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => AmountSelectionView(transaction: transaction),
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );

      case PurposeSelectionViewRoute:
        return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) {
            return PurposeSelectionView();
          },
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );

      case AccountSelectionViewRoute:
        final Transaction transaction = settings.arguments;

        return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) {
            return AccountView(transaction: transaction);
          },
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );

      case LoginViewRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case HomeViewRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case AccountViewRoute:
        return MaterialPageRoute(builder: (_) => AccountView());
      case SpendingViewRoute:
        return MaterialPageRoute(builder: (_) => SpendingView());
      case AddTransactionOverviewRoute:
        final Transaction transaction = settings.arguments;

        return MaterialPageRoute(builder: (_) => AddTransactionOverview(transaction: transaction));
      case MapViewRoute:
        return MaterialPageRoute(builder: (_) => MapView());
      case PreferencesViewRoute:
        return MaterialPageRoute(builder: (_) => PreferencesView());
      default:
        return MaterialPageRoute(
            builder: (_) => UndefinedView(name: settings.name));
    }
  }
}