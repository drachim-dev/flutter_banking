import 'package:flutter/material.dart';
import 'package:flutter_banking/view/account_view.dart';
import 'package:flutter_banking/view/depot_view.dart';
import 'package:flutter_banking/view/spending_view.dart';

class Destination {
  const Destination(this.view, this.title, this.icon, this.showFab, this.keepAlive);

  final Widget view;
  final String title;
  final IconData icon;
  final bool showFab;
  final bool keepAlive;
}

final List<Destination> allDestinations = <Destination>[
  Destination(SpendingView(), 'Spending', Icons.trending_up, true, true),
  Destination(AccountView(), 'Accounts', Icons.account_balance, true, true),
  Destination(DepotView(), 'Depot', Icons.assessment, true, true),
];