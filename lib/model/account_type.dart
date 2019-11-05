import 'package:flutter/material.dart';

enum AccountType { CheckingAccount, CreditCard, CustodyAccount }

class AccountTypeHelper {
  static IconData getIcon(AccountType type) {
    switch (type) {
      case AccountType.CheckingAccount:
        return Icons.account_balance;
      case AccountType.CreditCard:
        return Icons.credit_card;
      case AccountType.CustodyAccount:
        return Icons.trending_up;
      default:
        return Icons.close;
    }
  }

  static String getValue(AccountType type) {
    switch (type) {
      case AccountType.CheckingAccount:
        return 'Girokonto';
      case AccountType.CreditCard:
        return 'Kreditkarte';
      case AccountType.CustodyAccount:
        return 'Depot';
      default:
        return '';
    }
  }
}
