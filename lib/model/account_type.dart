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
        return Icons.card_membership;
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

  static AccountType fromValue(String value) {
    switch (value) {
      case 'Girokonto':
        return AccountType.CheckingAccount;
      case 'Kreditkarte':
        return AccountType.CreditCard;
      case 'Depot':
        return AccountType.CustodyAccount;
      default:
        return AccountType.CheckingAccount;
    }
  }
}
