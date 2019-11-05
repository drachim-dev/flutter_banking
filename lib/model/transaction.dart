import 'package:flutter/foundation.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/purpose.dart';

class Transaction {
  Account ownAccount;
  Account foreignAccount;
  DateTime date;
  String usageText;
  double amount;
  Purpose purpose;

  Transaction(
      {@required this.ownAccount,
      @required this.date,
      this.foreignAccount,
      this.usageText,
      @required this.purpose,
      @required this.amount});
}