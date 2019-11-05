import 'package:flutter/foundation.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/institute.dart';

class Account {
  final String owner, number, name;
  final Institute institute;
  final AccountType accountType;
  final double balance;

  Account(
      {@required this.owner,
      @required this.number,
      @required this.institute,
      this.accountType,
      this.name,
      this.balance});
}
